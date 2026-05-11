library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity cross_binario is

generic(	Nprng : Natural := 4;   -- Cantidad de bits del PRNG de entrada.
		  Npadre : Natural := 48;  -- Cantidad de bits del padre. Es 3xNParam.
	     NParam : Natural := 16); -- Cantidad de bits de cada parametro. Se asume que los parametros son 3 y de igual cantidad de bits. Orden [A,r,SigmaG2] en p1, p2 y hijo

port(		 prng_A : in  std_logic_vector(Nprng - 1 downto 0);
			 prng_r : in  std_logic_vector(Nprng - 1 downto 0);
	 prng_SigmaG2 : in  std_logic_vector(Nprng - 1 downto 0);
			  p1,p2 : in  std_logic_vector(Npadre - 1 downto 0);
			   hijo : out std_logic_vector(Npadre - 1 downto 0));
end entity;

architecture rtl of cross_binario is

	signal       prng_intA : unsigned(Nprng - 1 downto 0);
	signal       prng_intr : unsigned(Nprng - 1 downto 0);
	signal prng_intSigmaG2 : unsigned(Nprng - 1 downto 0);
	
	signal 						 p1_A,p2_A,hijoA : std_logic_vector(NParam - 1 downto 0);
	signal 						 p1_r,p2_r,hijor : std_logic_vector(NParam - 1 downto 0);
	signal p1_SigmaG2,p2_SigmaG2,hijoSigmaG2 : std_logic_vector(NParam - 1 downto 0);

begin

			prng_intA <= unsigned(prng_A);
			prng_intr <= unsigned(prng_r);
	prng_intSigmaG2 <= unsigned(prng_SigmaG2);
	
	p1_A <= p1(Npadre - 1 downto Npadre - Nparam);
	p2_A <= p2(Npadre - 1 downto Npadre - Nparam);
	
	p1_r <= p1(Npadre - Nparam - 1 downto Nparam);
	p2_r <= p2(Npadre - Nparam - 1 downto Nparam);
	
	p1_SigmaG2 <= p1(Nparam - 1 downto 0);
	p2_SigmaG2 <= p2(Nparam - 1 downto 0);
	
	gen_bitsA : for i in 0 to (NParam-1) generate
   begin
       hijoA(i) <= p1_A(i) when i < to_integer(prng_intA) else p2_A(i);
   end generate;
	 
	gen_bitsr : for j in 0 to (NParam-1) generate
   begin
       hijor(j) <= p1_r(j) when j < to_integer(prng_intr) else p2_r(j);
   end generate;
	 
	gen_bitsSigmaG2 : for k in 0 to (NParam-1) generate
   begin
       hijoSigmaG2(k) <= p1_SigmaG2(k) when k < to_integer(prng_intSigmaG2) else p2_SigmaG2(k);
   end generate;
	
	hijo(Npadre - 1 downto 0) <= hijoA & hijor & hijoSigmaG2;
	
end rtl;

--------------------------------------------------------------------------------------------------------------