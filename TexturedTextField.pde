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
│ Textured Textfield GUI element class representation           │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedTextField extends TextField {

    protected Shadow shadow;
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedTextField  ░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedTextField( PVector coordinates, int width, String placeHolderText ) {
        super( coordinates, width, placeHolderText );
        this.shadow = new Shadow( color( 0, 100, 200, 50 ), this.coordinates, this.width, this.height, 2, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedTextField :: draw  ░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            // If focused
            if ( this.focused ) {
                // Shadow shadow = new Shadow( color( 0, 100, 200, 50 ), new PVector( this.x, this.y ), this.width, this.height, 2, this.roundness );
                this.shadow.draw();
                noFill();
                stroke( 0, 100, 200, 150 );
                rect( this.coordinates.x - 1, this.coordinates.y - 1, 
                      this.width + 2, this.height + 2, 
                      this.roundness, this.roundness, this.roundness, this.roundness );
            }
            fill( 245, 245, 245 );
            stroke( 184, 184, 184 );
            rect( this.coordinates.x, this.coordinates.y, 
                  this.width, this.height, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            textSize( this.textSize );
            if ( this.inputText.length() != 0 ) {
                fill( 100, 100, 100 );
                text( this.inputText, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
            } else {
                fill( 150, 150, 150 );
                text( this.placeHolderText, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
            }

        }
    }
}