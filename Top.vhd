----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:53 06/12/2020 
-- Design Name: 
-- Module Name:    Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Top is
    Port ( clk : in  STD_LOGIC);
end Top;

architecture Behavioral of Top is

signal RAMA : std_logic_vector(15 downto 0):= (others => '0');
signal RAMB : std_logic_vector(15 downto 0):= (others => 'Z');
signal RAMA1 : std_logic_vector(15 downto 0);
signal RAMB1 : std_logic_vector(15 downto 0);
signal ADDRA : std_logic_vector(12 downto 0) := (others => '0');
signal ADDRB : std_logic_vector(12 downto 0) := "1000000000000";
signal wea : std_logic_vector(1 downto 0) := (others => '0');
signal web : std_logic_vector(1 downto 0) := (others => '0');

signal clk_100 : std_logic;

signal band0a : std_logic;
signal band1a : std_logic;
signal band2a : std_logic;
signal band3a : std_logic;

signal band0b : std_logic;
signal band1b : std_logic;
signal band2b : std_logic;
signal band3b : std_logic;

begin

--RAMA1<=RAMA+"0000000000000001";
RAMB1<=RAMB+"0000000000000001";

process(clk)

begin

	if(clk'event and clk='1') then
--		wea<=not wea;
--		web<=not web;
		if(ADDRA < "0000" & "0010" & "0000" & "0") then
			ADDRA<= ADDRA + "0000000010000";
			ADDRB<= ADDRB + "0000000010000";
			else
			ADDRA<= "0000" & "0000" & "0000" & "0";
			ADDRB<= "1000" & "0000" & "0000" & "0";
		end if;		
	end if;
	

end process;



process(ADDRA, clk_100)

begin

	if(ADDRA'event) then
		band0a<='1';
		band1a<='0';
		band2a<='0';
		band3a<='0';
		wea<="00";
		RAMA1<="0000000000000000";
	end if;
	if(clk_100'event and clk_100='1' and band0a='1') then
		band0a<='0';
		band1a<='1';
		band2a<='0';
		band3a<='0';
		wea<="00";
	end if;
	if(clk_100'event and clk_100='1' and band1a='1') then
		band0a<='0';
		band1a<='0';
		band2a<='1';
		band3a<='0';
		RAMA1<=RAMA+"0000000000000001";
		wea<="11";
	end if;
	if(clk_100'event and clk_100='1' and band2a='1') then
		band0a<='0';
		band1a<='0';
		band2a<='0';
		band3a<='1';
		wea<="00";
		RAMA1<="0000000000000000";
	end if;

end process;


process(ADDRB, clk_100)

begin

	if(ADDRB'event) then
		band0b<='1';
		band1b<='0';
		band2b<='0';
		band3b<='0';
		web<="00";
		RAMB1<="0000000000000000";
	end if;
	if(clk_100'event and clk_100='0' and band0b='1') then
		band0b<='0';
		band1b<='1';
		band2b<='0';
		band3b<='0';
		web<="00";
	end if;
	if(clk_100'event and clk_100='0' and band1b='1') then
		band0b<='0';
		band1b<='0';
		band2b<='1';
		band3b<='0';
		RAMB1<=RAMB+"0000000000000001";
		web<="11";
	end if;
	if(clk_100'event and clk_100='0' and band2b='1') then
		band0b<='0';
		band1b<='0';
		band2b<='0';
		band3b<='1';
		web<="00";
		RAMB1<="0000000000000000";
	end if;

end process;




   -- DCM_SP: Digital Clock Manager
   --         Spartan-6
   -- Xilinx HDL Language Template, version 14.7

   DCM_SP_inst : DCM_SP
   generic map (
      CLKDV_DIVIDE => 2.0,                   -- CLKDV divide value
                                             -- (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      CLKFX_DIVIDE => 1,                    	-- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => 4,                   -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 10.0,                  -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "1X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      DFS_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DLL_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DSS_MODE => "NONE",                    -- Unsupported - Do not change value
      DUTY_CYCLE_CORRECTION => TRUE,         -- Unsupported - Do not change value
      FACTORY_JF => X"c080",                 -- Unsupported - Do not change value
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   port map (
      CLK0 => open,         						-- 1-bit output: 0 degree clock output
      CLK180 => open,     							-- 1-bit output: 180 degree clock output
      CLK270 => open,     							-- 1-bit output: 270 degree clock output
      CLK2X => open,       						-- 1-bit output: 2X clock frequency clock output
      CLK2X180 => open, 							-- 1-bit output: 2X clock frequency, 180 degree clock output
      CLK90 => open,       						-- 1-bit output: 90 degree clock output
      CLKDV => open,       						-- 1-bit output: Divided clock output
      CLKFX => clk_100,       					-- 1-bit output: Digital Frequency Synthesizer output (DFS)
      CLKFX180 => open, 							-- 1-bit output: 180 degree CLKFX output
      LOCKED => open,     							-- 1-bit output: DCM_SP Lock Output
      PSDONE => open,     							-- 1-bit output: Phase shift done output
      STATUS => open,     							-- 8-bit output: DCM_SP status output
      CLKFB => open,       						-- 1-bit input: Clock feedback input
      CLKIN => clk,       							-- 1-bit input: Clock input
      DSSEN => '0',       							-- 1-bit input: Unsupported, specify to GND.
      PSCLK => '0',       							-- 1-bit input: Phase shift clock input
      PSEN => '0',         						-- 1-bit input: Phase shift enable
      PSINCDEC => '0', 								-- 1-bit input: Phase shift increment/decrement input
      RST => '0'            						-- 1-bit input: Active high reset input
   );












   RAMB8BWER_inst_0 : RAMB8BWER
   generic map (
      -- DATA_WIDTH_A/DATA_WIDTH_B: 'If RAM_MODE="TDP": 0, 1, 2, 4, 9 or 18; If RAM_MODE="SDP": 36'
      DATA_WIDTH_A => 18,
      DATA_WIDTH_B => 18,
      -- DOA_REG/DOB_REG: Optional output register (0 or 1)
      DOA_REG => 0,
      DOB_REG => 0,
      -- EN_RSTRAM_A/EN_RSTRAM_B: Enable/disable RST
      EN_RSTRAM_A => TRUE,
      EN_RSTRAM_B => TRUE,
      -- INITP_00 to INITP_03: Initial memory contents.
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      -- INIT_00 to INIT_1F: Initial memory contents.
		INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",

      -- INIT_A/INIT_B: Initial values on output port
      INIT_A => X"00000",
      INIT_B => X"00000",
      -- INIT_FILE: Not Supported
      INIT_FILE => "NONE",                                                             -- Do not modify
      -- RAM_MODE: "SDP" or "TDP" 
      RAM_MODE => "TDP",
      -- RSTTYPE: "SYNC" or "ASYNC" 
      RSTTYPE => "SYNC",
      -- RST_PRIORITY_A/RST_PRIORITY_B: "CE" or "SR" 
      RST_PRIORITY_A => "CE",
      RST_PRIORITY_B => "CE",
      -- SIM_COLLISION_CHECK: Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE" 
      SIM_COLLISION_CHECK => "ALL",
      -- SRVAL_A/SRVAL_B: Set/Reset value for RAM output
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      -- WRITE_MODE_A/WRITE_MODE_B: "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST" 
   )
   port map (
															-- Port A Data: 16-bit (each) output: Port A data
      DOADO => RAMA,									--ram_out_16bit,             -- 16-bit output: A port data/LSB data output
      DOPADOP => open,         					-- 2-bit output: A port parity/LSB parity output
															-- Port B Data: 16-bit (each) output: Port B data
      DOBDO => RAMB,             				-- 16-bit output: B port data/MSB data output
      DOPBDOP => open,         					-- 2-bit output: B port parity/MSB parity output
															-- Port A Address/Control Signals: 13-bit (each) input: Port A address and control signals (write port
															-- when RAM_MODE="SDP")
      ADDRAWRADDR => addra, 						-- 13-bit input: A port address/Write address input
      CLKAWRCLK => not clk_100,     			-- 1-bit input: A port clock/Write clock input
      ENAWREN => '1',--'1',         			-- 1-bit input: A port enable/Write enable input
      REGCEA => '0',           					-- 1-bit input: A port register enable input
      RSTA => '0',               				-- 1-bit input: A port set/reset input
      WEAWEL => wea,           					-- 2-bit input: A port write enable input
															-- Port A Data: 16-bit (each) input: Port A data
      DIADI => RAMA1,             				-- 16-bit input: A port data/LSB data input
      DIPADIP => "00",         					-- 2-bit input: A port parity/LSB parity input
															-- Port B Address/Control Signals: 13-bit (each) input: Port B address and control signals (read port
															-- when RAM_MODE="SDP")
      ADDRBRDADDR => addrb, 						-- 13-bit input: B port address/Read address input
      CLKBRDCLK => clk_100,     					-- 1-bit input: B port clock/Read clock input
      ENBRDEN => '1',         					-- 1-bit input: B port enable/Read enable input
      REGCEBREGCE => '0', 							-- 1-bit input: B port register enable/Register enable input
      RSTBRST => '0',         					-- 1-bit input: B port set/reset input
      WEBWEU => web,           					-- 2-bit input: B port write enable input
															-- Port B Data: 16-bit (each) input: Port B data
      DIBDI => RAMB1,			             		-- 16-bit input: B port data/MSB data input
      DIPBDIP => "00"         					-- 2-bit input: B port parity/MSB parity input
   );

end Behavioral;

