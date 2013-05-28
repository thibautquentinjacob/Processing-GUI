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
   Main program
   
   TODO
   ==============

   FIXME
   ==============
   
*/

int width = 800;
int height = 800;
PVector groupPosititon = new PVector( 30, 30 );
PVector groupPosititon2 = new PVector( 200, 30 );
Group group = new Group( "test", groupPosititon );
Group group2 = new Group( "test", groupPosititon2 );
ArrayList<Integer> sliderPositions;
void draw() {
	colorMode( RGB, 255 );
	background( 255 );
	group.draw();
   group2.draw();
}

void setup() {
	size( width, height );
   sliderPositions = new ArrayList<Integer>();
   sliderPositions.add( 100 );
   // sliderPositions.add( 50 );
   String[] checks = { "Check 1", "Check 2", "Check 3" };
   boolean[] checkSelected = { false, true, false };
	String[] options = { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" };
	group.addControl( new CheckBox( 50, 50, 12, checks, true, checkSelected ));
	group.addControl( new Button( 50, 100, 20, "Button", true ));
	group.addControl( new Label( 50, 150, 20, "Label" ));
	group2.addControl( new RadioButtons( 50, 190, 12, options, true, 1 ));
	group2.addControl( new Slider( 50, 300, 100, 1, sliderPositions ));
}

void mouseClicked() {
	group.mouseClicked();
}

void mouseMoved() {
	group.mouseMoved();
}

void mouseReleased() {
	group.mouseReleased();
}

void mousePressed() {
	group.mousePressed();
}

void mouseDragged() {
   group.mouseDragged();
}