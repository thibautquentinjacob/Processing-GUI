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
   Copyright (C) 2013, Thibaut Jacob <jacob@lri.fr> */

/* Description
   ===========
   Radio buttons GUI element class
   
   TODO
   ==============

   FIXME
   ==============

*/

class RadioButtons extends Control {

    private int selected;
    private String selectedValue;
    private int checkRadius = 6;
    private int shadowOffset = 3;
    private int heightOffset = 5;
    private String[] texts;

    public RadioButtons( int x, int y, int size, String[] texts ) {
        this.x = x;
        this.y = y;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.selected = 0;
        this.selectedValue = this.texts[this.selected];
        this.shadowed = false;
        this.disabled = false;
        this.type = "Radio Buttons";
    }

    public RadioButtons( int x, int y, int size, String[] texts, boolean shadowed, int selected ) {
        this.x = x;
        this.y = y;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.selected = selected;
        this.selectedValue = this.texts[this.selected];
        this.shadowed = shadowed;
        this.disabled = false;
        this.type = "Radio Buttons";
    }

    @Override
    public void draw() {
        colorMode( RGB, 255 );
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            String text = this.texts[i];
            if ( this.shadowed ) {
                fill( 200, 200, 200, 200 );
                noStroke();
                ellipse( this.x + this.shadowOffset + this.width / 2, this.y + height / 2 + this.shadowOffset + ( this.heightOffset + this.height ) * i, this.width, this.height );
            }
            int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
            int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
            stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
            fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
            ellipse( this.x + this.width / 2, this.y + height / 2 + ( this.heightOffset + this.height ) * i, this.width, this.height );
            if ( this.selected == i ) {
                fill( 100, 100, 100, 200 );
                noStroke();
                ellipse( this.x + 0.5 + this.width / 2, this.y + height / 2 + 0.5 + ( this.heightOffset + this.height ) * i, this.width - this.checkRadius, this.height - this.checkRadius );
            }
            if ( this.hovered ) {
                fill( 255, 255, 255, 50 );
                noStroke();
                ellipse( this.x + this.width / 2, this.y + height / 2 + ( this.heightOffset + this.height ) * i, this.width, this.height );
            }
            if ( this.selected == i ) {
                fill( 0, 0, 0 );
            } else {
                fill( 100, 100, 100 );
            }

            textSize( this.textSize );
            text( text, this.x + this.width + 10, this.y + height / 2 + 5 + ( this.heightOffset + this.height ) * i );
        }
    }

    public int isInside( int mouseX, int mouseY ) {
        int distX = mouseX - this.x;
        int distY = mouseY - this.y;
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height + ( this.heightOffset + this.height ) * i ) {
                return i;
            }
        }
        return -1;
    }

    @Override
    public int getHeight() {
        return this.texts.length * ( this.height + this.heightOffset );
    }

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

    // Events
    @Override
    public void mouseClicked() {
        int optionPicked = isInside( mouseX, mouseY );
        if ( optionPicked != -1 ) {
            this.selected = optionPicked;
            this.selectedValue = this.texts[this.selected];
        }
        // print(optionPicked);
    }

    @Override
    public void mouseMoved() {
        int optionHovered = isInside( mouseX, mouseY );
        if ( optionHovered != -1 ) {
            this.hovered = true;
        } else {
            this.hovered = false;
        }
    }
}