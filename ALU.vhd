----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:50 05/17/2024 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Carry_in : in  STD_LOGIC;
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Result : out  STD_LOGIC_VECTOR (3 downto 0);
           Carry_out : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

 signal sum0, sum1, sum2, sum3 : STD_LOGIC;
    signal carry0, carry1, carry2, carry3 : STD_LOGIC;

    component fulladder_ami
        Port (
            a : in  STD_LOGIC;
            b : in  STD_LOGIC;
            c : in  STD_LOGIC;
            sum : out  STD_LOGIC;
            carry : out  STD_LOGIC
        );
    end component;

begin
    -- Full Adders for Addition
    FA0: fulladder_ami Port Map (a => A(0), b => B(0), c => Carry_in, sum => sum0, carry => carry0);
    FA1: fulladder_ami Port Map (a => A(1), b => B(1), c => carry0, sum => sum1, carry => carry1);
    FA2: fulladder_ami Port Map (a => A(2), b => B(2), c => carry1, sum => sum2, carry => carry2);
    FA3: fulladder_ami Port Map (a => A(3), b => B(3), c => carry2, sum => sum3, carry => carry3);

    process(A, B, Op, sum0, sum1, sum2, sum3, carry3)
    begin
        case Op is
            when "00" => -- Addition
                Result <= sum0 & sum1 & sum2 & sum3;
                Carry_out <= carry3;
            when "01" => -- AND
                Result <= A and B;
                Carry_out <= '0';
            when "10" => -- OR
                Result <= A or B;
                Carry_out <= '0';
            when "11" => -- XOR
                Result <= A xor B;
                Carry_out <= '0';
            when others =>
                Result <= (others => '0');
                Carry_out <= '0';
        end case;
    end process;


end Behavioral;

