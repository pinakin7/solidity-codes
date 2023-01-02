//  SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract TheNaruVerse is Ownable, ERC721URIStorage{

    uint public totNFT = 0;

    uint CURRENT_TOKEN_PRICE = 5;

    uint CURRENT_TOKEN_VALUE = 1;

    struct NaruFT{
        uint id;
        string uri;
        address currentOwner;
        uint currentPrice;
    }

    event TokenMinted(address _recipient, uint tokenId);

    event TransferredNFT(address _from, address _to, uint _tokenID);

    mapping(uint => NaruFT) public nvfts;

     mapping(address => uint) public  _balanceOf;

    mapping(address => mapping(address => uint)) public _allowance;

    constructor() public ERC721("NaruFT","NvFT"){}

    // minting the nft adding to the map
    function mint(string memory _tokenURI, address _recipient) public onlyOwner returns (uint){
        totNFT ++;

        uint newItemId = totNFT;

        // minting the nft at newTokenId to _recipient
        _mint(_recipient, newItemId);

        // setting the nft tokent's uri to newItemId
        _setTokenURI(newItemId, _tokenURI);

        nvfts[newItemId] = NaruFT(newItemId, _tokenURI, _recipient, CURRENT_TOKEN_PRICE);

        emit TokenMinted(_recipient, newItemId);

        return newItemId;
    }

    // transfer ownership of the given nft
    function buyNFT(address payable _from, address _to, uint _tokenID) payable public {

        NaruFT memory _nvft = nvfts[_tokenID];


        uint transactionFees = CURRENT_TOKEN_PRICE * CURRENT_TOKEN_VALUE;

        
                // if(_to.send(transactionFees)){
                //     safeTransferFrom(_from, _to, _tokenID);
                //     _nvft.currentOwner = _to;
                //     emit TransferredNFT(_from, _to, _tokenID);                    
                // }

        (bool sent, bytes memory data) = _to.call{gas:500000, value: transactionFees}("");
        require(sent, "Failed to send Ether");
        if(sent){
            safeTransferFrom(_from, _to, _tokenID);
            _nvft.currentOwner = _to;
            emit TransferredNFT(_from, _to, _tokenID);
        }

        // bool _sent = payable(address(this)).send(transactionFees);

        // bool sent = _from.send(transactionFees);

        // if(sent && _sent){
        //     safeTransferFrom(_from, _to, _tokenID);
        //     _nvft.currentOwner = _to;
        //     emit TransferredNFT(_from, _to, _tokenID);
        // }
        
    //     bool _sent = _transferFrom(_from, _to, transactionFees);
    //    if(_sent){
    //         safeTransferFrom(_from, _to, _tokenID);
    //         _nvft.currentOwner = _to;
    //         emit TransferredNFT(_from, _to, _tokenID);
    //    }
    }

    // // transaction fees
    // function sendViaCall(address payable _to) public payable {
    //     // Call returns a boolean value indicating success or failure.
    //     (bool sent, bytes memory data) = _to.call{value: msg.value}("");

    //     require(sent, "Failed to send Ether");
    // }

    function transferEthers(address payable _to, uint _numEthers) public returns(bool){
        _to.transfer(_numEthers);
        return true;
    }

    function _transferFrom(address _from, address _to, uint _value) public returns (bool success) {
            require(_value <= _balanceOf[_from]);
            require(_value <= _allowance[_from][msg.sender]);
            _balanceOf[_from] -= _value;
            _balanceOf[_to] += _value;
            _allowance[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        }



}