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
│ Slider GUI element class representation                       │
│   ...                                                         │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

import java.util.Collections;

class Slider extends Control {

    protected int min, max;
    protected int range;
    protected int resolution;
    protected ArrayList<Integer> dragPositions;
    protected int selectedSlider = -1;
    protected int oldMouseX, oldMouseY;
    protected boolean dragging = false;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public Slider( PVector coordinates, int min, int max, int size ) {
        this.coordinates = coordinates;
        this.range = max - min;
        this.resolution = this.range / size;
        this.width = size;
        this.height = 5;
        this.min = 0;
        this.max = 100;
        this.disabled = false;
        this.dragPositions = new ArrayList<Integer>();
        this.dragPositions.add( this.range );
        this.selectedSlider = -1;
        this.type = "Slider";
    }
    
    public Slider( PVector coordinates, int min, int max, int size, ArrayList<Integer> dragPositions ) {
        this.coordinates = coordinates;
        this.range = max - min;
        this.resolution = this.range / size;
        this.width = size;
        this.height = 5;
        this.min = min;
        this.max = max;
        this.disabled = false;
        this.dragPositions = dragPositions;
        this.resolution = resolution;
        this.selectedSlider = -1;
        this.type = "Slider";
        Collections.sort( this.dragPositions, Collections.reverseOrder() ); 
    }

    public boolean isInside( int mouseX, int mouseY ) {
        for ( int i = 0 ; i < dragPositions.size() ; i++ ) {
            int position = this.dragPositions.get( i );
            float distX = mouseX - ( this.coordinates.x + position * width / range );
            float distY = mouseY - ( this.coordinates.y + this.height / 2 );
            int distance = (int)Math.sqrt( pow( distX, 2 ) + pow( distY, 2 ));
            if ( distance <= this.height * 3 + 2 ) {
                // println("Inside");
                this.selectedSlider = i;
                return true;
            }
        }
        this.selectedSlider = -1;
        return false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: getHeight  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public int getHeight() {
        return this.height * 3 + 2;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: getWidth  ░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public int getWidth() {
        return this.width + ( this.height * 3 + 2 ) / 2;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: setMin  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setMin( int min ) {
        if ( this.min < this.max ) {
            this.min = min;
            this.range = this.max - this.min;
            this.resolution = this.range / this.width;
            for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
                int position = this.dragPositions.get( i );
                if ( position < min ) {
                    this.dragPositions.set( i, min );
                }
            }
        } else {
            println( "Min should be inferior to max" );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: setMax  ░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void setMax( int max ) {
        if ( this.min < this.max ) {
            this.max = max;
            this.range = this.max - this.min;
            this.resolution = this.range / this.width;
            for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
                int position = this.dragPositions.get( i );
                if ( position > max ) {
                    this.dragPositions.set( i, max );
                }
            }
        } else {
            println( "Max should be superior to min" );
        }
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: getRanges  ░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public ArrayList<PVector> getRanges() {
        ArrayList<PVector> ranges = new ArrayList<PVector>();
        for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
            if ( this.dragPositions.size() == 1 ) {
                ranges.add( new PVector( this.coordinates.x, this.dragPositions.get( i )));
            } else if ( i % 2 == 0 && ( i + 1 ) < this.dragPositions.size()) {
                ranges.add( new PVector( this.coordinates.x + this.dragPositions.get( i + 1 ), 
                                         this.dragPositions.get( i ) - this.dragPositions.get( i + 1 )));
            } else if ( i == this.dragPositions.size() - 1 && i % 2 == 0 ) {
                ranges.add( new PVector( this.coordinates.x + this.min, 
                                         this.dragPositions.get( i ) - this.min));
            }
        }
        return ranges;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Events  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY ) ) {
            this.hovered = true;
        } else {
            this.hovered = false;
        }
        oldMouseX = mouseX;
        oldMouseY = mouseY;
    }

    @Override
    public void mouseDragged() {
        if (( isInside( mouseX, mouseY ) || this.dragging ) && this.selectedSlider != -1 && 
                 this.dragPositions.get( this.selectedSlider ) <= range &&
                 this.dragPositions.get( this.selectedSlider ) >= 0 ) {
            this.dragging = true;
            int value = (int)(( mouseX - oldMouseX ) * range / width );
            if ( this.dragPositions.get( this.selectedSlider ) + value >= 0 && 
                 this.dragPositions.get( this.selectedSlider ) + value <= range ) {
                /* println( "\nmouseX: " + mouseX + " oldMouseX: " + oldMouseX + 
                         " Offset: " + ( mouseX - oldMouseX ) + " current value: " + 
                         this.dragPositions.get( this.selectedSlider ) + " new value: " +
                         ( this.dragPositions.get( this.selectedSlider ) + value )); */
                this.dragPositions.set( this.selectedSlider,
                                        this.dragPositions.get( this.selectedSlider ) + value );
                oldMouseX = mouseX;
                oldMouseY = mouseY;
            }
        }
        Collections.sort( this.dragPositions, Collections.reverseOrder() );
    }
    
    @Override
    public void mouseReleased() {
        this.dragging = false;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ Slider :: draw  ░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    @Override
    public void draw() {
        if ( !this.hidden ) {
            colorMode( RGB, 255 );
            int[] strokeColorChannels = { 
                this.strokeColor.getRed(), 
                this.strokeColor.getGreen(), 
                this.strokeColor.getBlue() };
            int[] fillColorChannels = { 
                this.fillColor.getRed(), 
                this.fillColor.getGreen(), 
                this.fillColor.getBlue() };
            fill( 100, 100, 100 );
            stroke( 0, 0, 0 );
            rect( this.coordinates.x, this.coordinates.y + this.height + 2, this.width, this.height, 
                  this.roundness, this.roundness, this.roundness, this.roundness );
            ArrayList<PVector> ranges = getRanges();
            fill( 0, 150, 250 );
            for ( PVector overlay : ranges ) {
                rect( overlay.x * width / this.range, this.coordinates.y + this.height + 2, 
                      overlay.y * width / this.range, this.height, 
                      this.roundness, this.roundness, this.roundness, this.roundness );
            }
            for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
                int position = this.dragPositions.get( i );
                stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
                fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
                ellipse( this.coordinates.x + position * width / range , 
                         this.coordinates.y + this.height * 3 / 2 + 2, 
                         this.height * 3 + 2 , this.height * 3 + 2 );
                fill( 100, 100, 100 );
                ellipse( this.coordinates.x + position * width / range, 
                         this.coordinates.y + this.height * 3 / 2 + 2, 
                         this.height, this.height );
                fill( 0 );
                text( position, this.coordinates.x + position * width / 
                      range - ( this.height * 3 + 2 ) / 2, 
                      this.coordinates.y + this.height - 10 );
                text( this.min, this.coordinates.x + this.min * width / 
                      range - ( this.height * 3 + 2 ) / 2, 
                      this.coordinates.y + this.height - 10 );
                text( this.max, this.coordinates.x + this.max * width / 
                      range - ( this.height * 3 + 2 ) / 2, 
                      this.coordinates.y + this.height - 10 );
            }
        }
    }
}