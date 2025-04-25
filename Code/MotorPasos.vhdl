library IEEE;
use ieee.std_logic_arith.all;
use IEEE.std_logic_1164.all;

--Alfaro Fernández, Azul
--Hernández Jaimes, Rogelio Yael
--Núñez Luna, Aranza Abril


entity MotorPasos is
port(clk:in std_logic;
		sensor_disp: out std_logic;
		sensor_eco: in std_logic;
		rst:in std_logic;
		mot:out std_logic_vector(3 downto 0));
end MotorPasos;

architecture arqMotorPasos of MotorPasos is
signal clkl: std_logic;
signal clklb : std_logic;
signal clklc : std_logic;
signal state: std_logic_vector(1 downto 0);
signal duty : integer range 0 to 1000 := 100;
signal direc:std_logic:='0';
signal pause: std_logic:='1';
signal inicio: std_logic;
begin
	u1: entity work.divf(arqdivf) generic map(200) port map(clk,clkl);
	u2: entity work.divf(arqdivf) generic map(25000) port map(clk,clklc);
	u3: entity work.senal(arqsenal) port map(clkl,duty,clklb);
	u4: entity work.sensor(arqsensor) port map(clk,sensor_disp,sensor_eco,inicio);
	u5: entity work.secuencia(arqsec) port map(inicio,clklc,direc,pause);
	u6:entity work.estados(arqestados) port map(clklb,pause,rst,direc,state);
	u7: entity work.romlod(arqromlod) port map(state,pause,mot);
end architecture;