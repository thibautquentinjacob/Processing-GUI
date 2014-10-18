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
│ Checkboxes GUI element class representation                   │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│   * Fix hovered                                             │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class CheckBox extends Control {

    protected boolean[] checked;
    protected int checkRadius = 7;
    protected int heightOffset = 5;
    protected String[] texts;
    protected int selected = -1;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CheckBox ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public CheckBox( PVector coordinates, int size, String[] texts ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.disabled = false;
        this.type = "CheckBox";
        for ( int i = 0 ; i < texts.length ; i++ ) {
            checked[i] = false;
        }
        this.checkRadius = size / 2;
        this.roundness = 2;
    }

    public CheckBox( PVector coordinates, int size, String[] texts, boolean[] checked ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.checked = checked;
        this.disabled = false;
        this.type = "CheckBox";
        this.checkRadius = size / 2;
        this.roundness = 2;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CheckBox :: draw  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            for ( int i = 0 ; i < texts.length ; i++ ) {
                String text = this.texts[i];

                fill( 0 );
                stroke( 0 );
                rect( this.coordinates.x, this.coordinates.y + 
                      ( this.heightOffset + this.height ) * i, 
                      this.width + 1, this.height + 1, this.roundness + 2, 
                      this.roundness + 2, this.roundness + 2, this.roundness + 2 );
                if ( this.checked[i] ) {
                    fill( 100, 100, 100 );
                    stroke( 130 );
                    // rect( this.coordinates.x + this.checkRadius / 2 , 
                    //       this.coordinates.y + this.checkRadius / 2 + 
                    //       ( this.heightOffset + this.height ) * i, 
                    //       this.width - this.checkRadius + 2, 
                    //       this.height - this.checkRadius + 2, this.roundness, 
                    //       this.roundness, this.roundness, this.roundness );
                    VerticalGradient tick = new VerticalGradient( color( 200 ), color( 100 ), this.height - this.checkRadius + 3, 
                                                              this.width - this.checkRadius + 3, 
                                                              new PVector( this.coordinates.x + this.checkRadius / 2 , 
                                                                           this.coordinates.y + this.checkRadius / 2 +  ( this.heightOffset + this.height ) * i ), 
                                                              this.roundness );
                    tick.draw();
                }
                // if ( this.hovered ) {
                //     fill( 255, 255, 255 );
                //     noStroke();
                //     rect( this.coordinates.x, this.coordinates.y + 
                //           ( this.heightOffset + this.height ) * i, 
                //           this.width, this.height, this.roundness, 
                //           this.roundness, this.roundness, this.roundness );
                // }

                // Text drawing
                if ( this.checked[i] ) {
                    fill( 255 );
                } else {
                    fill( 100, 100, 100 );
                }
                textSize( this.textSize );
                text( text, this.coordinates.x + this.width + 10, 
                      this.coordinates.y + height / 2 + 
                      ( this.heightOffset + this.height ) * i + 5 );
            }
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: isInside ░░░░░░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside the slider. │
    └────────────────────────────────────────────┘ */
    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            if ( distX >= 0 && distX <= this.getWidth() && 
                 distY >= 0 && distY <= this.height + 
                 ( this.heightOffset + this.height ) * i ) {
                this.selected = i;
                return true;
            }
        }
        return false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CheckBox :: getHeight  ░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public int getHeight() {
        return this.texts.length * ( this.height + this.heightOffset );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Checkbox :: getWidth  ░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public int getWidth() {
        float maxTextWidth = 0;
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            if ( textWidth( this.texts[i] ) > maxTextWidth ) {
                maxTextWidth = textWidth( this.texts[i] );
            }
        }
        return this.width + (int)maxTextWidth + 10;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void mouseClicked() {
        if ( isInside( mouseX, mouseY )) {
            if ( selected != -1 ) {
                this.checked[selected] = !this.checked[selected];
            }
        }
    }

    @Override
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            if ( selected != -1 ) {
                this.hovered = true;
            } else {
                this.hovered = false;
            }
        }
    }
}