/*
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.  All rights reserved.
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
 * - Neither the name of Crossbow Technology nor the names of
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
 * @author Martin Turon <mturon@xbow.com>
 * @author Miklos Maroti
 *
 * Modified on 2012/06/01
 * Author: Ugo Colesanti <colesanti@dis.uniroma1.it>
 * Comment: Added Zigduino components for port init
 */

#include "hardware.h"

module PlatformP @safe()
{
  provides interface Init;

  uses
  {
    interface Init as McuInit;
    interface Init as LedsInit;
    interface Init as ZigduinoDigitalInit ;
    interface Init as ZigduinoAnalogInit ;
    interface Init as ZigduinoUnusedInit ;
  }
}

implementation
{
  command error_t Init.init()
  {
    error_t ok;

    //disable jtag
    MCUCR |= 1<<JTD;
    MCUCR |= 1<<JTD; 

    ok = call McuInit.init();
    ok = ecombine(ok, call ZigduinoDigitalInit.init()) ;
    ok = ecombine(ok, call ZigduinoAnalogInit.init()) ;
    ok = ecombine(ok, call ZigduinoUnusedInit.init()) ;
/*
    atomic{
    PRR0 = 0xff ; // activate power reduction
    PRR1 = 0x3f ; // activate power reduction

    DIDR1 = 0x3 ; // disable digital input
    DIDR0 = 0xff ; // disable digital input

    ACSR |= 0x80 ; // disable analog comparator
    }
*/
    ok = ecombine(ok, call LedsInit.init());

    return ok;
  }

  default command error_t LedsInit.init() { return SUCCESS; }
}
