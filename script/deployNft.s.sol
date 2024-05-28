//SPDX-License-Identifier:MIT
import {Script} from "forge-std/Script.sol";
import {NFT} from "src/NFT.sol";
pragma solidity ^0.8.0;

contract deployNft is Script {
    function run() external returns (NFT) {
         NFT nft;
        vm.startBroadcast();
        nft = new NFT();
        vm.stopBroadcast();
        return nft;
    }
}
