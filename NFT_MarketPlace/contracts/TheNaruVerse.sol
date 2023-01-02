//  SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";



contract TheNaruVerse is Ownable, ERC721URIStorage{

    uint256 private totNFT;
    uint256 private CURRENT_TOKEN_PRICE = 0.05 ether;
    uint256 private CURRENT_TOKEN_VALUE = 1 ether;
    uint256 private mintingFees;
    uint256 private registrationFees;
    uint256 private totOnSale;
    uint256 private activationFees;
    address payable private contractOwner;
    address payable private contractAddress;
    uint256 private totCreators;
    uint256 private totRents;

    uint NO_AUCTION = 0;
    uint private constant DUTCH_AUCTION = 1;
    uint private constant ENGLISH_AUCTION = 2;
    uint private constant DUTCH_AUCTION_RATE = 25;
    uint private constant ENGLISH_AUCTION_RATE = 20;
    uint private constant RENT_FEE_DURATION = 60000;


    uint private constant DURATION = 7 days;

    struct NaruFT{
        uint id;
        string uri;
        address creator;
        address currentOwner;
        uint256 currentPrice;
        bool sold;
        bool onSale;
        bool exists;
        uint auctionID;
        bool canRent;
        bool isRented;
    }

    struct Creator{
        address creatorID;
        uint256 totNFT;
        bool exists;
    }

    struct AuctionedNFT{
        uint auctionID;
        uint256 startingPrice;
        uint256 highestBid;
        address currentOwner;
        address highestBider;
        uint256 discountRate;
        uint256 startAt;
        uint256 exipresAt;
    }

    struct Bid{
        uint256 bid;
        address bider;
        uint256 timestamp;
    }

// Renting a NFT 
// {
//      NaruFT;
//      currentOwner;
//      rentedBy;
//      rentedTill;
//      rentingFees;
// } 

    struct RentedNFT{
        NaruFT nft;
        address rentedBy;
        uint256 rentedOn;
        uint256 rentedTill;
        uint256 rentingFees;
        uint256 lastRent;
    }

    mapping(uint => NaruFT) public nvfts;

    mapping(address => Creator) public creators;

    mapping(address => uint256) public nfts;

    mapping(uint => AuctionedNFT) public auctionNFTS;

    mapping(uint256 => Bid) public englishBids;

    mapping(uint256 => RentedNFT) public rents;

    mapping(uint256 => uint256) public rentingFees;

    event TokenMinted(address, uint256);
    event TokenSold(uint256, address);
    event OnSale(uint256);
    event OffSale(uint256);
    event NewCreator(address);
    event LiveOnDutchAuction(uint256, uint256, uint256);
    event LiveOnEnglishAuction(uint256, uint256, uint256);
    event SoldNFTDucth(uint256, uint256, address);
    event SoldNFTEnglish(uint256, uint256, address);
    event EnglishEnded(uint256);
    event EnglishBid(uint256, uint256, address);
    event BidWithdrawn(address, uint256);

    constructor() public ERC721("NaruFT","NvFT"){
        contractOwner = payable(msg.sender);
        mintingFees = 0.2 ether;
        registrationFees = 1 ether;
        totNFT = 0;
        totOnSale = 0;
        totCreators = 0;
        contractAddress = payable((address(this)));
        activationFees = 0.02 ether;
    }

    function getDutchAuctionRate() public pure returns(uint){
        return DUTCH_AUCTION_RATE/100;
    }

    function getTotRents() public view returns(uint256){
        return totRents;
    }

    function getEnglishAuctionRate() public pure returns(uint){
        return ENGLISH_AUCTION_RATE/100;
    }

    function getDutchAuctionID() public pure returns(uint){
        return DUTCH_AUCTION;
    }

    function getEnglishAuctionID() public pure returns(uint){
        return ENGLISH_AUCTION;
    }

    function getActivationFees() public view returns(uint256){
        return activationFees;
    }

    function getTotCreators() public view returns(uint256) {
        return totCreators;
    }

    function getTotOnSale() public view returns(uint256){
        return totOnSale;
    }

    function getTotNFT() public view returns(uint256){
        return totNFT;
    }

    function getRegistrationFees() public view returns(uint256){
        return registrationFees;
    }

    function getMintingFees() public view returns(uint256){
        return mintingFees;
    }

    // getting the contract balance
    function getContractBalance() public view onlyOwner returns(uint256){
        require(msg.sender==contractOwner, "Invalid Operation");
        return address(this).balance;
    }

    // set the nft available for renting
    function setOnRent(uint256 _tokenID, uint256 _rentingFee) public {
        NaruFT memory _curr = nvfts[_tokenID];
        require(_curr.exists);
        require(_curr.currentOwner == msg.sender); 
        require(_curr.auctionID == NO_AUCTION);

        _curr.canRent = true;

        nvfts[_tokenID] = _curr;

        rentingFees[_tokenID] = _rentingFee;

        totRents++;
    }

    // setting the nft unavailabe for renting
    function setOffRent(uint256 _tokenID) public {
        NaruFT memory _curr = nvfts[_tokenID];
        require(_curr.exists);
        require(_curr.currentOwner == msg.sender); 
        require(!_curr.isRented);

        _curr.canRent = false;
        nvfts[_tokenID] = _curr;

        totRents--;
    }


    function getRentingFees(uint256 _tokenID) public view returns(uint256) {
        return rentingFees[_tokenID];
    }

    // rent any nft
    function rentNFT(uint256 _tokenID, uint256 duration) public payable {
        NaruFT memory _curr = nvfts[_tokenID];
        require(_curr.exists);
        require(_curr.currentOwner != msg.sender); 
        require(_curr.auctionID == NO_AUCTION);
        require(_curr.canRent);
        require(!_curr.isRented);

        require(msg.value>=rentingFees[_tokenID]);

        _curr.isRented = true;
        _curr.canRent = false;
        nvfts[_tokenID] = _curr;

        RentedNFT memory _rent = RentedNFT(_curr, msg.sender, 
                                            block.timestamp, 
                                            block.timestamp+duration, 
                                            rentingFees[_tokenID],
                                            block.timestamp);

        rents[_tokenID] = _rent;

        payRentToOwner(_curr.currentOwner, _tokenID);

        transferFrom(_curr.currentOwner, msg.sender, _tokenID);

    }

    function payRentToOwner(address _owner, uint256 _tokenID) public payable {
        uint256 _rent = rentingFees[_tokenID];

        uint256 _lastRented = rents[_tokenID].lastRent;

        _rent = (block.timestamp - _lastRented)/RENT_FEE_DURATION * rentingFees[_tokenID];

        (bool sent, bytes memory data) = payable(_owner).call{value:_lastRented}("");

        require(sent);

        (bool _sent, bytes memory _data) = payable(msg.sender).call{value:(msg.value - _lastRented)}("");

        require(_sent);

    }

    // time left for the rented Item
    function timeLeft(uint256 _tokenID) public returns(uint256){
        return (rents[_tokenID].rentedTill - block.timestamp);
    }


    // rooling back the renting transaction
    function rollbackRent(uint256 _tokenID) public payable {
        NaruFT memory _curr = nvfts[_tokenID];
        require(_curr.exists);
        require(_curr.canRent);
        require(_curr.isRented);

        require(block.timestamp >= rents[_tokenID].rentedTill);

        payRentToOwner(_curr.currentOwner, _tokenID);

        _curr.isRented = false;

        nvfts[_tokenID] = _curr;

        transferFrom(rents[_tokenID].rentedBy, _curr.currentOwner, _tokenID);

        delete rents[_tokenID];
        delete rentingFees[_tokenID];

    }

    // upgrading the token price 
    function upgradePrice() internal {
        if(totNFT > 10){
            CURRENT_TOKEN_PRICE = CURRENT_TOKEN_PRICE*2;
        }
        if(totNFT > 100){
            CURRENT_TOKEN_PRICE = CURRENT_TOKEN_PRICE*4;
        }
        if(totNFT > 1000){
            CURRENT_TOKEN_PRICE = CURRENT_TOKEN_PRICE*CURRENT_TOKEN_PRICE;
        }
    }

    // payable function sender must pay the registration fees for becoming a creator at our marketplace
    function registerCreator(address _owner) external payable {

        Creator memory _currCreator = Creator(_owner, 0, true);

        creators[_owner] = _currCreator;

        totCreators++;

        emit NewCreator(_owner);
    }

    // payable function the creator must pay the minting fees to create any NFT on our marketplace
    function mintNFT(string memory _tokenURI, address _owner) external returns(uint256){

        Creator memory _curr = creators[_owner];    
        require(_curr.exists, "Please Register the Creator First");
        
        upgradePrice();

        totNFT++;

        uint newItemId = totNFT;       

        // minting the nft at newTokenId to _recipient
        _mint(_owner, newItemId);

        // setting the nft tokent's uri to newItemId
        _setTokenURI(newItemId, _tokenURI);

        nvfts[newItemId] = NaruFT(newItemId, _tokenURI, _owner, _owner, CURRENT_TOKEN_PRICE, false, false, true, NO_AUCTION, false, false);
    
        _curr.totNFT++;
        creators[_owner] = _curr;

        emit TokenMinted(_owner, newItemId);

        return newItemId;      
    
    }

    // buy a nft if the owner has set it on sale 
    function buyNFT(uint256 _tokenID, address payable _buyer) public {

        require(_tokenID <= totNFT, "Provide Valid Token ID");

        _validate(_tokenID);

        _trade(_tokenID, _buyer);

        nfts[_buyer]++;

        emit TokenSold(_tokenID, _buyer);
    }

    // validation wether or not the nft is on sale and is it sold or not and the ethers sent are matching the nft price
    function _validate(uint256 _tokenID) internal {
        NaruFT memory _curr = nvfts[_tokenID];
        require(_curr.onSale, "NFT is not on Sale");
        require(!_curr.sold, "NFT already sold");
        require(_curr.auctionID==0, "Cannot be bought, listed on the auction");
        require(msg.value >= _curr.currentPrice, "Cost of the NFT is invalid");
        require(!_curr.isRented, "Cannot buy the NFT");
    }

    // trading of the nft paying the nft fees anf transferring the ownership of the nft
    function _trade(uint256 _tokenID, address payable _buyer) internal {
        NaruFT memory _curr = nvfts[_tokenID];

        _payFees();

        (bool send, bytes memory data) = _buyer.call{value:msg.value}("");

        require(send, "Transaction cannot be processed further");

        transferFrom(_curr.currentOwner, _buyer, _tokenID);

        _curr.sold = true;
        _curr.onSale = false;
        _curr.currentOwner = _buyer;

        nvfts[_tokenID] = _curr;
    }

    // paying the contract the nft fees for further transfer
    function _payFees() public payable{}

    // settting the nft on sale
    function setOnSale(uint256 _tokenID) public {
        NaruFT memory _curr = nvfts[_tokenID];

        require(_curr.exists, "No such NFT exists");        

        if(!_curr.onSale){
            _curr.onSale = true;
            totOnSale++;
        }

        nvfts[_tokenID] = _curr;

        emit OnSale(_tokenID);

    }

    // setting the nft off the sale
    function setOffSale(uint256 _tokenID) public{
        NaruFT memory _curr = nvfts[_tokenID];

        require(_curr.exists, "No such NFT exists");        

        if(_curr.onSale){
            _curr.onSale = false;
            totOnSale--;
        }

        nvfts[_tokenID] = _curr;

        emit OffSale(_tokenID);
    }

    // transferring funds back to the current owner for withdrawal purpose
    function transferFunds(address payable _payee) internal{
        (bool send, bytes memory data) = _payee.call{value:msg.value}("");

        require(send, "Transaction cannot be processed further");
    }

    // withdraw an nft 
    function withdrawNFT(uint256 _tokenID) public {
        NaruFT memory _curr = nvfts[_tokenID];

        require(_curr.exists, "No such NFT exists");   
        require(_curr.auctionID==0, "Cannot be withdrawn listed on auction"); 
        require(!_curr.isRented, "Cannot withdraw the NFT"); 

        transferFunds(payable(_curr.currentOwner));

        _transfer(_curr.currentOwner, contractAddress, _tokenID);
        
        if(_curr.onSale){
            totOnSale--;
        }

        _curr.currentOwner = contractAddress;
        _curr.sold = false;
        _curr.exists = false;
        _curr.onSale = false;

        nvfts[_tokenID] = _curr;

    }


    // validation for activation
    function _validateActivation() internal {
        require(msg.value==activationFees, "Invalid activatiion fees");
    }

    // setting the nft back live
    function setNFTActive(uint256 _tokenID, address _owner) public {
        require(msg.sender==_owner, "Transaction can not proceed further");

        NaruFT memory _curr = nvfts[_tokenID];

        require(!_curr.exists, "NFT is already live");  

        require(_curr.creator == _owner, "You are not the creator of the nft"); 

        _validateActivation();

        _payFees();

        _transfer(_curr.currentOwner, _owner, _tokenID);

        _curr.currentOwner = _owner;
        _curr.exists = true;
        _curr.sold = false;
        _curr.onSale = false;

        nvfts[_tokenID] = _curr;

    }

      

    // Enabling the Dutch Auction
    function setNFTOnDutchAuction(uint256 _tokenID, uint256 _discountRate, uint256 _startingPrice, uint256 _startAt) public {
        NaruFT memory _curr = nvfts[_tokenID];

        require(msg.sender==_curr.currentOwner, "Cannot put NFT on auction");

        require(_curr.auctionID==0, "Cannot process the transaction already in the Auction");

        // start dutch auction

        require(_startingPrice>= _discountRate*DURATION, "Invalid Starting Price");

        AuctionedNFT memory _anft = AuctionedNFT(DUTCH_AUCTION,
                                                     _startingPrice, 
                                                     _startingPrice, 
                                                     _curr.currentOwner,
                                                     msg.sender, 
                                                     _discountRate,
                                                     _startAt, 
                                                     _startAt+DURATION);

        auctionNFTS[_tokenID] = _anft;

        _curr.auctionID = DUTCH_AUCTION;
        nvfts[_tokenID] = _curr;

        emit LiveOnDutchAuction(_tokenID, DURATION, _startingPrice);

    }

    // gives the current price of the token listed on the ducth auction
    function getCurrPrice(uint256 _tokenID) public view returns(uint256){
        AuctionedNFT memory _anft = auctionNFTS[_tokenID];

        uint256 _timeElapsed = block.timestamp - _anft.startAt;

        uint256 _discount = _timeElapsed * _anft.discountRate;

        return _anft.startingPrice - _discount;

    }

    function unListAuction(uint256 _tokenID) internal {
        NaruFT memory _curr = nvfts[_tokenID];
        _curr.auctionID = NO_AUCTION;
        nvfts[_tokenID] = _curr;        
    }

    // buying the token from the dutch auction
    function buyDutch(uint256 _tokenID) external payable {
        AuctionedNFT memory _anft = auctionNFTS[_tokenID];
        require(block.timestamp < _anft.exipresAt, "Auction Listing Expired");

        if(block.timestamp < _anft.exipresAt){
            unListAuction(_tokenID);
            delete auctionNFTS[_tokenID];
        }

        uint256 _currPrice = getCurrPrice(_tokenID);

        require(msg.value >= _currPrice, "Invalid Price");

        transferFrom(_anft.currentOwner, msg.sender, _tokenID);

        uint256 refund = msg.value - _currPrice;
        if(refund > 0){
            (bool send, bytes memory data) = payable(msg.sender).call{value:refund}("");
            require(send, "Transaction Failed");
        }

        (bool send, bytes memory data) = payable(_anft.currentOwner).call{value:_currPrice}("");
        require(send, "Transaction Failed");

        NaruFT memory _curr = nvfts[_tokenID];
        _curr.auctionID = NO_AUCTION;
        _curr.currentOwner = msg.sender;
        _curr.currentPrice = _currPrice;
        _curr.sold = true;
        nvfts[_tokenID] = _curr;

        delete auctionNFTS[_tokenID];

        emit SoldNFTDucth(_tokenID, _currPrice, msg.sender);

    }

//  uint auctionID;
//         uint256 startingPrice;
//         uint256 currentBid;
//         address currentOwner;
//         address currentBider;
//         uint256 discountRate;
//         uint256 startAt;
//         uint256 exipresAt;

    // Enabling the English Auction
    function setNFTOnEnglishAuction(uint256 _tokenID, uint256 _startingBid) public {
            NaruFT memory _curr = nvfts[_tokenID];

            require(msg.sender==_curr.currentOwner, "Cannot put NFT on auction");

            require(_curr.auctionID==0, "Cannot process the transaction already in the Auction");

            // start english auction
            _curr.auctionID = ENGLISH_AUCTION;
            nvfts[_tokenID] = _curr;

            AuctionedNFT memory _anft = AuctionedNFT(ENGLISH_AUCTION,
                                                _startingBid,
                                                _startingBid,
                                                msg.sender,
                                                msg.sender,
                                                0,
                                                block.timestamp,
                                                block.timestamp+DURATION);
            

            auctionNFTS[_tokenID] = _anft;
        emit LiveOnEnglishAuction(_tokenID, DURATION, _startingBid);
    }

    // bid for the nft
    function bid(uint256 _tokenID) external payable {
        NaruFT memory _curr = nvfts[_tokenID];
        AuctionedNFT memory _anft = auctionNFTS[_tokenID];
        require(_curr.auctionID == ENGLISH_AUCTION, "Not Listed on English Auction");
        require(_anft.exipresAt > block.timestamp, "Listing Expired");

        if(_anft.exipresAt <= block.timestamp){
            unListAuction(_tokenID);
            // sell to highest bidder
            endEnglish(_tokenID);
            delete auctionNFTS[_tokenID];
        }

        require(_anft.highestBid < msg.value, "Cannot place the Bid a higher one already exists");

        withdrawBid(payable(_anft.highestBider), _anft.highestBid);

        _anft.highestBid = msg.value;
        _anft.highestBider = msg.sender;

        auctionNFTS[_tokenID] = _anft;

        Bid memory _bid = Bid(msg.value, msg.sender, block.timestamp);

        englishBids[_tokenID] = _bid;

        emit EnglishBid(_tokenID, msg.value, msg.sender);
    }

    // transfer the highest bid from previous highest bidder to current higest bider
    function withdrawBid(address payable _bider, uint256 _bid) internal {
        (bool send, bytes memory data) = _bider.call{value:_bid}("");
        require(send, "Transaction Failed");

        emit BidWithdrawn(_bider, _bid);
    }

    // endding the English Auction for the Token
    function endEnglish(uint _tokenID) public {
        NaruFT memory _curr = nvfts[_tokenID];
        AuctionedNFT memory _anft = auctionNFTS[_tokenID];
        require(_curr.auctionID == ENGLISH_AUCTION, "Not Listed on English Auction");
        require(_anft.exipresAt > block.timestamp, "Listing Expired");

        if(_anft.highestBider != _curr.currentOwner){            

            (bool send, bytes memory data) = payable(_anft.currentOwner).call{value:_anft.highestBid}("");
            require(send, "Transaction Failed");
            transferFrom(_curr.currentOwner, _anft.highestBider, _tokenID);

            _curr.auctionID = NO_AUCTION;
            _curr.currentOwner = _anft.highestBider;
            _curr.currentPrice = _anft.highestBid;
            _curr.sold = true;
            nvfts[_tokenID] = _curr;


            delete auctionNFTS[_tokenID];

            emit SoldNFTEnglish(_tokenID, _curr.currentPrice, _curr.currentOwner);
        }

        emit EnglishEnded(_tokenID);
    }

}




