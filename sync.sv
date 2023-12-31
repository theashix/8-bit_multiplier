//These are synchronizers required for bringing asynchronous signals into the FPGA

//synchronizer with no reset (for switches/buttons)
module sync (
	input  logic Clk, SW,
	output logic q
);

always_ff @ (posedge Clk)
begin
	q <= SW;
end

endmodule


//synchronizer with reset to 0 (d_ff)
module sync_r0 (
	input  logic Clk, reset, SW,
	output logic q
);

//initial
//begin
//	q <= 1'b0;
//end

always_ff @ (posedge Clk or posedge reset)
begin
	if (reset)
		q <= 1'b0;
	else
		q <= SW;
end

endmodule

//synchronizer with reset to 1 (d_ff)
module sync_r1 (
	input  logic Clk, reset, SW,
	output logic q
);
//initial
//begin
//	q <= 1'b1;
//end

always_ff @ (posedge Clk or posedge reset)
begin
	if (reset)
		q <= 1'b1;
	else
		q <= SW;
end

endmodule