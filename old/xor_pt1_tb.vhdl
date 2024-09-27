library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T_ENCRYP is
end T_ENCRYP;

architecture TEST of T_ENCRYP is

    component ENCRYP
        port(
            MESSAGE     : in  std_logic_vector(7 downto 0);
            KEY         : in  std_logic_vector(7 downto 0);
            ENC_MESSAGE : out std_logic_vector(7 downto 0);
            DEC_MESSAGE : out std_logic_vector(7 downto 0)
        );
    end component ENCRYP;

    signal MESSAGE_REG : unsigned(7 downto 0)         := "00000000";
    signal MESSAGE     : std_logic_vector(7 downto 0) := "00000000";
    signal KEY         : std_logic_vector(7 downto 0) := "00010110";
    signal ENC_MESSAGE : std_logic_vector(7 downto 0);
    signal DEC_MESSAGE : std_logic_vector(7 downto 0);

begin
    UUT : ENCRYP
        port map(
            MESSAGE     => MESSAGE,
            KEY         => KEY,
            ENC_MESSAGE => ENC_MESSAGE,
            DEC_MESSAGE => DEC_MESSAGE
        );

    process
    begin
        -- waiting for a little so it doesn't check the validation right away
        wait for 10 ns;
        for i in 0 to 255 loop

            -- validating encryption and decryption
            assert ENC_MESSAGE = (MESSAGE xor KEY)
            report "Encrpytion incorrect"
            severity error;

            assert DEC_MESSAGE = MESSAGE
            report "Decryption incorrect"
            severity error;

            -- cycling through all of the values of an 8bit vector
            MESSAGE_REG <= MESSAGE_REG + 1;
            MESSAGE     <= std_logic_vector(MESSAGE_REG);
            wait for 10 ns;

        end loop;
        wait;

    end process;
end TEST;
