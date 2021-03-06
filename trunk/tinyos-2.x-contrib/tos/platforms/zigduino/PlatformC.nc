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
 * Comment: Added Zigduino components for port init
 */

configuration PlatformC
{
  provides
  {
    interface Init;
    interface Atm128Calibrate; // TODO: should be moved to McuInitC
  }

  uses interface Init as LedsInit;
}
implementation
{
  //initialization
  components PlatformP, McuInitC, MeasureClockC;
  components KeepMcuIdleP, McuSleepC ;
  components ZigduinoDigitalPortsC ,ZigduinoAnalogPortsC, ZigduinoUnusedPinsP ;
  Init = PlatformP;
  LedsInit = PlatformP.LedsInit;
  PlatformP.McuInit -> McuInitC;
  PlatformP.ZigduinoDigitalInit -> ZigduinoDigitalPortsC ;
  PlatformP.ZigduinoAnalogInit -> ZigduinoAnalogPortsC ;
  PlatformP.ZigduinoUnusedInit -> ZigduinoUnusedPinsP ;
  Atm128Calibrate = MeasureClockC;

  KeepMcuIdleP.McuPowerOverride <- McuSleepC ; // use IDLE as the lowest state for zigduino, otherwise the timer stops running
}
