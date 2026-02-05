`timescale 1ns / 1ps

module tb_systolic_2x2;

parameter DW = 8;
parameter PW = 32;

reg clk;
reg rst;

reg [DW-1:0] A00, A10;
reg [DW-1:0] B00, B01;

wire [PW-1:0] C00, C01, C10, C11;

systolic_2x2 dut (
    .clk(clk),
    .rst(rst),

    .A00(A00), .A01(0),
    .A10(A10), .A11(0),

    .B00(B00), .B01(B01),
    .B10(0),   .B11(0),

    .C00(C00), .C01(C01),
    .C10(C10), .C11(C11)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    A00 = 0; A10 = 0;
    B00 = 0; B01 = 0;

    #20 rst = 0;

    // Cycle 1
    A00 = 1;   // A(0,0)
    A10 = 0;
    B00 = 5;   // B(0,0)
    B01 = 0;
    #10;

    // Cycle 2
    A00 = 2;   // A(0,1)
    A10 = 3;   // A(1,0)
    B00 = 7;   // B(1,0)
    B01 = 6;   // B(0,1)
    #10;

    // Cycle 3
    A00 = 0;
    A10 = 4;   // A(1,1)
    B00 = 0;
    B01 = 8;   // B(1,1)
    #10;

    // Flush
    A00 = 0; A10 = 0;
    B00 = 0; B01 = 0;
    #20;

    $display("C00 = %d (expected 19)", C00);
    $display("C01 = %d (expected 22)", C01);
    $display("C10 = %d (expected 43)", C10);
    $display("C11 = %d (expected 50)", C11);

    #10 $finish;
end

endmodule
