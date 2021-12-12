primitive multiplexer (mux, control, dataA, dataB);
output mux;
input control, dataA, dataB;

table
// control dataA dataB mux
       0     1    0   : 1 ;
       0     1    1   : 1 ;
       0     1    x   : 1 ;
       0     0    0   : 0 ;
       0     0    1   : 0 ;
       0     0    x   : 0 ;
       1     0    1   : 1 ;
       1     1    1   : 1 ;
       1     x    1   : 1 ;
       1     0    0   : 0 ;
       1     1    0   : 0 ;
       1     x    0   : 0 ;
       x     0    0   : 0 ;
       x     1    1   : 1 ;
endtable
endprimitive


primitive multiplexer (mux, control, dataA, dataB);
output mux;
input control, dataA, dataB;

table
// control dataA dataB mux
      0      1     ?  : 1 ; // ? = 0 1 x
      0      0     ?  : 0 ;
      1      ?     1  : 1 ;
      1      ?     0  : 0 ;
      x      0     0  : 0 ;
      x      1     1  : 1 ;
endtable
endprimitive

primitive d_edge_ff (q, clock, data);
output q; reg q;
input clock, data;
table
// clock data q q+
// obtain output on rising edge of clock
    (01)  0 : ? : 0 ;
    (01)  1 : ? : 1 ;
    (0?)  1 : 1 : 1 ;
    (0?)  0 : 0 : 0 ;
    // ignore negative edge of clock
    (?0)  ? : ? : - ;
    // ignore data changes on steady clock
    ?   (??): ? : - ;
endtable
endprimitive

primitive srff (q, s, r);
output q; reg q;
input s, r;

initial q = 1'b1;

table
// s r q q+
    1 0 : ? : 1 ;
    f 0 : 1 : - ;
    0 r : ? : 0 ;
    0 f : 0 : - ;
    1 1 : ? : 0 ;
endtable
endprimitive

primitive dff1 (q, clk, d);
input clk, d;
output q; reg q;

initial q = 1'b1;

table
// clk d q q+
    r 0 : ? : 0 ;
    r 1 : ? : 1 ;
    f ? : ? : - ;
    ? * : ? : - ;
endtable
endprimitive

module dff (q, qb, clk, d);

input clk, d;
output q, qb;

dff1 g1 (qi, clk, d);
buf #3 g2 (q, qi);
not #5 g3 (qb, qi);

endmodule


primitive jk_edge_ff (q, clock, j, k, preset, clear);
output q; reg q;
input clock, j, k, preset, clear;

table
    // clock jk pc state output/next state
        ? ?? 01 : ? : 1 ; // preset logic
        ? ?? *1 : 1 : 1 ;
        ? ?? 10 : ? : 0 ; // clear logic
        ? ?? 1* : 0 : 0 ;
        r 00 00 : 0 : 1 ; // normal clocking cases
        r 00 11 : ? : - ;
        r 01 11 : ? : 0 ;
        r 10 11 : ? : 1 ;
        r 11 11 : 0 : 1 ;
        r 11 11 : 1 : 0 ;
        f ?? ?? : ? : - ;
        b *? ?? : ? : - ; // j and k transition cases
        b ?* ?? : ? : - ;
endtable
endprimitive