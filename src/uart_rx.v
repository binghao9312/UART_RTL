module uart_rx #(
    parameter integer DATA_BITS = 8
) (
    input        i_clk,
    input        i_rst,
    input        i_bps_en,
    input        i_srx,
    output reg [DATA_BITS-1:0] o_Rx_data,
    output reg                  o_Rx_valid
);


reg [2:0] CS,NS;
localparam integer BIT_IDX_WIDTH = $clog2(DATA_BITS);
reg [BIT_IDX_WIDTH-1:0] bit_idx;


endmodule
