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
│ Shadow class representation                                   │
│   Features drop shadow                                        │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class Shadow {

    protected color col;
    protected PVector coordinates;
    protected int width, height;
    protected int roundness;
    protected int blurFactor;
    PGraphics pg;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Shadow  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Shadow( color col, PVector coordinates, int width, int height, int blurFactor ) {
        int timeStart = millis();
        this.col = col;
        this.coordinates = coordinates;
        this.width = width;
        this.height = height;
        this.blurFactor = blurFactor;
        this.roundness = 0;
        pg = createGraphics( this.width * this.blurFactor, this.height * this.blurFactor );
        pg.beginDraw();
        pg.fill( this.col );
        pg.noStroke();
        pg.rect( 2 * this.blurFactor, 2 * this.blurFactor, 
                 this.width + 2 * this.blurFactor, this.height + 2 * this.blurFactor, 
                 this.roundness, this.roundness, this.roundness, this.roundness );
        pg.filter( BLUR, this.blurFactor );
        pg.endDraw();
        int timeEnd = millis();
        // println( "Shadow Creation: " + ( timeEnd - timeStart ));
    };

    public Shadow( color col, PVector coordinates, int width, int height, int blurFactor, int roundness ) {
        int timeStart = millis();
        this.col = col;
        this.coordinates = coordinates;
        this.width = width;
        this.height = height;
        this.blurFactor = blurFactor;
        this.roundness = roundness;
        pg = createGraphics( this.width * this.blurFactor, 
                             this.height * this.blurFactor );
        pg.beginDraw();
        pg.fill( this.col );
        pg.noStroke();
        pg.rect( 2 * this.blurFactor, 2 * this.blurFactor, 
                 this.width + 2 * this.blurFactor, this.height + 2 * this.blurFactor, 
                 this.roundness, this.roundness, this.roundness, this.roundness );
        pg.filter( BLUR, this.blurFactor );
        pg.endDraw();
        int timeEnd = millis();
        // println( "Shadow Creation: " + ( timeEnd - timeStart ));
    };

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Shadow :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    protected void draw() {
        int timeStart = millis();
        image( pg, this.coordinates.x - this.blurFactor * 2 - 1, 
               this.coordinates.y - this.blurFactor * 2 - 1 );
        int timeEnd = millis();
        // println( "Shadow Display: " + ( timeEnd - timeStart ));
    };
		
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Shadow :: getCoordinates  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
	public PVector getCoordinates() {
	    return this.coordinates;
	}
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Shadow :: setCoordinates  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setCoordinates( PVector coordinates ) {
        this.coordinates = coordinates;
    }

}