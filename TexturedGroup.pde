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

   FIXME
   ==============

*/

class TexturedGroup extends Group {
    
    public TexturedGroup( String name, PVector coordinates ) {
        super( name, coordinates );
    }
    
    public TexturedGroup( String name, PVector coordinates, ArrayList<Control> controls ) {
        super( name, coordinates, controls );
    }

    @Override
    public void draw() {
        fill( #474747 );
        // stroke( 220, 220, 220 );
        text( this.name, this.coordinates.x, this.coordinates.y );
        // fill( 150, 150, 150 );
        // noStroke();
        // rect( this.coordinates.x, this.coordinates.y + 5, this.width, this.height, 5, 5, 5, 5 );
        fill( 255, 255, 255, 110 );
        stroke( 0, 0, 0, 50 );
        rect( this.coordinates.x, this.coordinates.y + 5, this.width, this.height, 5, 5, 5, 5 );
        for ( Control control: this.controls ) {
            control.draw();
        }
        // For debugging purposes
        // this.drawOverlay();
    }

}