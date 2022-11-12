\m4_TLV_version 1d: tl-x.org
\SV

   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
	`include "sqrt32.v"
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;

   //...

   |calc
      @0
         $reset = *reset;
      @1   
         $val2[31:0] = $rand2[3:0];
         $valid = $reset ? 0 : (>>1$valid + 1);
         $valid_or_reset = $valid || $reset;
         
      ?$valid_or_reset
         @1
            $out[31:0] = $reset ? 0 : >>2$out2;
            
            $sum[31:0] = $out + $val2;
            $diff[31:0] = $out - $val2;
            $prod[31:0] = $out * $val2;
            $quot[31:0] = $out / $val2;
            
            
         @2
            $mem[31:0] = $reset ? 0 :
                                  ($op == 5) ? >>2$out2 :
                                  >>2$mem;

            $out2[31:0] = ($op == 0) ? $sum :
                        ($op == 1) ? $diff :
                        ($op == 2) ? $prod :
                        ($op == 3) ? $quot :
                        ($op == 4) ? >>2$mem : >>2$out2;


         
   // Assert these to end simulation (before Makerchip cycle limit).
!  *passed = *cyc_cnt > 16'd30;
   
\SV
   endmodule
