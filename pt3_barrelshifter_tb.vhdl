library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T_ENCRYP3 is
end T_ENCRYP3;

architecture TEST of T_ENCRYP3 is

    component ENCRYP3
        port(
            DIRECTION     : in  std_logic;
            ASCII         : in  std_logic_vector(7 downto 0);
            KEY           : in  std_logic_vector(7 downto 0);
            ENC_MESSAGE   : out std_logic_vector(7 downto 0);
            DEC_MESSAGE   : out std_logic_vector(7 downto 0);
            MSB_CHECK     : out std_logic_vector(7 downto 0);
            FIVEBIT_CHECK : out std_logic;
            GREEN_LED     : out std_logic;
            RED_LED       : out std_logic
        );
    end component ENCRYP3;

    signal DIRECTION     : std_logic;
    signal ASCII         : std_logic_vector(7 downto 0);
    signal ASCII_REG     : unsigned(7 downto 0);
    signal KEY           : std_logic_vector(7 downto 0);
    signal ENC_MESSAGE   : std_logic_vector(7 downto 0);
    signal DEC_MESSAGE   : std_logic_vector(7 downto 0);
    signal MSB_CHECK     : std_logic_vector(7 downto 0);
    signal GREEN_LED     : std_logic;
    signal RED_LED       : std_logic;
    signal FIVEBIT_CHECK : std_logic;

begin
    UUT : ENCRYP3
        port map(
            DIRECTION     => DIRECTION,
            ASCII         => ASCII,
            KEY           => KEY,
            ENC_MESSAGE   => ENC_MESSAGE,
            DEC_MESSAGE   => DEC_MESSAGE,
            MSB_CHECK     => MSB_CHECK,
            FIVEBIT_CHECK => FIVEBIT_CHECK,
            GREEN_LED     => GREEN_LED,
            RED_LED       => RED_LED
        );

    process
    begin
        KEY       <= "00010001";
        ASCII_REG <= "01000000";
        
        -- waiting for a little so it doesn't check the validation right away
        wait for 10 ns;
        for i in 0 to 30 loop
            -- cycling through all of the values of capital ASCII alphabet
            -- checking range from 01000000
            wait for 5 ns;
            DIRECTION <= '1';

            wait for 5 ns;
            assert MSB_CHECK = "11111111"
            report "MSB check failed"
            severity error;

            wait for 5 ns;
            assert FIVEBIT_CHECK = '1'
            report "Five bit check failed"
            severity error;

            wait for 5 ns;
            assert GREEN_LED = '1'
            report "Invalid Character: " & to_string(ASCII)
            severity error;

            wait for 5 ns;
            assert RED_LED = '1'
            report "Valid Character: " & to_string(ASCII)
            severity error;

            wait for 5 ns;
            assert ENC_MESSAGE = (ASCII xor KEY)
            report "Encrpytion incorrect"
            severity error;

            wait for 5 ns;
            assert DEC_MESSAGE = ASCII
            report "Decryption incorrect"
            severity error;

            wait for 5 ns;
            --adding to the unsigned signal to loop through the values
            ASCII_REG <= ASCII_REG + 1;
            ASCII     <= std_logic_vector(ASCII_REG);

        end loop;

        wait;

    end process;
end TEST;
