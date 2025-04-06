`timescale 1ns/1ns

module dma ( 
    input clk, 
    input reset, 
    input wire [15:0] uio_in,
    output wire fetch_w,
    output wire fetch_inp,
    output wire fetch_ins,
    output wire start,
    output wire [5:0] dma_address 
);

    assign fetch_w = (uio_in[15:12] == 4'b0001) ? 1 : 0;  
    assign fetch_inp = (uio_in[15:12] == 4'b0010) ? 1 : 0;
    assign fetch_ins = (uio_in[15:12] == 4'b0011) ? 1 : 0;  
    assign start = (uio_in[15:12] == 4'b0100) ? 1 : 0;   
    assign dma_address = uio_in[5:0]; 

endmodule
