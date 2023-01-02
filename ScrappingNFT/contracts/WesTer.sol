// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract WesTer is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    uint256 private _tokenIds;

    constructor() public ERC721("WesTer", "WT") {}

    function mintNFT(string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds++;

        uint256 newItemId = _tokenIds;

        // minting the nft at newTokenId to recipient
        _mint(msg.sender, newItemId);

        // setting the nft tokent's uri to newItemId
        _setTokenURI(newItemId, tokenURI);

        setApprovalForAll(address(this), true);

        return newItemId;
    }

    function buyNFT(uint256 _tokenID, address _buyer) public returns(address){
        safeTransferFrom(msg.sender, _buyer, _tokenID);

        return _buyer;
    }   
}
