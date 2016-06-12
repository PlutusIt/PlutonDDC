var PlutonSale = require(PlutonSale);
var Web3 = require('web3');
var web3 = new Web3();

web3.setProvider(new web3.providers.HttpProvider( /* INSERT IP:RPC */ ));

var newEther = PlutonSale.contributionCall({
	contributor: userAddress, 
	amount: amountSpent,
	bonus: userBonus
	}), {
	fromBlock: 0,
	toBlock: 'latest'
});

newEther.watch(function(err, result) {
	if (err) {
		console.log(err)
		return;
	}

	/// append details of result.args to frontend UI
})
