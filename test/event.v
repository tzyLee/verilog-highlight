module test;

parameter d = 50; // d declared as a parameter and
reg [7:0] r; // r declared as an 8-bit reg

initial begin // a waveform controlled by sequential delay
    #d r = 'h35;
    #d r = 'hE2;
    #d r = 'h00;
    #d r = 'hF7;
    #d -> end_wave; //trigger an event called end_wave
end


initial fork
    #50 r = 'h35;
    #100 r = 'hE2;
    #150 r = 'h00;
    #200 r = 'hF7;
    #250 -> end_wave[2];
join

endmodule