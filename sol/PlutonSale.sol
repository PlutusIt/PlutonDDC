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
    
    // Initializes the contract at the sale's start.
    // Param duration is in seconds
    function PlutonSale(address owner, uint duration) {
    	plutusBoard = owner;
        endTime = startTime + duration;
    }

    modifier beforeDeadline() { 
    	if (now > endTime) throw;
    		_ 
    }
    
    // Determines if you get a bonus of 1%, 2%, 3%, or 0%
    function bonusPercent() beforeDeadline returns (uint bonus) {
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

        return bonus;
    }

    // This is the default function called when Ether
    // is sent to this contract address.
    function () beforeDeadline returns (bool success) {
    	bonusPercent();
    	uint amount = msg.value;
        users[users.length++] = User({contributor: tx.origin, amount: amount, bonusPercent: bonus});
        amountRaised += amount;
        contributionCall();
    }

    // logs each transaction for the frontend UI to display
    function contributionCall() {
        uint amount;
        Contribution(tx.origin, amount, amountRaised);
    }

    modifier afterDeadline() { 
    	if (now <= endTime) throw; 
    		_
    }

    // Returns the total amount raised after the sale
    function saleProceeds() afterDeadline returns (uint amountRaised) {
        return amountRaised;
    }

    modifier onlyPlutus() {
        if (msg.sender != plutusBoard) throw;
            _
    }
    
    // Sends sale proceeds to Plutus Board at the end of the sale
    function sendEthToPlutusBoard() onlyPlutus afterDeadline {
        plutusBoard.send(this.balance);
    }
}
