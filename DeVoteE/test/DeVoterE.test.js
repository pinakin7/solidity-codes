// writing test

const { assert } = require("chai");

const DeVoterE = artifacts.require("./DeVoterE.sol");

contract("DeVoterE", (accounts) => {
    before(async () => {
        this.deVoterE = await DeVoterE.deployed();
    });

    it("deploys successfully", async () => {
        const address = await this.deVoterE.address;
        assert.notEqual(address, 0x0);
        assert.notEqual(address, "");
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
    });

    it("created voters successfully", async()=>{

        await this.deVoterE.registerVoter("Ronaldo","Indian",36,"GUJ123456789","123456789852","Surat",Date.now()); 
        
        await this.deVoterE.registerVoter("Messi","Indian",34,"RAJ123456780","123456789853","Jaipur",Date.now()); 
        
        await this.deVoterE.registerVoter("Kohli","Indian",30,"MAH123456781","123456789854","Mumbai",Date.now()); 
        
        await this.deVoterE.registerVoter("Dhoni","Indian",36,"GOA123456782","123456789855","Panjim",Date.now()); 

        const validVoters = await this.deVoterE.getTotValidVoters();

        const validCandidates = await this.deVoterE.getTotValidCandidates();

        const totCriminals = await this.deVoterE.getTotCriminals();

        assert.equal(validVoters, 4);
        assert.equal(validCandidates, 0);
        assert.equal(totCriminals, 0);


    });

    it("created candidates successfully", async()=>{
        await this.deVoterE.registerCandidate("Shah Rukh Khan", "Khan-Tone", false, "321654987951",53,"Jaipur",Date.now()); 
        
        await this.deVoterE.registerCandidate("Salman Khan", "Khan-Tone", false, "321654987953",55,"Jaipur",Date.now()); 
        
        await this.deVoterE.registerCandidate("Aamir Khan", "Khan-Tone", false, "321654987957",52,"Mumbai",Date.now()); 
        
        await this.deVoterE.registerCandidate("Ranbir Kapoor", "Kapoor-Tone", true, "321654987958",52,"Goa",Date.now()); 

        const validVoters = await this.deVoterE.getTotValidVoters();

        const validCandidates = await this.deVoterE.getTotValidCandidates();

        const totCriminals = await this.deVoterE.getTotCriminals();

        assert.equal(validVoters, 4);
        assert.equal(validCandidates, 4);
        assert.equal(totCriminals, 0);

    });

    it("criminal created successfully", async()=>{

        await this.deVoterE.setCriminalRecord("654785985412","Murder",Date.now());

        const validVoters = await this.deVoterE.getTotValidVoters();

        const validCandidates = await this.deVoterE.getTotValidCandidates();

        const totCriminals = await this.deVoterE.getTotCriminals();

        assert.equal(validVoters, 4);
        assert.equal(validCandidates, 4);
        assert.equal(totCriminals, 1);

    });

    it("voting started", async()=>{
        
        const votingStart = Date.now()

        await this.deVoterE.startVoting(votingStart);

        const currTime = Date.now();

        const elapsedTime = await this.deVoterE.getElapsedTime(currTime);

        assert.equal(elapsedTime, (currTime-votingStart));

        const totVotes = await this.deVoterE.getVotesCount();

        assert.equal(totVotes, 0);

    });

    it("votes registered", async()=>{

        await this.deVoterE.registerVote("GUJ123456789","321654987951",Date.now(),"Surat");

        await this.deVoterE.registerVote("RAJ123456780","321654987953",Date.now(),"Jaipur");

        await this.deVoterE.registerVote("MAH123456781","321654987957",Date.now(),"Mumbai");

        await this.deVoterE.registerVote("GOA123456782","321654987958",Date.now(),"Goa");

        const totVotes = await this.deVoterE.getVotesCount();

        assert.equal(totVotes, 4);

        const KhTVotes = await this.deVoterE.partyVotes("Khan-Tone");

        const KpTVotes = await this.deVoterE.partyVotes("Kapoor-Tone");

        assert.equal(KhTVotes, 3);

        assert.equal(KpTVotes, 1);

    });

});
