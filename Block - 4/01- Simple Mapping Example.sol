// Solidity Mappings
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleMappingExample{

    mapping (uint => bool) public myMapping;
    mapping (address => bool) public MyAddressMapping;

    function setValue (uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddresstoTrue() public {
        MyAddressMapping[msg.sender] = true;
    }
}

/*
Run the Smart Contract
Mapping are an interesting datatype in Solidity. They are accessed like arrays, but they have one major advantage: All key/value pairs are initialized with their default value.
If you have a look at the example Smart Contract, you'll see that we have two mappings.
One, that maps uint256 to booleans, that's called myMapping. Another one that maps addresses to booleans, that we called myAddressMapping.
We can access a mapping with the brackets []. If we want to access the key "123" in our myMapping, then we'd simply write myMapping[123]
------------------------------------

Write to a uint => bool Mapping

If you have a look at our simple function setValue(uint _index), then you will see you will write "true" to an _index. So, if the _index = 0, then myMapping[0] will be set to true. Again, no need to initialize anything here, it will just assign the value.
Give it a try!
1.	Set the value of myMapping[0] to true, by entering "0" next to the "setValue" button
2.	Hit the setValue button
3.	retrieve the myMapping[0] value again, by entering "0" next to the "myMapping" button
4.	It should return true ✨
------------------------------------

Address Keys in Mappings

If you come from the traditional Development world, then integer keys are nothing particularly interesting probably. It's very much like using an array or a hash map or something similar.
Addresses are a cool thing in Solidity. They are like a bank account number, an IBAN if you wish. You know who transacts with your Smart Contract and the Smart Contract knows who you are.
The cool thing is, addresses can be keys for arrays and mappings. And in our example we map addresses to boolean values. We could use this for white-listing for example. So, if an address is allowed to do a certain action in our Smart Contract then we can white-list it.
Let's see how that behaves. First, let's check the value for your own address:
1.	Copy the Address from the Dropdown - there is a little copy icon next to the dropdown, press it
2.	Paste the Address into the input field next to "myAddressMapping"
3.	Press the Button
4.	The value should be "false"
------------------------------------

Set Address Keys in a Mapping

Let's have a closer look at the function setMyAddressToTrue:
   function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

This function does several things:
1.	it accesses the global msg-object and gets the senders address. So, if you are interacting with a specific address, then for the Smart Contract that address will be in msg.sender
2.	It accesses the myAddressMapping mapping and sets the value "true" for the current address.
Let's give it a try!
1.	simply click the "setMyAddressToTrue" button. There is no input field, because the address will automatically be the one you use to interact with the Smart Contract
2.	Retrieve the value again
It should be true
*/