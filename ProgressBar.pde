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
│ ProgressBar GUI element class representation                  │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│   * Implement undefined state                               │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

class ProgressBar extends Control {

    // private String text;
    private boolean undefined; // *** NOT IMPLEMENTED ***
    private float progress;
    private float completeness;
    private VerticalGradient background;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ ProgressBar  ░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public ProgressBar( PVector coordinates, int width, int height, float progress, float completeness ) {
        this.coordinates = coordinates;
        this.width = width;
        this.height = height;
        // this.text = text;
        this.disabled = false;
        this.type = "ProgressBar";
        this.undefined = false;
        this.roundness = 2;
        this.progress = progress;
        this.completeness = completeness;
        this.background = new VerticalGradient( color( 0 ), color( 40 ), this.height + 1, this.width, 
                                                new PVector( this.coordinates.x, this.coordinates.y ), 
                                                this.roundness );

    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ ProgressBar :: draw  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            this.background.draw();
            this.progress = this.progress > this.completeness ? this.completeness : this.progress;
            this.progress = this.progress <= 1 ? 1 : this.progress;
            VerticalGradient bar = new VerticalGradient( color( 200 ), color( 100 ), this.height - 6 + 1, 
                                                              int(( this.progress / this.completeness ) * ( this.width - 6 )), 
                                                              new PVector( this.coordinates.x + 3, this.coordinates.y + 3 ), 
                                                              this.roundness );
            bar.draw();
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ ProgressBar :: setProgress  ░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setProgress( float progress ) {
        this.progress = progress;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ ProgressBar :: setText  ░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    // public void setText( String text ) {
    //     this.text = text;
    // }

    // *** NOT IMPLEMENTED ***
    /*
    ╔════════════════════════════════════════════╗
    ║ ░ ProgressBar :: setUndefined  ░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setUndefined( boolean undefined ) {
        this.undefined = undefined;
    }

}