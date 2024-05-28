//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import {Script, console} from "forge-std/Script.sol";
import {JaiShreeRamNFT} from "src/RamHanumanNFT.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployRamHnumanNft is Script {
    function run() external returns (JaiShreeRamNFT) {
        string memory jaiHanumanSVG = vm.readFile("image/jaiHanuman.svg");
        string memory jaiShreeSVG = vm.readFile("image/JaiShreeRam.svg");
        console.log(jaiShreeSVG);
        vm.startBroadcast();
        JaiShreeRamNFT jaishreeramNFT = new JaiShreeRamNFT(
            svgImageToImageUri(jaiShreeSVG),
            svgImageToImageUri(jaiHanumanSVG)
        );
        vm.stopBroadcast();
        return jaishreeramNFT;
    }

    function svgImageToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseUrL = "data:image/svg+xml;base64,";
        string memory svgToUri = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseUrL, svgToUri));
    }
}
