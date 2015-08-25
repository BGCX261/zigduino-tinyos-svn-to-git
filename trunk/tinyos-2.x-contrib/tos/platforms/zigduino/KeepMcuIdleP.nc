module KeepMcuIdleP{
  provides {
    interface McuPowerOverride;
  }
}
implementation {
	async command mcu_power_t McuPowerOverride.lowestState()
	{
		return ATM128_POWER_IDLE;
	}
}
