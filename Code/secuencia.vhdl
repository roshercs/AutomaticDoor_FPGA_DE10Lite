library ieee;
use ieee.std_logic_1164.all;

--Alfaro Fernández, Azul
--Hernández Jaimes, Rogelio Yael
--Núñez Luna, Aranza Abril

entity secuencia is
port ( start: in std_logic;
		 clk: in std_logic;
		 direccion: out std_logic:='0';
		 espera: out std_logic);
end entity;

architecture arqsec of secuencia is
signal conteo: integer range 0 to 10000:=0;
signal starting: std_logic:='0'; --puerta abriendose
signal waiting: std_logic:='0'; --puerta abierta
signal closing: std_logic:='0'; -- puerta cerrandose
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if start='1' and starting='0' and waiting='0' and closing='0' then
				starting<='1';
				espera<='0';
				direccion<='0';
			end if;
			--abriendo puerta
			if starting='1' then
				if conteo=4800 then
					espera<='1';
					waiting<='1';
					starting<='0';
					direccion<='1';
					conteo<=0;
				else
					conteo<=conteo+1;
				end if;
			elsif waiting='1' and start='0' then
				--puerta abierta
				if conteo=4500 then
					espera<='0';
					conteo<=0;
					waiting<='0';
					closing<='1';
				else
					conteo<=conteo+1;
				end if;
			elsif closing='1' then
				--cerrando puerta
				if conteo=4800 then
					direccion<='0';
					espera<='1';
					closing<='0';
					conteo<=0;
				else
					conteo<=conteo+1;
				end if;
			end if;
		end if;
	end process;
	
end architecture;