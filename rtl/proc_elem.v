module PE #(
parameter DW = 8,
parameter PW = 32
)(
input  wire clk,
input  wire rst,
input  wire [DW-1:0] a_in,
input  wire [DW-1:0] b_in,

output reg  [DW-1:0] a_out,
output reg  [DW-1:0] b_out,
output reg  [PW-1:0] psum
);

always @(posedge clk) begin
    if (rst) begin
        a_out <= 0;
        b_out <= 0;
        psum  <= 0;
    end else begin
        a_out <= a_in;
        b_out <= b_in;
        psum  <= psum + (a_in * b_in);
    end
end

endmodule
