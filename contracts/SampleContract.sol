pragma solidity ^0.4.7;

import "@digix/solidity-core-libraries/contracts/MathUtils.sol";

contract SampleContract {

  address public owner;

  struct Data {
    address user;
    uint256 age;
    uint256 last_update;
    bool active;
  }

  mapping (uint256 => Data) dataCollection;
  uint256 public dataCount;

  modifier ifOwner() {
    if (owner != msg.sender) {
      throw;
    } else {
      _;
    }
  }

  function SampleContract() {
    owner = msg.sender;
  }

  function addData(address _user, uint256 _age, bool _isactive) ifOwner returns (bool _success) {
    var dataid = dataCount++;
    dataCollection[dataid].user = _user;
    dataCollection[dataid].age = _age;
    dataCollection[dataid].active = _isactive;
    dataCollection[dataid].last_update = now;
    _success = true;
    return _success;
  }

  function getData(uint256 _dataid) returns (address _user, uint256 _age, bool _isactive) {
    (_user, _age, _isactive) = (dataCollection[_dataid].user, dataCollection[_dataid].age, dataCollection[_dataid].active);
    return (_user, _age, _isactive);
  }

  function updateAge(uint256 _dataid, uint256 _age) ifOwner returns (bool _success) {
    dataCollection[_dataid].age = _age;
    dataCollection[_dataid].last_update = now;
    _success = true;
    return _success;
  }

  function daysSinceLastUpdate(uint256 _dataid) returns (uint256 _days) {
    _days = (now - dataCollection[_dataid].last_update) / 1 days;
    return _days;
  }

  function safeAdd(uint256 _a, uint256 _b) returns (uint256 _c) {
    return MathUtils.add(_a, _b);
  }

}
