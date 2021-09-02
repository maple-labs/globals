// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { IMapleGlobals } from "../../interfaces/IMapleGlobals.sol";

import { PendingGovernor } from "./PendingGovernor.sol";

contract Governor is PendingGovernor {

    /************************/
    /*** Direct Functions ***/
    /************************/

    function mapleGlobals_setStakerCooldownPeriod(address globals, uint256 newCooldownPeriod) external {
        IMapleGlobals(globals).setStakerCooldownPeriod(newCooldownPeriod);
    }

    function mapleGlobals_setLpCooldownPeriod(address globals, uint256 newCooldownPeriod) external {
        IMapleGlobals(globals).setLpCooldownPeriod(newCooldownPeriod);
    }

    function mapleGlobals_setStakerUnstakeWindow(address globals, uint256 newUnstakeWindow) external {
        IMapleGlobals(globals).setStakerUnstakeWindow(newUnstakeWindow);
    }

    function mapleGlobals_setLpWithdrawWindow(address globals, uint256 newLpWithdrawWindow) external {
        IMapleGlobals(globals).setLpWithdrawWindow(newLpWithdrawWindow);
    }

    function mapleGlobals_setMaxSwapSlippage(address globals, uint256 newMaxSlippage) external {
        IMapleGlobals(globals).setMaxSwapSlippage(newMaxSlippage);
    }

    function mapleGlobals_setGlobalAdmin(address globals, address newGlobalAdmin) external {
        IMapleGlobals(globals).setGlobalAdmin(newGlobalAdmin);
    }

    function mapleGlobals_setValidBalancerPool(address globals, address balancerPool, bool valid) external {
        IMapleGlobals(globals).setValidBalancerPool(balancerPool, valid);
    }

    function mapleGlobals_setValidPoolFactory(address globals, address factory, bool valid) external {
        IMapleGlobals(globals).setValidPoolFactory(factory, valid);
    }

    function mapleGlobals_setValidLoanFactory(address globals, address factory, bool valid) external {
        IMapleGlobals(globals).setValidLoanFactory(factory, valid);
    }

    function mapleGlobals_setValidSubFactory(address globals, address fac, address sub, bool valid) external {
        IMapleGlobals(globals).setValidSubFactory(fac, sub, valid);
    }

    function mapleGlobals_setDefaultUniswapPath(address globals, address from, address to, address mid) external {
        IMapleGlobals(globals).setDefaultUniswapPath(from, to, mid);
    }

    function mapleGlobals_setPoolDelegateAllowlist(address globals, address delegate, bool valid) external {
        IMapleGlobals(globals).setPoolDelegateAllowlist(delegate, valid);
    }

    function mapleGlobals_setCollateralAsset(address globals, address asset, bool valid) external {
        IMapleGlobals(globals).setCollateralAsset(asset, valid);
    }

    function mapleGlobals_setLiquidityAsset(address globals, address asset, bool valid) external {
        IMapleGlobals(globals).setLiquidityAsset(asset, valid);
    }

    function mapleGlobals_setCalc(address globals, address calc, bool valid) external {
        IMapleGlobals(globals).setCalc(calc, valid);
    }

    function mapleGlobals_setInvestorFee(address globals, uint256 fee) external {
        IMapleGlobals(globals).setInvestorFee(fee);
    }

    function mapleGlobals_setTreasuryFee(address globals, uint256 fee) external {
        IMapleGlobals(globals).setTreasuryFee(fee);
    }

    function mapleGlobals_setMapleTreasury(address globals, address mapleTreasury) external {
        IMapleGlobals(globals).setMapleTreasury(mapleTreasury);
    }

    function mapleGlobals_setDefaultGracePeriod(address globals, uint256 defaultGracePeriod) external {
        IMapleGlobals(globals).setDefaultGracePeriod(defaultGracePeriod);
    }

    function mapleGlobals_setMinLoanEquity(address globals, uint256 minLoanEquity) external {
        IMapleGlobals(globals).setMinLoanEquity(minLoanEquity);
    }

    function mapleGlobals_setFundingPeriod(address globals, uint256 fundingPeriod) external {
        IMapleGlobals(globals).setFundingPeriod(fundingPeriod);
    }

    function mapleGlobals_setSwapOutRequired(address globals, uint256 amount) external {
        IMapleGlobals(globals).setSwapOutRequired(amount);
    }

    function mapleGlobals_setPriceOracle(address globals, address asset, address oracle) external {
        IMapleGlobals(globals).setPriceOracle(asset, oracle);
    }

    function mapleGlobals_setPendingGovernor(address globals, address pendingGovernor) external {
        IMapleGlobals(globals).setPendingGovernor(pendingGovernor);
    }

    /*********************/
    /*** Try Functions ***/
    /*********************/

    function try_mapleGlobals_setStakerCooldownPeriod(address globals, uint256 newCooldownPeriod) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setStakerCooldownPeriod.selector, newCooldownPeriod));
    }

    function try_mapleGlobals_setLpCooldownPeriod(address globals, uint256 newCooldownPeriod) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setLpCooldownPeriod.selector, newCooldownPeriod));
    }

    function try_mapleGlobals_setStakerUnstakeWindow(address globals, uint256 period) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setStakerUnstakeWindow.selector, period));
    }

    function try_mapleGlobals_setLpWithdrawWindow(address globals, uint256 period) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setLpWithdrawWindow.selector, period));
    }

    function try_mapleGlobals_setMaxSwapSlippage(address globals, uint256 newSlippage) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setMaxSwapSlippage.selector, newSlippage));
    }

    function try_mapleGlobals_setGlobalAdmin(address globals, address globalAdmin) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setGlobalAdmin.selector, globalAdmin));
    }

    function try_mapleGlobals_setValidBalancerPool(address globals, address balancerPool, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setValidBalancerPool.selector, balancerPool, valid));
    }

    function try_mapleGlobals_setValidPoolFactory(address globals, address factory, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setValidPoolFactory.selector, factory, valid));
    }

    function try_mapleGlobals_setValidLoanFactory(address globals, address factory, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setValidLoanFactory.selector, factory, valid));
    }

    function try_mapleGlobals_setValidSubFactory(address globals, address fac, address sub, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setValidSubFactory.selector, fac, sub, valid));
    }

    function try_mapleGlobals_setDefaultUniswapPath(address globals, address from, address to, address mid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setDefaultUniswapPath.selector, from, to, mid));
    }

    function try_mapleGlobals_setPoolDelegateAllowlist(address globals, address pd, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setPoolDelegateAllowlist.selector, pd, valid));
    }

    function try_mapleGlobals_setCollateralAsset(address globals, address asset, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setCollateralAsset.selector, asset, valid));
    }

    function try_mapleGlobals_setLiquidityAsset(address globals, address asset, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setLiquidityAsset.selector, asset, valid));
    }

    function try_mapleGlobals_setCalc(address globals, address calc, bool valid) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setCalc.selector, calc, valid));
    }

    function try_mapleGlobals_setInvestorFee(address globals, uint256 fee) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setInvestorFee.selector, fee));
    }

    function try_mapleGlobals_setTreasuryFee(address globals, uint256 fee) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setTreasuryFee.selector, fee));
    }

    function try_mapleGlobals_setMapleTreasury(address globals, address _treasury) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setMapleTreasury.selector, _treasury));
    }

    function try_mapleGlobals_setDefaultGracePeriod(address globals, uint256 defaultGracePeriod) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setDefaultGracePeriod.selector, defaultGracePeriod));
    }

    function try_mapleGlobals_setMinLoanEquity(address globals, uint256 newLiquidity) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setMinLoanEquity.selector, newLiquidity));
    }

    function try_mapleGlobals_setFundingPeriod(address globals, uint256 fundingPeriod) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setFundingPeriod.selector, fundingPeriod));
    }

    function try_mapleGlobals_setSwapOutRequired(address globals, uint256 swapAmt) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setSwapOutRequired.selector, swapAmt));
    }

    function try_mapleGlobals_setPriceOracle(address globals, address asset, address oracle) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setPriceOracle.selector, asset, oracle));
    }

    function try_mapleGlobals_setPendingGovernor(address globals, address pendingGov) external returns (bool ok) {
        (ok,) = globals.call(abi.encodeWithSelector(IMapleGlobals.setPendingGovernor.selector, pendingGov));
    }

}
