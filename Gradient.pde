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
│ Gradient class representation                                 │
│   Allows to represent vertical and linear gradients between   │
│   two colors.                                                 │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   Implement horizontal color gradient                       │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

abstract class Gradient {

    protected color from;
    protected color to;
    protected int interval;
    protected int height;
    protected int width;
    protected PVector coordinates;
    protected int topRightCornerRadius, topLeftCornerRadius, 
                  bottomRightCornerRadius, bottonLeftCornerRadius;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Gradient  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Gradient( color from, color to, int height, int width, PVector coordinates ) {
        this.from = from;
        this.to = to;
        this.height = height;
        this.width = width;
        this.coordinates = coordinates;
        this.topRightCornerRadius = 0;
        this.topLeftCornerRadius = 0;
        this.bottomRightCornerRadius = 0;
        this.bottonLeftCornerRadius = 0;
    };

    public Gradient( color from, color to, int height, 
                     int width, PVector coordinates, int cornerRadius ) {
        this.from = from;
        this.to = to;
        this.height = height;
        this.width = width;
        this.coordinates = coordinates;
        this.topRightCornerRadius = cornerRadius;
        this.topLeftCornerRadius = cornerRadius;
        this.bottomRightCornerRadius = cornerRadius;
        this.bottonLeftCornerRadius = cornerRadius;
    };

    public Gradient( color from, color to, 
                     int height, int width, PVector coordinates, 
                     int topRightCornerRadius, int topLeftCornerRadius, 
                     int bottomRightCornerRadius, int bottonLeftCornerRadius ) {
        this.from = from;
        this.to = to;
        this.height = height;
        this.width = width;
        this.coordinates = coordinates;
        this.topRightCornerRadius = topRightCornerRadius;
        this.topLeftCornerRadius = topLeftCornerRadius;
        this.bottomRightCornerRadius = bottomRightCornerRadius;
        this.bottonLeftCornerRadius = bottonLeftCornerRadius;
    };

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Gradient :: draw  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    private void draw(){};
    
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Gradient :: getCoordinates  ░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public PVector getCoordinates() {
      return this.coordinates;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Gradient :: setCoordinates  ░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setCoordinates( PVector coordinates ) {
      this.coordinates = coordinates;
    }

};

class VerticalGradient extends Gradient {

    protected PImage img;
    protected PGraphics pg;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ VerticalGradient  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public VerticalGradient( color from, color to, int height, int width, PVector coordinates ) {
        super( from, to, height, width, coordinates );
        int timeStart = millis();
        img = createImage( this.width, this.height, RGB);
        pg = createGraphics( this.width, this.height, JAVA2D );
        img.loadPixels();
        for ( int i = 0 ; i < this.height ; i++ ) {
            float inter = map( i, 0, this.height, 0, 1 );
            color c = lerpColor( this.from, this.to, inter );
            for ( int j = 0 ; j < this.width ; j++ ) {
                img.pixels[j + i * this.width] = c;
            }
        }
        img.updatePixels();

        // If corner are round
        if ( topRightCornerRadius > 0 || topLeftCornerRadius > 0 || 
             bottomRightCornerRadius > 0 || bottonLeftCornerRadius > 0 ) {
            // Create a mask to crop the gradient
            pg.beginDraw();
            pg.background( 0 );
            pg.smooth();
            pg.noStroke();
            pg.fill( 255 );
            pg.rect( 0, 0, pg.width, pg.height, this.topRightCornerRadius, 
                     this.topLeftCornerRadius, this.bottomRightCornerRadius, 
                     this.bottonLeftCornerRadius );
            pg.endDraw();
            img.mask( pg ); // Apply the mask
        }
        int timeEnd = millis();
        // println( "Gradient Creation: " + ( timeEnd - timeStart ));
    }

    public VerticalGradient( color from, color to, int height, int width, PVector coordinates, int cornerRadius ) {
        super( from, to, height, width, coordinates, cornerRadius );
        int timeStart = millis();
        img = createImage( this.width, this.height, RGB );
        pg = createGraphics( this.width, this.height, JAVA2D );
        img.loadPixels();
        for ( int i = 0 ; i < this.height ; i++ ) {
            float inter = map( i, 0, this.height, 0, 1 );
            color c = lerpColor( this.from, this.to, inter );
            for ( int j = 0 ; j < this.width ; j++ ) {
                img.pixels[j + i * this.width] = c;
            }
        }
        img.updatePixels();

        // If corner are round
        if ( topRightCornerRadius > 0 || topLeftCornerRadius > 0 || 
             bottomRightCornerRadius > 0 || bottonLeftCornerRadius > 0 ) {
            // Create a mask to crop the gradient
            pg.beginDraw();
            pg.background( 0 );
            pg.smooth();
            pg.noStroke();
            pg.fill( 255 );
            pg.rect( 0, 0, pg.width, pg.height, this.topRightCornerRadius, 
                     this.topLeftCornerRadius, this.bottomRightCornerRadius, 
                     this.bottonLeftCornerRadius );
            pg.endDraw();
            img.mask( pg ); // Apply the mask
        }
        int timeEnd = millis();
        // println( "Gradient Creation: " + ( timeEnd - timeStart ));
    }

    public VerticalGradient( color from, color to, int height, 
                             int width, PVector coordinates, 
                             int topRightCornerRadius, int topLeftCornerRadius, 
                             int bottomRightCornerRadius, int bottonLeftCornerRadius ) {
        super( from, to, height, width, coordinates, 
               topRightCornerRadius, topLeftCornerRadius, 
               bottomRightCornerRadius, bottonLeftCornerRadius );
        img = createImage( this.width, this.height, RGB);
        pg = createGraphics( this.width, this.height, JAVA2D );
        img.loadPixels();
        for ( int i = 0 ; i < this.height ; i++ ) {
            float inter = map( i, 0, this.height, 0, 1 );
            color c = lerpColor( this.from, this.to, inter );
            for ( int j = 0 ; j < this.width ; j++ ) {
                img.pixels[j + i * this.width] = c;
            }
        }
        img.updatePixels();

        // If corner are round
        if ( topRightCornerRadius > 0 || topLeftCornerRadius > 0 || 
             bottomRightCornerRadius > 0 || bottonLeftCornerRadius > 0 ) {
            // Create a mask to crop the gradient
            pg.beginDraw();
            pg.background( 0 );
            pg.smooth();
            pg.noStroke();
            pg.fill( 255 );
            pg.rect( 0, 0, pg.width, pg.height, this.topRightCornerRadius, 
                     this.topLeftCornerRadius, this.bottomRightCornerRadius, 
                     this.bottonLeftCornerRadius );
            pg.endDraw();
            img.mask( pg ); // Apply the mask
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ VerticalGradient :: draw  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    private void draw() {
        image( img, this.coordinates.x, this.coordinates.y );
    }

};

class HorizontalGradient extends Gradient {

    public HorizontalGradient( color from, color to, int height, int width, PVector coordinates ) {
        super( from, to, height, width, coordinates );
    }

    public void draw() {
        for ( int i = int( this.coordinates.x ) ; i <= int( this.coordinates.x ) + this.width ; i++ ) {
            float inter = map( i, this.coordinates.x, this.coordinates.x + this.width, 0, 1 );
            color c = lerpColor( from, to, inter );
            stroke( c );
            line( i, this.coordinates.y, i, this.coordinates.y + this.height );
        }
    }

}