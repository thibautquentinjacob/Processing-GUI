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
│ Textured Slider GUI element class representation              │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class TexturedSlider extends Slider {
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedSlider  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public TexturedSlider( PVector coordinates, int min, int max, int size ) {
        super( coordinates, min, max, size );
        this.height = 8;
        this.roundness = 5;
    }

    public TexturedSlider( PVector coordinates, int min, int max, int size, ArrayList<Integer> dragPositions ) {
        super( coordinates, min, max, size, dragPositions );
        this.height = 8;
        this.roundness = 5;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ TexturedSlider :: draw  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            int[] strokeColorChannels = { 
                this.strokeColor.getRed(), 
                this.strokeColor.getGreen(), 
                this.strokeColor.getBlue() };
            int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
            noFill();
            stroke( 247, 247, 247 );
            rect( this.coordinates.x, this.coordinates.y + this.height + 2 + 1, 
                  this.width, this.height - 1, this.roundness, this.roundness, this.roundness, this.roundness );
            fill( 222, 222, 222 );
            stroke( 112, 112, 112 );
            rect( this.coordinates.x, this.coordinates.y + this.height + 2, 
                  this.width, this.height - 1, this.roundness, this.roundness, this.roundness, this.roundness );
            for ( int position : this.dragPositions ) {
                stroke( 151, 151, 151 );
                fill( 240, 240, 240 );
                ellipse( this.coordinates.x + position * width / range , 
                         this.coordinates.y + this.height * 2 / 2 + 5, 
                         this.height * 2 - 1 , this.height * 2 - 1 );
                fill( 0, 0, 0 );
                ellipse( this.coordinates.x + position * width / range, 
                         this.coordinates.y + this.height * 2 / 2 + 5, 
                         5, 5 );
            }
        }
    }

}