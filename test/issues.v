// issues from https://github.com/mshr-h/vscode-verilog-hdl-support

module test;
mymod modinst (
  .a (str.aa),
  .b (str.aa==PARAM0),
  .c (str.aa==PARAM1)
);
mymod #(
  .PARAM ()
)modinst (
  .a (str.aa),
  .b (str.aa==PARAM0),
  .c (str.aa==PARAM1)
);
// TODO range and parameter is not supported in module instantiation
mymod #(
  .PARAM ()
)modinst (
  .a (str.aa),
  .b (str.aa==PARAM0),
  .b (str.aa==PARAM0),
  .b (str.aa==PARAM0),
  .c (str.aa==PARAM1)
);

initial #(3) display;
initial #1 display;
reg #1 a;
assign b = #2 c;
initial begin #5 display; end
initial
  begin #5 display;
end



localparam [NUM_ATC-1:0] zero = 0; // Helper constant to get width right
FL1P3AZ oe_next[NUM_ATC-1:0] (oe_int, zero, state[0] | state[1], ~master_clk, state[1], OE);
`ifndef test
`endif


endmodule

module mux2to1_3bit(input [2:0] in0, input [2:0] in1, input select, output reg [2:0] muxOut);
    always @*
    begin
        case(select)
            1'b0: muxOut = in0;
            1'b1: muxOut = in1;
        endcase
    end
endmodule

module module_name(
    input  input_1;
    output output_1;
);

case (case_expression)
  case_item_1: begin
    case_statement_1a;
    case_statement_1b;
  end
  case_item_2 : case_statement_2;
  default     : case_statement_default;
endcase

casez (case_expression)
  case_item_1: begin
    case_statement_1a;
    case_statement_1b;
  end
  case_item_2 : case_statement_2;
  default     : case_statement_default;
endcase

casex (case_expression)
  case_item_1: begin
    case_statement_1a;
    case_statement_1b;
  end
  case_item_2 : case_statement_2();
  default     : case_statement_default;
endcase

endmodule

`include "some_include.v"
module sample(
    input clk,
    input signed [7:0] data,
    output result
);

`ifdef SIMULATION
    integer dbg_id;
`endif
parameter SOME_PARAM = 6;

wire signed [SOME_PARAM-1:0] some_logic; // some comment

module_def module_instance (
    .clk(clk),
    .data(data)
);

endmodule

module xadc(
input i_clk_100m,
input i_sig_p,
input i_sig_n,
input i_ref_p,
input i_ref_n,
input i_RESET
);

initial begin
  a/**/();
end
endmodule