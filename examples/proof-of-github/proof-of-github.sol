contract ProofOfGithub {
    address owner;

    struct GitHubProof {
        bool hasAccount;
        uint validatedOn;
    }

    mapping(address => GitHubProof) validations;

    modifier onlyOwner() {
        if (owner != msg.sender) throw;
        _;
    }

    function ProofOfGithubPrivacy() {
            owner = msg.sender;
    }

    function newAccountToAddress(address addr)
        onlyOwner
        {
        validations[addr] = GitHubProof({
            hasAccount: true,
            validatedOn: now
        });
    }

    function getByAddress(address addr) constant returns(bool) {
        return (validations[addr].validatedOn != uint(0x0));
    }

    function getDateValidated(address addr) constant returns(uint) {
        return validations[addr].validatedOn;
    }

    function postProof(bytes username) returns (uint balance) {
        if(!msg.sender.send(msg.value)) {
            throw;
        }

        return msg.value;
    }

    function kill()
        onlyOwner {
        selfdestruct(owner);
    }
}
