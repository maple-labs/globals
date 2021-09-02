// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { IMapleGlobals } from "../../interfaces/IMapleGlobals.sol";

contract GlobalAdmin {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mapleGlobals_setProtocolPause(address globals, bool pause) external {
        IMapleGlobals(globals).setProtocolPause(pause);
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mapleGlobals_setProtocolPause(address globals, bool pause) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setProtocolPause.selector, pause));
    }

}
