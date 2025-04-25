library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_UNSIGNED.all;
--Alfaro Fernández, Azul
--Hernández Jaimes, Rogelio Yael
--Núñez Luna, Aranza Abril

entity romlod is
port(
bus_dir: in std_logic_vector (1 downto 0);
cs: in std_logic;
bus_datos: out std_logic_vector (3 downto 0));
end romlod;

architecture arqromlod of romlod is
--formato de orden de bits: Direccion, 
constant L1: std_logic_vector (3 downto 0):="1100"; 
constant L2: std_logic_vector (3 downto 0):="1001";
constant L3: std_logic_vector (3 downto 0):="0011"; 
constant L4: std_logic_vector (3 downto 0):="0110";
type memoria is array (3 downto 0) of std_logic_vector (3 downto 0);
constant mem_rom: memoria:=(L1,L2,L3,L4);
signal dato: std_logic_vector (3 downto 0);
begin
	prom: process(bus_dir)
	begin
		dato <= mem_rom(conv_integer(bus_dir));
	end process prom;

	pbuf: process (dato,cs)
	begin
		if(cs='0') then
			bus_datos <= dato;
		else
			bus_datos <= (others => '0');
		end if;
	end process pbuf;
end arqromlod;