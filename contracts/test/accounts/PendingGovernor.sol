// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { IMapleGlobals } from "../../interfaces/IMapleGlobals.sol";

contract PendingGovernor {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mapleGlobals_acceptGovernor(address globals) external {
        IMapleGlobals(globals).acceptGovernor();
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mapleGlobals_acceptGovernor(address globals) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.acceptGovernor.selector));
    }

}
