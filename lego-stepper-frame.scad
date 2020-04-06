$fn=50;

module pos(rows,cols) {
	for (r=[0:rows-1]) {
		for (c=[0:cols-1]) {
			translate([r*8,c*8,0]) one_one(true);
			translate([r*8,c*8,3.3]) one_one(true);
			translate([r*8,c*8,6.6]) one_one(false);
		}		
	}
}

module flat_pos(rows,cols,flattop) {
	for (r=[0:rows-1]) {
		for (c=[0:cols-1]) {
			translate([r*8,c*8,0]) one_one(flattop);
		}		
	}
}

module flat_neg(rows,cols) {

  difference() {
   union() {
      translate([1.5,1.5,-1]) cube([8*rows-3,8*cols-3,2.2+1]);	
//	for (r=[0:rows-1]) {
//		for (c=[0:cols-1]) {
//			translate([r*8+4,c*8+4,0]) cylinder(r=1.25, h=4);
//		}
//	}
   }
   if(cols==1 && rows > 1) {
	  for (r=[1:rows-1]) {
		translate([r*8,4,0.0]) cylinder(r=1.4, h=2.2);		
	 }		
   }
   if(rows==1 && cols > 1) {
	  for (c=[1:cols-1]) {
		translate([4,c*8,0.0]) cylinder(r=1.4, h=2.2);		
	 }		
   }
   if(rows > 1 && cols >1) {
	for (r=[1:rows-1]) {
		for (c=[1:cols-1]) {
			translate([r*8,c*8,0.0]) {
	                  difference() {
					cylinder(r=6.5/2, h=2.2);
					cylinder(r=5/2, h=2.2);
				}			
			}
		}
	}		
   }
 }
}


module one_one(flattop) {
 union() {
   cube([8,8,3.3]);
	if(!flattop) {
	   translate([4,4,0]) cylinder(r=4.9/2, h=5);
	}
 }
}

module flat_thick(rows,cols) {
 difference() {  
   pos(rows,cols);
   flat_neg(rows,cols);
 }
}

module side_holes(brick_len) {    
    union() {
        for(i=[1:brick_len-1]) {
            translate([i*8,8,5.7])
            rotate([90,0,0])
            union() {
                translate([0,0,-0.1]) cylinder(r=5/2, h=8.2); //+0.2 
                translate([0,0,-0.1]) cylinder(r=6.4/2, h=1); //+0.2
                translate([0,0,7]) cylinder(r=6.4/2, h=1.1);  //+0.2          
            }
        }
    }
}

module flat(rows,cols,flattop=false) {
 difference() {  
   flat_pos(rows,cols,flattop);
   flat_neg(rows,cols);
 }
}

module corner(rows,cols,w,flat) {
 difference() {  
   union() {
       if(flat) {
           flat_pos(rows,w);
           flat_pos(w,cols);
       }
       else {
           pos(rows,w);
           pos(w,cols);
       }
   }
   union() {
	   flat_neg(rows,w);
	   flat_neg(w,cols);
   }
 }
}

module legs(h1) {
	tmp=h1-12.5;
	difference() {
		union() {
			flat(1,1,true);	
			translate([8,0.0,0]) flat(1,1,true);	
		
			translate([0.5,0,3]) cube([15,5.5,h1-7-3]);
			difference() {
				translate([1,4,h1-10]) rotate([0,90,0]) cylinder(r=4,h=14);		
				cube([16,8,2]);					
			}
			translate([1,0,h1-7]) cube([14,8,2]);

			
			translate([4,4,h1-5]) scale([0.9,1.1,1]) cylinder(r1=2.45, r2=2.2,h=5);		
			translate([12,4,h1-5]) scale([0.9,1.1,1])cylinder(r1=2.45, r2=2.2,h=5);					
		}

		translate([7.5,-1,0]) cube([1,10,(tmp > 5) ? tmp : 5]);
		translate([4,4,h1-5]) cylinder(r=1.5,h=5);		
		translate([12,4,h1-5]) cylinder(r=1.5,h=5);		
		
	}
}

module one_one_hook(hole_r=1.5) {
	flat(1,1,true);

