//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import {Test, console} from "forge-std/Test.sol";
import {DeployRamHnumanNft} from "script/deployRamHnumanNft.s.sol";

contract DeployJaiShreeRamNftTest is Test {
    DeployRamHnumanNft deployer;

    function setUp() public {
        deployer = new DeployRamHnumanNft();
    }

    function testSvgToImageUri() public {
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjEwMCIgd2lkdGg9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8Y2lyY2xlIHI9IjQ1IiBjeD0iNTAiIGN5PSI1MCIgZmlsbD0icmVkIiAvPgo8L3N2Zz4=";
        string
            memory svg = '<svg height="100" width="100" xmlns="http://www.w3.org/2000/svg"><circle r="45" cx="50" cy="50" fill="red" /></svg>';

        string memory originalUri = deployer.svgImageToImageUri(svg);
        console.log(originalUri);

        vm.expectRevert();
        assert(
            keccak256(abi.encodePacked(originalUri)) ==
                keccak256(abi.encodePacked(expectedUri))
        );
    }
}
