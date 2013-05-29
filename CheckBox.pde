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
   Checkboxes GUI element class
   
   TODO
   ==============

   FIXME
   ==============

 */

class CheckBox extends Control {

	private boolean[] checked;
	private int checkRadius = 6;
	private int heightOffset = 5;
	private int shadowOffset = 3;
	private String[] texts;

	public CheckBox( int x, int y, int size, String[] texts ) {
		this.x = x;
		this.y = y;
		this.width = size;
		this.height = size;
		this.texts = texts;
		this.shadowed = false;
		this.disabled = false;
		this.type = "CheckBox";
		for ( int i = 0 ; i < texts.length ; i++ ) {
			checked[i] = false;
		}
	}

	public CheckBox( int x, int y, int size, String[] texts, boolean shadowed, boolean[] checked ) {
		this.x = x;
		this.y = y;
		this.width = size;
		this.height = size;
		this.texts = texts;
		this.shadowed = shadowed;
		this.checked = checked;
		this.disabled = false;
		this.type = "CheckBox";
	}

	@Override
	public void draw() {
		colorMode( RGB, 255 );
		for ( int i = 0 ; i < texts.length ; i++ ) {
			String text = this.texts[i];
			if ( this.shadowed ) {
			fill( 200, 200, 200, 200 );
			noStroke();
			rect( this.x + this.shadowOffset, this.y + this.shadowOffset + ( this.heightOffset + this.height ) * i, this.width, this.height, 
						this.roundness, this.roundness, this.roundness, this.roundness );
			}
			int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
			int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
			stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
			fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
			rect( this.x, this.y + ( this.heightOffset + this.height ) * i, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
			if ( this.checked[i] ) {
				fill( 100, 100, 100, 200 );
				noStroke();
				rect( this.x + this.checkRadius / 2 , this.y + this.checkRadius / 2 + ( this.heightOffset + this.height ) * i, this.width - this.checkRadius + 1, 
							this.height - this.checkRadius + 1, this.roundness, this.roundness, this.roundness, this.roundness );
			}
			if ( this.hovered ) {
				fill( 255, 255, 255, 50 );
				noStroke();
				rect( this.x, this.y + ( this.heightOffset + this.height ) * i, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
			}
			if ( this.checked[i] ) {
				fill( 0, 0, 0 );
			} else {
				fill( 100, 100, 100 );
			}
		
			textSize( this.textSize );
			text( text, this.x + this.width + 10, this.y + height / 2 + ( this.heightOffset + this.height ) * i + 5 );
		}
	}

	public int isInside( int mouseX, int mouseY ) {
		int distX = mouseX - this.x;
		int distY = mouseY - this.y;
		for ( int i = 0 ; i < this.texts.length ; i++ ) {
			if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height + ( this.heightOffset + this.height ) * i ) {
				return i;
			}
		}
		return -1;
	}

	@Override
	public int getHeight() {
		return this.texts.length * ( this.height + this.heightOffset );
	}

	@Override
	public int getWidth() {
		float maxTextWidth = 0;
		for ( int i = 0 ; i < this.texts.length ; i++ ) {
			if ( textWidth( this.texts[i] ) > maxTextWidth ) {
				maxTextWidth = textWidth( this.texts[i] );
			}
		}
		return this.width + (int)maxTextWidth + 10;
	}

	// Events
	@Override
	public void mouseClicked() {
		int selected = isInside( mouseX, mouseY );
		if ( selected != -1 ) {
			this.checked[selected] = !this.checked[selected];
		}
	}

	@Override
	public void mouseMoved() {
		int selected = isInside( mouseX, mouseY );
		if ( selected != -1 ) {
			this.hovered = true;
		} else {
			this.hovered = false;
		}
	}
}