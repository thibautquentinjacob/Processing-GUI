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
    protected PGraphics cache;
    protected boolean cached = false;
    protected Shadow shadow;
    protected VerticalGradient gradient;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Button  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Button( PVector coordinates, String text, String tooltipText ) {
        this.coordinates = coordinates;
        this.height = 24;
        this.padding = 5;
        this.width = int( textWidth( text )) + 10 + 2 * this.padding;
        this.text = text;
        this.disabled = false;
        this.type = "Button";
        this.tooltip = new Tooltip( new PVector( this.coordinates.x + 5, this.coordinates.y + this.height ), tooltipText );
        this.roundness = 5;
        shadow = new Shadow( color( 0, 100, 200 ), new PVector( this.coordinates.x - 2, this.coordinates.y - 2 ), this.width - 5, this.height - 5, 5, this.roundness );
        gradient = new VerticalGradient( color( 50 ), color( 25 ), this.height, this.width, this.coordinates, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Button :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );

            if ( this.hovered ) {
                shadow.draw();
            }

            noFill();
            stroke( 0, 0, 0 );
            gradient.draw();
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height,
                  roundness, roundness, roundness, roundness );

            // Button text
            fill( 255 );
            textSize( this.textSize );
            float tw = textWidth( this.text );
            text( this.text, this.coordinates.x + ( this.width - tw ) / 2, this.coordinates.y + height / 2 + 5 );
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
            // this.coordinates.x += this.pressedOffset;
            // this.coordinates.y += this.pressedOffset;
        }
    }

    @Override
    public void mouseReleased() {
        if ( this.pressed ) {
            this.pressed = false;
            // this.coordinates.x -= this.pressedOffset;
            // this.coordinates.y -= this.pressedOffset;
        }
    }
}