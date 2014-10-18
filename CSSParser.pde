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
│ Action class representation                                   │
│   Allows to represent an action by passing a callback function│
│   and a name.                                                 │
├─────────────────────────────────────────────────────────────╤─┤
│ TODO                                                        │░│
│ ..                                                          │░│
│ FIXME                                                       │░│
│ ...                                                         │░│
└─────────────────────────────────────────────────────────────┴─┘ */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.FileInputStream;

class CSSParser {

    private String fileName;
    private HashMap<String, HashMap<String, ArrayList<String>>> dictionary;

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CSSParser  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public CSSParser( String fileName ) {
        this.fileName = fileName;
        this.dictionary = new HashMap<String, HashMap<String, ArrayList<String>>>();
        HashMap<String, ArrayList<String>> group;
        // Button defaults
        // released state
        group = new HashMap<String, ArrayList<String>>();
        group.put( "height", new ArrayList<String>(){{ add("24"); }});
        group.put( "padding", new ArrayList<String>(){{ add("5"); }});
        group.put( "border-color", new ArrayList<String>(){{ add("5"); add("5"); add("5"); add("255"); }});
        group.put( "border-width", new ArrayList<String>(){{ add("1"); }});
        group.put( "border-radius", new ArrayList<String>(){{ add("5"); }});
        group.put( "text-align", new ArrayList<String>(){{ add("center"); }});
        group.put( "font-size", new ArrayList<String>(){{ add("11"); }});
        group.put( "box-shadow", new ArrayList<String>(){{ add("0"); add("0"); add("1"); add("5"); add("0"); add("0"); add("0"); add("0"); }});
        group.put( "color", new ArrayList<String>(){{ add("0"); add("0"); add("0"); add("255"); }});
        group.put( "background-color", new ArrayList<String>(){{ add("100"); add("100"); add("100"); add("255"); }});
        this.dictionary.put( "Button", group );

        // Hovered state
        group = new HashMap<String, ArrayList<String>>();
        group.put( "height", new ArrayList<String>(){{ add("24"); }});
        group.put( "padding", new ArrayList<String>(){{ add("5"); }});
        group.put( "border-color", new ArrayList<String>(){{ add("5"); add("5"); add("5"); add("255"); }});
        group.put( "border-width", new ArrayList<String>(){{ add("1"); }});
        group.put( "border-radius", new ArrayList<String>(){{ add("5"); }});
        group.put( "text-align", new ArrayList<String>(){{ add("center"); }});
        group.put( "font-size", new ArrayList<String>(){{ add("11"); }});
        group.put( "box-shadow", new ArrayList<String>(){{ add("2"); add("2"); add("5"); }});
        group.put( "color", new ArrayList<String>(){{ add("0"); add("0"); add("0"); add("255"); }});
        group.put( "background-color", new ArrayList<String>(){{ add("120"); add("120"); add("120"); add("255"); }});
        this.dictionary.put( "Button:hovered", group );

        // Pressed state
        group = new HashMap<String, ArrayList<String>>();
        group.put( "height", new ArrayList<String>(){{ add("24"); }});
        group.put( "padding", new ArrayList<String>(){{ add("5"); }});
        group.put( "border-color", new ArrayList<String>(){{ add("5"); add("5"); add("5"); add("255"); }});
        group.put( "border-width", new ArrayList<String>(){{ add("1"); }});
        group.put( "border-radius", new ArrayList<String>(){{ add("5"); }});
        group.put( "text-align", new ArrayList<String>(){{ add("center"); }});
        group.put( "font-size", new ArrayList<String>(){{ add("11"); }});
        group.put( "box-shadow", new ArrayList<String>(){{ add("2"); add("2"); add("5"); }});
        group.put( "color", new ArrayList<String>(){{ add("0"); add("0"); add("0"); add("255"); }});
        group.put( "background-color", new ArrayList<String>(){{ add("120"); add("120"); add("120"); add("255"); }});
        this.dictionary.put( "Button:pressed", group );
        
        // Disabled state
        group = new HashMap<String, ArrayList<String>>();
        group.put( "height", new ArrayList<String>(){{ add("24"); }});
        group.put( "padding", new ArrayList<String>(){{ add("5"); }});
        group.put( "border-color", new ArrayList<String>(){{ add("5"); add("5"); add("5"); add("255"); }});
        group.put( "border-width", new ArrayList<String>(){{ add("1"); }});
        group.put( "border-radius", new ArrayList<String>(){{ add("5"); }});
        group.put( "text-align", new ArrayList<String>(){{ add("center"); }});
        group.put( "font-size", new ArrayList<String>(){{ add("11"); }});
        group.put( "box-shadow", new ArrayList<String>(){{ add("2"); add("2"); add("5"); }});
        group.put( "color", new ArrayList<String>(){{ add("0"); add("0"); add("0"); add("255"); }});
        group.put( "background-color", new ArrayList<String>(){{ add("100"); add("100"); add("100"); add("255"); }});
        this.dictionary.put( "Button:disabled", group );
        
        // Override defaults with target css file
        this.parse();
    //     v border-color
    // border-width
    // border-left-color
    // border-left-width
    // border-right-color
    // border-right-width
    // border-top-color
    // border-top-width
    // border-bottom-color
    // border-bottom-width
    // v border-radius
    // box-shadow
    // height
    // width
    // font-size
    // v padding
    // padding-bottom
    // padding-left
    // padding-right
    // padding-top
    // text-align
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CSSParser :: parse  ░░░░░░░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public void parse() {
        String selectorRegex = "^([a-zA-Z:]+).*";
        String colorRegex = "\\s*([a-zA-Z-]+)\\s*:\\s*rgba\\(\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*\\);";
        String entryRegex = "\\s*([a-zA-Z-]+)\\s*:\\s*([a-zA-Z0-9, '#]+);";
        String commentStartRegex = "\\/\\*.*";
        String commentEndRegex = ".*\\*\\/";
        Pattern selectorPattern = Pattern.compile( selectorRegex );
        Pattern colorPattern = Pattern.compile( colorRegex );
        Pattern entryPattern = Pattern.compile( entryRegex );
        Pattern commentStartPattern = Pattern.compile( commentStartRegex );
        Pattern commentEndPattern = Pattern.compile( commentEndRegex );
        Matcher matcher;
        boolean commented = false;
        try {
            BufferedReader reader = null;
            try {
                InputStream is = new FileInputStream( sketchPath( this.fileName ));
                reader = new BufferedReader( new InputStreamReader( is ));
            } catch( IOException e ) {
                println( e.toString() );
            }
            try {
                String line;
                int lineNumber = 0;
                // HashMap<String, ArrayList<String>> group = new HashMap<String, ArrayList<String>>();
                String selector = "";
                while (( line = reader.readLine()) != null ) {
                    lineNumber++;
                    // Comment start
                    if ( line.matches( commentStartRegex )) { 
                        println( lineNumber + ": Comment start" );
                        commented = true;
                    } else if ( line.matches( commentEndRegex )) {
                        println( lineNumber + ": Comment end" );
                        commented = false;
                    } else if ( !commented ) {
                        // Selector
                        if ( line.matches( selectorRegex )) {
                            if ( selector != "" ) {
                                println( "Selector is " + selector );
                                // group = new HashMap<String, ArrayList<String>>();
                            }
                            // Extract capturing group
                            matcher = selectorPattern.matcher( line );
                            while ( matcher.find() ) {
                                selector = matcher.group( 1 );
                            }
                        // color rgba
                        } else if ( line.matches( colorRegex )) {
                            println("color");
                            matcher = colorPattern.matcher( line );
                            ArrayList<String> arr = new ArrayList<String>();
                            while ( matcher.find() ) {
                                arr.add( matcher.group( 2 ));
                                arr.add( matcher.group( 3 ));
                                arr.add( matcher.group( 4 ));
                                arr.add( matcher.group( 5 ));
                                // group.put( matcher.group( 1 ), arr );
                                println( matcher.group( 1 ) + " = " + arr.toString());
                                this.dictionary.get( selector ).put( matcher.group( 1 ), arr );
                            }
                        // Key/value
                        } else if ( line.matches( entryRegex )) {
                            matcher = entryPattern.matcher( line );
                            ArrayList<String> arr = new ArrayList<String>();
                            while ( matcher.find() ) {
                                arr.add( matcher.group( 2 ));
                                // group.put( matcher.group( 1 ), arr );
                                println( matcher.group( 1 ) + " = " + matcher.group( 2 ));
                                this.dictionary.get( selector ).put( matcher.group( 1 ), arr );
                            }
                            // this.dictionary.put( selector, group );
                            
                        }
                    } else {
                        // println( "Skipping " + line );
                    }
                }
                reader.close();
            } catch ( Exception e ){
                println( e.toString() );
            }
        } catch ( Exception e ) {
            println( e.toString());
       }
       println( dictionary.toString() );
       // exit();
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CSSParser :: getDictionary  ░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public HashMap<String, HashMap<String, ArrayList<String>>> getDictionary() {
		return this.dictionary;
    }

    /*
    ╔════════════════════════════════════════════╗
    ║ ░ CSSParser :: getProperty  ░░░░░░░░░░░░░░ ║
    ╚════════════════════════════════════════════╝ */
    public ArrayList<String> getProperty( String selector, String property ) {
        return this.dictionary.get( selector ).get( property );
    }

}