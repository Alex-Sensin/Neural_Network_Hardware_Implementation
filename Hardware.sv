module And(A, B, C);
    input logic A;
    input logic B;
    output logic C;
    assign C = A & B;
endmodule

module Adder(Cin, A, B, S, Cout);
    input logic Cin;
    input logic A;
    input logic B;
    output logic Cout;
    output logic S;

    logic x;

    assign x = A ^ B;
    assign S = x ^ Cin;
    assign Cout = (A & B) | (x & Cin);

endmodule

module Adder4(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [3:0] A;
    input logic [3:0] B;
    output logic [3:0] S;
    output logic Cout;

    wire w1, w2, w3;

    Adder Adder0(Cin, A[0], B[0], S[0], w1);
    Adder Adder1(w1, A[1], B[1], S[1], w2);
    Adder Adder2(w2, A[2], B[2], S[2], w3);
    Adder Adder3(w3, A[3], B[3], S[3], Cout);
endmodule

module Adder8(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [7:0] A;
    input logic [7:0] B;
    output logic [7:0] S;
    output logic Cout;

    wire w1;

    Adder4 Adder0(Cin, A[3:0], B[3:0], S[3:0], w1);
    Adder4 Adder1(w1, A[7:4], B[7:4], S[7:4], Cout);
endmodule

module Adder16(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [15:0] A, B;
    output logic [15:0] S;
    output logic Cout;

    wire w1, w2, w3;

    Adder4 Adder0(Cin, A[3:0], B[3:0], S[3:0], w1);
    Adder4 Adder1(w1, A[7:4], B[7:4], S[7:4], w2);
    Adder4 Adder2(w2, A[11:8], B[11:8], S[11:8], w3);
    Adder4 Adder3(w3, A[15:12], B[15:12], S[15:12], Cout);
endmodule

module Adder32(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [31:0] A, B;
    output logic [31:0] S;
    output logic Cout;

    wire w1;

    Adder16 Adder0(Cin, A[15:0], B[15:0], S[15:0], w1);
    Adder16 Adder1(w1, A[31:16], B[31:16], S[31:16], Cout);
endmodule

module halfAdder(A, B, S, Cout);
    input logic A;
    input logic B;
    output logic S;
    output logic Cout;

    assign S = A ^ B;
    assign Cout = A & B;
endmodule

module multiplier(A, B, C);
    input logic [1:0] A;
    input logic [1:0] B;
    output logic [3:0] C;

    wire w1, w2, w3, w4;

    assign C[0] = A[0] & B[0];
    assign w1 = A[1] & B[0];
    assign w2 = A[0] & B[1];
    halfAdder halfAdder0(w1, w2, C[1], w3);
    assign w4 = A[1] & B[1];
    halfAdder halfAdder1(w3, w4, C[2], C[3]);
endmodule

module multiplier4(A, B, C);
    input logic [3:0] A;
    input logic [3:0] B;
    output logic [7:0] C;

    assign C = 8'b0000_0000;

    wire half11, half12;
    wire half21, half22;
    wire half31, half32;
    wire half41, half42;

    wire full11, full12, full13;
    wire full21, full22, full23;
    wire full31, full32, full33;
    wire full41, full42, full43;
    wire full51, full52, full53;
    wire full61, full62, full63;
    wire full71, full72, full73;
    wire full81, full82, full83;

    And And01(A[0], B[0], C[0]);

    And And11(A[0], B[1], half11);
    And And12(A[1], B[0], half12);
    halfAdder halfAdder1(half11, half12, C[1], full11);

    And And21(A[0], B[2], full12);
    And And22(A[2], B[0], half22);
    And And23(A[1], B[1], half21);
    halfAdder halfAdder2(half21, half22, full13, full31);
    Adder Adder1(full11, full12, full13, C[2], full21);

    And And31(A[0], B[3], full22);
    And And32(A[1], B[2], full32);
    And And33(A[2], B[1], half31);
    And And34(A[3], B[0], half32);
    halfAdder halfAdder3(half31, half32, full33, full51);
    Adder Adder3(full31, full32, full33, full23, full41);
    Adder Adder2(full21, full22, full23, C[3], half41);

    And And41(A[1], B[3], full42);
    And And42(A[2], B[2], full52);
    And And43(A[3], B[1], full53);
    Adder Adder5(full51, full52, full53, full43, full71);
    Adder Adder4(full41, full42, full43, half42, full62);
    halfAdder halfAdder4(half41, half42, C[4], full61);

    And And51(A[2], B[3], full72);
    And And52(A[3], B[2], full73);
    Adder Adder7(full71, full72, full73, full63, full82);
    Adder Adder6(full61, full62, full63, C[5], full81);

    And And61(A[3], B[3], full83);
    Adder Adder8(full81, full82, full83, C[6], C[7]);
endmodule

module multiplier8(A, B, C);
    input logic [7:0] A;
    input logic [7:0] B;
    output logic [15:0] C;

    wire [7:0] ac, ad, bc, bd;
    logic [15:0] ac2, ad2, bc2, bd2;
    wire [15:0] out1, out2;
    wire null1, null2, null3;
    logic zero = 1'b0;
    

    // (a+b)(c+d) = ac+ad+bc+bd
    assign ac2[7:0] = 8'b0;
    assign ad2[15:12] = 4'b0;
    assign ad2[3:0] = 4'b0;
    assign bc2[15:12] = 4'b0;
    assign bc2[3:0] = 4'b0;
    assign bd2[15:8] = 8'b0;    

    multiplier4 multiplier4_2(A[7:4], B[7:4], ac);
    multiplier4 multiplier4_3(A[7:4], B[3:0], ad);
    multiplier4 multiplier4_4(A[3:0], B[7:4], bc);
    multiplier4 multiplier4_5(A[3:0], B[3:0], bd);

    assign ac2[15:8] = ac;
    assign ad2[11:4] = ad;
    assign bc2[11:4] = bc;
    assign bd2[7:0] = bd;

    Adder16 Adder16_0(zero, ac2, ad2, out1, null1);
    Adder16 Adder16_1(zero, bc2, bd2, out2, null2);
    Adder16 Adder16_2(zero, out1, out2, C, null3);
endmodule

module multiplier16(A, B, C);
    input logic [15:0] A;
    input logic [15:0] B;
    output logic [31:0] C;

    wire [15:0] ac, ad, bc, bd;
    logic [31:0] ac2, ad2, bc2, bd2;
    wire [31:0] out1, out2;
    wire null1, null2, null3;
    logic zero = 1'b0;
    

    // (a+b)(c+d) = ac+ad+bc+bd
    assign ac2[15:0] = 16'b0;
    assign ad2[31:24] = 8'b0;
    assign ad2[7:0] = 8'b0;
    assign bc2[31:24] = 8'b0;
    assign bc2[7:0] = 8'b0;
    assign bd2[31:16] = 16'b0;    

    multiplier8 multiplier8_2(A[15:8], B[15:8], ac);
    multiplier8 multiplier8_3(A[15:8], B[7:0], ad);
    multiplier8 multiplier8_4(A[7:0], B[15:8], bc);
    multiplier8 multiplier8_5(A[7:0], B[7:0], bd);

    assign ac2[31:16] = ac;
    assign ad2[23:8] = ad;
    assign bc2[23:8] = bc;
    assign bd2[15:0] = bd;

    Adder32 Adder32_0(zero, ac2, ad2, out1, null1);
    Adder32 Adder32_1(zero, bc2, bd2, out2, null2);
    Adder32 Adder32_2(zero, out1, out2, C, null3);
endmodule

module twosCompAdder8(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [8:0] A; // 8 bit with the fifth bit indicating negitive or positive
    input logic [8:0] B;
    output logic [8:0] S;
    // output logic N;
    output logic Cout;

    logic [7:0] tempA, tempB, tempS;
    logic tempSN;
    logic [1:0] test;

    // logic flag1;
    // logic flag2;
    // assign flag1 = 1'b1;

    always @(*) begin
        test = 2'bxx;
        tempSN = 1'b0;
        tempA = A[7:0];
        tempB = B[7:0];

        if ((A[8] & B[8]) === 1'b1) begin
            tempSN = 1'b1;
            test = 2'b00;
        end
        if (tempA > tempB) begin
            if (A[8] == 1'b1) begin
                tempSN = 1'b1;
                test = 2'b01;
            end
        end
        if (tempA < tempB) begin
            if (B[8] == 1'b1) begin
                tempSN = 1'b1;
                test = 2'b10;
            end
        end
        if (!(A[8] | B[8])) begin
            tempSN = 1'b0;
            test = 2'b11;
        end

        // 2 comp convertions
        if (A[8] == 1'b1) begin
            tempA = ~A[7:0] + 1'b1;
        end else begin
            tempA = A[7:0];
        end

        if (B[8] == 1'b1) begin
            tempB = ~B[7:0] + 1'b1;
        end else begin
            tempB = B[7:0];
        end

    end

    Adder8 Adder8_0(Cin, tempA, tempB, tempS, Cout);

    logic [7:0] temp;

    always @(*) begin
        temp = 8'b00000000;
        if (tempSN == 1'b1) begin
            temp = ~tempS[7:0] + 1'b1;
        end else begin
            temp = tempS[7:0];
        end
    end
    // assign tempS = ~tempS + 1'b1;
    assign S[7:0] = temp[7:0];
    assign S[8] = tempSN;
endmodule

module twosCompAdder16(Cin, A, B, S, Cout);
    input logic Cin;
    input logic [16:0] A; // 16 bit with the fifth bit indicating negitive or positive
    input logic [16:0] B;
    output logic [16:0] S;
    // output logic N;
    output logic Cout;

    logic [15:0] tempA, tempB, tempS;
    logic tempSN;
    logic [1:0] test;

    // logic flag1;
    // logic flag2;
    // assign flag1 = 1'b1;

    always @(*) begin
        test = 2'bxx;
        tempSN = 1'b0;
        tempA = A[15:0];
        tempB = B[15:0];

        if ((A[16] & B[16]) === 1'b1) begin
            tempSN = 1'b1;
            test = 2'b00;
        end
        if (tempA > tempB) begin
            if (A[16] == 1'b1) begin
                tempSN = 1'b1;
                test = 2'b01;
            end
        end
        if (tempA < tempB) begin
            if (B[16] == 1'b1) begin
                tempSN = 1'b1;
                test = 2'b10;
            end
        end
        if (!(A[16] | B[16])) begin
            tempSN = 1'b0;
            test = 2'b11;
        end

        // 2 comp convertions
        if (A[16] == 1'b1) begin
            tempA = ~A[15:0] + 1'b1;
        end else begin
            tempA = A[15:0];
        end

        if (B[16] == 1'b1) begin
            tempB = ~B[15:0] + 1'b1;
        end else begin
            tempB = B[15:0];
        end

    end

    Adder16 Adder16_0(Cin, tempA, tempB, tempS, Cout);

    // assign flag2 = 1'b1;

    always@(*) begin
        if (tempSN == 1'b1) begin
            tempS = ~tempS + 1'b1;
        end else if (Cout) begin
            
        end
    end
    // assign tempS = ~tempS + 1'b1;

    assign S[15:0] = tempS;
    assign S[16] = tempSN;
endmodule

module fractionAdder12(A, B, Out, Cout);
    input logic [11:0] A;
    input logic [11:0] B;
    output logic [11:0] Out;
    output logic Cout;
    logic[8:0] offset = 9'b100000111; // -7 00111 -> 11001

    logic [8:0] expA;
    assign expA[8] = A[11];
    assign expA[7:4] = 4'b0000;
    assign expA[3:0] = A[10:7];
    logic [8:0] expB;
    assign expB[8] = B[11];
    assign expB[7:4] = 4'b0000;
    assign expB[3:0] = B[10:7];

    logic [8:0] tempexpA;
    assign tempexpA[3:0] = expA[3:0];
    assign tempexpA[8:4] = 2'h0;
    logic [8:0] tempexpB;
    assign tempexpB[3:0] = expB[3:0];
    assign tempexpB[8:4] = 2'h0;


    logic [8:0] tempEA;
    logic [3:0] eA; //amount to be shifted
    logic eA_Cout;
    logic [8:0] tempEB;
    logic [3:0] eB;
    logic eB_Cout;
    logic eA_Sign;
    logic eB_Sign;

    wire null1;
    wire null2;

    twosCompAdder8 Comp_eA(1'b0, tempexpA, offset, tempEA, null1);
    twosCompAdder8 Comp_eB(1'b0, tempexpB, offset, tempEB, null2);

    assign eA_Cout = tempEA[4];
    assign eA[3:0] = tempEA[3:0];
    assign eA_Sign = tempEA[8];

    assign eB_Cout = tempEB[4];
    assign eB[3:0] = tempEB[3:0];
    assign eB_Sign = tempEB[8];

    logic [7:0] OutMag;
    logic [3:0] OutExp;
    logic [7:0] tempMagA;
    logic [7:0] tempMagB;
    logic [2:0] test3;

    always @(*) begin
        test3 = 3'bxxx;
        OutExp = 4'b0000;
        if (eA_Sign == 1'b1) begin
            if (eB_Sign == 1'b1) begin
                if (eA == eB) begin
                tempMagA[6:0] = A[6:0];
                tempMagA[7] = 1'b1;
                tempMagB[6:0] = B[6:0];
                tempMagB[7] = 1'b1;
                OutExp = expA[3:0];
                test3 = 3'b000;
                end else if (eA < eB) begin
                    tempMagA[6:0] = A[6:0];
                    tempMagA[7] = 1'b1;
                    tempMagB[6:0] = B[6:0];
                    tempMagB[7] = 1'b1;

                    tempMagB = tempMagB >> (eB - eA);
                    OutExp = expA[3:0]; 
                    test3 = 3'b001;   
                end else if (eA > eB) begin
                    tempMagA[6:0] = A[6:0];
                    tempMagA[7] = 1'b1;
                    tempMagB[6:0] = B[6:0];
                    tempMagB[7] = 1'b1;

                    tempMagA = tempMagA >> (eA - eB);
                    OutExp = expB[3:0]; 
                    test3 = 3'b010;   
                end
            end else if (eB_Sign == 1'b0) begin
                tempMagA[6:0] = A[6:0];
                tempMagA[7] = 1'b1;
                tempMagB[6:0] = B[6:0];
                tempMagB[7] = 1'b1;

                tempMagA = tempMagA >> (eB + eA);
                OutExp = expB[3:0]; 
                test3 = 3'b011;  
            end
        end else if (eB_Sign == 1'b1) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagB = tempMagB >> (eA + eB);
            OutExp = expA[3:0]; 
            test3 = 3'b100; 
        end else if (eA == eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;
            OutExp = expA[3:0];
            test3 = 3'b101;
        end else if (eA > eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagB = tempMagB >> (eA - eB);
            OutExp = expA[3:0]; 
            test3 = 3'b110;   
        end else if (eA < eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagA = tempMagA >> (eB - eA);
            OutExp = expB[3:0]; 
            test3 = 3'b111;   
        end
    end 

    logic [16:0] outA;
    logic [16:0] outB;
    logic [16:0] tempOutMag;
    logic null3;
    logic test2 = 1'bx;
    logic [3:0] tempOutExp;

    assign outA[16] = A[11];
    assign outA[7:0] = tempMagA;
    assign outA[15:8] = 2'h0;
    assign outB[16] = B[11];
    assign outB[7:0] = tempMagB;
    assign outB[15:8] = 2'h0;

    twosCompAdder16 Add16(1'b0, outA, outB, tempOutMag, null3);
    
    always @(*) begin
        test2 = 1'bx;
        if (A[10:0] == 11'b00000000000) begin
            tempOutMag[6:0] = B[6:0];
            tempOutExp = B[10:7];
            tempOutMag[16] = B[11];
        end else if (B[10:0] == 11'b00000000000) begin
            tempOutMag[6:0] = A[6:0];
            tempOutExp = A[10:7];
            tempOutMag[16] = A[11];
        end else if (tempOutMag[8] === 1'b1) begin
            tempOutExp = OutExp + 1'b1;
            tempOutMag = tempOutMag >> 1;
            test2 = 1'b0;
        end else begin
            tempOutExp = OutExp;
            tempOutMag = tempOutMag;
            test2 = 1'b1;
        end
    end

    assign Out[6:0] = tempOutMag[6:0];
    assign Out[10:7] = tempOutExp;
    assign Out[11] = tempOutMag[16];

endmodule

module fractionAdder14(A, B, Out, Cout);
    input logic [13:0] A;
    input logic [13:0] B;
    output logic [13:0] Out;
    output logic Cout;
    logic[8:0] offset = 9'b100011111; // -31 ,001111 

    logic [8:0] expA;
    assign expA[8] = A[13];
    assign expA[7:6] = 2'b00;
    assign expA[5:0] = A[12:7];
    logic [8:0] expB;
    assign expB[8] = B[13];
    assign expB[7:6] = 2'b00;
    assign expB[5:0] = B[12:7];

    logic [8:0] tempexpA;
    assign tempexpA[5:0] = expA[5:0];
    assign tempexpA[8:6] = 2'h0;
    logic [8:0] tempexpB;
    assign tempexpB[5:0] = expB[5:0];
    assign tempexpB[8:6] = 2'h0;


    logic [8:0] tempEA;
    logic [5:0] eA; //amount to be shifted
    logic eA_Cout;
    logic [8:0] tempEB;
    logic [5:0] eB;
    logic eB_Cout;
    logic eA_Sign;
    logic eB_Sign;

    wire null1;
    wire null2;

    twosCompAdder8 Comp_eA(1'b0, tempexpA, offset, tempEA, null1);
    twosCompAdder8 Comp_eB(1'b0, tempexpB, offset, tempEB, null2);

    assign eA_Cout = tempEA[6];
    assign eA[5:0] = tempEA[5:0];
    assign eA_Sign = tempEA[8];

    assign eB_Cout = tempEB[6];
    assign eB[5:0] = tempEB[5:0];
    assign eB_Sign = tempEB[8];

    logic [7:0] OutMag;
    logic [5:0] OutExp;
    logic [7:0] tempMagA;
    logic [7:0] tempMagB;
    logic [2:0] test3;

    always @(*) begin
        test3 = 3'bxxx;
        OutExp = 6'b000000;
        if (eA_Sign == 1'b1) begin
            if (eB_Sign == 1'b1) begin
                if (eA == eB) begin
                tempMagA[6:0] = A[6:0];
                tempMagA[7] = 1'b1;
                tempMagB[6:0] = B[6:0];
                tempMagB[7] = 1'b1;
                OutExp = expA[5:0];
                test3 = 3'b000;
                end else if (eA < eB) begin
                    tempMagA[6:0] = A[6:0];
                    tempMagA[7] = 1'b1;
                    tempMagB[6:0] = B[6:0];
                    tempMagB[7] = 1'b1;

                    tempMagB = tempMagB >> (eB - eA);
                    OutExp = expA[5:0]; 
                    test3 = 3'b001;   
                end else if (eA > eB) begin
                    tempMagA[6:0] = A[6:0];
                    tempMagA[7] = 1'b1;
                    tempMagB[6:0] = B[6:0];
                    tempMagB[7] = 1'b1;

                    tempMagA = tempMagA >> (eA - eB);
                    OutExp = expB[5:0]; 
                    test3 = 3'b010;   
                end
            end else if (eB_Sign == 1'b0) begin
                tempMagA[6:0] = A[6:0];
                tempMagA[7] = 1'b1;
                tempMagB[6:0] = B[6:0];
                tempMagB[7] = 1'b1;

                tempMagA = tempMagA >> (eB + eA);
                OutExp = expB[5:0]; 
                test3 = 3'b011;  
            end
        end else if (eB_Sign == 1'b1) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagB = tempMagB >> (eA + eB);
            OutExp = expA[5:0]; 
            test3 = 3'b100; 
        end else if (eA == eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;
            OutExp = expA[5:0];
            test3 = 3'b101;
        end else if (eA > eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagB = tempMagB >> (eA - eB);
            OutExp = expA[5:0]; 
            test3 = 3'b110;   
        end else if (eA < eB) begin
            tempMagA[6:0] = A[6:0];
            tempMagA[7] = 1'b1;
            tempMagB[6:0] = B[6:0];
            tempMagB[7] = 1'b1;

            tempMagA = tempMagA >> (eB - eA);
            OutExp = expB[5:0]; 
            test3 = 3'b111;   
        end
    end 

    logic [16:0] outA;
    logic [16:0] outB;
    logic [16:0] tempOutMag;
    logic null3;
    logic test2 = 1'bx;
    logic [5:0] tempOutExp;

    assign outA[16] = A[13];
    assign outA[7:0] = tempMagA;
    assign outA[15:8] = 2'h0;
    assign outB[16] = B[13];
    assign outB[7:0] = tempMagB;
    assign outB[15:8] = 2'h0;

    twosCompAdder16 Add16(1'b0, outA, outB, tempOutMag, null3);
    
    always @(*) begin
        test2 = 1'bx;
        if (A[12:0] == 13'b00000000000) begin
            tempOutMag[6:0] = B[6:0];
            tempOutExp = B[12:7];
            tempOutMag[16] = B[13];
        end else if (B[13:0] == 13'b00000000000) begin
            tempOutMag[6:0] = A[6:0];
            tempOutExp = A[12:7];
            tempOutMag[16] = A[13];
        end else if (tempOutMag[8] === 1'b1) begin
            tempOutExp = OutExp + 1'b1;
            tempOutMag = tempOutMag >> 1;
            test2 = 1'b0;
        end else begin
            tempOutExp = OutExp;
            tempOutMag = tempOutMag;
            test2 = 1'b1;
        end
    end

    assign Out[6:0] = tempOutMag[6:0];
    assign Out[12:7] = tempOutExp;
    assign Out[13] = tempOutMag[16];

endmodule

module signMultiplier8(A, B, C);
    input logic [8:0] A;
    input logic [8:0] B;
    output logic [16:0] C;

    logic [7:0] tempA;
    logic signA;
    logic [7:0] tempB;
    logic signB;
    logic [15:0] tempC;
    logic signC;

    assign tempA[7:0] = A[7:0];
    assign signA = A[8];
    assign tempB[7:0] = B[7:0];
    assign signB = B[8];

    multiplier8 mult8(tempA, tempB, tempC);

    always @(*) begin
        if (signA == 1'b1) begin
            if (signB == 1'b1) begin
                signC = 1'b0;
            end else begin
                signC = 1'b1;
            end
        end else if (signB == 1'b1) begin
            signC = 1'b1;
        end else begin
            signC = 1'b0;
        end

        if (tempC == 16'h0) begin
            signC = 1'b0;
        end
    end

    assign C[16] = signC;
    assign C[15:0] = tempC;

endmodule

module signMultiplier16(A, B, C);
    input logic [16:0] A;
    input logic [16:0] B;
    output logic [32:0] C;

    logic [15:0] tempA;
    logic signA;
    logic [15:0] tempB;
    logic signB;
    logic [31:0] tempC;
    logic signC;

    assign tempA[15:0] = A[15:0];
    assign signA = A[16];
    assign tempB[15:0] = B[15:0];
    assign signB = B[16];

    multiplier16 mult16(tempA, tempB, tempC);

    always @(*) begin
        if (signA == 1'b1) begin
            if (signB == 1'b1) begin
                signC = 1'b0;
            end else begin
                signC = 1'b1;
            end
        end else if (signB == 1'b1) begin
            signC = 1'b1;
        end else begin
            signC = 1'b0;
        end

        if (tempC == 16'h0) begin
            signC = 1'b0;
        end
    end

    assign C[32] = signC;
    assign C[31:0] = tempC;

endmodule

module fractionMultiplier12(A, B, C);
    // offset 11, range x^2, x^-13
    input logic [11:0] A;
    input logic [11:0] B;
    output logic [11:0] C;

    // variable setup
    logic signA;
    logic [3:0] expA;
    logic [6:0] magA;
    logic signB;
    logic [3:0] expB;
    logic [6:0] magB;
    logic [3:0] expC;
    logic [6:0] magC;
    logic signC;

    assign signA = A[11];
    assign expA = A[10:7];
    assign magA = A[6:0];
    assign signB = B[11];
    assign expB = B[10:7];
    assign magB = B[6:0];

    // Magnitude calculations
    logic [8:0] tempMagA;
    logic [8:0] tempMagB;

    assign tempMagA[6:0] = magA[6:0];
    assign tempMagB[6:0] = magB[6:0];

    assign tempMagA[7] = 1'b1;
    assign tempMagB[7] = 1'b1;

    assign tempMagA[8] = signA;
    assign tempMagB[8] = signB;

    logic [16:0] tempMagC;
    logic expShift;

    signMultiplier8 mult8(tempMagA, tempMagB, tempMagC);

    always @(*) begin
        expShift = 1'b0;
        if (tempMagC[15] == 1'b1) begin
            expShift = 1'b1;
        end else begin
            expShift = 1'b0;
        end
    end

    assign signC = tempMagC[16];
    assign magC[6:0] = tempMagC[13:7] >> expShift;

    // Exponent Calculations
    logic [8:0] tempExpA;
    logic [8:0] tempExpB;
    logic [8:0] tempExpC;
    logic [8:0] offsetA;
    logic [8:0] offsetB;
    logic [8:0] offsetC;
    logic [8:0] offset;
    logic [8:0] posOffset;
    wire null1, null2, null3, null4;

    assign offset = 9'b1_0000_1011;
    assign posOffset = 9'b0_0000_1011;
    assign tempExpA[3:0] = expA;
    assign tempExpB[3:0] = expB;
    assign tempExpA[8:4] = 5'b0_0000;
    assign tempExpB[8:4] = 5'b0_0000;

    twosCompAdder8 offset1(1'b0, tempExpA, offset, offsetA, null1);
    twosCompAdder8 offset2(1'b0, tempExpB, offset, offsetB, null2);

    twosCompAdder8 exp1(1'b0, offsetA, offsetB, offsetC, null3);
    twosCompAdder8 exp2(1'b0, offsetC, posOffset, tempExpC, null4);

    assign expC = tempExpC[3:0] + expShift;

    logic [16:0] tempOutMag;
    logic [3:0] tempOutExp;

    always @(*) begin
        if (A[10:0] == 11'b00000000000) begin
            tempOutMag[6:0] =7'b0000000;
            tempOutExp = 4'b0000;
            tempOutMag[16] = 1'b0;
        end else if (B[10:0] == 11'b00000000000) begin
            tempOutMag[6:0] = 7'b0000000;
            tempOutExp = 4'b0000;
            tempOutMag[16] = 1'b0;
        end else begin
            tempOutMag[16] = signC;
            tempOutMag[6:0] = magC;
            tempOutExp[3:0] = expC[3:0];
        end
    end

    // Final Values
    assign C[11] = tempOutMag[16];
    assign C[10:7] = tempOutExp[3:0];
    assign C[6:0] = tempOutMag[6:0];

endmodule

module fractionMultiplier14(A, B, C);
    // offset 31, range x^2, x^-13
    input logic [13:0] A;
    input logic [13:0] B;
    output logic [13:0] C;

    // variable setup
    logic signA;
    logic [5:0] expA;
    logic [6:0] magA;
    logic signB;
    logic [5:0] expB;
    logic [6:0] magB;
    logic [5:0] expC;
    logic [6:0] magC;
    logic signC;

    assign signA = A[13];
    assign expA = A[12:7];
    assign magA = A[6:0];
    assign signB = B[13];
    assign expB = B[12:7];
    assign magB = B[6:0];

    // Magnitude calculations
    logic [8:0] tempMagA;
    logic [8:0] tempMagB;

    assign tempMagA[6:0] = magA[6:0];
    assign tempMagB[6:0] = magB[6:0];

    assign tempMagA[7] = 1'b1;
    assign tempMagB[7] = 1'b1;

    assign tempMagA[8] = signA;
    assign tempMagB[8] = signB;

    logic [16:0] tempMagC;
    logic expShift;

    signMultiplier8 mult8(tempMagA, tempMagB, tempMagC);

    always @(*) begin
        expShift = 1'b0;
        if (tempMagC[15] == 1'b1) begin
            expShift = 1'b1;
        end else begin
            expShift = 1'b0;
        end
    end

    assign signC = tempMagC[16];
    assign magC[6:0] = tempMagC[13:7] >> expShift;

    // Exponent Calculations
    logic [8:0] tempExpA;
    logic [8:0] tempExpB;
    logic [8:0] tempExpC;
    logic [8:0] offsetA;
    logic [8:0] offsetB;
    logic [8:0] offsetC;
    logic [8:0] offset;
    logic [8:0] posOffset;
    wire null1, null2, null3, null4;

    assign offset = 9'b1_0001_1111; //offset 31
    assign posOffset = 9'b0_0001_1111;
    assign tempExpA[5:0] = expA;
    assign tempExpB[5:0] = expB;
    assign tempExpA[8:6] = 3'b000;
    assign tempExpB[8:6] = 3'b000;

    twosCompAdder8 offset1(1'b0, tempExpA, offset, offsetA, null1);
    twosCompAdder8 offset2(1'b0, tempExpB, offset, offsetB, null2);

    twosCompAdder8 exp1(1'b0, offsetA, offsetB, offsetC, null3);
    twosCompAdder8 exp2(1'b0, offsetC, posOffset, tempExpC, null4);

    assign expC = tempExpC[5:0] + expShift;

    logic [16:0] tempOutMag;
    logic [5:0] tempOutExp;

    always @(*) begin
        if (A[12:0] == 13'b0000000000000) begin
            tempOutMag[6:0] =7'b0000000;
            tempOutExp = 6'b000000;
            tempOutMag[16] = 1'b0;
        end else if (B[12:0] == 13'b0000000000000) begin
            tempOutMag[6:0] = 7'b0000000;
            tempOutExp = 6'b000000;
            tempOutMag[16] = 1'b0;
        end else begin
            tempOutMag[16] = signC;
            tempOutMag[6:0] = magC;
            tempOutExp[5:0] = expC[5:0];
        end
    end

    // Final Values
    assign C[13] = tempOutMag[16];
    assign C[12:7] = tempOutExp[5:0];
    assign C[6:0] = tempOutMag[6:0];

endmodule
    
module Relu8(X, Out);
    input logic [8:0] X;
    output logic [8:0] Out;

    logic [8:0] tempOut;
    
    always @(*) begin
        if (X[8] == 1'b0) begin
            tempOut = X;
        end else begin
            tempOut = 9'b0_0000_0000;
        end
    end

    assign Out = tempOut;

endmodule

module Relu12(X, Out);
    input logic [11:0] X;
    output logic [11:0] Out;

    logic [11:0] tempOut;
    
    always @(*) begin
        if (X[11] == 1'b0) begin
            tempOut = X;
        end else begin
            tempOut = 12'b0_000_0000_0000;
        end
    end

    assign Out = tempOut;

endmodule

module Relu14(X, Out);
    input logic [14:0] X;
    output logic [14:0] Out;

    logic [14:0] tempOut;
    
    always @(*) begin
        if (X[14] == 1'b0) begin
            tempOut = X;
        end else begin
            tempOut = 14'b0_0000_0000_0000;
        end
    end

    assign Out = tempOut;

endmodule

// looks at weight file, input file, and bias file
// and runs the values to the activation function
// 

