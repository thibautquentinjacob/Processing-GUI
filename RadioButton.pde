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
│ Radio button GUI element class representation                 │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class RadioButton extends Control {

    protected int selected;
    protected String selectedValue;
    protected int checkRadius = 6;
    protected int shadowOffset = 3;
    protected int heightOffset = 5;
    protected String[] texts;
    private int pointed = -1;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ RadioButton  ░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public RadioButton( PVector coordinates, int size, String[] texts ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.selected = 0;
        this.selectedValue = this.texts[this.selected];
        this.shadowed = false;
        this.disabled = false;
        this.type = "Radio Buttons";
    }

    public RadioButton( PVector coordinates, int size, String[] texts, boolean shadowed, int selected ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.selected = selected;
        this.selectedValue = this.texts[this.selected];
        this.shadowed = shadowed;
        this.disabled = false;
        this.type = "Radio Buttons";
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ RadioButton :: draw  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            for ( int i = 0 ; i < this.texts.length ; i++ ) {
                String text = this.texts[i];
                if ( this.shadowed ) {
                    fill( 200, 200, 200, 200 );
                    noStroke();
                    ellipse( this.coordinates.x + this.shadowOffset + this.width / 2, 
                             this.coordinates.y + height / 2 + this.shadowOffset + 
                             ( this.heightOffset + this.height ) * i, 
                             this.width, this.height );
                }
                int[] strokeColorChannels = { 
                    this.strokeColor.getRed(), 
                    this.strokeColor.getGreen(), 
                    this.strokeColor.getBlue() };
                int[] fillColorChannels = { 
                    this.fillColor.getRed(), 
                    this.fillColor.getGreen(), 
                    this.fillColor.getBlue() };
                stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
                fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
                ellipse( this.coordinates.x + this.width / 2, 
                         this.coordinates.y + height / 2 + 
                         ( this.heightOffset + this.height ) * i, 
                         this.width, this.height );
                if ( this.selected == i ) {
                    fill( 100, 100, 100, 200 );
                    noStroke();
                    ellipse( this.coordinates.x + 0.5 + this.width / 2, 
                             this.coordinates.y + height / 2 + 0.5 + ( this.heightOffset + this.height ) * i, 
                             this.width - this.checkRadius, this.height - this.checkRadius );
                }
                if ( this.hovered ) {
                    fill( 255, 255, 255, 50 );
                    noStroke();
                    ellipse( this.coordinates.x + this.width / 2, 
                             this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i, 
                             this.width, this.height );
                }
                if ( this.selected == i ) {
                    fill( 0, 0, 0 );
                } else {
                    fill( 100, 100, 100 );
                }

                textSize( this.textSize );
                text( text, this.coordinates.x + this.width + 10, 
                      this.coordinates.y + height / 2 + 5 + ( this.heightOffset + this.height ) * i );
            }
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ RadioButton :: isInside ░░░░░░░░░░░░░░░░ ║
    ╟────────────────────────────────────────────╢
    │ Checks if the cursor is inside the button. │
    └────────────────────────────────────────────┘ */
    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            if ( distX >= 0 && distX <= this.getWidth() && 
                 distY >= 0 && distY <= this.height + 
                 ( this.heightOffset + this.height ) * i ) {
                this.pointed = i;
                return true;
            }
        }
        return false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ RadioButton :: getHeight  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public int getHeight() {
        return this.texts.length * ( this.height + this.heightOffset );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ RadioButton :: getWidth  ░░░░░░░░░░░░░░░ ║
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
            int optionPicked = this.pointed;
            if ( optionPicked != -1 ) {
                this.selected = optionPicked;
                this.selectedValue = this.texts[this.selected];
            }
        }
    }

    @Override
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            // int optionHovered = this.selected;
            // if ( optionHovered != -1 ) {
            //     this.hovered = true;
            // } else {
            //     this.hovered = false;
            // }
        }
    }
}