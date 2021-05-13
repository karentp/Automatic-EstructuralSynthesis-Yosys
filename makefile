CONDUCTUAL = mux_memoria_conductual.v
YS1 = parcial.ys
YS2 = completo.ys
BANCO  = BancoPruebaEstructural.v
BANCOCOMP = BancoPruebaEstructural_comparativo.v




all: sintesisyosys_completa_condelay

sintesis_parcial: $(YS1)
	@echo ----------------------------------
	@echo Corriendo Sintesis Parcial sin mapeo de tecnología: 
	@echo ----------------------------------
	yosys $(YS1)
	@echo ----------------------------------
	@echo Cambiando nombre al module para evitar problemas:
	@echo ----------------------------------
	sed -i 's/mux_memoria/mux_memoria_estructural/' sintetizado.v

sintesis_completa: $(YS2)
	@echo ----------------------------------
	@echo Corriendo Sintesis Completa con liberia cmos_cells.lib: 
	@echo ----------------------------------
	yosys $(YS2)
	@echo ----------------------------------
	@echo Cambiando nombre al module para evitar problemas:
	@echo ----------------------------------
	sed -i 's/mux_memoria/mux_memoria_estructural/' sintetizado_conlib.v


prueba_parcial: $(BANCO) sintetizado.v
	@echo ----------------------------------
	@echo Corriendo prueba del estructural parcial sin uso de la libreria cmos_cells.lib:
	@echo ----------------------------------
	iverilog -o pruebaestructuralyosys.vvp $(BANCO) sintetizado.v
	vvp pruebaestructuralyosys.vvp

prueba_sin_delay: $(BANCO) cmos_cells.v sintetizado_conlib.v
	@echo ----------------------------------
	@echo Corriendo el estructural completo sin delays:
	@echo ----------------------------------
	iverilog -o pruebaestructuralyosys.vvp $(BANCO) cmos_cells.v sintetizado_conlib.v
	vvp pruebaestructuralyosys.vvp

prueba_con_delay: $(BANCO) cmos_cells_delay.v sintetizado_conlib.v
	@echo ----------------------------------
	@echo Corriendo pruebas del estructural con delays:
	@echo ----------------------------------
	iverilog -o pruebaestructuralyosys_delay.vvp $(BANCO) cmos_cells_delay.v sintetizado_conlib.v
	vvp pruebaestructuralyosys_delay.vvp

prueba_comparativa: $(BANCOCOMP) sintetizado_conlib.v cmos_cells_delay.v
	@echo ----------------------------------
	@echo Corriendo el estructural con delays comparandolo con el estructural manual:
	@echo ----------------------------------
	iverilog -o pruebaestructuralyosyscomparativo.vvp $(BANCOCOMP) sintetizado_conlib.v cmos_cells_delay.v
	vvp pruebaestructuralyosyscomparativo.vvp


sintesisyosys_parcial: 
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave sintesis parcial:
	@echo ----------------------------------
	$(MAKE) sintesis_parcial
	$(MAKE) prueba_parcial
	gtkwave mux_memoria_estructural_yosys.vcd

sintesisyosys_completa_sindelay: 
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave sin delay:
	@echo ----------------------------------
	$(MAKE) sintesis_completa
	$(MAKE) prueba_sin_delay
	gtkwave mux_memoria_estructural_yosys.vcd

sintesisyosys_completa_condelay:
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave final con delay:
	@echo ----------------------------------
	$(MAKE) sintesis_completa
	$(MAKE) prueba_con_delay
	gtkwave mux_memoria_estructural_yosys.vcd

sintesisyosys_comparativo:
	@echo ----------------------------------
	@echo Sintesis, pruebas y gtkwave comparativa:
	@echo ----------------------------------
	$(MAKE) sintesis_completa
	$(MAKE) prueba_comparativa
	gtkwave mux_memoria_estructural_comparativo.vcd




	

	
