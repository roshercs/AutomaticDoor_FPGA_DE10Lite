library ieee;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_Arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY contador is
port( clk: in std_logic;
		sensor_eco: in std_logic;
		espera: out std_logic;
		inicio: out std_logic);
end entity;

architecture arqcont of contador is
signal eco_pasado: std_logic := '0';
signal eco_sinc: std_logic := '0';
signal eco_nsinc: std_logic := '0';
signal centimetros: unsigned (15 downto 0) := (others => '0');
signal centimetros_unid: unsigned (3 downto 0) := (others => '0');
signal centimetros_dec: unsigned (3 downto 0) := (others => '0');
signal sal_unid: unsigned (3 downto 0) := (others => '0');
signal sal_dece: unsigned (3 downto 0) := (others => '0');
signal cuenta: unsigned (16 downto 0) := (others => '0');
signal unidades: std_logic_Vector ( 3 downto 0); 
signal decenas: std_logic_Vector ( 3 downto 0); 
begin
	process(clk)
	begin
			if rising_edge(clk) then
				if eco_pasado = '0' and eco_sinc = '1' then --Calcula la distancia 
					cuenta <= ( others => '0' );
					centimetros <= ( others => '0');
					centimetros_unid <= ( others => '0' );
					centimetros_dec <= ( others => '0' );
					espera<='0';
				elsif eco_pasado = '1' and eco_sinc = '0' then --Detecta el objeto
					sal_unid <= centimetros_unid;
					sal_dece <= centimetros_dec;
					
					unidades <= conv_STD_LOGIC_VECTOR(sal_unid,4); --Se guarda la unidad de centimetros en 4 bits
					decenas <= conv_STD_LOGIC_VECTOR(sal_dece,4); --Se guarda la unidad de centimetros en 4 bits
				elsif cuenta = 2900-1 then 
					if centimetros_unid = 9 then -- muestra del display del 9 al 19 o 2
						centimetros_unid <= ( others => '0' );
						centimetros_dec <= centimetros_dec+1; --Aumenta 1 en decenas
					else
						centimetros_unid <= centimetros_unid+1; --Aumenta 1 en unidades
					end if;
					centimetros <= centimetros+1; --Suma de los centimetros
					cuenta <= ( others => '0' );
					if centimetros = 3448 then 
						espera <= '0';
						cuenta <= ( others => '0' );
					end if;
				else
					cuenta <= cuenta+1;
				end if;
					eco_pasado <= eco_sinc;
					eco_sinc <= eco_nsinc;
					eco_nsinc <= sensor_eco;
			end if;
			
			if ((unidades>="0010" and unidades<="0110") and decenas = "0000") then
				inicio <= '1'; -- a 5 cm de distancia
			else
				inicio<='0';
			end if;
	end process;
end architecture;