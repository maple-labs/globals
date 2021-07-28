// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { DSTest } from "../../modules/ds-test/src/test.sol";

import { GlobalAdmin } from "./accounts/GlobalAdmin.sol";
import { Governor }    from "./accounts/Governor.sol";

import { CalculatorMock, OracleMock, SubFactoryMock, TokenMock } from "./Mocks.sol";

import { MapleGlobals } from "../MapleGlobals.sol";

contract MapleGlobalsTest is DSTest {
    
    GlobalAdmin realGlobalAdmin;
    GlobalAdmin fakeGlobalAdmin;
    Governor    realGov; 
    Governor    fakeGov;

    MapleGlobals globals;

    function setUp() public {
        realGlobalAdmin = new GlobalAdmin();
        fakeGlobalAdmin = new GlobalAdmin();
        realGov         = new Governor();
        fakeGov         = new Governor();

        address mplMock         = address(1);
        address globalAdminMock = address(2);

        globals = new MapleGlobals(address(realGov), mplMock, address(realGlobalAdmin));
    }

    function test_constructor() public {
        address govMock         = address(0);
        address mplMock         = address(1);
        address globalAdminMock = address(2);

        MapleGlobals globalsMock = new MapleGlobals(govMock, mplMock, globalAdminMock);

        assertEq(globalsMock.governor(),             govMock);
        assertEq(globalsMock.mpl(),                  mplMock);
        assertEq(globalsMock.swapOutRequired(),      10_000);
        assertEq(globalsMock.fundingPeriod(),        10 days);
        assertEq(globalsMock.defaultGracePeriod(),   5 days);
        assertEq(globalsMock.investorFee(),          50);
        assertEq(globalsMock.treasuryFee(),          50);
        assertEq(globalsMock.maxSwapSlippage(),      1000);
        assertEq(globalsMock.minLoanEquity(),        2000);
        assertEq(globalsMock.globalAdmin(),          globalAdminMock);
        assertEq(globalsMock.stakerCooldownPeriod(), 10 days);
        assertEq(globalsMock.lpCooldownPeriod(),     10 days);
        assertEq(globalsMock.stakerUnstakeWindow(),  2 days);
        assertEq(globalsMock.lpWithdrawWindow(),     2 days);
    }

    function test_transfer_governor() public {
        assertTrue(!fakeGov.try_setPendingGovernor(address(globals), address(fakeGov)));
        assertTrue(!realGov.try_setPendingGovernor(address(globals), address(0)));        // Cannot set governor to zero
        assertTrue( realGov.try_setPendingGovernor(address(globals), address(fakeGov)));

        assertEq(globals.pendingGovernor(), address(fakeGov));
        assertEq(globals.governor(),        address(realGov));

        assertTrue(!fakeGov.try_setPendingGovernor(address(globals), address(realGov)));  // Still does not have permission as pendingGovernor

        assertTrue(!realGov.try_acceptGovernor(address(globals)));
        assertTrue( fakeGov.try_acceptGovernor(address(globals)));

        assertEq(globals.pendingGovernor(), address(0));
        assertEq(globals.governor(),        address(fakeGov));
    }

    /***************/
    /*** Setters ***/
    /***************/
    function test_setStakerCooldownPeriod() public {
        assertTrue(!fakeGov.try_setStakerCooldownPeriod(address(globals), 1 days));
        assertTrue( realGov.try_setStakerCooldownPeriod(address(globals), 1 days));
        assertEq(globals.stakerCooldownPeriod(), 1 days);
    }   
    
    function test_setLpCooldownPeriod() public {
        assertTrue(!fakeGov.try_setLpCooldownPeriod(address(globals), 1 days));
        assertTrue( realGov.try_setLpCooldownPeriod(address(globals), 1 days));
        assertEq(globals.lpCooldownPeriod(), 1 days);
    }
    
    function test_setStakerUnstakeWindow() public {
        assertTrue(!fakeGov.try_setStakerUnstakeWindow(address(globals), 1 days));
        assertTrue( realGov.try_setStakerUnstakeWindow(address(globals), 1 days));
        assertEq(globals.stakerUnstakeWindow(), 1 days);
    }
    
    function test_setLpWithdrawWindow() public {
        assertTrue(!fakeGov.try_setLpWithdrawWindow(address(globals), 1 days));
        assertTrue( realGov.try_setLpWithdrawWindow(address(globals), 1 days));
        assertEq(globals.lpWithdrawWindow(), 1 days);
    }
    
    function test_setMaxSwapSlippage() public {
        assertTrue(!fakeGov.try_setMaxSwapSlippage(address(globals), 10_000));
        assertTrue(!realGov.try_setMaxSwapSlippage(address(globals), 10_001));  // Out of range
        assertTrue( realGov.try_setMaxSwapSlippage(address(globals), 10_000));
        assertEq(globals.maxSwapSlippage(), 10_000);
    }
    
    function test_setGlobalAdmin() public {
        assertTrue(!fakeGov.try_setGlobalAdmin(address(globals), address(1)));
        assertTrue(!realGov.try_setGlobalAdmin(address(globals), address(0)));  // Can't set to zero address

        realGlobalAdmin.setProtocolPause(address(globals), true);
        assertTrue(!realGov.try_setGlobalAdmin(address(globals), address(1)));
        
        realGlobalAdmin.setProtocolPause(address(globals), false);
        assertTrue( realGov.try_setGlobalAdmin(address(globals), address(1)));
    }
    
    function test_setValidBalancerPool() public {
        assertTrue(!globals.isValidBalancerPool(address(1)));

        assertTrue(!fakeGov.try_setValidBalancerPool(address(globals), address(1), true));
        assertTrue( realGov.try_setValidBalancerPool(address(globals), address(1), true));
        assertTrue( globals.isValidBalancerPool(address(1)));

        assertTrue(!fakeGov.try_setValidBalancerPool(address(globals), address(1), false));
        assertTrue( realGov.try_setValidBalancerPool(address(globals), address(1), false));
        assertTrue(!globals.isValidBalancerPool(address(1)));
    }
    
    function test_setProtocolPause() public {
        assertTrue(!globals.protocolPaused());

        assertTrue(!fakeGlobalAdmin.try_setProtocolPause(address(globals), true));
        assertTrue( realGlobalAdmin.try_setProtocolPause(address(globals), true));
        assertTrue( globals.protocolPaused());

        assertTrue(!fakeGlobalAdmin.try_setProtocolPause(address(globals), false));
        assertTrue( realGlobalAdmin.try_setProtocolPause(address(globals), false));
        assertTrue(!globals.protocolPaused());
        
    }
    
    function test_setValidPoolFactory() public {
        assertTrue(!globals.isValidPoolFactory(address(1)));
        
        assertTrue(!fakeGov.try_setValidPoolFactory(address(globals), address(1), true));
        assertTrue( realGov.try_setValidPoolFactory(address(globals), address(1), true));
        assertTrue( globals.isValidPoolFactory(address(1)));

        assertTrue(!fakeGov.try_setValidPoolFactory(address(globals), address(1), false));
        assertTrue( realGov.try_setValidPoolFactory(address(globals), address(1), false));
        assertTrue(!globals.isValidPoolFactory(address(1)));
    }
    
    function test_setValidLoanFactory() public {
        assertTrue(!globals.isValidLoanFactory(address(1)));
        
        assertTrue(!fakeGov.try_setValidLoanFactory(address(globals), address(1), true));
        assertTrue( realGov.try_setValidLoanFactory(address(globals), address(1), true));
        assertTrue( globals.isValidLoanFactory(address(1)));

        assertTrue(!fakeGov.try_setValidLoanFactory(address(globals), address(1), false));
        assertTrue( realGov.try_setValidLoanFactory(address(globals), address(1), false));
        assertTrue(!globals.isValidLoanFactory(address(1)));
    }
    
    function test_setValidSubFactory() public {
        address loanFactoryMock = address(1);
        address poolFactoryMock = address(2);
        address subFactoryMock  = address(3);

        assertTrue(!globals.validSubFactories(loanFactoryMock, subFactoryMock));
        assertTrue(!globals.validSubFactories(poolFactoryMock, subFactoryMock));   

        assertTrue(!realGov.try_setValidSubFactory(address(globals), loanFactoryMock, subFactoryMock, true));  // Can't call since loanFactory not whitelisted
        assertTrue(!realGov.try_setValidSubFactory(address(globals), poolFactoryMock, subFactoryMock, true));  // Can't call since poolFactory not whitelisted

        realGov.setValidLoanFactory(address(globals), loanFactoryMock, true);

        assertTrue( realGov.try_setValidSubFactory(address(globals), loanFactoryMock, subFactoryMock, true));  // Can   call since loanFactory is  whitelisted
        assertTrue(!realGov.try_setValidSubFactory(address(globals), poolFactoryMock, subFactoryMock, true));  // Can't call since poolFactory not whitelisted

        assertTrue( globals.validSubFactories(loanFactoryMock, subFactoryMock));
        assertTrue(!globals.validSubFactories(poolFactoryMock, subFactoryMock));   

        realGov.setValidLoanFactory(address(globals), loanFactoryMock, false);
        realGov.setValidPoolFactory(address(globals), poolFactoryMock, true);

        assertTrue(!realGov.try_setValidSubFactory(address(globals), loanFactoryMock, subFactoryMock, true));  // Can't call since loanFactory not whitelisted
        assertTrue( realGov.try_setValidSubFactory(address(globals), poolFactoryMock, subFactoryMock, true));  // Can   call since poolFactory is  whitelisted
        
        assertTrue(!fakeGov.try_setValidSubFactory(address(globals), loanFactoryMock, subFactoryMock, true));  // Non-gov can't call
    }
    
    function test_setDefaultUniswapPath() public {
        address from = address(1);
        address to   = address(2);
        address mid  = address(3);

        assertEq(globals.defaultUniswapPath(from, to), address(0));

        assertTrue(!fakeGov.try_setDefaultUniswapPath(address(globals), from, to, mid));
        assertTrue( realGov.try_setDefaultUniswapPath(address(globals), from, to, mid));

        assertEq(globals.defaultUniswapPath(from, to), mid);
    }
    
    function test_setPoolDelegateAllowlist() public {
        assertTrue(!globals.isValidPoolDelegate(address(1)));
        
        assertTrue(!fakeGov.try_setPoolDelegateAllowlist(address(globals), address(1), true));
        assertTrue( realGov.try_setPoolDelegateAllowlist(address(globals), address(1), true));
        assertTrue( globals.isValidPoolDelegate(address(1)));

        assertTrue(!fakeGov.try_setPoolDelegateAllowlist(address(globals), address(1), false));
        assertTrue( realGov.try_setPoolDelegateAllowlist(address(globals), address(1), false));
        assertTrue(!globals.isValidPoolDelegate(address(1)));
    }
    
    function test_setCollateralAsset() public {
        address collateralAssetMock = address(new TokenMock());

        assertTrue(!globals.isValidCollateralAsset(collateralAssetMock));
        
        assertTrue(!fakeGov.try_setCollateralAsset(address(globals), collateralAssetMock, true));
        assertTrue( realGov.try_setCollateralAsset(address(globals), collateralAssetMock, true));
        assertTrue( globals.isValidCollateralAsset(collateralAssetMock));

        assertTrue(!fakeGov.try_setCollateralAsset(address(globals), collateralAssetMock, false));
        assertTrue( realGov.try_setCollateralAsset(address(globals), collateralAssetMock, false));
        assertTrue(!globals.isValidCollateralAsset(collateralAssetMock));
    }
    
    function test_setLiquidityAsset() public {
        address liquidityAssetMock = address(new TokenMock());

        assertTrue(!globals.isValidLiquidityAsset(liquidityAssetMock));
        
        assertTrue(!fakeGov.try_setLiquidityAsset(address(globals), liquidityAssetMock, true));
        assertTrue( realGov.try_setLiquidityAsset(address(globals), liquidityAssetMock, true));
        assertTrue( globals.isValidLiquidityAsset(liquidityAssetMock));

        assertTrue(!fakeGov.try_setLiquidityAsset(address(globals), liquidityAssetMock, false));
        assertTrue( realGov.try_setLiquidityAsset(address(globals), liquidityAssetMock, false));
        assertTrue(!globals.isValidLiquidityAsset(liquidityAssetMock));
    }
    
    function test_setCalc() public {
        assertTrue(!globals.validCalcs(address(1)));
        
        assertTrue(!fakeGov.try_setCalc(address(globals), address(1), true));
        assertTrue( realGov.try_setCalc(address(globals), address(1), true));
        assertTrue( globals.validCalcs(address(1)));

        assertTrue(!fakeGov.try_setCalc(address(globals), address(1), false));
        assertTrue( realGov.try_setCalc(address(globals), address(1), false));
        assertTrue(!globals.validCalcs(address(1)));
    }
    
    function test_setInvestorFee() public {
        assertEq(globals.treasuryFee(), 50);
        assertEq(globals.investorFee(), 50);

        assertTrue(!fakeGov.try_setInvestorFee(address(globals), 9_050));  // Non-governor cant set
        assertTrue(!realGov.try_setInvestorFee(address(globals), 9_951));  // 99.51 + 0.50 = 100.01% is outside of bounds
        assertTrue( realGov.try_setInvestorFee(address(globals), 9_950));  // 100% is upper bound

        assertEq(globals.investorFee(), 9_950);        
    }
    
    function test_setTreasuryFee() public {
        assertEq(globals.treasuryFee(), 50);
        assertEq(globals.investorFee(), 50);

        assertTrue(!fakeGov.try_setTreasuryFee(address(globals), 9_050));  // Non-governor cant set
        assertTrue(!realGov.try_setTreasuryFee(address(globals), 9_951));  // 99.51 + 0.50 = 100.01% is outside of bounds
        assertTrue( realGov.try_setTreasuryFee(address(globals), 9_950));  // 100% is upper bound

        assertEq(globals.treasuryFee(), 9_950); 
    }
    
    function test_setMapleTreasury() public {
        assertEq(globals.mapleTreasury(), address(0));
        
        assertTrue(!fakeGov.try_setMapleTreasury(address(globals), address(1)));
        assertTrue( realGov.try_setMapleTreasury(address(globals), address(1)));

        assertEq(globals.mapleTreasury(), address(1));
    }
    
    function test_setDefaultGracePeriod() public {
        assertTrue(!fakeGov.try_setDefaultGracePeriod(address(globals), 1 days));
        assertTrue( realGov.try_setDefaultGracePeriod(address(globals), 1 days));
        assertEq(globals.defaultGracePeriod(), 1 days);
    }
    
    function test_setMinLoanEquity() public {
        assertTrue(!fakeGov.try_setMinLoanEquity(address(globals), 1000));
        assertTrue( realGov.try_setMinLoanEquity(address(globals), 1000));
        assertEq(globals.minLoanEquity(), 1000);
        
    }
    
    function test_setFundingPeriod() public {
        assertTrue(!fakeGov.try_setFundingPeriod(address(globals), 1 days));
        assertTrue( realGov.try_setFundingPeriod(address(globals), 1 days));
        assertEq(globals.fundingPeriod(), 1 days);
    }
    
    function test_setSwapOutRequired() public {
        assertTrue(!fakeGov.try_setSwapOutRequired(address(globals), 10_000));
        assertTrue( realGov.try_setSwapOutRequired(address(globals), 10_000));
        assertEq(globals.swapOutRequired(), 10_000);
    }
    
    function test_setPriceOracle() public {
        assertEq(globals.oracleFor(address(1)), address(0));
        
        assertTrue(!fakeGov.try_setPriceOracle(address(globals), address(1), address(2)));
        assertTrue( realGov.try_setPriceOracle(address(globals), address(1), address(2)));

        assertEq(globals.oracleFor(address(1)), address(2));
    }
    
    function test_setPendingGovernor() public {
        assertEq(globals.pendingGovernor(), address(0));
        
        assertTrue(!fakeGov.try_setPendingGovernor(address(globals), address(1)));
        assertTrue( realGov.try_setPendingGovernor(address(globals), address(1)));

        assertEq(globals.pendingGovernor(), address(1));
    }

    /***************/
    /*** Getters ***/
    /***************/
    function test_getLatestPrice() public {
        address oracleMock = address(new OracleMock());
        realGov.setPriceOracle(address(globals), address(1), oracleMock);
        assertEq(globals.getLatestPrice(address(1)), 100);
    }

    function test_isValidSubFactory() public {
        address loanFactoryMock = address(1);
        address poolFactoryMock = address(2);
        address subFactoryMock  = address(new SubFactoryMock(1));

        realGov.setValidLoanFactory(address(globals), loanFactoryMock, true);
        realGov.setValidLoanFactory(address(globals), poolFactoryMock, true);

        assertTrue(!globals.isValidSubFactory(loanFactoryMock, subFactoryMock, 1));

        realGov.setValidSubFactory(address(globals), loanFactoryMock, subFactoryMock, true);

        assertTrue(!globals.isValidSubFactory(poolFactoryMock, subFactoryMock, 1));  // Wrong superfactory
        assertTrue(!globals.isValidSubFactory(loanFactoryMock, subFactoryMock, 2));  // Wrong subfactory type
        assertTrue( globals.isValidSubFactory(loanFactoryMock, subFactoryMock, 1));  // Wrong subfactory type
    }

    function test_isValidCalc() public {
        address calc = address(new CalculatorMock(1));
    
        realGov.setCalc(address(globals), calc, true);
        assertTrue(!globals.isValidCalc(calc, 2));
        assertTrue( globals.isValidCalc(calc, 1));
    }

    function test_getLpCooldownParams() public {
        (uint256 lpCooldownPeriod, uint256 lpWithdrawWindow) = globals.getLpCooldownParams();

        assertTrue(lpCooldownPeriod > 0 && lpWithdrawWindow > 0);  // Ensure real values are used

        assertEq(lpCooldownPeriod, globals.lpCooldownPeriod());
        assertEq(lpWithdrawWindow, globals.lpWithdrawWindow());
    }

}
