contract PlutonSale {

	address public plutusBoard;
	uint public endTime;
	uint public startTime = now;
    uint public amountRaised;
    uint public bonus;
    User[] public users;
   
    // Logs a new contribution to the sale
    event Contribution(address indexed contributor, uint indexed amount, uint indexed bonus);

    // Data structure containing information on every contribution
    struct User {
        address contributor;
        uint amount;
        uint bonusPercent;
    }
    
    // Initializes the contract at the sale's start
    // duration is in seconds
    function PlutonSale(address owner, uint duration) {
    	plutusBoard = owner;
        endTime = startTime + duration;
    }


    modifier afterDeadline() { 
    	if (now > endTime) throw;
    		_ 
    }
    
    // This is the default function called when Ether is sent to the contract
    function () afterDeadline returns (bool success) {
    	uint bonusPeriod = 86400;
    	uint dayOne = startTime + bonusPeriod;
    	uint dayTwo = dayOne + bonusPeriod;
    	uint dayThree = dayTwo + bonusPeriod;
        if (now <= dayOne) {
            bonus = 3;
        } else if (now <= dayTwo) {
            bonus = 2;
        } else if (now <= dayThree) {
            bonus = 1;
        } else 
        	bonus = 0;

    	uint amount = msg.value;
        users[users.length++] = User({contributor: tx.origin, amount: amount, bonusPercent: bonus});
        amountRaised += amount;
        Contribution(tx.origin, amount, amountRaised);
    }


    modifier onlyPlutus() {
    	if (msg.sender != plutusBoard) throw;
    		_
    }

    modifier beforeEndSale() { 
    	if (now <= endTime) throw; 
    		_
    }
    
    // Sends sale proceeds to Plutus Board at the end of the sale
    function sendEthToPlutusBoard() onlyPlutus beforeEndSale {
        plutusBoard.send(this.balance);
    }
}
