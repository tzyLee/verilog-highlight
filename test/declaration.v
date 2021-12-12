module test;

parameter A = 5;
localparam B = 3;

wire signed [5:2] c [0:3];
reg d;
event e;
integer f;

trireg /**/
    (highz0, pull1) scalared
    signed [B:A] #(1:2:3, 4:5:6) g = 2, h = 3;

wand//
    (supply0, weak1)
vectored/**/signed
[2:0] #(A:B:2) m = 2, n = 6,


wire i = 1, j = 2,
k = 9;


endmodule