-- VHDL Entity r65c02_tc.r65c02_tc.symbol
--
-- Created:
--          by - remoteghost.UNKNOWN (ENTW-7HPZ200)
--          at - 10:24:26 07/21/13
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity r65c02_tc is
   port( 
      clk_clk_i   : in     std_logic;
      d_i         : in     std_logic_vector (7 downto 0);
      irq_n_i     : in     std_logic;
      nmi_n_i     : in     std_logic;
      rdy_i       : in     std_logic;
      rst_rst_n_i : in     std_logic;
      so_n_i      : in     std_logic;
      ce          : in     std_logic;
      a_o         : out    std_logic_vector (15 downto 0);
      d_o         : out    std_logic_vector (7 downto 0);
      rd_o        : out    std_logic;
      sync_o      : out    std_logic;
      wr_n_o      : out    std_logic;
      wr_o        : out    std_logic
   );

-- Declarations

end r65c02_tc ;

-- (C) 2008 - 2018 Jens Gutschmidt
-- (email: opencores@vivare-services.com)
-- 
-- Versions:
-- Revision 1.52  2018/09/10 12:14:00  jens
-- - RESET generates SYNC now, 1 dead cycle delayed
-- Revision 1.52  RC 2018/09/09 03:00:00  jens
-- - ADC / SBC flags and A like R65C02 now
-- Revision 1.52  BETA 2018/09/05 19:35:00  jens
-- - BBRx/BBSx internal cycles like real 65C02 now
-- - Bug Fix ADC and SBC in decimal mode (all op codes -
--   1 cycle is missing
-- - Bug Fix ADC and SBC in decimal mode (all op codes -
--   "Overflow" flag was computed wrong)
-- Revision 1.52  BETA 2018/09/02 18:49:00  jens
-- - Interrupt NMI and IRQ processing via FETCH stage now
-- Revision 1.52  BETA 2018/08/30 15:39:00  jens
-- - Interrupt priority order is now: BRQ - NMI - IRQ
-- - Performance improvements on-going (Mealy -> Moore)
-- Revision 1.52  BETA 2018/08/23 20:27:00  jens
-- - Bug Fixes All Branch Instructions 
--   (BCC, BCS, BEQ, BNE, BPL, BMI, BVC, BVS, BRA)
--   3 cycles now if branch forward occur and the branch
--   instruction lies on a xxFEh location.
--   (BBR, BBS) 6 cycles now if branch forward occur and the
--   branch instruction lies on a xxFDh location.
-- - Bug Fix Hardware Interrupts NMI & IRQ - 7 cycles & "SYNC" now
-- - Bug Fix Now all cycles are delayable (WR and internal)
-- 
-- Revision 1.51  RC 2014/04/19 14:44:00  jens
-- (never submitted to opencores)
-- - Bug Fix JMP ABS - produced a 6502 like JMP (IND) PCH.
--   When the ABS address data bytes cross the page
--   boundary (e.g. $02FE JMP hhll reads hh from
--   $02FF and ll from $0200, instead $02FF and $0300) 
-- 
-- Revision 1.5  RC 2013/08/01 11:00:00  jens
-- - Change Block name to lower case
-- - Bug Fix CMP (IND) - wrongly decoded as function AND
-- - Bug Fix BRK should clear decimal flag in P Reg
-- - Bug Fix JMP (ABS,X) - Low Address outputted twice - no High Address
-- - Bug Fix Unknown Ops - Used always 1b2c NOP ($EA) - new NOPs created
-- - Bug Fix DECIMAL ADC and SBC (all op codes - "C" flag was computed wrong)
-- - Bug Fix INC/DEC ABS,X - N/Z flag wrongly computed
-- - Bug Fix RTI - should increment stack pointer
-- - Bug Fix "E" & "B" flags (Bits 5 & 4) - should be always "1" in P Reg. Change "RES", "RTI", "IRQ" & "NMI" substates.
-- - Bug Fix ADC and SBC (all sub codes - "Overflow" flag was computed wrong)
-- - Bug Fix RMB, SMB Bug - Bit position decoded wrong
-- 
-- Revision 1.4  2013/07/21 11:11:00  jens
-- - Changing the title block and internal revision history
-- - Bug Fix STA [(IND)] op$92 ($92 was missed in the connection list at state FETCH)
-- 
-- Revision 1.3  2009/01/04 10:20:50  eda
-- Changes for cosmetic issues only
-- 
-- Revision 1.2  2009/01/04 09:23:12  eda
-- - Delete unused nets and blocks (same as R6502_TC)
-- - Rename blocks
-- - Re-arrage FSM symbols in block FSM_Execution_Unit
-- 
-- Revision 1.1  2009/01/03 16:36:48  eda
-- -- no description --
--  
-- 
--
-- VHDL Architecture r65c02_tc.r65c02_tc.struct
--
-- Created:
--          by - eda.UNKNOWN (ENTW-7HPZ200)
--          at - 12:21:16 10.09.2018
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2016.2 (Build 5)
--
-- COPYRIGHT (C) 2008 - 2018 by Jens Gutschmidt
-- 
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

library r65c02_tc;

architecture struct of r65c02_tc is

   -- Architecture declarations

   -- Internal signal declarations


   -- Component Declarations
   component core
   port (
      clk_clk_i   : in     std_logic ;
      d_i         : in     std_logic_vector (7 downto 0);
      irq_n_i     : in     std_logic ;
      nmi_n_i     : in     std_logic ;
      rdy_i       : in     std_logic ;
      rst_rst_n_i : in     std_logic ;
      so_n_i      : in     std_logic ;
      ce          : in     std_logic ;
      a_o         : out    std_logic_vector (15 downto 0);
      d_o         : out    std_logic_vector (7 downto 0);
      rd_o        : out    std_logic ;
      sync_o      : out    std_logic ;
      wr_n_o      : out    std_logic ;
      wr_o        : out    std_logic 
   );
   end component;

   -- Optional embedded configurations
   -- pragma synthesis_off
   for all : core use entity r65c02_tc.core;
   -- pragma synthesis_on


begin

   -- Instance port mappings.
   U_0 : core
      port map (
         clk_clk_i   => clk_clk_i,
         d_i         => d_i,
         irq_n_i     => irq_n_i,
         nmi_n_i     => nmi_n_i,
         rdy_i       => rdy_i,
         rst_rst_n_i => rst_rst_n_i,
         so_n_i      => so_n_i,
         ce          => ce,
         a_o         => a_o,
         d_o         => d_o,
         rd_o        => rd_o,
         sync_o      => sync_o,
         wr_n_o      => wr_n_o,
         wr_o        => wr_o
      );

end struct;