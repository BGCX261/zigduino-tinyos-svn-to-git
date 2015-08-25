/*
 * Copyright (c) 2012 Sapienza University of Rome.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Sapienza University of Rome nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SAPIENZA
 * UNIVERSITY OF ROME OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Ugo Colesanti <colesanti@dis.uniroma1.it>
 *
 */

configuration ZigduinoAnalogPortsC {
  provides interface GeneralIO as Analog0 ;
  provides interface GeneralIO as Analog1 ;
  provides interface GeneralIO as Analog2 ;
  provides interface GeneralIO as Analog3 ;
  provides interface GeneralIO as Analog4 ;
  provides interface GeneralIO as Analog5 ;


  provides interface Init ;
}
implementation {
	components AtmegaGeneralIOC as IO;
	components ZigduinoAnalogPortsP ;

	Init = ZigduinoAnalogPortsP ;

	Analog0 = IO.PortF0 ;
	Analog1 = IO.PortF1 ;
	Analog2 = IO.PortF2 ;
	Analog3 = IO.PortF3 ;
	Analog4 = IO.PortF4 ;
	Analog5 = IO.PortF5 ;
}
