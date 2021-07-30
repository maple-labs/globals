// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

import { IERC20 } from "../../../modules/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import { IMapleGlobals } from "../../interfaces/IMapleGlobals.sol"; 

contract Governor {

    /************************/
    /*** Direct Functions ***/
    /************************/
    function mapleGlobals_setValidLoanFactory(address globals, address factory, bool valid)         external { IMapleGlobals(globals).setValidLoanFactory(factory, valid); }
    function mapleGlobals_setValidPoolFactory(address globals, address factory, bool valid)         external { IMapleGlobals(globals).setValidPoolFactory(factory, valid); }
    function mapleGlobals_setPriceOracle(address globals, address asset, address oracle)            external { IMapleGlobals(globals).setPriceOracle(asset, oracle); }
    function mapleGlobals_setValidSubFactory(address globals, address fac, address sub, bool valid) external { IMapleGlobals(globals).setValidSubFactory(fac, sub, valid); }
    function mapleGlobals_setCalc(address globals, address calc, bool valid)                        external { IMapleGlobals(globals).setCalc(calc, valid); }

    /*********************/
    /*** Try Functions ***/
    /*********************/
    function try_mapleGlobals_setStakerCooldownPeriod(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setStakerCooldownPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_mapleGlobals_setLpCooldownPeriod(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setLpCooldownPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_mapleGlobals_setStakerUnstakeWindow(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setStakerUnstakeWindow(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_mapleGlobals_setLpWithdrawWindow(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setLpWithdrawWindow(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_mapleGlobals_setMaxSwapSlippage(address globals, uint256 newSlippage) external returns (bool ok) {
        string memory sig = "setMaxSwapSlippage(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, newSlippage));
    }

    function try_mapleGlobals_setGlobalAdmin(address globals, address globalAdmin) external returns (bool ok) {
        string memory sig = "setGlobalAdmin(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, globalAdmin));
    }

    function try_mapleGlobals_setValidBalancerPool(address globals, address balancerPool, bool valid) external returns (bool ok) {
        string memory sig = "setValidBalancerPool(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, balancerPool, valid));
    }

    function try_mapleGlobals_setValidPoolFactory(address globals, address factory, bool valid) external returns (bool ok) {
        string memory sig = "setValidPoolFactory(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, factory, valid));
    }

    function try_mapleGlobals_setValidLoanFactory(address globals, address factory, bool valid) external returns (bool ok) {
        string memory sig = "setValidLoanFactory(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, factory, valid));
    }

    function try_mapleGlobals_setValidSubFactory(address globals, address fac, address sub, bool valid) external returns (bool ok) {
        string memory sig = "setValidSubFactory(address,address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fac, sub, valid));
    }

    function try_mapleGlobals_setDefaultUniswapPath(address globals, address from, address to, address mid) external returns (bool ok) {
        string memory sig = "setDefaultUniswapPath(address,address,address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, from, to, mid));
    }

    function try_mapleGlobals_setPoolDelegateAllowlist(address globals, address pd, bool valid) external returns (bool ok) {
        string memory sig = "setPoolDelegateAllowlist(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, pd, valid));
    }

    function try_mapleGlobals_setCollateralAsset(address globals, address asset, bool valid) external returns (bool ok) {
        string memory sig = "setCollateralAsset(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, valid));
    }

    function try_mapleGlobals_setLiquidityAsset(address globals, address asset, bool valid) external returns (bool ok) {
        string memory sig = "setLiquidityAsset(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, valid));
    }

    function try_mapleGlobals_setCalc(address globals, address calc, bool valid) external returns (bool ok) {
        string memory sig = "setCalc(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, calc, valid));
    }

    function try_mapleGlobals_setInvestorFee(address globals, uint256 fee) external returns (bool ok) {
        string memory sig = "setInvestorFee(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fee));
    }

    function try_mapleGlobals_setTreasuryFee(address globals, uint256 fee) external returns (bool ok) {
        string memory sig = "setTreasuryFee(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fee));
    }

    function try_mapleGlobals_setMapleTreasury(address globals, address _treasury) external returns (bool ok) {
        string memory sig = "setMapleTreasury(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, _treasury));
    }

    function try_mapleGlobals_setDefaultGracePeriod(address globals, uint256 defaultGracePeriod) external returns (bool ok) {
        string memory sig = "setDefaultGracePeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, defaultGracePeriod));
    }

    function try_mapleGlobals_setMinLoanEquity(address globals, uint256 newLiquidity) external returns (bool ok) {
        string memory sig = "setMinLoanEquity(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, newLiquidity));
    }

    function try_mapleGlobals_setFundingPeriod(address globals, uint256 fundingPeriod) external returns (bool ok) {
        string memory sig = "setFundingPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fundingPeriod));
    }

    function try_mapleGlobals_setSwapOutRequired(address globals, uint256 swapAmt) external returns (bool ok) {
        string memory sig = "setSwapOutRequired(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, swapAmt));
    }

    function try_mapleGlobals_setPriceOracle(address globals, address asset, address oracle) external returns (bool ok) {
        string memory sig = "setPriceOracle(address,address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, oracle));
    }

    function try_mapleGlobals_setPendingGovernor(address globals, address pendingGov) external returns (bool ok) {
        string memory sig = "setPendingGovernor(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, pendingGov));
    }

    function try_mapleGlobals_acceptGovernor(address globals) external returns (bool ok) {
        string memory sig = "acceptGovernor()";
        (ok,) = globals.call(abi.encodeWithSignature(sig));
    }

}
