//  SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


contract DeVoterE{

    // Voters Struct
    struct Voter{
        string name;
        string nationality;
        uint age;
        string voterID;
        string adhaarNumber;
        string province;
        bool voted;
        uint256 timestamp;
    }

    // Vote Struct
    struct Vote{
        string voterID;
        uint256 timestamp;
        string candidateID;
        string province;
    }

    // Criminal Records Struct
    struct Criminal{
        string crime;
        string adhaarNumber;
        uint256 timestamp;
        bool convicted;
    }

    // Candidates Struct
    struct Candidate {
        string name;
        string partyName;
        bool isIndividual;
        string adhaarNumber;
        uint256 age;
        string province;
        uint256 totVotes;
        uint256 timestamp;
    }

    // counters
    uint256 private totValidVoters;
    uint256 private totCandidates;
    uint256 private totCriminals;
    uint256 private totVotes;
    uint256 private votingStart;
    uint256 private votingPeriod = 86400000;
    bool private votingActive = false;

    // mapping on the blockchain
    mapping(string => Voter) public validVoters;
    mapping(string => Vote) public votes;
    mapping(string => Criminal) public criminals;
    mapping(string => Candidate) public candidates;
    mapping(string => uint256) public partyVotes;


    // events on the blockchain
    event VoteRegistered(string, string, uint256);
    event VotingStarted(uint256);
    event VotingCompleted(uint256);
    event CriminalAdded(string, uint256);
    event VoterAdded(string, uint256);
    event CandidateAdded(string, uint256);

    // staring the voting
    function startVoting(uint256 _timestamp) public {
        votingStart = _timestamp;
        votingActive = true;
        emit VotingStarted(_timestamp);
    }
   
    // Total number of valid voters
    function getTotValidVoters() public view returns(uint256){
        return totValidVoters;
    }

    function getVotesCount() public view returns(uint256){
        return totVotes;
    }

    // Total number of valid candidates
    function getTotValidCandidates() public view returns(uint256){
        return totCandidates;
    }

    // Total number of criminals
    function getTotCriminals() public view returns(uint256){
        return totCriminals;
    }

    // Time elapsed since the voting started
    function getElapsedTime(uint _currTimeStamp) public view returns(uint256){
        return (_currTimeStamp - votingStart);
    }

    // Check for completion of whether or not voting is completed based on number of votes and time elapsed
    function isVotingCompleted(uint256 _currTimeStamp) public returns(bool){
 
        uint256 _timeElapsed = getElapsedTime(_currTimeStamp);
        votingActive = !((_timeElapsed == votingPeriod) && (totVotes == totValidVoters));


        return !votingActive;
    }

    // Setting a criminal record of any citizen and cancelling his/her candidancy
    function setCriminalRecord(string memory _adhaarNumber, string memory _crime, uint256 _currTimeStamp) public {
        Criminal memory _curr = Criminal(_crime, _adhaarNumber, _currTimeStamp, true);

        criminals[_adhaarNumber] = _curr;

        Candidate memory _currCandidate = candidates[_adhaarNumber];

        if(keccak256(abi.encodePacked(_curr.adhaarNumber)) == keccak256(abi.encodePacked(_currCandidate.adhaarNumber))){
            delete candidates[_adhaarNumber];
            totCandidates--;
        }
        
        totCriminals++;

        emit CriminalAdded(_adhaarNumber, _currTimeStamp);

    }

    // Registering unique votes if voting is active
    function registerVote(string memory _voterID, 
    string memory _candidateID, 
    uint256 _currTimeStamp, 
    string memory _province) public {
        
        require(votingActive, "Voting is in active currently");

        Vote memory _curr = Vote(_voterID, _currTimeStamp, _candidateID, _province);

        Voter memory _currVoter = validVoters[_voterID];

        Candidate memory _currCandidate = candidates[_candidateID];

        if(keccak256(abi.encodePacked(_currVoter.province)) == keccak256(abi.encodePacked(_currCandidate.province))){            

            if(!_currVoter.voted){

                votes[_voterID] = _curr;
                totVotes++;

                _currCandidate.totVotes++;

                _currVoter.voted = true;

                validVoters[_voterID] = _currVoter;
                candidates[_candidateID] = _currCandidate;

                partyVotes[_currCandidate.partyName]++;

                emit VoteRegistered(_voterID, _candidateID, _currTimeStamp);

            }
        }
    }

    // Registerring unique voters
    function registerVoter(string memory _name, 
    string memory _nationality, 
    uint _age, string memory _voterID, 
    string memory _adhaarNumber, 
    string memory _province,
    uint256 _currTimeStamp) public {
        Voter memory _curr = Voter(_name, _nationality, _age, _voterID, _adhaarNumber, _province, false, _currTimeStamp);

        Voter memory _temp = validVoters[_voterID];


        if(keccak256(abi.encodePacked(_curr.voterID)) != keccak256(abi.encodePacked(_temp.voterID))){
            
            validVoters[_voterID] = _curr;
            totValidVoters++;

            emit VoterAdded(_voterID, _currTimeStamp);
        }

    }

    // Registering candidates if not criminal
    function registerCandidate(string memory _name,
    string memory _partyName,
    bool _isIndividual,
    string memory _adhaarNumber,
    uint _age, 
    string memory _province,
    uint256 _currTimeStamp) public {

        Candidate memory _curr = Candidate(_name, _partyName, _isIndividual, _adhaarNumber, _age, _province, 0, _currTimeStamp);

        Criminal memory _currCriminal = criminals[_adhaarNumber];

        require(!_currCriminal.convicted, "Invalid Candidate for the elections");

        if(!_currCriminal.convicted){

            Candidate memory _temp = candidates[_adhaarNumber];


            if(keccak256(abi.encodePacked(_curr.adhaarNumber)) != keccak256(abi.encodePacked(_temp.adhaarNumber))){
                
                candidates[_adhaarNumber] = _curr;
                totCandidates++;

                emit CandidateAdded(_adhaarNumber, _currTimeStamp);
            }

        }

    }

}













// Event is an inheritable member of a contract. 
// An event is emitted, it stores the arguments passed in transaction logs. 
// These logs are stored on blockchain and are accessible using address of the contract till the contract is present on the blockchain. 
// An event generated is not accessible from within contracts, not even the one which have created and emitted them.