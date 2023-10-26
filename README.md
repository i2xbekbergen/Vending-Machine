# Vending-Machine
In this project, I designed a vending machine module. The project was implemented on the Vivado 2022.1 software in Verilog HDL. The basic principle of the vending machine is following: The vending machine sells three items with different prices (3, 5, and 7). Before selling, the stock of each item should be filled manually. If it is out of stock, the vending machine will light the LEDs. To buy the item, insert three types of coins (1, 5, and 10) until the balance reaches item price, and then select the item. The balance and stock of the selected item will be decreased by the price and 1, respectively. The maximum number that stock and balance can be reach are 5 and 50, respectively. To implement the operation of the vending machine on the FPGA board, its operation is divided into three modes: Item Filling, Coin Inserting, and Selling. These modes will be controlled by the switches in the FPGA board.
## Finite-State Machine
The machine has total 4 states: IDLE, ITEM FILLING, INSERT COIN, and SELLING. The FSM follows the truth table below:
![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/fb65286f-8b16-463d-9cb0-398d92b4e816)
According to the truth table above, I drew the following FSM for our vending machine:
![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/5afd0488-94bb-4c36-a006-988683aad269)
IDLE state is the state when the machine is waiting for the commands.

## Hardware Utilites
The project will be processed on the Digilent Arty S7-50: Spartan-7 FPGA Development Board. In terms of IO pins we will utilize board’s 4 switches, 4 buttons, 4 LEDs, and Seven Segment Display. The picture below shows the map of the IO pins.
![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/9f5bb516-4933-4d49-ac9f-ba8acdd911db)
1. SW3: Turns On/OFF the vending machine. Other part of FPGA board should operate only when SW3 is “HIGH”.
2. SW1-2: Control the mode of the vending machine. The truth table below shows the selected mode depending on SW1~2.
![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/82ca26e8-38aa-4cae-a2c6-5c32941a1af8)
3. SW0: Reset for vending machine. when it is switched “ON”, the vending machine should stop operation. After it is switched “DOWN”, the stocks and balance should be 0.
4. BTN1-3: Used for modifying 3 operation depending on the mode of bending machine: adding stocks, inserting coins, and selecting three items.
   ![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/63a9516e-d201-47ff-b1bd-28657b0950cb)
5. LED5: LED is “ON”, while vending machine is operating.
6. LED2-4: Indicating whether the stock of item is out or filled currently depending on the mode. It turns on only when the situation described in the table below.
   ![image](https://github.com/i2xbekbergen/Vending-Machine/assets/98009988/4d9bfa6a-c577-46d6-b9b1-1fa2c1cf8df4)
7. SSD: Represent the stock of most currently filled item for Item Filling and balance for Selling and Coin Inserting modes.

## Modules
Our vending machine consists of 7 modules: Vending Machine module (top module), FSM control module, Item Buffer module, Coin Buffer module, Clock Buffer module, Debouncer module, and SSD module. Let’s consider each module separately.
### FSM Module
The general idea of this module is to change the state of the Vending to the appropriate one.
### Clock Buffer Module
Now let’s write the code for the clock buffer. The vending machine operates with 50Hz clock. To make it, board generated 100MHz clock is converted as 5MHz clock by clocking wizard (VIVADO IP, declared in the skeleton code). Hence, we need to write module that converts clock from 5MHz to 50Hz. Let’s start!
Basically, we need to slow the clock by 100,000 times. Hence, we can assign a counter that will increment itself until it gets to 100,000/2 = 50,000 and then reset it and start counting again up to 50,000. Each time the counter gets to the 50,000, we will toggle the clock, thus generating 5Hz clock. Now let’s look on the code for that.
### Coin Buffer Module
The purpose of this module is to keep the value of the balance that will be displayed on the SSD. The value of the balance changes during the INSERT COIN and SELLING states. In INSERT COIN state we can fill our balance up to 50 coins. We can increase our balance by adding either 1, 5 or 10 coins. In the SELLING state we are reducing the balance. The value of the balance is reduced depending on the product we are buying. Since the prices are 3, 5, and 7 coins, we can reduce our balance only by those three values. In other states balance should remain its value.
### Item Buffer Module
The purpose of this module is to keep the value of the stocks. We have three stocks in total, each having products with different prices. As was mentioned in the introduction, after we turned on the vending machine it should be filled with products. Then we can by them after we insert coins. Thus, we see that the stock values change during the ITEM FILLING and SELLING states. In ITEM FILLING state the values of each stock increases by one each time we fill the stock with the products. In SELLING state the values of each stock decreases by one each time we buy products in that particular stock.
### Vending Machine Module
This module is the top module which collects all other modules, and the main purpose of this module is to turn on/off the corresponding LEDs at each state and to show the corresponding value on the SSD at each state. During ITEM FILLING state the LED corresponding to the most recently filled stock should be turned on, and the SSD should display the value of the stock. During INSERT COIN state the LEDs are turned off, and the SSD should display the value of the balance. During SELLING state the LEDs of the empty stocks must be turned on, and the SSD should display the value of the balance. In addition, the LED5 should be turned on if the vending machine is operating.

Besides LEDs, there are two more parameters in this module that i want to clarify. 
- The ```val_sel``` parameter is the value that keeps the value of which stock is now operating. We will further utilize the knowledge of the val_sel in other parts of the code.
- The ```value``` parameter represents the value that should be displayed on the SSD.

### Debouncer Module
This module is necessary to reduce the noise of the buttons when we are clicking on them.
### SSD Module
This module controls the SSD to correctly display the desired output.

## Codes
you can find the codes for each of the modules in the repository.
