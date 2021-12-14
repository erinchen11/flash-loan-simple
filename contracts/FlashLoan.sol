pragma solidity ^0.6.6; 
import "./FlashLoanReceiverBase.sol"; 
import "./ILendingPoolAddressesProvider.sol"; 
import "./ILendingPool.sol"; 
contract FlashloanV1 is FlashLoanReceiverBaseV1 { 

    constructor(address_addressProvider) FlashLoanReceiverBaseV1(_addressProvider) public{

    } 
    function flashloan(address_asset) public onlyOwner { 
        bytes memory data = ""; uint amount = 1 ether; 
        ILendingPoolV1 lendingPool = ILendingPoolV1(addressesProvider.getLendingPool()); 
        lendingPool.flashLoan(address(this),_asset, amount, data); } 

    function executeOperation( address_reserve, uint256_amount, uint256_fee, bytes calldata_params ) external override {
         require(_amount <= getBalanceInternal(address(this),_reserve), "Invalid balance, was the flashLoan successful?"); 
    
         uint totalDebt =_amount.add(_fee); transferFundsBackToPoolInternal(_reserve, totalDebt); } 
}