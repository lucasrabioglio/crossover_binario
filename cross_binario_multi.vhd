library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use work.tipos_pkg.all;
	
entity cross_binario_multi is
generic (
    Npadre : natural := 16;
    Nprng  : natural := 4;
    Nhijos : natural := 4
);

port (
    prng_i : in  sl_matrix_t(0 to Nhijos-1)(Nprng-1 downto 0);
    p1, p2 : in  std_logic_vector(Npadre - 1 downto 0);
    hijos  : out sl_matrix_t(0 to Nhijos-1)(Npadre-1 downto 0)
);
end entity;

architecture uno of cross_binario_multi is
begin

    gen_hijos : for h in 0 to Nhijos-1 generate
    begin

        gen_bits : for i in 0 to Npadre-1 generate
        begin
            hijos(h, i) <= p1(i) when i < to_integer(unsigned(prng_i(h, 0 to Nprng-1))) else
								   p2(i);
        end generate;

    end generate;

end uno;