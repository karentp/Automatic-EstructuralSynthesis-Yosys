//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

`timescale 	1ns	/ 100ps
// escala	unidad temporal (valor de "#1") / precisi�n

// includes de archivos de verilog

`include "mux_memoria_conductual.v"
`include "mux_memoria_estructural.v"
`include "probador_estructural_comparativo.v"
//`include "cmos_cells_delay.v"
//`include "sintetizado.v"
//`include "sintetizado_conlib.v"



 // Testbench
module BancoPruebasEstructural;
	
    wire clk, selector, reset_L, checker;
	wire [1:0] data_in0, data_in1, data_out_conductual, data_out_estructural, data_out_estructural_yosis;

	// Descripcion conductual del MUX con memoria
	mux_memoria	mux_conductual( .clk(clk), .selector(selector), .reset_L(reset_L), 
                             .data_in0(data_in0), .data_in1(data_in1), .data_out(data_out_conductual) );

	mux_memoria_estructural_manual	mux_estructural( .clk(clk), .selector(selector), .reset_L(reset_L), 
                             .data_in0(data_in0), .data_in1(data_in1), .data_out(data_out_estructural) );

	// Descripcion estructural del mux con memoria generado por Yosys
	mux_memoria_estructural	mux_estructural_yosys( .clk(clk), .selector(selector), .reset_L(reset_L), 
                             .data_in0(data_in0), .data_in1(data_in1), .data_out(data_out_estructural_yosis) );

	// Probador: generador de señales y monitor
	probador_estructural 	prob( .clk(clk), .selector(selector), .reset_L(reset_L), 
                     .data_in0(data_in0), .data_in1(data_in1), .data_out_conductual(data_out_conductual),
					.data_out_estructural(data_out_estructural), .data_out_estructural_yosis(data_out_estructural_yosis));
	


	

endmodule