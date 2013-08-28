//======================================================================
//
// chacha_core.v
// --------------
// Verilog 2001 implementation of the stream cipher ChaCha.
// This is the internal core with wide interfaces.
//
//
// Copyright (c) 2013// , Secworks Sweden AB
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or 
// without modification, are permitted provided that the following 
// conditions are met: 
// 
// 1. Redistributions of source code must retain the above copyright 
//    notice, this list of conditions and the following disclaimer. 
// 
// 2. Redistributions in binary form must reproduce the above copyright 
//    notice, this list of conditions and the following disclaimer in 
//    the documentation and/or other materials provided with the 
//    distribution. 
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module chacha_core(
                    // Clock and reset.
                    input wire           clk,
                    input wire           reset_n,
                
                    // Control.
                    input wire           initalize,
                    input wire           next,

                    // Parameters and data.
                    // Number of compression rounds c.
                    // Number of finalization rounds d.
                    // Key k.
                    // Message word block mi.
                    input wire [127 : 0] key,
                    input wire [127 : 0]  iv,

                    // Status output.
                    output wire           ready,
                    
                    // Hash word output.
                    output wire [31 : 0] chacha_word,
                    output wire          chacha_word_word_valid
                   );

  
  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------

  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  // x0..x15
  // 16 internal state registers.
  reg [31 : 0] x0_reg;
  reg [31 : 0] x0_new;
  reg          x0_we;
  
  reg [31 : 0] x1_reg;
  reg [31 : 0] x1_new;
  reg          x1_we;
  
  reg [31 : 0] x2_reg;
  reg [31 : 0] x2_new;
  reg          x2_we;
  
  reg [31 : 0] x3_reg;
  reg [31 : 0] x3_new;
  reg          x3_we;
  
  reg [31 : 0] x4_reg;
  reg [31 : 0] x4_new;
  reg          x4_we;
  
  reg [31 : 0] x5_reg;
  reg [31 : 0] x5_new;
  reg          x5_we;
  
  reg [31 : 0] x6_reg;
  reg [31 : 0] x6_new;
  reg          x6_we;
  
  reg [31 : 0] x7_reg;
  reg [31 : 0] x7_new;
  reg          x7_we;
  
  reg [31 : 0] x8_reg;
  reg [31 : 0] x8_new;
  reg          x8_we;
  
  reg [31 : 0] x9_reg;
  reg [31 : 0] x9_new;
  reg          x9_we;
  
  reg [31 : 0] x10_reg;
  reg [31 : 0] x10_new;
  reg          x10_we;
  
  reg [31 : 0] x1_reg;
  reg [31 : 0] x1_new;
  reg          x1_we;
  
  reg [31 : 0] x12_reg;
  reg [31 : 0] x12_new;
  reg          x13_we;
  
  reg [31 : 0] x14_reg;
  reg [31 : 0] x14_new;
  reg          x14_we;
  
  reg [31 : 0] x15_reg;
  reg [31 : 0] x15_new;
  reg          x15_we;
  
  
  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------

  
  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  
  
  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with synchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin
      if (!reset_n)
        begin
          // Reset all registers to defined values.
          x0_reg  <= 31'h00000000;
          x1_reg  <= 31'h00000000;
          x2_reg  <= 31'h00000000;
          x3_reg  <= 31'h00000000;
          x4_reg  <= 31'h00000000;
          x5_reg  <= 31'h00000000;
          x6_reg  <= 31'h00000000;
          x7_reg  <= 31'h00000000;
          x8_reg  <= 31'h00000000;
          x9_reg  <= 31'h00000000;
          x10_reg <= 31'h00000000;
          x11_reg <= 31'h00000000;
          x12_reg <= 31'h00000000;
          x13_reg <= 31'h00000000;
          x14_reg <= 31'h00000000;
          x15_reg <= 31'h00000000;
        end
      else
        begin
          if (x0_we)
            begin
              x0_reg <= x0_new;
            end
          if (x1_we)
            begin
              x1_reg <= x1_new;
            end
          if (x2_we)
            begin
              x2_reg <= x2_new;
            end
          if (x3_we)
            begin
              x3_reg <= x3_new;
            end
          if (x4_we)
            begin
              x4_reg <= x4_new;
            end
          if (x5_we)
            begin
              x5_reg <= x5_new;
            end
          if (x6_we)
            begin
              x6_reg <= x6_new;
            end
          if (x7_we)
            begin
              x7_reg <= x7_new;
            end
          if (x8_we)
            begin
              x8_reg <= x8_new;
            end
          if (x9_we)
            begin
              x9_reg <= x9_new;
            end
          if (x10_we)
            begin
              x10_reg <= x10_new;
            end
          if (x11_we)
            begin
              x11_reg <= x11_new;
            end
          if (x12_we)
            begin
              x12_reg <= x12_new;
            end
          if (x13_we)
            begin
              x13_reg <= x13_new;
            end
          if (x14_we)
            begin
              x14_reg <= x14_new;
            end
          if (x15_we)
            begin
              x15_reg <= x15_new;
            end
        end
    end // reg_update


  //----------------------------------------------------------------
  // quarter_round
  // update_logic for the quarter round.
  //----------------------------------------------------------------
  always @*
    begin : quarter_round
      // Internal wires
      reg [31 : 0] a;
      reg [31 : 0] a0;
      reg [31 : 0] a1;

      reg [31 : 0] b;
      reg [31 : 0] b0;
      reg [31 : 0] b1;
      reg [31 : 0] b2;
      reg [31 : 0] b3;

      
      reg [31 : 0] c;
      reg [31 : 0] c0;
      reg [31 : 0] c1;
      reg [31 : 0] c2;
      reg [31 : 0] c3;
      
      reg [31 : 0] d;
      reg [31 : 0] d0;
      reg [31 : 0] d1;
      reg [31 : 0] d2;
      reg [31 : 0] d3;

      // TODO add mux/demux for selecting x-registers updated by the round.
      
      a0 = a + b;
      a1 = a0 + b1;

      b0 = b ^ c0;
      b1 = {b0[20:0], b0[31:21]]};
      b2 = b1 ^ c1;
      b3 = {b2[24:0], b2[31:25]]};

      d0 = d ^ a0;
      d1 = {d0[15:0], d0[31:16]};
      d2 = d1 ^ a1;
      d3 = {d2[23:0], d2[31:24]};
      
    end // block: quarter_round
  
  //----------------------------------------------------------------
  // chacha_ctrl_fsm
  // Logic for the state machine controlling the core behaviour.
  //----------------------------------------------------------------
  always @*
    begin : chacha_ctrl_fsm
    end // chacha_ctrl_fsm
endmodule // chacha_core

//======================================================================
// EOF chacha_core.v
//======================================================================
