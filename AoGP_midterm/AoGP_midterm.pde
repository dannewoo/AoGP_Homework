// Art of Graphics Programming
// Section Example 004: "Storing Geometries: A Generic Approach"
// Example Stage: D (Part C)
// Course Materials by Patrick Hebron

import processing.opengl.*;

TMesh mesh;
PImage img;

void setup() {
  // In this stage, we add the ability to attach a texture to a TMesh object.
  // This will only display correctly if vertex positions, UVs and normals
  // are properly setup. (See TMesh for more details)

  size( 800, 600, OPENGL );
  img = loadImage("sun.png");
  // Choose the number of UVs in the mesh
  int meshPointsU = 30;
  int meshPointsV = 100;
  // Choose a size for the mesh
  float sideLength = 1000.0;

  // Using noiseSeed so that we get the same terrain
  // every time we run the program (for comparison with 004DA)
  noiseSeed(25);

  // Create new mesh factory
  TMeshFactory meshFactory = new TMeshFactory();

  // Create a new mesh object
  mesh = new TMesh();
  // Create terrain
  mesh = meshFactory.createTerrain( meshPointsU, meshPointsV, sideLength, sideLength, 0.0, sideLength/5.0, 8, 0.8 );

  // Center the mesh in window
  mesh.setPosition( new PVector( width/2.0 +100, height/2.0, -280.0 ) );

  // Set mesh texture
  mesh.setTexture( "rockies.jpg" );
}

void draw() {
  // Clear window
  float darkness = map(mouseY, 0, height, 0, 200);
  background( 255-darkness );
  // Set colors
  //  stroke( 255, 0, 0 );
  noStroke();
  fill( 0, 255, 0 );

  // Use lights to show the effect of normals
  // (We'll look at lights more closely in a later example)
  //  spotLight( 255, 255, 255, mouseX, mouseY/2, -mouseY, 0.0, 1.0, 0.0, HALF_PI, 10.0 );
  directionalLight( 200-darkness, 200-darkness, 200-darkness, 0, 1, -2 );
  // Draw the mesh
  sunRise();
  buildings();
  mesh.draw();
}

void sunRise() {
  pushMatrix();
  float darkness = map(mouseY, 0, height, -400, 800);
  translate(width/2-220, darkness, -900);
  image(img, 0, 0);
  popMatrix();
}

void buildings() {
  pushMatrix();
  translate(200, height-200, -100); 
  fill(255, 0, 0);
  rotateY(-0.2);
  box(200, 300, 100);
  popMatrix();
  pushMatrix();
  translate(300, height-200, -200); 
  fill(255, 0, 0);
  rotateY(-0.2);
  box(200, 200, 200);
  popMatrix();
}