   translate([0,4-1.6,3.2]) {
		difference() {
			intersection() {
				cube([8,3.2,4.4]);
			   translate([4,5,0]) rotate([90,0,0]) scale([1,1.5,1]) cylinder(r=4, h=10);	
			}
		   translate([4,5,1+hole_r]) rotate([90,0,0]) cylinder(r=hole_r, h=10);	
		   translate([4,5,1+2.5*hole_r]) rotate([90,0,0]) cylinder(r=hole_r, h=10);	
		}
	}
}

//28BYJ-48 stepper motor
module stepper() {
	color("Goldenrod", alpha=0.8) {
		translate([0,0,0])cylinder(r=2.5, h=8);
	}
	color("Silver", alpha=0.5) {
		translate([0,0,-1])cylinder(r=5, h=1);
		translate([0, -8, -20]) cylinder(r=14, h=19);
	
		difference() {
			union() {
				translate([-35/2,  -8, -2]) cylinder(r=3.5, h=1);
				translate([35/2,  -8, -2]) cylinder(r=3.5, h=1);
				translate([-35/2,  -8-3.5, -2]) cube([35,7,1]);
			}
			translate([-35/2,  -8, -4]) cylinder(r=2, h=10);
			translate([35/2,  -8, -4]) cylinder(r=2, h=10);		
		}	
	}
	color("Blue", alpha=0.5) {
		translate([-7.5,-8-18,-18]) cube([15,18,17]);
	}
}

module stepperholes() {
	translate([0,0,-2])cylinder(r=5.2, h=4);
	translate([0,0,-10])cylinder(r=5, h=40);
	translate([35/2,  -8, -10]) cylinder(r=2, h=20);
	translate([35/2,  -8, 1]) cylinder(r=4, h=4);
	translate([-35/2, -8, -10]) cylinder(r=2, h=20);
	translate([-35/2,  -8, 1]) cylinder(r=4, h=4);
}


module stepper_frame() {
    translate([8,42,0]) cube([2,2,9.9]);
    translate([8,42+3.8,0]) cube([2,2,9.9]);
    translate([9,43.6,2.5]) sphere(r=1);
    translate([9,46.4,2.5]) sphere(r=1);

    translate([38,42,0]) cube([2,2,9.9]);
    translate([38,42+3.8,0]) cube([2,2,9.9]);
    translate([39,43.6,2.5]) sphere(r=1);
    translate([39,46.4,2.5]) sphere(r=1);

    difference() {
        union() {
            translate([0,0,0]) corner(3,4,1);
            translate([8*6,8*8,0]) rotate([0,0,180]) corner(3,4,1);
            translate([8*6,0,0]) rotate([0,0,90]) corner(4,3,1);
            translate([0,8*8,0]) rotate([0,0,-90]) corner(4,3,1);

            translate([16,0,9.9]) flat_pos(2,1);
            
            translate([0,19,0]) cube([48,2,20]);
            translate([0,19,0]) cube([2,13,20]);
            translate([48-2,19,0]) cube([2,13,20]);
            
        }
        translate([8,0,0]) side_holes(4);
        translate([8,8*7,0]) side_holes(4);
        rotate([0,0,90]) translate([0,-8,0]) side_holes(8);
        rotate([0,0,90]) translate([0,-8*6,0]) side_holes(8);
        
        translate([24,20,5.7]) rotate([90,180,0]) stepperholes();    
        translate([2,21,9.9]) cube([44,4,20]);
     }
 }
 
//********************************************************

stepper_frame();
//translate([24,20,5.7]) rotate([90,180,0]) stepper(); 

//translate([0,0,0]) one_one_hook(1.33);
//translate([0,10,0]) one_one_hook(1.4);
//translate([10,0,0]) one_one_hook(1.45);
//translate([10,10,0]) one_one_hook(1.5);
//translate([20,0,0]) one_one_hook(1.55);
//translate([20,10,0]) one_one_hook(1.60);
//translate([10,10,0]) flat_thick(3,1);

//legs(19);
//translate([18,0,0]) legs(17);
//translate([-18,0,0]) legs(15);

//translate([0,0,0]) flat(2,2);
//translate([24,0,0]) flat(1,3);
//translate([40,0,0]) corner(3,3,1);
//translate([56,16,0]) flat(1,1);

