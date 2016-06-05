contract PlutusMultiSig {
     address plutus;
     address plutus2;
     address plutusBoard;
     uint numSigned = 0;
     bytes32 error;
     bool registeredYet;
     mapping (address => bool) signedYet;

     function PlutusMultiSig() {
       plutusBoard = msg.sender;
       registeredYet = false;
     }

     function register(address registerPlutus, address registerPlutus2) {
       if (msg.sender == plutusBoard && registeredYet == false) {
           plutus = registerPlutus;
           plutus2 = registerPlutus2;
           registeredYet = true;
       } else if (msg.sender == plutusBoard) {
           error = "registered already";
       } else {
         error = "you are not the Plutus Board!";
       }
   }

   function withdraw(address to) {
     if ((msg.sender == plutus || msg.sender == plutus2) && numSigned >= 2) {
        to.send(this.balance);
        numSigned = 0;
       signedYet[plutus] = signedYet[plutus2] = signedYet[plutusBoard] = false;
     } else {
        error = "cannot withdraw yet!";
     }
   }

   function addSignature() {
     if (msg.sender == plutus && signedYet[plutus]==false) {
       signedYet[plutus] = true;
       numSigned++;
     } else if (msg.sender == plutus2 && signedYet[plutus2]==false) {
       signedYet[plutus2] = true;
       numSigned++;
     } else if (msg.sender == plutusBoard && signedYet[plutusBoard]==false) {
       signedYet[plutusBoard] = true;
       numSigned++;
     } else {
       error = 'unknown address';
     }
   }
}