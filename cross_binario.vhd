library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity cross_binario is

generic	( Npadre : Natural := 16;
				Nprng : Natural := 4); -- Numero de bits de la palabra de salida del PRNG

port		( prng_i : in  std_logic_vector(Nprng - 1 downto 0); -- Entrada del PRNG
				p1,p2 : in  std_logic_vector(Npadre - 1 downto 0);
				 hijo : out std_logic_vector(Npadre - 1 downto 0));
end entity;

architecture rtl of cross_binario is

	signal prng_int : unsigned(Nprng - 1 downto 0);

begin

	prng_int <= unsigned(prng_i);
	
	gen_bits : for i in 0 to Npadre-1 generate
    begin
        hijo(i) <= p1(i) when i < to_integer(prng_int) else p2(i);
    end generate;
	
end rtl;