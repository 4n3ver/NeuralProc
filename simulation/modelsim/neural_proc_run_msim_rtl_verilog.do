transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/Mux2to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/neural_processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/macc.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/inst_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/sigmoid.v}

vlog -vlog01compat -work work +incdir+C:/Users/yoeli/Desktop/NeuralProc\ students {C:/Users/yoeli/Desktop/NeuralProc students/testbench2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  testbench2

add wave *
view structure
view signals
run -all
