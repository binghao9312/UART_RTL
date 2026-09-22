module uart_tx #(
    parameter integer DATA_BITS = 8
) (
    input        i_clk,
    input        i_rst,
    input        i_bps_en,
    input        i_Tx_valid,
    input  [DATA_BITS-1:0] i_Tx_data,
    output reg              o_stx
);

reg [2:0] CS,NS;
reg temp_save;
localparam integer BIT_IDX_WIDTH = $clog2(DATA_BITS);
reg [BIT_IDX_WIDTH-1:0] bit_idx;
reg [DATA_BITS-1:0] data_tmp;
/*
localparam 
    IDLE   = 0,
    READ   = 1,
    OUTPUT = 2;

always @(*)begin
    case(CS)
    IDLE:
    READ:
    OUTPUT:
    default: 
end */

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        CS  <= IDLE;
        temp_save <= 0;
    end
    else begin
        CS <= NS;
        if(i_Tx_valid)begin
            temp_save   <= 1;
            data_tmp    <= (temp_save){0,data_tmp[7:1]} :  i_Tx_data;
        end
        else begin
            temp_save   <= 0;
            data_tmp    <= 0;
        end
    end
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        o_stx <= 0;
    end
    else begin
        if(temp_save)begin
            o_stx       <= data_tmp[0];
        end
        else begin
            o_stx       <= 0;
        end
    end
end

endmodule
