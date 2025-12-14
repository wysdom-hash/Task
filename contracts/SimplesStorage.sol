
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleStorage{

string[] mainList;

function addToList (string memory data) public {
    mainList.push(data);
    return;
}
 function viewList() public view returns (string[] memory){
    return mainList;
 }

 struct subList{
    string data_1;
    uint data_2;
    bool data_3;
 }

  subList public sublist;

 function setSubList (string memory _data_1, uint _data_2, bool _data_3) public {
    sublist = subList(_data_1,_data_2,_data_3);
    //sublist.push(subList(_data_1,_data_2,_data_3));
 }


function viewSubList() public view returns (string memory){
    
    return sublist.data_1;

    }
    
 }




