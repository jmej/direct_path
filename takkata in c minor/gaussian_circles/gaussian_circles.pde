/**
 * Random Gaussian. 
 * 
 * This sketch draws ellipses with x and y locations tied to a gaussian distribution of random numbers.
 */

void setup() {
  size(640, 360);
  background(0);
}

void draw() {

  // Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
  float valForX = randomGaussian();
  float valForY = randomGaussian();

  float sdx = 60;                  // Define a standard deviation
  float meanx = width/2;           // Define a mean value (middle of the screen along the x-axis)
  float x = ( valForX * sdx ) + meanx;  // Scale the gaussian random number by standard deviation and mean

  float sdy = 60;                  // Define a standard deviation
  float meany = height/2;           // Define a mean value (middle of the screen along the x-axis)
  float y = ( valForY * sdy ) + meany;  // Scale the gaussian random number by standard deviation and mean

  noStroke();
  fill(255, 10);
  noStroke();
  ellipse(x, y, 32, 32);   // Draw an ellipse at our "normal" random location
}