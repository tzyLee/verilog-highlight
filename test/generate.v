module mod_a;
genvar i;
reg a[0:9], b[0:9];

for (i=0; i<10; i=i+1)
    assign a[i] = b[i];

endmodule

module gray2bin1 (bin, gray);

parameter SIZE = 8; // this module is parameterizable

output [SIZE-1:0] bin;
input [SIZE-1:0] gray;

genvar i, j, k;

generate
for (i=0; i<SIZE; i=i+1) begin : bit
    assign bin[i] = ^gray[SIZE-1:i];
    // i refers to the implicitly defined localparam whose
    // value in each instance of the generate block is
    // the value of the genvar when it was elaborated.
end
endgenerate

endmodule


module addergen1 (co, sum, a, b, ci);

parameter SIZE = 4;

output [SIZE-1:0] sum;
output co;
input [SIZE-1:0] a, b;
input ci;

wire [SIZE :0] c;
wire [SIZE-1:0] t [1:3];

genvar i;

assign c[0] = ci;

// Hierarchical gate instance names are:
//   xor gates: bit[0].g1 bit[1].g1 bit[2].g1 bit[3].g1
//              bit[0].g2 bit[1].g2 bit[2].g2 bit[3].g2
//   and gates: bit[0].g3 bit[1].g3 bit[2].g3 bit[3].g3
//              bit[0].g4 bit[1].g4 bit[2].g4 bit[3].g4
//   or gates:  bit[0].g5 bit[1].g5 bit[2].g5 bit[3].g5
// Generated instances are connected with
// multidimensional nets t[1][3:0] t[2][3:0] t[3][3:0]
// (12 nets total)

for(i=0; i<SIZE; i=i+1) begin:bit
    xor g1 (t[1][i], a[i], b[i]);
    xor g2 (sum[i], t[1][i], c[i]);
    and g3 (t[2][i], a[i], b[i]);
    and g4 (t[3][i], t[1][i], c[i]);
    or g5 (c[i+1], t[2][i], t[3][i]);
end

assign co = c[SIZE];

endmodule

module test;
parameter p = 0, q = 0;
wire a, b, c;
//---------------------------------------------------------
// Code to either generate a u1.g1 instance or no instance.
// The u1.g1 instance of one of the following gates:
// (and, or, xor, xnor) is generated if
// {p,q} == {1,0}, {1,2}, {2,0}, {2,1}, {2,2}, {2, default}
//---------------------------------------------------------
if (p == 1)
    if (q == 0) begin : u1      // If p==1 and q==0, then instantiate
        and g1(a, b, c);        // AND with hierarchical name test.u1.g1
    end
    else if (q == 2) begin : u1 // If p==1 and q==2, then instantiate
        or g1(a, b, c);         // OR with hierarchical name test.u1.g1
    end
    // "else" added to end "if (q == 2)" statement
    else ;                      // If p==1 and q!=0 or 2, then no instantiation
else if (p == 2)
    case (q)
    0, 1, 2: begin : u1         // If p==2 and q==0,1, or 2, then instantiate
        xor g1(a, b, c);        // XOR with hierarchical name test.u1.g1
    end
    default: begin : u1         // If p==2 and q!=0,1, or 2, then instantiate
        xnor g1(a, b, c);       // XNOR with hierarchical name test.u1.g1
    end
    endcase

endmodule


module multiplier(a, b, product);

parameter a_width = 8, b_width = 8;

localparam product_width = a_width+b_width;
// cannot be modified directly with the defparam
// statement or the module instance statement #

input [a_width-1:0] a;
input [b_width-1:0] b;
output [product_width-1:0] product;

generate
    if((a_width < 8) || (b_width < 8)) begin: mult
        CLA_multiplier #(a_width,b_width) u1(a, b, product);
    // instantiate a CLA multiplier
    end
    else begin: mult
        WALLACE_multiplier #(a_width,b_width) u1(a, b, product);
    // instantiate a Wallace-tree multiplier
    end
endgenerate
// The hierarchical instance name is mult.u1
endmodule


module dimm(addr, ba, rasx, casx, csx, wex, cke, clk, dqm, data, dev_id);

parameter [31:0] MEM_WIDTH = 16, MEM_SIZE = 8; // in mbytes

input [10:0] addr;
input ba, rasx, casx, csx, wex, cke, clk;
input [ 7:0] dqm;
inout [63:0] data;
input [ 4:0] dev_id;

genvar i;

case ({MEM_SIZE, MEM_WIDTH})
{32'd8, 32'd16}: // 8Meg x 16 bits wide
    begin: memory
        for (i=0; i<4; i=i+1) begin:word
            sms_08b216t0 p(.clk(clk), .csb(csx), .cke(cke),.ba(ba),
                           .addr(addr), .rasb(rasx), .casb(casx),
                           .web(wex), .udqm(dqm[2*i+1]), .ldqm(dqm[2*i]),
                           .dqi(data[15+16*i:16*i]), .dev_id(dev_id));
        // The hierarchical instance names are memory.word[3].p,
        // memory.word[2].p, memory.word[1].p, memory.word[0].p,
        // and the task memory.read_mem
        end

        task read_mem;
        input [31:0] address;
        output [63:0] data;
        begin // call read_mem in sms module
            word[3].p.read_mem(address, data[63:48]);
            word[2].p.read_mem(address, data[47:32]);
            word[1].p.read_mem(address, data[31:16]);
            word[0].p.read_mem(address, data[15: 0]);
        end
        endtask
    end
{32'd16, 32'd8}: // 16Meg x 8 bits wide
    begin: memory
        for (i=0; i<8; i=i+1) begin:byte
            sms_16b208t0 p(.clk(clk), .csb(csx), .cke(cke),.ba(ba),
                           .addr(addr), .rasb(rasx), .casb(casx),
                           .web(wex), .dqm(dqm[i]),
                           .dqi(data[7+8*i:8*i]), .dev_id(dev_id));
            // The hierarchical instance names are memory.byte[7].p,
            // memory.byte[6].p, ... , memory.byte[1].p, memory.byte[0].p,
            // and the task memory.read_mem
        end

        task read_mem;
        input [31:0] address;
        output [63:0] data;
        begin // call read_mem in sms module
        byte[7].p.read_mem(address, data[63:56]);
        byte[6].p.read_mem(address, data[55:48]);
        byte[5].p.read_mem(address, data[47:40]);
        byte[4].p.read_mem(address, data[39:32]);
        byte[3].p.read_mem(address, data[31:24]);
        byte[2].p.read_mem(address, data[23:16]);
        byte[1].p.read_mem(address, data[15: 8]);
        byte[0].p.read_mem(address, data[ 7: 0]);
        end
        endtask
    end
// Other memory cases ...
endcase
endmodule