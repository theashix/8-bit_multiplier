`timescale 1ns / 1ps

module control(input logic Clk, Reset_Load_Clear, Run, M,
                output logic clr_ld, shift_en, add, subtract);

  enum logic [4:0] {Idle, Add1, Add2, Add3, Add4, Add5, Add6, Add7, Add8, Subtract,
  Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Shift8, Reset} curr_state, next_state;

    always_ff @ (posedge Clk)
    begin
        if (Reset_Load_Clear)
            curr_state <= Idle;
        else
            curr_state <= next_state;
    end
    always_comb begin
        next_state = curr_state;
        unique case (curr_state)
            Idle :      if(Run)
                            next_state = Reset;
            Reset :                      next_state = Add1;
            Add1 :                       next_state = Shift1;
            Add2 :                       next_state = Shift2;
            Add3 :                       next_state = Shift3;
            Add4 :                       next_state = Shift4;
            Add5 :                       next_state = Shift5;
            Add6 :                       next_state = Shift6;
            Add7 :                       next_state = Shift7;

            Subtract :                   next_state = Shift8;
            Shift1 :                     next_state = Add2;
            Shift2 :                     next_state = Add3;
            Shift3 :                     next_state = Add4;
            Shift4 :                     next_state = Add5;
            Shift5 :                     next_state = Add6;
            Shift6 :                     next_state = Add7;
            Shift7 :                     next_state = Subtract;
            Shift8 :    if (~Run)
                                         next_state = Idle;
        endcase
        case (curr_state)
           Idle:
             begin
                clr_ld    = 1'b0;
                shift_en  = 1'b0;
                add       = 1'b0;
                subtract  = 1'b0;
		      end
           Reset:
             begin
                clr_ld    = 1'b1;
                shift_en  = 1'b0;
                add       = 1'b0;
                subtract  = 1'b0;
              end
           Add1, Add2, Add3, Add4, Add5, Add6, Add7:
		      begin
                clr_ld    = 1'b0;
                shift_en  = 1'b0;
                add       = M;
                subtract  = 1'b0;
              end
		   Subtract:
            begin
                clr_ld    = 1'b0;
                shift_en  = 1'b0;
                add       = M;
                subtract  = M;
            end
	   	  Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, Shift8:
	   	      begin
                clr_ld    = 1'b0;
                shift_en  = 1'b1;
                add       = 1'b0;
                subtract  = 1'b0;
		      end
	   	   default:
		      begin
                clr_ld    = 1'b0;
                shift_en  = 1'b0;
                add       = 1'b0;
                subtract  = 1'b0;
		      end
        endcase
    end
endmodule