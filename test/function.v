

module tryfact;

function [7:0] getbyte;
input [15:0] address;
begin
    // code to extract low-order byte from addressed word
    getbyte = result_expression;
end
endfunction

function [7:0] getbyte (input [15:0] address);
begin
    // code to extract low-order byte from addressed word
    getbyte = result_expression;
end
endfunction


function automatic [3:0] b;
endfunction

// define the function
function automatic integer factorial;
input [31:0] operand;
    integer i;
    if (operand >= 2)
        factorial = factorial (operand - 1) * operand;
    else
        factorial = 1;
endfunction

// test the function
integer result;
integer n;

initial begin
    for (n = 0; n <= 7; n = n+1) begin
        result = factorial(n);
        $display("%0d factorial=%0d", n, result);
    end
end
endmodule // tryfact


module ram_model (address, write, chip_select, data);
parameter data_width = 8;
parameter ram_depth = 256;

localparam addr_width = clogb2(ram_depth);

input [addr_width - 1:0] address;
input write, chip_select;
inout [data_width - 1:0] data;

//define the clogb2 function
function integer clogb2;
input [31:0] value;
begin
    value = value - 1;
    for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction

reg [data_width - 1:0] data_store[0:ram_depth - 1];
//the rest of the ram model

endmodule