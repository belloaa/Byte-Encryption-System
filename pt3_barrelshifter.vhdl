--notes 
--need to add signal when both tests are good
--need to add LED functionailty
--make code flow betetr

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ENCRYP3 is
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
end entity ENCRYP3;

architecture BEHAV of ENCRYP3 is

    signal ENC_MESSAGE_REG   : std_logic_vector(7 downto 0); --register used for storing encoded message data
    signal MSB_CHECK_REG     : std_logic_vector(7 downto 0); --register for storing result of 3 msb checking
    signal FIVEBIT_CHECK_REG : std_logic; -- register for storing result of 3 lsb checking
    signal MESSAGE           : std_logic_vector(7 downto 0) := (others => '0'); -- signal used for manipulating ascii input data
    signal SHIFT_AMOUNT      : std_logic_vector(2 downto 0); 
    signal ENC_ROT           : std_logic_vector(7 downto 0); -- stores rotated message that has yet to be encoded (kind of confusing change later)
    signal DEC_ROT           : std_logic_vector(7 downto 0); -- stores the decoded message (but still rotated)

begin
    ----------------------------------pt3. barrel shifter----------------------------------------

    -- direct instantiation for the barrel shifter rotating muxs
    -- rotator mux in barrel_mux.vhdl
    encode_mux : entity work.barrel_mux
        port map(
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            INPUT        => MESSAGE,
            DIRECTION    => DIRECTION,
            OUTPUT       => ENC_ROT
        );

    decode_mux : entity work.barrel_mux
        port map(
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            INPUT        => DEC_ROT,
            DIRECTION    => not DIRECTION,
            OUTPUT       => DEC_MESSAGE
        );

    SHIFT_AMOUNT <= KEY(2 downto 0);

    ----------------------------------pt2. comparator----------------------------------------

    -- third most significant bit check
    msb : process(ASCII, MSB_CHECK_REG)
        variable B_MASK  : std_logic_vector(7 downto 0) := "11100000";
        variable CAP_MSB : std_logic_vector(7 downto 0) := "01000000";

    begin
        MSB_CHECK_REG <= (ASCII and B_MASK) xnor CAP_MSB;
        MSB_CHECK     <= MSB_CHECK_REG;
    end process msb;

    -- remaining five bits check 
    fivebit : process(ASCII, FIVEBIT_CHECK_REG)
        variable A, B, C, D, E : std_logic;

    begin
        --assigns the five bits to variables for boolean expression from 5 variable kmap
        A := ASCII(4);
        B := ASCII(3);
        C := ASCII(2);
        D := ASCII(1);
        E := ASCII(0);

        -- boolean expression from kmap addressing only capital ASCII alphabet characters
        FIVEBIT_CHECK_REG <= ((A or B or C or D or E) and (not A or not B or not D or not E) and (not A or not B or not C));
        FIVEBIT_CHECK     <= FIVEBIT_CHECK_REG;
    end process fivebit;

    -- led check, assign this output to a constraint?
    rgb : process(FIVEBIT_CHECK_REG, MSB_CHECK_REG, ASCII)
    begin
        if FIVEBIT_CHECK_REG = '1' and MSB_CHECK_REG = "11111111" then
            GREEN_LED <= '1';
            RED_LED   <= '0';
            MESSAGE   <= ASCII;
        else
            GREEN_LED <= '0';
            RED_LED   <= '1';
            MESSAGE   <= "00000000";
        end if;
    end process;

    ----------------------------------pt.1 xor encrption and decryption----------------------------------------

    -- xor for encryption w/ key
    encoding : process(ENC_ROT, KEY, ENC_MESSAGE_REG)
    begin
        ENC_MESSAGE_REG <= (ENC_ROT xor KEY);
        ENC_MESSAGE     <= ENC_MESSAGE_REG;
    end process encoding;

    -- xor again for decryption
    decoding : process(ENC_MESSAGE_REG, KEY)
    begin
        DEC_ROT <= (ENC_MESSAGE_REG xor KEY);
    end process decoding;

end architecture BEHAV;
