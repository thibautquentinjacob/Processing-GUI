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
   Allows to group a set of controls.
   
   TODO
   ==============
   - Fix group dimension

   FIXME
   ==============
   
*/

class Group {
	
	protected String name;
	protected ArrayList<Control> controls;
	protected PVector coordinates;
	protected int padding;
	protected int width, height;
	
/* ========================
	 Group :: Group
	 ======================== */
	public Group( String name, PVector coordinates ) {
		this.name = name.toUpperCase();
		this.controls = new ArrayList<Control>();
		this.coordinates = coordinates;
		this.padding = 10;
		this.width = this.padding;
		this.height = this.padding;
	}
	
	public Group( String name, PVector coordinates, ArrayList<Control> controls ) {
		this.controls = controls;
		this.name = name;
		this.coordinates = coordinates;
		this.padding = 10;
		this.getGroupDimensions();
	}

/* ========================
	 Group :: draw
	 ======================== */
	public void draw() {
		fill( 100, 100, 100 );
		// stroke( 220, 220, 220 );
		text( this.name, this.coordinates.x, this.coordinates.y );
		// fill( 150, 150, 150 );
		// noStroke();
		// rect( this.coordinates.x, this.coordinates.y + 5, this.width, this.height, 5, 5, 5, 5 );
		fill( 240, 240, 240 );
		stroke( 220, 220, 220 );
		rect( this.coordinates.x, this.coordinates.y + 5, this.width-2, this.height-2, 5, 5, 5, 5 );
		for	( Control control: this.controls ) {
			control.draw();
		}
	}

/* ========================
	 Group :: addControl
	 ======================== */
	public void addControl( Control control ) {
		int verticalOffset = 0;
		if ( !this.controls.isEmpty()) {
			verticalOffset = this.controls.get( this.controls.size() - 1 ).getY() + this.controls.get( this.controls.size() - 1 ).getHeight() + 2 * this.padding;
		} else {
			verticalOffset = (int)this.coordinates.y + this.padding;
		}
		control.setX( (int)this.coordinates.x + this.padding );
		control.setY( verticalOffset + this.padding );
		this.controls.add( control );
		this.getGroupDimensions();
		this.height += verticalOffset;
	}

/* ========================
	 Group :: getControls
	 ======================== */
	public ArrayList<Control> getControls() {
		return this.controls;
	}

/* ========================
	 Group :: getGroupDimensions
	 ======================== */
	private void getGroupDimensions() {
		int maxWidth = Integer.MIN_VALUE;
		int maxHeight = 0;
		for ( int i = 0 ; i < this.controls.size() ; i++ ) {
			int width = this.controls.get( i ).getWidth();
			int height = this.controls.get( i ).getHeight();
			println( this.controls.get( i ).getType() + " dimensions are: " + width + " x " + height );
			if ( width > maxWidth ) {
				maxWidth = width;
			}
			maxHeight += height;
		}
		this.width = maxWidth + 2 * this.padding;
		this.height = maxHeight;
		println( "dimensions are: " + this.width + ", " + this.height );
	}

	public int getWidth() {
		return this.width;
	}

	public int getHeight() {
		return this.height;
	}

/* ========================
	 Group :: setpadding
	 ======================== */	
	public void setpadding( int padding ) {
		this.padding = padding;
	}

	void mouseClicked() {
		for ( Control control: controls ) {
			control.mouseClicked();
		}
	}
	
	void mouseMoved() {
		for ( Control control: controls ) {
			control.mouseMoved();
		}
	}
	
	void mouseReleased() {
		for ( Control control: controls ) {
			control.mouseReleased();
		}
	}
	
	void mousePressed() {
		for ( Control control: controls ) {
			control.mousePressed();
		}
	}
	
	void mouseDragged() {
		for ( Control control: controls ) {
			control.mouseDragged();
		}
	}

}