//SPDX-License-Id;ntifier:MIT
pragma solidity ^0.8.0;
import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract JaiShreeRamNFT is ERC721 {
    error JaiShreeRamNFT__cantFlipNftIfNotOwner();
    uint256 private s_tokenCounter;
    string private s_LordRamImageUri;
    string private s_JaiHanumanImageUri;

    enum RamRam {
        JaiShreeRam,
        JaiHanuman
    }

    mapping(uint256 => RamRam) s_tokenId;

    constructor(
        string memory LordRamImageUri,
        string memory JaiHanumanImageUri
    ) ERC721("RamHanuman", "RAM-RAM") {
        s_tokenCounter = 0;
        s_LordRamImageUri = LordRamImageUri;
        s_JaiHanumanImageUri = JaiHanumanImageUri;
    }

    function mint() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenId[s_tokenCounter] = RamRam.JaiShreeRam;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipNFT(uint256 tokenId) public {
        // only want the nftOwner to change the Mood
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert JaiShreeRamNFT__cantFlipNftIfNotOwner();
        }
        if (s_tokenId[tokenId] == RamRam.JaiShreeRam) {
            s_tokenId[tokenId] = RamRam.JaiHanuman;
        } else {
            s_tokenId[tokenId] = RamRam.JaiShreeRam;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenId[tokenId] == RamRam.JaiShreeRam) {
            imageURI = s_JaiHanumanImageUri;
        } else {
            imageURI = s_LordRamImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"RamRam"  , "attributes":[{"festival":"RamNami"}], "imageUri": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
