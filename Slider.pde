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
   Slider GUI element class
   
   TODO
   ==============

   FIXME
   ==============

*/

import java.util.Collections;

class Slider extends Control {

	protected int min, max;
	protected int range;
	protected int resolution;
	protected ArrayList<Integer> dragPositions;
	protected int selectedSlider = -1;
	protected int oldMouseX, oldMouseY;

/* ===========================
	Slider :: Slider
 =========================== */
	public Slider( int x, int y, int min, int max ) {
		this.x = x;
		this.y = y;
		this.range = max - min;
		this.resolution = 1;
		this.width = this.range;
		this.height = 5;
		this.min = 0;
		this.max = 100;
		this.disabled = false;
		this.dragPositions = new ArrayList<Integer>();
		this.dragPositions.add( this.range );
		this.selectedSlider = -1;
		this.type = "Slider";
	}
	
	public Slider( int x, int y, int min, int max, int resolution, ArrayList<Integer> dragPositions ) {
		this.x = x;
		this.y = y;
		this.range = max - min;
		this.width = this.range * resolution;
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
			int distX = mouseX - ( this.x + position * width / range );
			int distY = mouseY - ( this.y + this.height / 2 );
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

	@Override
	public int getHeight() {
		return this.height * 3 + 2;
	}

	@Override
	public int getWidth() {
		return this.width + ( this.height * 3 + 2 ) / 2;
	}

	public ArrayList<PVector> getRanges() {
		ArrayList<PVector> ranges = new ArrayList<PVector>();
		for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
			if ( this.dragPositions.size() == 1 ) {
				ranges.add( new PVector( this.x, this.dragPositions.get( i )));
			} else if ( i % 2 == 0 && ( i + 1 ) < this.dragPositions.size()) {
				ranges.add( new PVector( this.x + this.dragPositions.get( i + 1 ), this.dragPositions.get( i ) - this.dragPositions.get( i + 1 )));
			} else if ( i == this.dragPositions.size() - 1 && i % 2 == 0 ) {
				ranges.add( new PVector( this.x + this.min, this.dragPositions.get( i ) - this.min));
			}
		}
		return ranges;
	}

	// Events
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
		if ( isInside( mouseX, mouseY ) && this.selectedSlider != -1 && 
				 this.dragPositions.get( this.selectedSlider ) <= range &&
				 this.dragPositions.get( this.selectedSlider ) >= 0 ) {
			int value = (int)(( mouseX - oldMouseX ) * range / width );
			if ( this.dragPositions.get( this.selectedSlider ) + value >= 0 && this.dragPositions.get( this.selectedSlider ) + value <= range ) {
				// println( "\nmouseX: " + mouseX + " oldMouseX: " + oldMouseX + " Offset: " + ( mouseX - oldMouseX ) + " current value: " + this.dragPositions.get( this.selectedSlider ) + " new value: " + ( this.dragPositions.get( this.selectedSlider ) + value ));
				this.dragPositions.set( this.selectedSlider, this.dragPositions.get( this.selectedSlider ) + value );
				oldMouseX = mouseX;
				oldMouseY = mouseY;
			}
		}
		Collections.sort( this.dragPositions, Collections.reverseOrder() );
	}

	@Override
	public void draw() {
		colorMode( RGB, 255 );
		int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
		int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
		fill( 100, 100, 100 );
		stroke( 0, 0, 0 );
		rect( this.x, this.y + this.height + 2, this.width, this.height, 
					this.roundness, this.roundness, this.roundness, this.roundness );
		ArrayList<PVector> ranges = getRanges();
		fill( 0, 150, 250 );
		for ( PVector range : ranges ) {
			rect( range.x, this.y + this.height + 2, range.y, this.height, 
						this.roundness, this.roundness, this.roundness, this.roundness );
		}
		for ( int i = 0 ; i < this.dragPositions.size() ; i++ ) {
			int position = this.dragPositions.get( i );
			stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
			fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
			ellipse( this.x + position * width / range , this.y + this.height * 3 / 2 + 2, this.height * 3 + 2 , this.height * 3 + 2 );
			fill( 100, 100, 100 );
			ellipse( this.x + position * width / range, this.y + this.height * 3 / 2 + 2, this.height, this.height );
			fill( 0 );
			text( position, this.x + position * width / range - ( this.height * 3 + 2 ) / 2, this.y + this.height - 10 );
		}
	}
}