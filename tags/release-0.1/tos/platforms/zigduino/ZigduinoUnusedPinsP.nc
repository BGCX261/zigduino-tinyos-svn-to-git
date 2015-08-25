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

module ZigduinoUnusedPinsP{
  provides {
    interface Init;
  }
}
implementation {
	command error_t Init.init() {
	    atomic {
	      dbg("Init", "ZigduinoUnusedPins: initialized.\n");
	      DDRB |= 0x27 ; PORTB &= ~0x27 ;
	      DDRD |= 0xff ; PORTD &= ~0xff ;
	      DDRF |= 0xd0 ; PORTF &= ~0xd0 ;
	      DDRG |= 0x3f ; PORTG &= ~0x3f ;
	    }
	    return SUCCESS;
	  }
}
// PB ports
    // PB0 --> x
    // PB1 --> Led L & DIGITAL 13 && SPI1
    // PB2 --> SPI3 (optional DIGITAL 11)
    // PB3 --> DIGITAL 12 && SPI2
    // PB4 --> DIGITAL 8
    // PB5 --> x (optional DIGITAL 11)
    // PB6 --> DIGITAL 10
    // PB7 --> DIGITAL 9

    // PD ports (I2C, unconnected, Leds RFRX/RFTX)
	// PD0 --> I2C SCL
	// PD1 --> I2C SDA
	// PD2 --> x
	// PD3 --> x
	// PD4 --> x
	// PD5 --> Led RFTX ==> don't touch
	// PD6 --> Led RFRX == don't touch
	// PD7 --> GND ==> leave it as is!

    // PE ports
    // PE0 --> UARTRX && DIGITAL 0
    // PE1 --> UARTTX && DIGITAL 1
    // PE2 --> DIGITAL 4
    // PE3 --> DIGITAL 5
    // PE4 --> DIGITAL 6
    // PE5 --> DIGITAL 3
    // PE6 --> DIGITAL 2
    // PE7 --> DIGITAL 7

    // PF ports
    // PF0 --> ANALOG 0
    // PF1 --> ANALOG 1
    // PF2 --> ANALOG 2
    // PF3 --> ANALOG 3
    // PF4 --> x (optional ANALOG 4)
    // PF5 --> x (optional ANALOG 5)
    // PF6 --> x
    // PF7 --> x

    // PG ports (unconnected)
    // PG0 --> x
    // PG1 --> x
    // PG2 --> x
    // PG3 --> x
    // PG4 --> x
    // PG5 --> x
