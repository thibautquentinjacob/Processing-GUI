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
   Super class for all GUI objects
   
   TODO
   ==============
     - Implement disabled state
     - Add scale
     - Add constructors without coordinates for groups

   FIXME
   ==============
   - Fix bug when clicking on button
   - Fix radio buttons and checkboxes selection

*/

class Control {
    
    protected Color fillColor = new Color( 200, 200, 200 );
    protected Color strokeColor = new Color( 100, 100, 100 );
    protected int x, y, width, height;
    protected boolean shadowed;
    protected boolean hovered;
    protected boolean disabled;
    protected int textSize = 11;
    protected int roundness = 5;
    protected String type;
    
    public void draw() {}
    
    public void mouseClicked() {}
    public void mouseMoved() {}
    public void mousePressed() {}
    public void mouseReleased() {}
    public void mouseDragged() {}
    
    public void setColor( Color fillColor, Color strokeColor ) {
        this.fillColor = fillColor;
        this.strokeColor = strokeColor;
    }

    public Color[] getColor() {
        Color[] colors = { this.fillColor, this.strokeColor };
        return colors;
    }
    
    public int getX() {
        return this.x;
    }

    public int getY() {
        return this.y;
    }

    public void setX( int x ) {
        this.x = x;
    }
    
    public void setY( int y ) {
        this.y = y;
    }
    
    public void setShadowed( boolean shadowed ) {
        this.shadowed = shadowed;
    }
    
    public void setDisabled( boolean disabled ) {
        this.disabled = disabled;
    }
    
    public int getWidth() {
        return this.width;
    }
    
    public int getHeight() {
        return this.height;
    }

    public String getType() {
        return this.type;
    }

}