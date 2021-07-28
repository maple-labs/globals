// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

import { IERC20 } from "../../../modules/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import { IMapleGlobals } from "../../interfaces/IMapleGlobals.sol";
// import { MplRewards, MplRewardsFactory } from "../../core/mpl-rewards/contracts/MplRewardsFactory.sol";
// import { MapleTreasury }                 from "../../core/treasury/contracts/MapleTreasury.sol";

contract Governor {

    /************************/
    /*** DIRECT FUNCTIONS ***/
    /************************/

    // MplRewards        mplRewards;
    // MplRewardsFactory mplRewardsFactory;
    // MapleTreasury     treasury;

    // function createGlobals(address mpl) external returns (MapleGlobals) {
    //     globals = new MapleGlobals(address(this), mpl, address(1));
    //     return globals;
    // }

    // function createMplRewardsFactory() external returns (MplRewardsFactory) {
    //     mplRewardsFactory = new MplRewardsFactory(address(globals));
    //     return mplRewardsFactory;
    // }

    // function createMplRewards(address mpl, address pool) external returns (MplRewards) {
    //     mplRewards = MplRewards(mplRewardsFactory.createMplRewards(mpl, pool));
    //     return mplRewards;
    // }

    // // Used for "fake" governors pointing at a globals contract they didn't create
    // function setGovGlobals(MapleGlobals _globals) external {
    //     globals = _globals;
    // }

    // function setGovMplRewardsFactory(MplRewardsFactory _mplRewardsFactory) external {
    //     mplRewardsFactory = _mplRewardsFactory;
    // }

    // // Used for "fake" governors pointing at a staking rewards contract they don't own
    // function setGovMplRewards(MplRewards _mplRewards) external {
    //     mplRewards = _mplRewards;
    // }

    // // Used for "fake" governors pointing at a treasury contract they didn't create
    // function setGovTreasury(MapleTreasury _treasury) external {
    //     treasury = _treasury;
    // }

    // function transfer(IERC20 token, address account, uint256 amt) external {
    //     token.transfer(account, amt);
    // }

    /*** MapleGlobals Setters ***/
    function setCalc(address globals, address calc, bool valid)                            external { IMapleGlobals(globals).setCalc(calc, valid); }
    function setCollateralAsset(address globals, address asset, bool valid)                external { IMapleGlobals(globals).setCollateralAsset(asset, valid); }
    function setLiquidityAsset(address globals, address asset, bool valid)                 external { IMapleGlobals(globals).setLiquidityAsset(asset, valid); }
    function setValidLoanFactory(address globals, address factory, bool valid)             external { IMapleGlobals(globals).setValidLoanFactory(factory, valid); }
    function setValidPoolFactory(address globals, address factory, bool valid)             external { IMapleGlobals(globals).setValidPoolFactory(factory, valid); }
    function setValidSubFactory(address globals, address fac, address sub, bool valid)     external { IMapleGlobals(globals).setValidSubFactory(fac, sub, valid); }
    function setMapleTreasury(address globals, address _treasury)                          external { IMapleGlobals(globals).setMapleTreasury(_treasury); }
    function setGlobalAdmin(address globals, address _globalAdmin)                         external { IMapleGlobals(globals).setGlobalAdmin(_globalAdmin); }
    function setPoolDelegateAllowlist(address globals, address pd, bool valid)             external { IMapleGlobals(globals).setPoolDelegateAllowlist(pd, valid); }
    function setInvestorFee(address globals, uint256 fee)                                  external { IMapleGlobals(globals).setInvestorFee(fee); }
    function setTreasuryFee(address globals, uint256 fee)                                  external { IMapleGlobals(globals).setTreasuryFee(fee); }
    function setDefaultGracePeriod(address globals, uint256 period)                        external { IMapleGlobals(globals).setDefaultGracePeriod(period); }
    function setFundingPeriod(address globals, uint256 period)                             external { IMapleGlobals(globals).setFundingPeriod(period); }
    function setSwapOutRequired(address globals, uint256 swapAmt)                          external { IMapleGlobals(globals).setSwapOutRequired(swapAmt); }
    function setPendingGovernor(address globals, address gov)                              external { IMapleGlobals(globals).setPendingGovernor(gov); }
    function acceptGovernor(address globals)                                               external { IMapleGlobals(globals).acceptGovernor(); }
    function setPriceOracle(address globals, address asset, address oracle)                external { IMapleGlobals(globals).setPriceOracle(asset, oracle); }
    function setMaxSwapSlippage(address globals, uint256 newSlippage)                      external { IMapleGlobals(globals).setMaxSwapSlippage(newSlippage); }
    function setDefaultUniswapPath(address globals, address from, address to, address mid) external { IMapleGlobals(globals).setDefaultUniswapPath(from, to, mid); }
    function setValidBalancerPool(address globals, address balancerPool, bool valid)       external { IMapleGlobals(globals).setValidBalancerPool(balancerPool, valid); }
    function setLpCooldownPeriod(address globals, uint256 period)                          external { IMapleGlobals(globals).setLpCooldownPeriod(period); }
    function setStakerCooldownPeriod(address globals, uint256 period)                      external { IMapleGlobals(globals).setStakerCooldownPeriod(period); }
    function setLpWithdrawWindow(address globals, uint256 period)                          external { IMapleGlobals(globals).setLpWithdrawWindow(period); }
    function setStakerUnstakeWindow(address globals, uint256 period)                       external { IMapleGlobals(globals).setStakerUnstakeWindow(period); }

    /*********************/
    /*** TRY FUNCTIONS ***/
    /*********************/

    /*** MapleGlobals Setters ***/
    function try_setStakerCooldownPeriod(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setStakerCooldownPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_setLpCooldownPeriod(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setLpCooldownPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_setStakerUnstakeWindow(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setStakerUnstakeWindow(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_setLpWithdrawWindow(address globals, uint256 period) external returns (bool ok) {
        string memory sig = "setLpWithdrawWindow(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, period));
    }

    function try_setMaxSwapSlippage(address globals, uint256 newSlippage) external returns (bool ok) {
        string memory sig = "setMaxSwapSlippage(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, newSlippage));
    }

    function try_setGlobalAdmin(address globals, address globalAdmin) external returns (bool ok) {
        string memory sig = "setGlobalAdmin(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, globalAdmin));
    }














    function try_setGlobals(address globals, address target, address _globals) external returns (bool ok) {
        string memory sig = "setGlobals(address)";
        (ok,) = address(target).call(abi.encodeWithSignature(sig, _globals));
    }

    function try_setDefaultUniswapPath(address globals, address from, address to, address mid) external returns (bool ok) {
        string memory sig = "setDefaultUniswapPath(address,address,address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, from, to, mid));
    }

    function try_setCalc(address globals, address calc, bool valid) external returns (bool ok) {
        string memory sig = "setCalc(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, calc, valid));
    }

    function try_setCollateralAsset(address globals, address asset, bool valid) external returns (bool ok) {
        string memory sig = "setCollateralAsset(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, valid));
    }

    function try_setLiquidityAsset(address globals, address asset, bool valid) external returns (bool ok) {
        string memory sig = "setLiquidityAsset(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, valid));
    }

    function try_setValidLoanFactory(address globals, address factory, bool valid) external returns (bool ok) {
        string memory sig = "setValidLoanFactory(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, factory, valid));
    }

    function try_setValidPoolFactory(address globals, address factory, bool valid) external returns (bool ok) {
        string memory sig = "setValidPoolFactory(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, factory, valid));
    }

    function try_setValidSubFactory(address globals, address fac, address sub, bool valid) external returns (bool ok) {
        string memory sig = "setValidSubFactory(address,address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fac, sub, valid));
    }

    function try_setMapleTreasury(address globals, address _treasury) external returns (bool ok) {
        string memory sig = "setMapleTreasury(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, _treasury));
    }

    function try_setPoolDelegateAllowlist(address globals, address pd, bool valid) external returns (bool ok) {
        string memory sig = "setPoolDelegateAllowlist(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, pd, valid));
    }

    function try_setInvestorFee(address globals, uint256 fee) external returns (bool ok) {
        string memory sig = "setInvestorFee(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fee));
    }

    function try_setTreasuryFee(address globals, uint256 fee) external returns (bool ok) {
        string memory sig = "setTreasuryFee(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fee));
    }

    function try_setDefaultGracePeriod(address globals, uint256 defaultGracePeriod) external returns (bool ok) {
        string memory sig = "setDefaultGracePeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, defaultGracePeriod));
    }

    function try_setFundingPeriod(address globals, uint256 fundingPeriod) external returns (bool ok) {
        string memory sig = "setFundingPeriod(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, fundingPeriod));
    }

    function try_setSwapOutRequired(address globals, uint256 swapAmt) external returns (bool ok) {
        string memory sig = "setSwapOutRequired(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, swapAmt));
    }

    function try_setPendingGovernor(address globals, address pendingGov) external returns (bool ok) {
        string memory sig = "setPendingGovernor(address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, pendingGov));
    }

    function try_acceptGovernor(address globals) external returns (bool ok) {
        string memory sig = "acceptGovernor()";
        (ok,) = globals.call(abi.encodeWithSignature(sig));
    }

    function try_setPriceOracle(address globals, address asset, address oracle) external returns (bool ok) {
        string memory sig = "setPriceOracle(address,address)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, asset, oracle));
    }

    

    function try_setValidBalancerPool(address globals, address balancerPool, bool valid) external returns (bool ok) {
        string memory sig = "setValidBalancerPool(address,bool)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, balancerPool, valid));
    }

    function try_setMinLoanEquity(address globals, uint256 newLiquidity) external returns (bool ok) {
        string memory sig = "setMinLoanEquity(uint256)";
        (ok,) = globals.call(abi.encodeWithSignature(sig, newLiquidity));
    }

    

    

    

    
}
