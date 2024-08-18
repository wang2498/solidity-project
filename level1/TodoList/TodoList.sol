// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList {
    struct Todo {
        string name;
        bool isCompleted;
    }
    Todo[] public list;

    function create(string memory _name) external {
        list.push(Todo({name: _name, isCompleted: false}));
    }

    function modiName1(uint _index, string memory _name) external {
        list[_index].name = _name;
    }

    function modiName2(uint _index, string memory _name) external {
        Todo storage temp = list[_index];
        temp.name = _name;
    }

    function modiStatus1(uint _index, bool status) external {
        list[_index].isCompleted = status;
    }

    function modiStatus2(uint _index) external {
        list[_index].isCompleted = !list[_index].isCompleted;
    }
    function get1(uint _index) external view returns(string memory _name, bool _status){
        Todo memory temp = list[_index];
        return (temp.name, temp.isCompleted);
    }
    function get2(uint _index) external  view returns(string memory _name, bool _status) {
        Todo storage temp = list[_index];
        return (temp.name, temp.isCompleted);
    }
}
