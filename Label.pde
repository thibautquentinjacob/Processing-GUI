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
   Label GUI element class
   
   TODO
   ==============

   FIXME
   ==============

*/

class Label extends Control {

	private String text;

	public Label( int x, int y, int height, String text ) {
		this.x = x;
		this.y = y;
		this.width = int( textWidth( text )) + 10;
		this.height = height;
		this.text = text;
		this.disabled = false;
		this.type = "Label";
	}

	@Override
	public void draw() {
		colorMode( RGB, 255 );
		fill( 0, 0, 0 );
		textSize( this.textSize );
		text( this.text, this.x, this.y + height / 2 + 5 );
	}

	public void setText( String text ) {
		this.text = text;
		this.width = int( textWidth( text )) + 10;
	}

}