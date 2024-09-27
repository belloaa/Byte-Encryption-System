library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T_CASE_MODIFIER is
end T_CASE_MODIFIER;

architecture TEST of T_CASE_MODIFIER is

    component case_modifier
        port(
            MESSAGE      : in  std_logic_vector(7 downto 0);
            OUT_MESSAGE      : out std_logic_vector(7 downto 0)
        );
    end component case_modifier;
    
    signal MESSAGE_TB     : std_logic_vector(7 downto 0) := "01000000";
    signal MESSAGE_REG : unsigned(7 downto 0) := "01000000";
    signal OUT_MESSAGE_TB : std_logic_vector(7 downto 0);
    
 begin
     UUT : case_modifier
            port map(
                MESSAGE     => MESSAGE_TB,
                OUT_MESSAGE => OUT_MESSAGE_TB
            );
        process
        begin
        -- waiting for a little so it doesn't check the validation right away
        for i in 0 to 30 loop
        wait for 5 ns;
--            wait for 5 ns;
--            assert GREEN_LED_TB = '1'
--            report "Invalid Character: "
--            severity error;

--            wait for 5 ns;
--            assert RED_LED_TB = '1'
--            report "Valid Character: "
--            severity error;
            
            -- cycling through all of the values of an 8bit vector
            MESSAGE_REG <= MESSAGE_REG + 1;
            MESSAGE_TB     <= std_logic_vector(MESSAGE_REG);
            
        end loop;
        wait;

    end process;
end TEST;