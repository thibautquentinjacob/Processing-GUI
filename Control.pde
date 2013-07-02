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

abstract class Control {
    
    protected Color fillColor = new Color( 200, 200, 200 );
    protected Color strokeColor = new Color( 100, 100, 100 );
    protected PVector coordinates;
    protected int width, height;
    protected boolean shadowed;
    protected boolean hovered;
    protected boolean disabled;
    protected boolean hidden = false;
    protected int textSize = 11;
    protected int roundness = 5;
    protected String type;
    protected Tooltip tooltip;
    protected ArrayList<Action> mouseClickedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseMovedActions = new ArrayList<Action>();
    protected ArrayList<Action> mousePressedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseReleasedActions = new ArrayList<Action>();
    protected ArrayList<Action> mouseDraggedActions = new ArrayList<Action>();
    protected ArrayList<Action> keyPressedActions = new ArrayList<Action>();

    public void draw() {}
    public boolean isInside( int mouseX, int mouseY ) {
        float distX = mouseX - this.coordinates.x;
        float distY = mouseY - this.coordinates.y;
        if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height ) {
            return true;
        } else {
            return false;
        }
    }

    public void hide() {
        this.hidden = true;
    }

    public void show() {
        this.hidden = false;
    }

    public void toggle() {
        this.hidden = !this.hidden;
    }
    
    public void mouseClicked() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseClickedActions ) {
                action.call();
            }
        }
    }
    public void mouseMoved() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseMovedActions ) {
                action.call();
            }
        }
    }
    public void mousePressed() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mousePressedActions ) {
                action.call();
            }
        }
    }
    public void mouseReleased() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseReleasedActions ) {
                action.call();
            }
        }
    }
    public void mouseDragged() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : mouseDraggedActions ) {
                action.call();
            }
        }
    }
    public void keyPressed() {
        if ( isInside( mouseX, mouseY )) {
            for ( Action action : keyPressedActions ) {
                action.call();
            }
        }
    }
    
    public void setAction( String actionType, Action action ) {
        if ( actionType == "mouseClicked" ) {
            mouseClickedActions.add( action );
        } else if ( actionType == "mouseMoved" ) {
            mouseMovedActions.add( action );
        } else if ( actionType == "mousePressed" ) {
            mousePressedActions.add( action );
        } else if ( actionType == "mouseReleased" ) {
            mouseReleasedActions.add( action );
        } else if ( actionType == "mouseDragged" ) {
            mouseDraggedActions.add( action );
        } else if ( actionType == "keyPressed" ) {
            keyPressedActions.add( action );
        }
    }

    public void removeAction ( String actionType, Action action ) {
        if ( actionType == "mouseClicked" ) {
            mouseClickedActions.remove( action );
        } else if ( actionType == "mouseMoved" ) {
            mouseMovedActions.remove( action );
        } else if ( actionType == "mousePressed" ) {
            mousePressedActions.remove( action );
        } else if ( actionType == "mouseReleased" ) {
            mouseReleasedActions.remove( action );
        } else if ( actionType == "mouseDragged" ) {
            mouseDraggedActions.remove( action );
        } else if ( actionType == "keyPressed" ) {
            keyPressedActions.remove( action );
        }
    }

    public void setColor( Color fillColor, Color strokeColor ) {
        this.fillColor = fillColor;
        this.strokeColor = strokeColor;
    }

    public Color[] getColor() {
        Color[] colors = { this.fillColor, this.strokeColor };
        return colors;
    }
    
    public PVector getCoordinates() {
        return this.coordinates;
    }
    
    public void setCoordinates( PVector coordinates ) {
        this.coordinates = coordinates;
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