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
   __ Write something here __
   
   TODO
   ==============
	 - Implement disabled state
	 - Add scale

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

/* ===========================
		CheckBox control
   =========================== */
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
			return this.texts.length * this.height;
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

/* ===========================
		RadioButtons control
	 =========================== */
	class RadioButtons extends Control {

		private int selected;
		private String selectedValue;
		private int checkRadius = 6;
		private int shadowOffset = 3;
		private int heightOffset = 5;
		private String[] texts;

		public RadioButtons( int x, int y, int size, String[] texts ) {
			this.x = x;
			this.y = y;
			this.width = size;
			this.height = size;
			this.texts = texts;
			this.selected = 0;
			this.selectedValue = this.texts[this.selected];
			this.shadowed = false;
			this.disabled = false;
			this.type = "Radio Buttons";
		}

		public RadioButtons( int x, int y, int size, String[] texts, boolean shadowed, int selected ) {
			this.x = x;
			this.y = y;
			this.width = size;
			this.height = size;
			this.texts = texts;
			this.selected = selected;
			this.selectedValue = this.texts[this.selected];
			this.shadowed = shadowed;
			this.disabled = false;
			this.type = "Radio Buttons";
		}

		@Override
		public void draw() {
			colorMode( RGB, 255 );
			for ( int i = 0 ; i < this.texts.length ; i++ ) {
				String text = this.texts[i];
				if ( this.shadowed ) {
					fill( 200, 200, 200, 200 );
					noStroke();
					ellipse( this.x + this.shadowOffset + this.width / 2, this.y + this.shadowOffset + ( this.heightOffset + this.height ) * i, this.width, this.height );
				}
				int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
				int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
				stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
				fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
				ellipse( this.x + this.width / 2, this.y + ( this.heightOffset + this.height ) * i, this.width, this.height );
				if ( this.selected == i ) {
					fill( 100, 100, 100, 200 );
					noStroke();
					ellipse( this.x + 0.5 + this.width / 2, this.y + 0.5 + ( this.heightOffset + this.height ) * i, this.width - this.checkRadius, this.height - this.checkRadius );
				}
				if ( this.hovered ) {
					fill( 255, 255, 255, 50 );
					noStroke();
					ellipse( this.x + this.width / 2, this.y + ( this.heightOffset + this.height ) * i, this.width, this.height );
				}
				if ( this.selected == i ) {
					fill( 0, 0, 0 );
				} else {
					fill( 100, 100, 100 );
				}
	
				textSize( this.textSize );
				text( text, this.x + this.width + 10, this.y + height / 2 + ( this.heightOffset + this.height ) * i );
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
			return this.texts.length * this.height;
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
			int optionPicked = isInside( mouseX, mouseY );
			if ( optionPicked != -1 ) {
				this.selected = optionPicked;
				this.selectedValue = this.texts[this.selected];
			}
			// print(optionPicked);
		}

		@Override
		public void mouseMoved() {
			int optionHovered = isInside( mouseX, mouseY );
			if ( optionHovered != -1 ) {
				this.hovered = true;
			} else {
				this.hovered = false;
			}
		}
	}

/* ===========================
		Button control
	 =========================== */
	class Button extends Control {
	
		private boolean pressed;
		private int shadowOffset = 3;
		private int pressedOffset = 2;
		private String text;
	
		public Button( int x, int y, int height, String text ) {
			this.x = x;
			this.y = y;
			this.width = int( textWidth( text )) + 10;
			this.height = height;
			this.text = text;
			this.shadowed = false;
			this.disabled = false;
			this.type = "Button";
		}
	
		public Button( int x, int y, int height, String text, boolean shadowed ) {
			this.x = x;
			this.y = y;
			this.width = int( textWidth( text )) + 10;
			this.height = height;
			this.text = text;
			this.shadowed = shadowed;
			this.disabled = false;
			this.type = "Button";
		}
	
		@Override
		public void draw() {
			colorMode( RGB, 255 );
			if ( this.shadowed ) {
				fill( 200, 200, 200, 200 );
				noStroke();
				if ( this.pressed ) {
					rect( this.x + this.shadowOffset - this.pressedOffset, this.y + this.shadowOffset - this.pressedOffset, this.width, this.height, 
								this.roundness, this.roundness, this.roundness, this.roundness );
				} else {
					rect( this.x + this.shadowOffset, this.y + this.shadowOffset, this.width, this.height, 
								this.roundness, this.roundness, this.roundness, this.roundness );
				}
			}
			int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
			int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
			stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
			fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
			rect( this.x, this.y, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
			if ( this.hovered ) {
				fill( 255, 255, 255, 50 );
				noStroke();
				rect( this.x, this.y, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
			}
			fill( 0, 0, 0 );
			textSize( this.textSize );
			text( this.text, this.x + 5, this.y + height / 2 + 5 );
		}
	
		public boolean isInside( int mouseX, int mouseY ) {
			int distX = mouseX - this.x;
			int distY = mouseY - this.y;
			if ( distX >= 0 && distX <= this.width && distY >= 0 && distY <= this.height ) {
				return true;
			} else {
				return false;
			}
		}
	
		// Events
		@Override
		public void mouseMoved() {
			if ( isInside( mouseX, mouseY ) ) {
				this.hovered = true;
			} else {
				this.hovered = false;
			}
		}
		
		@Override
		public void mousePressed() {
			if ( isInside( mouseX, mouseY ) ) {
				this.pressed = true;
				this.x += this.pressedOffset;
				this.y += this.pressedOffset;
			}
		}
		
		public void mouseReleased() {
			if ( this.pressed ) {
				this.pressed = false;
				this.x -= this.pressedOffset;
				this.y -= this.pressedOffset;
			}
		}
	}
	
/* ===========================
		Label control
	 =========================== */
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
	}
	
/* ===========================
		Slider control
	 =========================== */
	class Slider extends Control {
	
		private int range;
		private int resolution;
		private ArrayList<Integer> dragPositions;
		private int selectedSlider = -1;
		private int oldMouseX, oldMouseY;
	
/* ===========================
		Slider :: Slider
	 =========================== */
		public Slider( int x, int y, int range ) {
			this.x = x;
			this.y = y;
			this.resolution = 1;
			this.width = range;
			this.height = 5;
			this.range = range;
			this.disabled = false;
			this.dragPositions = new ArrayList<Integer>();
			this.dragPositions.add( range );
			this.selectedSlider = -1;
			this.type = "Slider";
		}
		
		public Slider( int x, int y, int range, int resolution, ArrayList<Integer> dragPositions ) {
			this.x = x;
			this.y = y;
			this.width = range * resolution;
			this.height = 5;
			this.range = range;
			this.disabled = false;
			this.dragPositions = dragPositions;
			this.resolution = resolution;
			this.selectedSlider = -1;
			this.type = "Slider";
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
			return this.width + ( this.height * 3 + 2 );
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
		public void mousePressed() {
			if ( isInside( mouseX, mouseY ) ) {
				// this.pressed = true;
// 				this.x += this.pressedOffset;
// 				this.y += this.pressedOffset;
			}
		}
		
		public void mouseReleased() {
			// if ( this.pressed ) {
// 				this.pressed = false;
// 				this.x -= this.pressedOffset;
// 				this.y -= this.pressedOffset;
// 			}
		}

		@Override
		public void mouseDragged() {
			if ( isInside( mouseX, mouseY ) && this.selectedSlider != -1 && 
					 this.dragPositions.get( this.selectedSlider ) <= range &&
					 this.dragPositions.get( this.selectedSlider ) >= 0 ) {
				int value = (int)( this.x + ( mouseX - oldMouseX ) * range / width );
				println( "\nmouseX: " + mouseX + " oldMouseX: " + oldMouseX + " Offset: " + ( mouseX - oldMouseX ) + " value: " + value );
				this.dragPositions.set( this.selectedSlider, value );
				oldMouseX = mouseX;
				oldMouseY = mouseY;
			}
		}
	
		@Override
		public void draw() {
			colorMode( RGB, 255 );
			int[] strokeColorChannels = { this.strokeColor.getRed(), this.strokeColor.getGreen(), this.strokeColor.getBlue() };
			int[] fillColorChannels = { this.fillColor.getRed(), this.fillColor.getGreen(), this.fillColor.getBlue() };
			fill( 100, 100, 100 );
			stroke( 0, 0, 0 );
			rect( this.x, this.y, this.width, this.height, this.roundness, this.roundness, this.roundness, this.roundness );
			for ( int position : this.dragPositions ) {
				stroke( strokeColorChannels[0], strokeColorChannels[1], strokeColorChannels[2] );
				fill( fillColorChannels[0], fillColorChannels[1], fillColorChannels[2] );
				ellipse( this.x + position * width / range , this.y + this.height / 2, this.height * 3 + 2 , this.height * 3 + 2 );
				fill( 100, 100, 100 );
				ellipse( this.x + position * width / range, this.y + this.height / 2, this.height, this.height );
			}
		}
	}
