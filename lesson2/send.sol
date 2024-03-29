    // SPDX-License-Identifier: MIT

    pragma solidity ^0.8.12;

    //bir para gönderme kontratı yazalım

    contract SendMoney{

        uint public balanceReceived; // alınan bakiye

        function recieveMoney() public payable{ //para alma
            balanceReceived += msg.value;
        }

        function getBalance() public view returns(uint){
            return address(this).balance; // this kastedmek (bu kontratın içindeki bakiyeyi)
        }

        function takeMoney() public{
            //address payable whoMoney = msg.sender; payable olmadığı ve dönüştüremediği için
            address payable whoMoney = payable(msg.sender);
            whoMoney.transfer(this.getBalance()); // tüm bakiyeyi transfer eder
        }

        function takeMoneyTo(address payable _to) public{
            _to.transfer(this.getBalance());
            
        }

        //bunlar yazıldıktın sonra contructor yapısına giriş yap
        //biz bu kontrat içindeki parayı gönderirken kontratın tanımasını istiyoruz

        address public owner;

        constructor(){ //akıllı kontratlar ilk yayınlanırken çalışırlar 
            owner = msg.sender;
        }

        
        //daha sonra takemoney to içine aşağıdakini yaz

        function takeMoneyToa(address payable _to) public{
            require(!paused, "Akilli kontrat durduruldu!");
            require(msg.sender == owner, "Akilli kontratin sahibi degilsiniz!"); 
            _to.transfer(this.getBalance());
        }

        //kontratı durdurma yapısı
        bool public paused;

        function setPaused(bool _paused) public{
            require(msg.sender == owner, "Akilli kontratin sahibi degilsiniz");
            paused = _paused;
        }

        //kendini imha etme şuanda solidity içinde çalışmıyor

        function destroy(address payable to) public{
            selfdestruct(to);
        }


    }