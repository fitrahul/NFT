// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ERC721Token {
    mapping (address => uint256) public balances;
    mapping (uint256 => address) public owners; // return owner address
    mapping (address => mapping (address => bool)) public operatorApprovals;
    mapping (uint256 => address) tokenApprovals; // return address of _operator(to whom owner approve their Token Id)

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // 1.
    function balanceOf(address _owner) public view returns (uint256) {
        // check the address of owner is valid or not
        // check the balances of a prticular owner
        require(_owner != address(0), "Not a valid Address");
        return balances[_owner];
    }

    // 2.
    function ownerOf(uint256 _tokenId) public view returns (address) {
        // check the address of owner is valid or not
        // check the owner of a prticular NFT or Token Id
        require(owners[_tokenId] != address(0), "Not a valid Token Id");
        return owners[_tokenId];
    }

    // 3. for all NFT
    function setApprovalForAll(address _operator, bool _approved) public {
        // approve the _operator for all NFT of owner(msg.sender);
        operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        // to check all NFT are approved to _operator by owner or not
        require(_owner != address(0) && _operator != address(0), "Not the valid Address");
        return operatorApprovals[_owner][_operator];
    }

    // 4. for some NFT
    function approve(address _approved, uint256 _tokenId) public payable {
        // check Token Id belongs to owner and operator or not
        // point _approved address to Token Id of owner address
        require(_approved != address(0), "Address of _approved is invalid");
        require(owners[_tokenId] == msg.sender || isApprovedForAll(msg.sender, owners[_tokenId]), "Token Id not belong to Owner or Operator");
        tokenApprovals[_tokenId] = _approved;
        emit Approval(owners[_tokenId], _approved, _tokenId);
    }

    function getApproved(uint256 _tokenId) public view returns (address) {
        // get the _approved address of Token Id
        require(owners[_tokenId] != address(0), "Token Id is not a valid NFT");
        return tokenApprovals[_tokenId];
    }

    // 5.
    function transferFrom(address _from, address _to, uint256 _tokenId) public payable {
        address owner = owners[_tokenId]; // address owner = ownerOf(_tokenId)
        address approvedAddress = tokenApprovals[_tokenId];
        require(owner == msg.sender|| isApprovedForAll(msg.sender, approvedAddress), "Msg.sender is not owner or Operator address is not a valid address");
        require(_from == owner, "From is not owner");
        require(_to != address(0), "To address is invalid");
        require(owner != address(0), "Token Id is not valid");
        balances[_from] -= 1; // 1 NFT decrease
        balances[_to] += 1;
        owners[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    // 6.
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public {
        transferFrom(_from, _to, _tokenId);
        require(_checkOnERC721Received(), "Reciever not implement");
    }

    function _checkOnERC721Received() private pure returns(bool) {
        return true;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }
}