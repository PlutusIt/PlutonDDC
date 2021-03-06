var Web3 = require('web3');
var web3 = new Web3();

web3.setProvider(new web3.providers.HttpProvider( /* INSERT IP ADDRESS:RPC PORT*/ ));

var owner = /* INSERT PLUTUS BOARD ADDRESS */;
var duration = 1814400;

var plutonsaleContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"endTime","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"users","outputs":[{"name":"contributor","type":"address"},{"name":"amount","type":"uint256"},{"name":"bonusPercent","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[],"name":"contributionCall","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"bonus","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"startTime","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"amountRaised","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[],"name":"sendEthToPlutusBoard","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"plutusBoard","outputs":[{"name":"","type":"address"}],"type":"function"},{"inputs":[{"name":"owner","type":"address"},{"name":"duration","type":"uint256"}],"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"contributor","type":"address"},{"indexed":true,"name":"amount","type":"uint256"},{"indexed":true,"name":"bonus","type":"uint256"}],"name":"Contribution","type":"event"}]);
var plutonsale = plutonsaleContract.new(
   owner,
   duration,
   {
     from: web3.eth.accounts[0], 
     data: '60606040524260026000505560405160408061060e833981016040528080519060200190919080519060200190919050505b81600060006101000a81548173ffffffffffffffffffffffffffffffffffffffff0219169083021790555080600260005054016001600050819055505b50506105908061007e6000396000f36060604052361561008a576000357c0100000000000000000000000000000000000000000000000000000000900480633197cbb614610282578063365b98b2146102a55780636fd965b8146102f557806375b4d78c1461030457806378e97925146103275780637b3e5e7b1461034a5780638322e5e51461036d5780638e42436d1461037c5761008a565b61026a5b6000600060006000600060006001600050544211156100ac57610002565b620151809450846002600050540193508484019250848301915083421115156100df57600360046000508190555061011f565b82421115156100f857600260046000508190555061011e565b814211151561011157600160046000508190555061011d565b60006004600050819055505b5b5b34905060606040519081016040528032815260200182815260200160046000505481526020015060056000506005600050805480919060010190908154818355818115116101db576003028160030283600052602060002091820191016101da9190610186565b808211156101d65760006000820160006101000a81549073ffffffffffffffffffffffffffffffffffffffff02191690556001820160005060009055600282016000506000905550600301610186565b5090565b5b505050815481101561000257906000526020600020906003020160005b5060008201518160000160006101000a81548173ffffffffffffffffffffffffffffffffffffffff0219169083021790555060208201518160010160005055604082015181600201600050559050508060036000828282505401925050819055506102616103b5565b5b505050505090565b60405180821515815260200191505060405180910390f35b61028f6004805050610408565b6040518082815260200191505060405180910390f35b6102bb6004808035906020019091905050610411565b604051808473ffffffffffffffffffffffffffffffffffffffff168152602001838152602001828152602001935050505060405180910390f35b61030260048050506103b5565b005b6103116004805050610471565b6040518082815260200191505060405180910390f35b610334600480505061047a565b6040518082815260200191505060405180910390f35b6103576004805050610483565b6040518082815260200191505060405180910390f35b61037a600480505061048c565b005b610389600480505061056a565b604051808273ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6000600360005054813273ffffffffffffffffffffffffffffffffffffffff167f5f7675b09617d2c9fa4fd13058ee5877a9538f626b0308816736e83748a4504060405180905060405180910390a45b50565b60016000505481565b600560005081815481101561000257906000526020600020906003020160005b915090508060000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16908060010160005054908060020160005054905083565b60046000505481565b60026000505481565b60036000505481565b600060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156104e857610002565b600160005054421115156104fb57610002565b600060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1660003073ffffffffffffffffffffffffffffffffffffffff1631604051809050600060405180830381858888f19350505050505b565b600060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff168156', 
     gas: 3000000
   }, function(e, contract){
    console.log(e, contract);
    if (typeof contract.address != 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })

var newEther = plutonsale.contributionCall({
	contributor: userAddress, 
	amount: amountSpent,
	bonus: userBonus
	}, {
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

// returns total ETH in account
web3.eth.watch({altered: web3.eth.coinbase}).changed(function(){
  	web3.eth.coinbase.then(function(result) {
  		document.getElementById('coinbase').innerText = result;
  	});
  	web3.eth.balanceAt(web3.eth.coinbase).then(function(result){
    	document.getElementById('balance').innerText = result;
    });
});