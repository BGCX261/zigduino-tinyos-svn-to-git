/*
 * Copyright (c) 2010, University of Szeged
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Miklos Maroti
 *
 * Modified on 2012/06/01
 * Author: Ugo Colesanti <colesanti@dis.uniroma1.it>
 * Comment: added support for external 16Mhz transceiver oscillator as
 * 			main clock (it is set to be the default behavior, you need to
 * 			define ATM128RFA1_RC_OSC to switch back to internal RC Oscillator)
 */

#include "TimerConfig.h"
#ifndef ATM128RFA1_RC_OSC
#define ATM128RFA1_RC_OSC 0
#else
#define ATM128RFA1_RC_OSC 1
#endif
module McuInitP @safe()
{
	provides interface Init;

	uses
	{
		interface Init as MeasureClock;
		interface Init as TimerInit;
		interface Init as AdcInit;
		interface Init as RadioInit;
	}
}

implementation
{
	error_t systemClockInit()
	{
		// set the clock prescaler
		atomic
		{
			// enable changing the prescaler
			CLKPR = 0x80;

#if PLATFORM_MHZ == 16
			CLKPR = (ATM128RFA1_RC_OSC)? 0x0f : 0x00 ;
#elif PLATFORM_MHZ == 8
			CLKPR = (ATM128RFA1_RC_OSC)? 0x00 : 0x01 ;
#elif PLATFORM_MHZ == 4
			CLKPR = (ATM128RFA1_RC_OSC)? 0x01 : 0x02 ;
#elif PLATFORM_MHZ == 2
			CLKPR = (ATM128RFA1_RC_OSC)? 0x02 : 0x03 ;
#elif PLATFORM_MHZ == 1
			CLKPR = (ATM128RFA1_RC_OSC)? 0x03 : 0x04 ;
#else
	#error "Unsupported MHZ"
#endif
		}

		return SUCCESS;
	}

	command error_t Init.init()
	{
		error_t ok;
		// workaround for errata 38.5.1 in datasheet
		if( VERSION_NUM==3 ){ //revision c (1.1)
			DRTRAM0 |= 1<<ENDRT;
			DRTRAM1 |= 1<<ENDRT;
			DRTRAM2 |= 1<<ENDRT;
			DRTRAM3 |= 1<<ENDRT;
		}
		
		ok = systemClockInit();
		ok = ecombine(ok, call MeasureClock.init());
		ok = ecombine(ok, call TimerInit.init());
		ok = ecombine(ok, call AdcInit.init());
		ok = ecombine(ok, call RadioInit.init());

		return ok;
	}

	default command error_t TimerInit.init() { return SUCCESS; }
	default command error_t AdcInit.init() { return SUCCESS; }
}
