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
   Example of a slider class with redefined drawing routine
   
   TODO
   ==============

   FIXME
   ==============

*/

class TexturedSlider extends Slider {
    
    public TexturedSlider( int x, int y, int min, int max, int size ) {
        super( x, y, min, max, size );
    }

    public TexturedSlider( int x, int y, int min, int max, int size, ArrayList<Integer> dragPositions ) {
        super( x, y, min, max, size, dragPositions );
    }

    @Override
    public void draw() {
        colorMode( RGB, 255 );
        int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
        int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
        fill( 100, 100, 100 );
        stroke( 0, 0, 0 );
        rect( this.x, this.y + this.height + 2, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
        for ( int position : this.dragPositions ) {
            stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
            fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
            ellipse( this.x + position * width / range , this.y + this.height * 3 / 2 + 2, this.height * 3 + 2 , this.height * 3 + 2 );
            fill( 100, 100, 100 );
            ellipse( this.x + position * width / range, this.y + this.height * 3 / 2 + 2, this.height, this.height );
        }
    }

}