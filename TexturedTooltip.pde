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
│ Textured Tooltip class representation                         │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedTooltip extends Tooltip {

    protected color from = color( 91, 91, 91 );
    protected color to = color( 64, 64, 64 );
    protected VerticalGradient vg;
    protected Shadow shadow;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedTooltip  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedTooltip( PVector coordinates, String text ) {
        super( coordinates, text );
        this.vg = new VerticalGradient( from, to, this.height, this.width, this.coordinates, this.roundness );
        this.shadow = new Shadow( color( 0, 0, 0, 100 ), this.coordinates, this.width, this.height, 2, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedTooltip :: draw  ░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {
        colorMode( RGB, 255 );
        // Shadow shadow = new Shadow( color( 0, 0, 0, 100 ), new PVector( this.x, this.y), this.width, this.height, 2, this.roundness );
        this.shadow.draw();
        this.vg.draw();
        noFill();
        stroke( 38, 38, 38 );
        rect( this.coordinates.x - 1, this.coordinates.y - 1, this.width + 1, this.height + 1, 
              this.roundness, this.roundness, this.roundness, this.roundness );
        stroke( 103, 103, 103 );
        rect( this.coordinates.x, this.coordinates.y, this.width - 1, this.height - 1, 
              this.roundness, this.roundness, this.roundness, this.roundness );
        fill( 91, 91, 91 );
        triangle( this.coordinates.x + 10, this.coordinates.y, 
                  this.coordinates.x + 15, this.coordinates.y - 5, 
                  this.coordinates.x + 20, this.coordinates.y );
        fill( 255, 255, 255 );
        text( this.text, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
    }
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedTooltip :: setInputText  ░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setInputText( String text ) {
        this.text = text;
        this.height = ( int( textWidth( this.text )) + 10 ) / this.width * 24;
    }

}