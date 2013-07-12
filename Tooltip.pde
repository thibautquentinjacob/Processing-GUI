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
│ Tooltip class representation                                  │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Tooltip {

    protected String text;
    protected PVector coordinates;
    protected int width, height;
    protected int roundness = 5;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tooltip  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Tooltip( PVector coordinates, String text ) {
        this.coordinates = coordinates;
        this.width = int( textWidth( text )) + 24;
        this.height = 24;
        this.text = text;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tooltip :: draw  ░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void draw() {
        colorMode( RGB, 255 );
        fill( 255, 255, 255 );
        stroke( 100, 100, 100 );
        rect( this.coordinates.x, this.coordinates.y, this.width, this.height, 
              this.roundness, this.roundness, this.roundness, this.roundness );
        fill( 100, 100, 100 );
        text( this.text, this.coordinates.x + 10, this.coordinates.y + height / 2 + 5 );
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Tooltip :: setInputText  ░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setInputText( String text ) {
        this.text = text;
        this.height = ( int( textWidth( this.text )) + 10 ) / this.width * 24;
    }

}