PGraphics demo_rt;

int demo_rt_pts = 4; 
float demo_rt_angle = 0;
float demo_rt_radius = 99;
float demo_rt_length = 95;

//demo_rt_vertices
PVector demo_rt_vertices[][];
boolean demo_rt_isPyramid = false;

float demo_rt_angleInc = PI/300.0;

void setup_demo_rt() {
  
  demo_rt = createGraphics( 1024, 1024, P3D );
  demo_rt_radius = demo_rt.width/5;
  demo_rt_length = demo_rt.width/6;
  
}

void update_demo_rt() {
  
  demo_rt.beginDraw();
  
  demo_rt_pts = int( 10 + sin( frameCount * 0.03 ) * 7 );
  demo_rt_radius = demo_rt.width / ( 10 + sin( frameCount * 0.063421 ) * 8 );
  
  demo_rt.background( 
    128 + sin( frameCount * 0.02 ) * 100, 
    128 + sin( frameCount * 0.01089 ) * 100,
    128 + sin( frameCount * 0.024 ) * 100);
  demo_rt.lights();
  demo_rt.fill(255, 200, 200);
  demo_rt.translate(demo_rt.width/2, demo_rt.height/2);
  demo_rt.rotateX(frameCount * demo_rt_angleInc);
  demo_rt.rotateY(frameCount * demo_rt_angleInc);
  demo_rt.rotateZ(frameCount * demo_rt_angleInc);

  // initialize vertex arrays
  demo_rt_vertices = new PVector[2][demo_rt_pts+1];

  // fill arrays
  for (int i = 0; i < 2; i++){
    demo_rt_angle = 0;
    for(int j = 0; j <= demo_rt_pts; j++){
      demo_rt_vertices[i][j] = new PVector();
      if (demo_rt_isPyramid){
        if (i==1){
          demo_rt_vertices[i][j].x = 0;
          demo_rt_vertices[i][j].y = 0;
        }
        else {
          demo_rt_vertices[i][j].x = cos(radians(demo_rt_angle)) * demo_rt_radius;
          demo_rt_vertices[i][j].y = sin(radians(demo_rt_angle)) * demo_rt_radius;
        }
      } 
      else {
        demo_rt_vertices[i][j].x = cos(radians(demo_rt_angle)) * demo_rt_radius;
        demo_rt_vertices[i][j].y = sin(radians(demo_rt_angle)) * demo_rt_radius;
      }
      demo_rt_vertices[i][j].z = demo_rt_length; 
      // the .0 after the 360 is critical
      demo_rt_angle += 360.0/demo_rt_pts;
    }
    demo_rt_length *= -1;
  }

  // draw cylinder tube
  demo_rt.beginShape(QUAD_STRIP);
  for(int j = 0; j <= demo_rt_pts; j++){
    demo_rt.vertex(demo_rt_vertices[0][j].x, demo_rt_vertices[0][j].y, demo_rt_vertices[0][j].z);
    demo_rt.vertex(demo_rt_vertices[1][j].x, demo_rt_vertices[1][j].y, demo_rt_vertices[1][j].z);
  }
  demo_rt.endShape();

  //draw cylinder ends
  for (int i = 0; i < 2; i++){
    demo_rt.beginShape();
    for(int j = 0; j < demo_rt_pts; j++){
      demo_rt.vertex(demo_rt_vertices[i][j].x, demo_rt_vertices[i][j].y, demo_rt_vertices[i][j].z);
    }
    demo_rt.endShape(CLOSE);
  }
  
  demo_rt.endDraw();
  
}