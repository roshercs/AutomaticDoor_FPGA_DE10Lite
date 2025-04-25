library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--Alfaro Fernández, Azul
--Hernández Jaimes, Rogelio Yael
--Núñez Luna, Aranza Abril

entity estados is
port (clk: in std_logic;
		UD: in std_logic; --paro
		rst: in std_logic;
		dir: in std_logic; --0: sentido antihorario, 1: sentido horario
		state:out std_logic_vector(1 downto 0));
end estados;
architecture arqestados of estados is
	subtype estado is std_logic_vector(1 downto 0);
	constant sm0:estado:="00";
	constant sm1:estado:="01";
	constant sm2:estado:="10";
	constant sm3:estado:="11";
	signal pres_S,next_S:estado;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if UD='0' then
				if rst='1' then
					pres_S<=sm0;
				else 
					pres_S<=next_S;
				end if;
			end if;
		end if;
		state<=pres_S;
	end process;

	process(pres_S, dir)
	begin
		case(pres_S) is
			when sm0 =>
				if dir='0' then 
					next_S<=sm1;
				else
					next_S<=sm3; 
				end if;
			when sm1 =>
				if dir='0' then 
						next_S<=sm2;
					else
						next_S<=sm0; 
					end if;
			when sm2 =>
				if dir='0' then 
					next_S<=sm3;
				else
					next_S<=sm1; 
				end if;
			when others => --Estado 3
				if dir='0' then 
					next_S<=sm0;
				else
					next_S<=sm2;
				end if;
		end case;
	end process;
end architecture;