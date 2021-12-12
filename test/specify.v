module XORgate (a, b, out);

input a, b;
output out;

xor x1 (out, a, b);

specify
    specparam noninvrise = 1, noninvfall = 2;
    specparam invertrise = 3, invertfall = 4;
    if (a) (b => out) = (invertrise, invertfall);
    if (b) (a => out) = (invertrise, invertfall);
    if (~a)(b => out) = (noninvrise, noninvfall);
    if (~b)(a => out) = (noninvrise, noninvfall);
    showcancelled out;
    pulsestyle_ondetect out;
    pulsestyle_onevent out;
    noshowcancelled out;
endspecify

specify
    (clk => q) = 12;
    (data => q) = 10;
    (clr, pre *> q) = 4;
    specparam
        PATHPULSE$clk$q = (2,9),
        PATHPULSE$clr$q = (0,4),
        PATHPULSE$clr[2]$q = (0,4),
        PATHPULSE$ = 3;
endspecify

endmodule

module ALU (o1, i1, i2, opcode);

input [7:0] i1, i2;
input [2:1] opcode;
output [7:0] o1;

//functional description omitted
specify
    // add operation
    if (opcode == 2'b00) (i1,i2 *> o1) = (25.0, 25.0);
    // pass-through i1 operation
    if (opcode == 2'b01) (i1 => o1) = (5.6, 8.0);
    // pass-through i2 operation
    if (opcode == 2'b10) (i2 => o1) = (5.6, 8.0);
    // delays on opcode changes
    (opcode *> o1) = (6.1, 6.5);

    if (C1) (IN => OUT) = (1,1);
    ifnone (IN => OUT) = (2,2);
    // add operation
    if (opcode == 2'b00) (i1,i2 *> o1) = (25.0, 25.0);
    // pass-through i1 operation
    if (opcode == 2'b01) (i1 => o1) = (5.6, 8.0);
    // pass-through i2 operation
    if (opcode == 2'b10) (i2 => o1) = (5.6, 8.0);
    // all other operations
    ifnone (i2 => o1) = (15.0, 15.0);
    (posedge CLK => (Q +: D)) = (1,1);
    ifnone (CLK => Q) = (2,2);
endspecify

endmodule


module dff(q, qbar, clock, data, preset, clear);

output q, qbar;
input clock, data, preset, clear;

reg notifier;

and (enable, preset, clear);
not (qbar, ffout);
buf (q, ffout);
posdff_udp (ffout, clock, data, preset, clear, notifier);

specify
    // Define timing check specparam values
    specparam tSU = 10, tHD = 1, tPW = 25, tWPC = 10, tREC = 5;
    // Define module path delay rise and fall min:typ:max values
    specparam tPLHc = 4:6:9 , tPHLc = 5:8:11;
    specparam tPLHpc = 3:5:6 , tPHLpc = 4:7:9;

    // Specify module path delays
    (clock *> q,qbar) = (tPLHc, tPHLc);
    (preset,clear *> q,qbar) = (tPLHpc, tPHLpc);

    // Setup time : data to clock, only when preset and clear are 1
    $setup(data, posedge clock &&& enable, tSU, notifier);
    // Hold time: clock to data, only when preset and clear are 1
    $hold(posedge clock, data &&& enable, tHD, notifier);
    // Clock period check
    $period(posedge clock, tPW, notifier);
    // Pulse width : preset, clear
    $width(negedge preset, tWPC, 0, notifier);
    $width(negedge clear, tWPC, 0, notifier);
    // Recovery time: clear or preset to clock
    $recovery(posedge preset, posedge clock, tREC, notifier);
    $recovery(posedge clear, posedge clock, tREC, notifier);

    $setup( data, posedge clk &&& clr, 10 ) ;

    $setup( data, posedge clk &&& (~clr), 10 ) ;
    $setup( data, posedge clk &&& (clr===0), 10 );
    $setup( data, edge[01, 0x, x1] clk &&& (clr===0), 10 );
endspecify

endmodule