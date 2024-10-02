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
            DIRECTION   : in  std_logic;
            RED_LED     : out std_logic;
            GREEN_LED   : out std_logic;
            OUT_MESSAGE : out std_logic_vector(7 downto 0)
        );
    end component ENCRYP;

    signal DIRECTION     : std_logic;
    signal MESSAGE       : std_logic_vector(7 downto 0);
    signal MESSAGE_REG   : unsigned(7 downto 0);
    signal KEY           : std_logic_vector(7 downto 0);
    signal OUT_MESSAGE   : std_logic_vector(7 downto 0);
    signal RED_LED       : std_logic;
    signal GREEN_LED     : std_logic;

begin
    UUT : ENCRYP
        port map(
            DIRECTION     => DIRECTION,
            MESSAGE       => MESSAGE,
            KEY           => KEY,
            OUT_MESSAGE   => OUT_MESSAGE,
            RED_LED       => RED_LED,
            GREEN_LED     => GREEN_LED
        );

    process
    begin
        KEY       <= "00010001";   
        MESSAGE_REG <= "01000000"; -- Start before 'A' in ASCII
        DIRECTION <= '1';

        -- Wait to start the test
        wait for 10 ns;

        -- Loop through the ASCII uppercase letters
        for i in 0 to 25 loop
            -- Assign MESSAGE from ASCII_REG
            MESSAGE <= std_logic_vector(MESSAGE_REG);
            wait for 5 ns;

            -- Assertions for encryption
            assert (OUT_MESSAGE = (MESSAGE xor KEY))
            report "Encryption failed at character: " & integer'image(i)
            severity error;
            
            wait for 5 ns;
            -- Check the GREEN_LED (valid input) and RED_LED (invalid input)
            if MESSAGE >= "01000000" and MESSAGE <= "01011010" then
                assert (GREEN_LED = '1' and RED_LED = '0')
                report "Valid character check failed at: " & integer'image(i)
                severity error;
            else
                assert (GREEN_LED = '0' and RED_LED = '1')
                report "Invalid character check failed at: " & integer'image(i)
                severity error;
            end if;

            
            wait for 5 ns;
            -- Assertions for decryption (should retrieve the original MESSAGE)
            assert (OUT_MESSAGE = MESSAGE)
            report "Decryption failed at character: " & integer'image(i)
            severity error;

            wait for 5 ns;

            -- Increment MESSAGE_REG to next ASCII value
            MESSAGE_REG <= MESSAGE_REG + 1;
            wait for 10 ns;
        end loop;
        wait;  

    end process;
end TEST;
