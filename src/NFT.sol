//SPDX-License-Identifier:MIT
pragma solidity 0.8.21;
import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract NFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("hoBabu", "hB") {
        s_tokenCounter = 0;
    }

    function mint(string memory toeknUri) public {
        s_tokenIdToUri[s_tokenCounter] = toeknUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
    /**
     * Getter function
     */
    function getTokenUri(uint256 counter) external view returns (string memory)
    {
        return s_tokenIdToUri[counter];
    }
    /**
     * Get  s_tokenCounter;
     */
    function getTokenIdCounter()external view returns (uint256)
    {
        return s_tokenCounter;
    }
}
