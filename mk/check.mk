BATCHDIR = unittest

check: $(OUTDIR)/$(TARGET).bin $(QEMU_STM32)
	$(QEMU_STM32) -nographic -M stm32-p103 \
		-gdb tcp::3333 -S \
		-serial stdio \
		-kernel $(OUTDIR)/$(TARGET).bin -monitor null > /dev/null &
	@echo
	$(CROSS_COMPILE)gdb -batch -x $(BATCHDIR)/test-itoa.in
	@mv -f gdb.txt test-strlen.txt
	@echo
	@pkill -9 $(notdir $(QEMU_STM32))
