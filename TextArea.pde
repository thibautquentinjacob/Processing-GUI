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
│ TextArea GUI element class representation                     │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   * Implement selection                                     │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TextArea extends TextField {

    protected ArrayList<String> lines;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TextArea  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TextArea( PVector coordinates, int width, int height, String placeHolderText ) {
        super( coordinates, width, placeHolderText );
        this.height = height;
        this.lines = new ArrayList<String>();
        this.lines.add( "plopdededwfewfewf" );
        this.lines.add( "dewfefewfewfw" );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TextArea :: draw  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            fill( 255 );
            stroke( 0 );
            rect( this.coordinates.x, this.coordinates.y, this.width, this.height,
                  this.roundness, this.roundness, this.roundness, this.roundness );
            if ( this.selected ) {
                fill( 0, 100, 200 );
                noStroke();
                rect( this.coordinates.x + 5 + this.selection.x * textWidth( "a" ), this.coordinates.y + 3, this.selection.y * textWidth( "a" ), 20 );
            }
            textSize( this.textSize );
            if ( this.inputText.length() != 0 ) {
                if ( this.selected ) {
                    fill( 255 );
                } else {
                    fill( 0 );
                }
                for ( int i = 0 ; i < this.lines.size() ; i++ ) {
                    String line = this.lines.get( i );
                    text( line, this.coordinates.x + 5, this.coordinates.y + 10 * i + 5 );
                }
                
            // Placeholder text
            } else {
                fill( 150, 150, 150 );
                text( this.placeHolderText, this.coordinates.x + 5, this.coordinates.y + height / 2 + 5 );
            }
            // If focused
            if ( this.focused ) {
                noFill();
                stroke( 0, 100, 255 );
                rect( this.coordinates.x, this.coordinates.y, this.width, this.height,
                      this.roundness, this.roundness, this.roundness, this.roundness );
                // Draw blinking cursor
                if ( frameCount % 30 > 0 && frameCount % 30 < 15 ) {
                    stroke( 0, 0, 255 );
                    cursorPosition = cursorPosition < 0 ? 0 : cursorPosition; // cursorPosition should be >= 0
                    cursorPosition = cursorPosition > this.inputText.length() ? this.inputText.length() : cursorPosition; // cursorPosition should be >= 0
                    int cursorXPosition = (int)textWidth( this.inputText.substring( 0, cursorPosition ));
                    // line( cursorXPosition + this.coordinates.x + 10, this.coordinates.y + 5, 
                    //       cursorXPosition + this.coordinates.x + 10, this.coordinates.y + 5 + this.height / 2 );
                    line( cursorXPosition + this.coordinates.x + 5, this.coordinates.y + 5 + this.height / 2, 
                          cursorXPosition + this.coordinates.x + 5 + textWidth( "a" ), this.coordinates.y + 5 + this.height / 2 );
                    println( "Cursor position " + cursorPosition );

                }
            }
        }
    }

    @Override
    public void keyPressed() {
        if ( this.focused ) {
            if ( keyCode == BACKSPACE ) {
                // Do not erase anything if cursor is at position 0
                if ( this.cursorPosition == 0 ) {
                    return;
                }
                // If selected, erase selection
                if ( this.selected ) {
                    this.selected = false;
                    StringBuilder strBuilder = new StringBuilder( this.inputText );
                    this.inputText = strBuilder.delete((int)this.selection.x, (int)this.selection.y ).toString();
                    this.selection = new PVector( 0, 0 );
                    return;
                }
                // If input text length > 0, we can remove character
                if ( this.inputText.length() > this.viewableCharacterLimit && this.inputText.length() - 1 - this.viewableCharacterLimit > 0 ) {
                    this.inputText = this.inputText.substring( 0, this.inputText.length() - 1 );
                    this.textShown = this.inputText.substring( this.inputText.length() - this.viewableCharacterLimit, 
                                                               this.inputText.length());
                    // this.cursorPosition = new PVector( this.cursorPosition.x - textWidth( "a" ), this.cursorPosition.y );
                    //this.cursorPosition--;
                    // println( "Showing " + this.textShown + " from " + (this.inputText.length() - 1 - this.viewableCharacterLimit) + 
                    // " to " + (this.inputText.length() - 1 ));
                } else if ( this.inputText.length() > 0 ) {
                    if ( this.cursorPosition < this.inputText.length() && this.cursorPosition > 0 ) {
                        String firstPart = this.inputText.substring( 0, this.cursorPosition - 1 );
                        String secondPart = this.inputText.substring( this.cursorPosition, this.inputText.length());
                        this.inputText = firstPart + secondPart;
                    } else if ( this.cursorPosition == 0 ) {
                    // Nothing
                    } else {
                        this.inputText = this.inputText.substring( 0, this.inputText.length() - 1 );
                    }
                    
                    this.textShown = this.inputText;
                    // this.cursorPosition = new PVector( this.cursorPosition.x - textWidth( "a" ), this.cursorPosition.y );
                    this.cursorPosition--;
                }
            } else if ( keyCode == LEFT ) {
                if ( this.cursorPosition > 0 ) {
                    this.cursorPosition--;
                }
            } else if ( keyCode == RIGHT ) {
                if ( this.cursorPosition < this.inputText.length()) {
                    this.cursorPosition++;
                }
            // Enter key : ignored
            } else if ( keyCode == SHIFT ) {
            // Any other key
            } else {
                 // If selected, replace selection by character
                if ( this.selected ) {
                    this.selected = false;
                    StringBuilder strBuilder = new StringBuilder( this.inputText );
                    this.inputText = strBuilder.insert((int)this.selection.y, key ).delete((int)this.selection.x, (int)this.selection.y ).toString();
                    this.selection = new PVector( 0, 0 );
                    return;
                }
                // Cursor is at the first position
                if ( cursorPosition == 0 ) {
                    this.inputText = key + this.inputText;
                // cursor is at the last position
                } else if ( cursorPosition == this.inputText.length()) {
                    this.inputText += key;
                // Cursor is in between two characters
                } else {
                    String firstPart = this.inputText.substring( 0, this.cursorPosition );
                    String secondPart = this.inputText.substring( this.cursorPosition, this.inputText.length());
                    this.inputText = firstPart + key + secondPart;
                }
                
                // if ( this.inputText.length() - 1 > this.viewableCharacterLimit ) {
                //     this.textShown = this.inputText.substring( this.inputText.length() - 1 - this.viewableCharacterLimit, 
                //                                                this.inputText.length());
                //     this.cursorPosition++;
                //     // this.cursorPosition = new PVector( this.cursorPosition.x + textWidth( key ), this.cursorPosition.y );
                // } else {
                    // split inputText into line segments
                for ( int i = 0 ; i < this.inputText.length() / this.viewableCharacterLimit ; i++ ) {
                    String line = this.inputText.substring( i, i + this.viewableCharacterLimit );
                    lines.set( i, line );
                }
                this.textShown = this.inputText;
                this.cursorPosition++;
                // }
            }
        }
    }
}
