library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ENCRYP is
    port(
        MESSAGE     : in  std_logic_vector(7 downto 0);
        KEY         : in  std_logic_vector(7 downto 0)
    );
end entity ENCRYP;

architecture BEHAV of ENCRYP is
    signal ENC_MESSAGE : std_logic_vector(7 downto 0);
    signal DEC_MESSAGE : std_logic_vector(7 downto 0);
begin
    encrypt_xor : entity work.xor_enc
        port map(
            MESSAGE => MESSAGE,
            KEY => KEY,
            OUT_MESSAGE => ENC_MESSAGE
        );
    
    decrypt_xor : entity work.xor_enc
        port map(
            MESSAGE => ENC_MESSAGE,
            KEY => KEY,
            OUT_MESSAGE => DEC_MESSAGE
        );

end architecture BEHAV;