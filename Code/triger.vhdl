library ieee;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_Arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY triger is
port( clk: in std_logic;
		triger: out std_logic;
		espera_aux: in std_logic);
end entity;

architecture arqtriger of triger is
signal cuenta: unsigned (16 downto 0) := (others => '0');
signal espera: std_logic := '0';
begin
	process(clk)
	begin
			if rising_Edge(clk) then
			 espera<=espera_aux;
				if espera = '0' then
					if cuenta = 500 then
						triger<= '0';
						espera <= '1';
						cuenta <= ( others => '0');
					else
						triger <= '1';
						cuenta <= cuenta+1;
					end if;
				end if;
			end if;
	end process;
end architecture;