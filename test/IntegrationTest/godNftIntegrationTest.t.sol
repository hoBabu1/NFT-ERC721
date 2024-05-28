//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import {Test, console} from "forge-std/Test.sol";
import {JaiShreeRamNFT} from "src/RamHanumanNFT.sol";
import {DeployRamHnumanNft} from "script/deployRamHnumanNft.s.sol";

contract godNftIntegrationTest is Test {
    address USER = makeAddr("hoBabu");
    JaiShreeRamNFT jaishreeramnft;
    DeployRamHnumanNft deployer;

    string ramTokenUri = vm.readFile("image/baseUriofJaiShreeRam.txt");

    function setUp() public {
        deployer = new DeployRamHnumanNft();
        jaishreeramnft = deployer.run();
    }

    function testViewTokenUriIntegrationTest() public {
        vm.prank(USER);
        jaishreeramnft.mint();
        console.log(jaishreeramnft.tokenURI(0));
    }

    function testFlipTokenToJaiShreeRam() public {
        vm.prank(USER);
        jaishreeramnft.mint(); // Lord Hanuman NFT
        vm.prank(USER);
        jaishreeramnft.flipNFT(0); // It will be into Lord Ram NFT

        assert(
            keccak256(abi.encodePacked(jaishreeramnft.tokenURI(0))) ==
                keccak256(abi.encodePacked(ramTokenUri))
        );
    }
}
