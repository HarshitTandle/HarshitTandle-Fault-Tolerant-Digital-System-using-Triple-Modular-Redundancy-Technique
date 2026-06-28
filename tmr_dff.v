module tmr_dff (
    input wire clk,
    input wire rst,
    input wire d,
    output wire q_tmr
);

    
    reg q1, q2, q3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end else begin
            q1 <= d;
            q2 <= ~d;
            q3 <= d;
        end
    end

    
    assign q_tmr = (q1 & q2) | (q2 & q3) | (q1 & q3);

endmodule



module tmr_dff_tb;

 
    reg clk;
    reg rst;
    reg d;
    wire q_tmr;

    
    tmr_dff uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q_tmr(q_tmr)
    );

    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    
    initial begin
        
        rst = 1;
        d = 0;

        
        #10;
        rst = 0;

        
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 1;
        #10 d = 0;

       

        #20 $finish;
    end

   
    initial begin
        $monitor("Time=%0t | rst=%b d=%b | q_tmr=%b", $time, rst, d, q_tmr);
    end

endmodule