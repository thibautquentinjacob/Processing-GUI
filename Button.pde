/*  This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA  02110-1301, USA.
   
   ---
   Copyright (C) 2013, Thibaut Jacob <jacob@lri.fr> 
   
┌───────────────────────────────────────────────────────────────┐
│░░░░░░░░░░ Description ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
├───────────────────────────────────────────────────────────────┤
│ Button GUI element class representation                       │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Button extends Control {

    protected boolean pressed;
    protected int shadowOffset = 3;
    protected int pressedOffset = 2;
    protected String text;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Button  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Button( PVector coordinates, int height, String text, String tooltipText ) {
        this.coordinates = coordinates;
        this.width = int( textWidth( text )) + 10;
        this.height = height;
        this.text = text;
        this.shadowed = false;
        this.disabled = false;
        this.type = "Button";
        this.tooltip = new Tooltip( new PVector( this.coordinates.x + 5, this.coordinates.y + this.height ), tooltipText );
    }

    public Button( PVector coordinates, int height, String text, String tooltipText, boolean shadowed ) {
        this.coordinates = coordinates;
        this.width = int( textWidth( text )) + 10;
        this.height = height;
        this.text = text;
        this.shadowed = shadowed;
        this.disabled = false;
        this.type = "Button";
        this.tooltip = new Tooltip( new PVector( this.coordinates.x + 5, this.coordinates.y + this.height ), tooltipText );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Button :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            if ( this.shadowed ) {
                fill( 200, 200, 200, 200 );
                noStroke();
                if ( this.pressed ) {
                    rect( this.coordinates.x + this.shadowOffset - this.pressedOffset, 
                          this.coordinates.y + this.shadowOffset - this.pressedOffset, 
                          this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
                } else {
                    rect( this.coordinates.x + this.shadowOffset, this.coordinates.y + this.shadowOffset, 
                          this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
                }
            }
            int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
            int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
            stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
            fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            if ( this.hovered ) {
                fill( 255, 255, 255, 50 );
                noStroke();
                rect( this.coordinates.x, this.coordinates.y, this.width, this.height, 
                      this.roundness, this.roundness, this.roundness, this.roundness );
                this.tooltip.draw();
            }
            fill( 0, 0, 0 );
            textSize( this.textSize );
            text( this.text, this.coordinates.x + 5, this.coordinates.y + height / 2 + 5 );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Button :: isInside ░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside the button. │
    └────────────────────────────────────────────┘ */
    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height ) {
            return true;
        } else {
            return false;
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            this.hovered = true;
        } else {
            this.hovered = false;
        }
    }
    
    @Override
    public void mousePressed() {
        if ( isInside( mouseX, mouseY ) ) {
            this.pressed = true;
            this.coordinates.x += this.pressedOffset;
            this.coordinates.y += this.pressedOffset;
        }
    }
    
    @Override
    public void mouseReleased() {
        if ( this.pressed ) {
            this.pressed = false;
            this.coordinates.x -= this.pressedOffset;
            this.coordinates.y -= this.pressedOffset;
        }
    }
}