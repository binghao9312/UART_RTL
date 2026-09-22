module uart_top #(
    parameter integer DATA_BITS = 8
) (
    input        i_clk,
    input        i_rst,

    input        i_srx,
    output [DATA_BITS-1:0] o_Rx_data,
    output       o_Rx_valid,

    input        i_Tx_valid,
    input  [DATA_BITS-1:0] i_Tx_data,
    output       o_stx
);

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        
    end
    else begin
    
    end
end


endmodule
