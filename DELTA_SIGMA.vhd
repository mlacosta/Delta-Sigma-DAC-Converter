----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mariano Leonel Acosta
-- 
-- Create Date: 31.03.2018 20:38:32
-- Design Name: 
-- Module Name: DELTA_SIGMA - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- resetear antes de usar!!!!!

entity DELTA_SIGMA is
    generic (N : integer:=24;
             M : integer:=18 );
             
    Port ( clk : in STD_LOGIC;
               data : in signed ((N-1) downto 0);
           dac_out : out signed (0 downto 0);
           reset : in STD_LOGIC);
end DELTA_SIGMA;

architecture Behavioral of DELTA_SIGMA is

    signal a,b,c,d: signed ((N-1) downto 0);
begin
    
    process(clk,reset)
        
        variable reg_a: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_b: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_c: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_d: signed ((N-1) downto 0):=to_signed(0,N);
        
        variable reg_y: signed ((N-1) downto 0):=to_signed(0,N);
        
        variable reg_a_1: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_b_1: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_c_1: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_d_1: signed ((N-1) downto 0):=to_signed(0,N);
        
        variable reg_y_1: signed ((N-1) downto 0):=to_signed(0,N);
        
        variable reg_x: signed ((N-1) downto 0):=to_signed(0,N);
        variable reg_x_1: signed ((N-1) downto 0):=to_signed(0,N);
        
        variable temp1,temp2: signed ((N-1) downto 0):=to_signed(0,N);
        
        
        
        begin
            
            if (reset = '1') then
                
                reg_a:=to_signed(0,N);
                reg_c:=to_signed(0,N);
                reg_b:=to_signed(0,N);
                reg_d:=to_signed(0,N);
                reg_y:=to_signed(0,N);
                reg_a_1:=to_signed(0,N);
                reg_c_1:=to_signed(0,N);
                reg_b_1:=to_signed(0,N);
                reg_d_1:=to_signed(0,N);
                reg_y_1:=to_signed(0,N);
                reg_x_1:=to_signed(0,N);
                reg_x:=to_signed(0,N);
                
            end if;
            
            if rising_edge(clk) then
                
                reg_x:=data;
                temp1:=reg_x_1-reg_y_1;
                temp2:=reg_b_1-reg_y_1;
                
                if(temp1>=0) then
                    reg_a:=shift_right(temp1,1);
                else
                    reg_a:=-shift_right(-temp1,1);
                end if;
                
                if(temp2>=0) then
                    reg_c:=shift_right(temp2,1);
                else
                    reg_c:=-shift_right(-temp2,1);
                end if;
                
                reg_b:=reg_a+reg_b_1;
                
                reg_d:=reg_c+reg_d_1;
                
               if (reg_d>=to_signed(0,N)) then
                    reg_y:=to_signed(2 **(M-1)-1,N);
                    
                else 
        
                    reg_y:=to_signed(-2 **(M-1),N);
                                      
                end if;
                -----------------------------------------------------------
                dac_out<=not(reg_y((N-1) downto (N-1)));
                
                --actualizar estados
                reg_a_1:=reg_a;
                reg_c_1:=reg_c;
                reg_b_1:=reg_b;
                reg_d_1:=reg_d;
                reg_y_1:=reg_y;
                reg_x_1:=reg_x;
                
                a<=reg_a;
                c<=reg_c;
                b<=reg_b;
                d<=reg_d;
                

            end if;
        end process;

    
end Behavioral;
