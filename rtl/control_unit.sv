`timescale 1ns/1ns

module control_unit (
    input wire fetch_ins,
    input wire [15:0] ui_in,       // 指令输入
    input wire [5:0] dma_address,  // 指令存储器地址

    input wire clk,
    input wire reset,
    input wire start,
    output reg [5:0] base_address,
    output reg load_input,
    output reg load_weight,
    output reg valid,
    output reg store,
    output reg ext
);

    
    reg [15:0] instruction_memory [0:63]; // 指令存储器（最多支持64条指令）
    reg [5:0] pc;                         // 指令计数器,一次读一条
    reg [15:0] current_instruction;       // 当前指令
    reg [2:0] opcode;                     // 操作码字段
    reg [5:0] addr_field;                 // 操作码字段

    // 指令操作码定义
    localparam [2:0]
        OP_NOP        = 3'b000,
        OP_LOAD_ADDR  = 3'b001,
        OP_LOAD_WEIGHT= 3'b010,
        OP_LOAD_INPUT = 3'b011,
        OP_COMPUTE    = 3'b100,
        OP_STORE      = 3'b101,
        OP_EXT        = 3'b111;

    // 状态机状态定义
    typedef enum logic [3:0] {
        IDLE,
        FETCH,
        DECODE,
        LOAD_ADDR,
        LOAD_INPUT,
        LOAD_WEIGHT,
        COMPUTE,
        STORE_RESULT,
        EXT_OP
    } state_t;
    
    state_t state;
    // 主控制逻辑和状态机
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 重置所有信号和状态
            state <= IDLE;
            pc <= 6'd0;
            current_instruction <= 16'd0;            
            base_address <= 6'd0;
            load_input <= 1'b0;
            load_weight <= 1'b0;
            valid <= 1'b0;
            store <= 1'b0;
            ext <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (fetch_ins) begin
                        // 加载指令到指令存储器
                        instruction_memory[dma_address] <= ui_in;
                    end else if (start) begin
                        // 开始执行指令
                        state <= FETCH;
                    end
                end

                FETCH: begin
                    // 从指令存储器中取指令
                    current_instruction <= instruction_memory[pc];
                    pc <= pc + 6'd1;
                    state <= DECODE;
                end

                DECODE: begin
                    opcode <= current_instruction[15:13];
                    addr_field <= current_instruction[12:7];
                    // 根据操作码转移到相应的状态
                    case (opcode)
                        OP_LOAD_ADDR:  state <= LOAD_ADDR;
                        OP_LOAD_INPUT: state <= LOAD_INPUT;
                        OP_LOAD_WEIGHT:state <= LOAD_WEIGHT;
                        OP_COMPUTE:    state <= COMPUTE;
                        OP_STORE:      state <= STORE_RESULT;
                        OP_EXT:        state <= EXT_OP;
                        default:       state <= FETCH;  // NOP或未定义指令，直接取下一条指令
                    endcase
                end

                LOAD_ADDR: begin
                    // 执行 LOAD_ADDR 指令
                    base_address <= addr_field;
                    state <= FETCH;  // 完成后取下一条指令
                end

                LOAD_INPUT: begin
                    // 执行 LOAD_INPUT 指令
                    load_input <= 1'b1;
                    state <= FETCH;  // 完成后取下一条指令
                end

                LOAD_WEIGHT: begin
                    // 执行 LOAD_WEIGHT 指令
                    load_weight <= 1'b1;
                    state <= FETCH;  // 完成后取下一条指令
                end

                COMPUTE: begin
                    // 执行 COMPUTE 指令
                    valid <= 1'b1;
                    state <= FETCH;  // 完成后取下一条指令
                end

                STORE_RESULT: begin
                    // 执行 STORE 指令
                    store <= 1'b1;
                    state <= FETCH;  // 完成后取下一条指令
                end

                EXT_OP: begin
                    // 执行 EXT 指令，结束执行
                    ext <= 1'b1;
                    state <= IDLE;   // 回到空闲状态
                    pc <= 6'd0;      // 重置程序计数器
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
