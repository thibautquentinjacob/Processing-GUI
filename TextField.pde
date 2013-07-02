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
   
   TODO
   ==============
   - Focus empty placeholder
   - Hide overflow

   FIXME
   ==============

*/

class TextField extends Control {

    protected String inputText;
    protected String textShown;
    protected String placeHolderText;
    protected String placeHolderTextCopy;
    protected boolean focused;

    public TextField( PVector coordinates, int width, String placeHolderText ) {
        this.coordinates = coordinates;
        this.width = width;
        this.height = (( int( textWidth( placeHolderText )) + 10 ) / this.width + 1 ) * 24;
        this.placeHolderText = placeHolderText;
        this.placeHolderTextCopy = this.placeHolderText;
        this.textShown = "";
        this.disabled = false;
        this.type = "TextField";
        this.inputText = "";
        this.focused = false;
    }

    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            fill( 255, 255, 255 );
            stroke( 100, 100, 100 );
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            textSize( this.textSize );
            if ( this.inputText.length() != 0 ) {
                fill( 100, 100, 100 );
                text( this.inputText, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
            } else {
                fill( 150, 150, 150 );
                text( this.placeHolderText, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
            }
            // If focused
            if ( this.focused ) {
                noFill();
                stroke( 255, 0, 0 );
                rect( this.coordinates.x - 1, this.coordinates.y - 1, this.width + 2, this.height + 2, 
                      this.roundness, this.roundness, this.roundness, this.roundness );
            }
        }
    }

    public void setInputText( String text ) {
        this.inputText = text;
        this.height = ( int( textWidth( placeHolderText )) + 10 ) / this.width * 24;
    }

    // @Override
    // protected boolean isInside( int mouseX, int mouseY ) {
    //     int distX = mouseX - this.x;
    //     int distY = mouseY - this.y;
    //     if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height ) {
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }

    // Events
    @Override
    public void mouseClicked() {
        if ( isInside( mouseX, mouseY )) {
            this.focused = true;
            this.placeHolderText = "";
        } else {
            this.focused = false;
            if ( this.inputText.length() == 0 ) {
                this.placeHolderText = this.placeHolderTextCopy;
            }
        }
    }

    @Override
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            this.hovered = true;
        } else {
            this.hovered = false;
        }
    }

    @Override
    public void keyPressed() {
        if ( this.focused ) {
            if ( keyCode == BACKSPACE ) {
                // If input text length > 0, we can remove character
                if ( this.inputText.length() > 0 ) {
                    this.inputText = this.inputText.substring( 0, this.inputText.length() - 1 );
                }
            // } else if ( keyCode == ENTER ) {
            //     this.inputText += key;
            //     this.height += 24;
            } else {
                this.inputText += key;
            }
        }
    }

}