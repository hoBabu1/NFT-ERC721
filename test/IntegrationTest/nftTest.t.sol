//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import {NFT} from "src/NFT.sol";
import {deployNft} from "script/deployNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract nftTest is Test {
    deployNft deployer;
    NFT basicNft;
    address public PLAYER = makeAddr("hoBabu");
    string public tokenUri = "ipfs://QmNN4Vz1ssF876evC9fVDe6VgwznjqcpFbpiLKBrDQk3xe";

    /* setUp function  */
    function setUp() external {
        deployer = new deployNft();
        basicNft = deployer.run();
    }

    /**
     * Checks the Name of NFT
     * Requirement - name of NFT from ERC721 `.name()`
     */
    function testNameIsCorrect() public view {
        assert(
            keccak256(abi.encodePacked(basicNft.name())) ==
                keccak256(abi.encodePacked("hoBabu"))
        );
    }

    /**
     * REQUIREMENT
     * Player will call mint function
     * Check wether tokenUri is saved or not at that particular  tokenId in mapping
     */
    function testMintCheckStorageOfToeknUriInMapping() public {
        vm.prank(PLAYER);
        basicNft.mint(tokenUri);

        assert(
            keccak256(abi.encodePacked(basicNft.getTokenUri(0))) ==
                keccak256(abi.encodePacked(tokenUri))
        );
    }

    /**
     * Check wether counter is getting increased or not ?
     */
    function testCounterShouldIncreaseByOneOnceAPlayerMInt() public 
    {
        vm.prank(PLAYER);
        basicNft.mint(tokenUri);
        assert(basicNft.getTokenIdCounter() == 1);
    }
}
