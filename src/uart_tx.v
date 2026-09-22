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
localparam integer BIT_IDX_WIDTH = $clog2(DATA_BITS);
reg [BIT_IDX_WIDTH-1:0] bit_idx;
reg [DATA_BITS-1:0] data_tmp;

localparam 
    IDLE   = 0,
    READ   = 1,
    OUTPUT = 2;

always @(*)begin
    case(CS)
    IDLE:       NS = (i_Tx_valid) READ : IDLE; 
    READ:       NS = OUTPUT;
    OUTPUT:     NS = (bit_idx == BIT_IDX_WIDTH)? OUTPUT : IDLE;
    default:    NS = IDLE;
end 

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        CS          <= IDLE;
        data_tmp    <= 0;
    end
    else begin
        CS <= NS;
        if(i_Tx_valid)begin
            data_tmp    <=  i_Tx_data;
        end
        else begin
            data_tmp    <= data_tmp;
        end
    end
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        o_stx   <= 0;
        bit_idx <= 0;
    end
    else begin
        if(bit_idx == BIT_IDX_WIDTH) begin
            bit_idx     <= 0;
            o_stx       <= 1;
        end 
        else if(i_bps_en)begin
            o_stx       <= data_tmp[bit_idx];
            bit_idx     <= bit_idx + 1;
        end
        else begin
            bit_idx     <= bit_idx;
            o_stx       <= 1;
        end
    end
end

endmodule
