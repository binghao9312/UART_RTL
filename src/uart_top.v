module#(
    parameter DATA_BITS = 8
) 
uart_top(
    input        i_clk,
    input        i_rst,

    input        i_srx,
    output [7:0] o_Rx_data,
    output       o_Rx_valid,

    input        i_Tx_valid,
    input  [7:0] i_Tx_data,
    output       o_stx
);

endmodule
