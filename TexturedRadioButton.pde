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
│ Textured Radio button GUI element class representation        │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedRadioButton extends RadioButton {

    protected VerticalGradient vg;
    protected color from;
    protected color to;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedRadioButton  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedRadioButton( PVector coordinates, int size, String[] texts ) {
        super( coordinates, size, texts );
        this.from = color( 112, 112, 112 );
        this.to = color( 76, 76, 76 );
        this.vg = new VerticalGradient( from, to, this.height, this.width, 
                                        this.coordinates, this.roundness );
        this.checkRadius = 0;
    }

    public TexturedRadioButton( PVector coordinates, int size, String[] texts, int selected ) {
        super( coordinates, size, texts, selected );
        this.from = color( 112, 112, 112 );
        this.to = color( 76, 76, 76 );
        this.vg = new VerticalGradient( from, to, this.height, this.width, 
                                        this.coordinates, this.roundness );
        this.checkRadius = 0;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedRadioButton :: draw  ░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            for ( int i = 0 ; i < this.texts.length ; i++ ) {
                String text = this.texts[i];
                noFill();
                // Double frame
                stroke( 247, 247, 247 );
                ellipse( this.coordinates.x + this.width / 2, 
                         this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i, 
                         this.width, this.height );
                stroke( 172, 172, 172 );
                fill( 211, 211, 211 );
                ellipse( this.coordinates.x + this.width / 2, 
                         this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i - 1, 
                         this.width, this.height );
                noFill();
                noStroke();
                
                if ( this.selected == i ) {
                    // Vertical gradient
                    this.vg = new VerticalGradient( from, to, this.width - this.checkRadius - 3, this.height - this.checkRadius - 3, 
                                                    new PVector( this.coordinates.x + this.width / 2 - 3.5, 
                                                    this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i - 4.5 ), this.roundness );
                    this.vg.draw();
                    stroke( 66, 66, 66 );
                    ellipse( this.coordinates.x + this.width / 2, 
                             this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i - 1, 
                             this.width - this.checkRadius - 4, this.height - this.checkRadius - 4 );
                }
                if ( this.hovered ) {
                    fill( 255, 255, 255, 50 );
                    noStroke();
                    ellipse( this.coordinates.x + this.width / 2, 
                             this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i, 
                             this.width, this.height );
                }
                if ( this.selected == i ) {
                    fill( 100, 100, 100 );
                } else {
                    fill( 100, 100, 100 );
                }

                // Text with carving
                fill( 255, 255, 255 );
                text( text, this.coordinates.x + this.width + 10, 
                      this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i + 4 );
                if ( this.selected == i ) {
                    fill( 0, 0, 0 );
                } else {
                    fill( 100, 100, 100 );
                }
                textSize( this.textSize );
                text( text, this.coordinates.x + this.width + 10, 
                      this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i + 3 );
            }
        }
    }

}