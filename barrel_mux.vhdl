library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_mux is
  port(
    SHIFT_AMOUNT : in  std_logic_vector(2 downto 0);
    INPUT      : in  std_logic_vector(7 downto 0);
    DIRECTION    : in  std_logic;
    OUTPUT      : out std_logic_vector(7 downto 0)
  );
end entity barrel_mux;

architecture BEHAV of barrel_mux is
begin
  process(SHIFT_AMOUNT, INPUT, DIRECTION)
  begin
    if DIRECTION = '0' then -- left shift
      case SHIFT_AMOUNT is
        when "000"  => OUTPUT <= INPUT;
        when "001"  => OUTPUT <= INPUT(6 downto 0) & INPUT(7);
        when "010"  => OUTPUT <= INPUT(5 downto 0) & INPUT(7 downto 6);
        when "011"  => OUTPUT <= INPUT(4 downto 0) & INPUT(7 downto 5);
        when "100"  => OUTPUT <= INPUT(3 downto 0) & INPUT(7 downto 4);
        when "101"  => OUTPUT <= INPUT(2 downto 0) & INPUT(7 downto 3);
        when "110"  => OUTPUT <= INPUT(1 downto 0) & INPUT(7 downto 2);
        when "111"  => OUTPUT <= INPUT(0) & INPUT(7 downto 1);
        when others => OUTPUT <= INPUT;
      end case;
    elsif DIRECTION = '1' then -- right shift
      case SHIFT_AMOUNT is
        when "000"  => OUTPUT <= INPUT;
        when "001"  => OUTPUT <= INPUT(0) & INPUT(7 downto 1);
        when "010"  => OUTPUT <= INPUT(1 downto 0) & INPUT(7 downto 2);
        when "011"  => OUTPUT <= INPUT(2 downto 0) & INPUT(7 downto 3);
        when "100"  => OUTPUT <= INPUT(3 downto 0) & INPUT(7 downto 4);
        when "101"  => OUTPUT <= INPUT(4 downto 0) & INPUT(7 downto 5);
        when "110"  => OUTPUT <= INPUT(5 downto 0) & INPUT(7 downto 6);
        when "111"  => OUTPUT <= INPUT(6 downto 0) & INPUT(7);
        when others => OUTPUT <= INPUT;
      end case;
    end if;
  end process;
end architecture BEHAV;
