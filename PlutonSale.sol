contract PlutonSale {
    address public plutusBoard;
    uint public amountRaised;
    uint public deadline;
    
    // Initializes the contract at the sale's start
    function PlutonSale(address _plutusBoard, uint _duration) {
        plutusBoard = _plutusBoard;
        deadline = now + _duration * 1 minutes;
    }
    
    // Logs a new contribution to the sale
    event FundTransfer(address indexed contributor, uint indexed amount, bool isContribution);
    
    // If Ether is sent to the contract after the end of the sale, it is refused
    modifier afterDeadline() { if (now >= deadline) _ }
    
    // This is the default function called when Ether is sent to the contract's address
    function () afterDeadline {
        uint amount = msg.value;
        amountRaised += amount;
        FundTransfer(msg.sender, amount, true);
    }
    
    // Returns the amount of Ether raised so far
    function getFundsRaised() returns (uint amountRaised) {
        amountRaised = this.balance;
    }
    
    // modifier to prevent sending funds to address plutusBoard before the sale end
    modifier beforeDeadline() { if (now < deadline) _ }
    
    // Logs the final amount of ETH raised and the MultiSig address the funds are sent to
    event EndSale(address plutusBoard, uint amountRaised);
    
    // Sends sale proceeds to the plutusMultiSig contract address at the end of the sale
    function sendToPlutusBoard(address _plutusBoard) beforeDeadline private returns(bool) {
        EndSale(plutusBoard, amountRaised);
        plutusBoard = _plutusBoard;
        _plutusBoard.send(this.balance);
    }
}
