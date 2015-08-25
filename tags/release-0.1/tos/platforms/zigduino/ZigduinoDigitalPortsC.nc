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

configuration ZigduinoDigitalPortsC {
  provides interface GeneralIO as Digital0 ; // warning: used with ft232rl
  provides interface GeneralIO as Digital1 ; // warning: used with ft232rl
  provides interface GeneralIO as Digital2 ;
  provides interface GeneralIO as Digital3 ;
  provides interface GeneralIO as Digital4 ;
  provides interface GeneralIO as Digital5 ;
  provides interface GeneralIO as Digital6 ;
  provides interface GeneralIO as Digital7 ;
  provides interface GeneralIO as Digital8 ;
  provides interface GeneralIO as Digital9 ;
  provides interface GeneralIO as Digital10 ;
//  provides interface GeneralIO as Digital11 ;
  provides interface GeneralIO as Digital12 ;
//  provides interface GeneralIO as Digital13 ;

  provides interface Init ;


}
implementation {
  components AtmegaGeneralIOC as IO;
  components ZigduinoDigitalPortsP ;

  Init = ZigduinoDigitalPortsP ;

  Digital0 = IO.PortE0 ;
  Digital1 = IO.PortE1 ;
  Digital2 = IO.PortE6 ;
  Digital3 = IO.PortE5 ;
  Digital4 = IO.PortE2 ;
  Digital5 = IO.PortE3 ;
  Digital6 = IO.PortE4 ;
  Digital7 = IO.PortE7 ;
  Digital8 = IO.PortB4 ;
  Digital9 = IO.PortB7 ;
  Digital10 = IO.PortB6 ;
  Digital12 = IO.PortB3 ;
}
