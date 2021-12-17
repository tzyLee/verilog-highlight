// issues from https://github.com/mshr-h/vscode-verilog-hdl-support

module test;

assign #(test) c = d;

initial begin
    lvalue = #(test) c;
end

initial
lvalue2 = #(test3) d;

initial
if (a)
    ;
else #(test3) b(some);


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

mymod #(
  .PARAM ()
)modinst (
  .a (str.aa),
  .b (str.aa==PARAM0),
  .b (str.aa==PARAM0),
  .b (str.aa==PARAM0),
  .c (str.aa==PARAM1)
);

FL1P3AZ oe_next[NUM_ATC-1:0] (oe_int, zero, state[0] | state[1], ~master_clk, state[1], OE);



module_def module_instance (
    .clk(clk),
    .data(data)
);


Delay #(.width(12), .delay(8)) delay_2r(.clk(clk), .data_in(delay_in_r_2), .data_out(delay_out_r_2));
Delay #(.width(12), .delay(8)) delay_2i(.clk(clk), .data_in(delay_in_i_2), .data_out(delay_out_i_2));
Butterfly #(.width (10)) butterfly_2(
    .mode             (stage_2_mode        ),
    .data_in_a_r      (delay_out_r_2[10:0] ),
    .data_in_a_i      (delay_out_i_2[10:0] ),
    .data_in_b_r      (butterfly_in_r_2    ),
    .data_in_b_i      (butterfly_in_i_2    ),
    .data_out_r       (din_r_3             ),
    .data_out_i       (din_i_3             ),
    .data_out_delay_r (butterfly_out_r_2   ),
    .data_out_delay_i (butterfly_out_i_2   )
);
Multiply #(.in_width(11), .const_width(8), .out_width(12)) multiply_2 (
    .data_in_r    (butterfly_out_r_2 ),
    .data_in_i    (butterfly_out_i_2 ),
    .data_const_r (const_r_2         ),
    .data_const_i (const_i_2         ),
    .data_out_r   (mult_out_r_2      ),
    .data_out_i   (mult_out_i_2      )
);

endmodule