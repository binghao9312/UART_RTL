module #(
    parameter DATA_BITS = 8
)
uart_rx(
    input        i_clk,
    input        i_rst,
    input        i_bps_en,
    input        i_srx,
    output [7:0] o_Rx_data,
    output       o_Rx_valid
);


reg [2:0] CS,NS;


endmodule
