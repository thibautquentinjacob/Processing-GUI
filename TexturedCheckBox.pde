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
│ Textured Checkbox GUI element class representation            │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedCheckBox extends CheckBox {

    protected VerticalGradient vg;
    protected color from;
    protected color to;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedCheckBox  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedCheckBox( PVector coordinates, int size, String[] texts ) {
        super( coordinates, size, texts );
        this.roundness = 2;
        this.from = color( 210, 210, 210 );
        this.to = color( 223, 223, 223 );
        this.vg = new VerticalGradient( from, to, this.height, this.width, 
                                        this.coordinates, this.roundness );
    }

    public TexturedCheckBox( PVector coordinates, int size, String[] texts, 
                             boolean shadowed, boolean[] checked ) {
        super( coordinates, size, texts, shadowed, checked );
        this.roundness = 2;
        this.from = color( 210, 210, 210 );
        this.to = color( 223, 223, 223 );
        this.vg = new VerticalGradient( from, to, this.height, this.width, 
                                        this.coordinates, this.roundness );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedCheckBox :: draw  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            for ( int i = 0 ; i < texts.length ; i++ ) {
                String text = this.texts[i];
                /* Shadow shadow = new Shadow( color( 0, 0, 0, 20 ), 
                                            new PVector( this.x, this.y + ( this.heightOffset + this.height ) * i ), 
                                            this.width, this.height, 2, this.roundness ); */
                // shadow.draw();
                noFill();
                // Double frame
                stroke( 247, 247, 247 );
                rect( this.coordinates.x - 1, this.coordinates.y + ( this.heightOffset + this.height ) * i, 
                      this.width + 1, this.height + 1, this.roundness, this.roundness, 
                      this.roundness, this.roundness );
                stroke( 172, 172, 172 );
                rect( this.coordinates.x - 1, this.coordinates.y + ( this.heightOffset + this.height ) * i - 1, 
                      this.width + 1, this.height + 1, this.roundness, this.roundness, 
                      this.roundness, this.roundness );
                // Vertical gradient
                this.vg = new VerticalGradient( from, to, this.height, this.width, 
                                                new PVector( this.coordinates.x, this.coordinates.y + 
                                                ( this.heightOffset + this.height ) * i ), this.roundness );
                this.vg.draw();
                // Draw checked mark
                if ( this.checked[i] ) {
                    fill( 255, 255, 255, 200 );
                    noStroke();
                    rect( this.coordinates.x + this.checkRadius / 2 , 
                          this.coordinates.y + this.checkRadius / 2 + ( this.heightOffset + this.height ) * i, 
                          this.width - this.checkRadius + 1, this.height - this.checkRadius + 1, 
                          this.roundness, this.roundness, this.roundness, this.roundness );
                }
                // Draw highlight
                if ( this.hovered && this.selected == i ) {
                    fill( 255, 255, 255, 50 );
                    noStroke();
                    rect( this.coordinates.x, this.coordinates.y + ( this.heightOffset + this.height ) * i, this.width, 
                          this.height, this.roundness, this.roundness, this.roundness, this.roundness );
                }
                // Text with carving
                fill( 255, 255, 255 );
                text( text, this.coordinates.x + this.width + 10, this.coordinates.y + 
                      height / 2 + ( this.heightOffset + this.height ) * i + 6 );
                if ( this.checked[i] ) {
                    fill( 0, 0, 0 );
                } else {
                    fill( 100, 100, 100 );
                }
                textSize( this.textSize );
                text( text, this.coordinates.x + this.width + 10, this.coordinates.y + 
                      height / 2 + ( this.heightOffset + this.height ) * i + 5 );
            }
        }
    }
}