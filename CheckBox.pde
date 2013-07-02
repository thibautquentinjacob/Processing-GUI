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
   Checkboxes GUI element class
   
   TODO
   ==============

   FIXME
   ==============

 */

class CheckBox extends Control {

    protected boolean[] checked;
    protected int checkRadius = 6;
    protected int heightOffset = 5;
    protected int shadowOffset = 3;
    protected String[] texts;
    protected int selected = -1;

    public CheckBox( PVector coordinates, int size, String[] texts ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.shadowed = false;
        this.disabled = false;
        this.type = "CheckBox";
        for ( int i = 0 ; i < texts.length ; i++ ) {
            checked[i] = false;
        }
        this.checkRadius = size / 2;
    }

    public CheckBox( PVector coordinates, int size, String[] texts, boolean shadowed, boolean[] checked ) {
        this.coordinates = coordinates;
        this.width = size;
        this.height = size;
        this.texts = texts;
        this.shadowed = shadowed;
        this.checked = checked;
        this.disabled = false;
        this.type = "CheckBox";
        this.checkRadius = size / 2;
    }

    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            for ( int i = 0 ; i < texts.length ; i++ ) {
                String text = this.texts[i];
                if ( this.shadowed ) {
                fill( 200, 200, 200, 200 );
                noStroke();
                rect( this.coordinates.x + this.shadowOffset, this.coordinates.y + this.shadowOffset + ( this.heightOffset + this.height ) * i, this.width, this.height, 
                            this.roundness, this.roundness, this.roundness, this.roundness );
                }
                int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
                int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
                stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
                fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
                rect( this.coordinates.x, this.coordinates.y + ( this.heightOffset + this.height ) * i, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
                if ( this.checked[i] ) {
                    fill( 100, 100, 100, 200 );
                    noStroke();
                    rect( this.coordinates.x + this.checkRadius / 2 , this.coordinates.y + this.checkRadius / 2 + ( this.heightOffset + this.height ) * i, this.width - this.checkRadius + 1, 
                                this.height - this.checkRadius + 1, this.roundness, this.roundness, this.roundness, this.roundness );
                }
                if ( this.hovered ) {
                    fill( 255, 255, 255, 50 );
                    noStroke();
                    rect( this.coordinates.x, this.coordinates.y + ( this.heightOffset + this.height ) * i, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
                }
                if ( this.checked[i] ) {
                    fill( 0, 0, 0 );
                } else {
                    fill( 100, 100, 100 );
                }
            
                textSize( this.textSize );
                text( text, this.coordinates.x + this.width + 10, this.coordinates.y + height / 2 + ( this.heightOffset + this.height ) * i + 5 );
            }
        }
    }

    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        for ( int i = 0 ; i < this.texts.length ; i++ ) {
            if ( distX >= 0 && distX <= this.getWidth() && distY >= 0 && distY <= this.height + ( this.heightOffset + this.height ) * i ) {
                this.selected = i;
                return true;
            }
        }
        return false;
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