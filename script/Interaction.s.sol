//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import {Script} from "forge-std/Script.sol";
import {NFT} from "src/NFT.sol";
import {deployNft} from "script/deployNft.s.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Interaction is Script {
    string public tokenUri = "ipfs://QmNN4Vz1ssF876evC9fVDe6VgwznjqcpFbpiLKBrDQk3xe";
    function run() external {
        // get address of most recent deployed
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "NFT",
            block.chainid
        );
        mintNft(mostRecentlyDeployed);

    }
    function mintNft(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        NFT(mostRecentlyDeployed).mint(tokenUri);
        vm.stopBroadcast();
    }
}
