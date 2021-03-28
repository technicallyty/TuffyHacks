pragma solidity ^0.8.0;

contract Election {

    struct Candidate {
        string name;
        uint voteCount;
    }

    struct Voter {
        uint vote;
        bool voted;
    }

    address public pollCreator;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public candidatesCount;

    constructor (string[] memory candidateNames) {
        //set the address as admin
        pollCreator = msg.sender;
        candidatesCount = 0;
        //admin sets up ballot names
        //push candidate names with 0 votes onto array
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
            candidatesCount++;
        }
    }

    function getCandidates() public view returns (Candidate[] memory) {
      return candidates;
    }

    function checkVotes(uint id) public view returns (uint) {
      uint count = candidates[id].voteCount;
      return count;
    }

    function giveRightToVote(address voter) public {
        //must be called from poll creator
        require(
            msg.sender == pollCreator,
            "Only the creator of the poll can give the right to vote."
        );
        //check if voter has previously voted
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        
        //not sure about this, trying to push voter into map
        //does it do it automatically? how would i push
        voters[voter].voted = false;

    }

    //candidate is an index of the array
    function vote (uint _candidateId) public {
        Voter storage sender = voters[msg.sender];

        //require that they haven't voted yet
        require(!sender.voted, "Already voted.");

        //require a valid candidate
        require(_candidateId >= 0 && _candidateId <= candidatesCount);
        
        //update to voted
        sender.voted = true;
        //update candidate vote count
        candidates[_candidateId].voteCount++;

    }
}