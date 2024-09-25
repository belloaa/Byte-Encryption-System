library ieee;
use ieee.std_logic_1164.all;

entity ENCRYP is
    port(
        clk         : in  std_logic;
        MESSAGE     : in  std_logic_vector(7 downto 0);
        KEY         : in  std_logic_vector(7 downto 0);
        ENC_MESSAGE : out std_logic_vector(7 downto 0);
        DEC_MESSAGE : out std_logic_vector(7 downto 0)
    );
end entity ENCRYP;

architecture BEHAV of ENCRYP is

    signal ENC_MESSAGE_REG : std_logic_vector(7 downto 0);

begin
    
    encoding : process(clk)
    begin
        if rising_edge(clk) then
            ENC_MESSAGE_REG <= (MESSAGE xor KEY);
            ENC_MESSAGE <= ENC_MESSAGE_REG;
        end if;
    end process encoding;

    decoding : process(clk)
    begin
        if rising_edge(clk) then
            DEC_MESSAGE <= (ENC_MESSAGE_REG xor KEY);
        end if;
    end process decoding;

end architecture BEHAV;
