library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ENCRYP is
    port(
        MESSAGE     : in  std_logic_vector(7 downto 0);
        KEY         : in  std_logic_vector(7 downto 0);
        ENC_MESSAGE : out std_logic_vector(7 downto 0);
        DEC_MESSAGE : out std_logic_vector(7 downto 0)
    );
end entity ENCRYP;

architecture BEHAV of ENCRYP is

    signal ENC_MESSAGE_REG : std_logic_vector(7 downto 0);
    
begin
    
    encoding : process(MESSAGE, KEY, ENC_MESSAGE_REG)
    begin
            ENC_MESSAGE_REG <= (MESSAGE xor KEY);
            ENC_MESSAGE <= ENC_MESSAGE_REG;
    end process encoding;

    decoding : process(ENC_MESSAGE_REG, KEY)
    begin
        DEC_MESSAGE <= (ENC_MESSAGE_REG xor KEY);
    end process decoding;

end architecture BEHAV;
