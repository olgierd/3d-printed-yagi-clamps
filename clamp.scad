boom = 30.4;        // rozmiar boomu
szer = 38;          // szerokość uchwytu
dl = 30;            // długość uchwytu
wys = 26;           // wysokość uchwytu
zach = 6;           // zachodzi pod boom
d = 8.1;            // srednica elementu
el_nb = 13;         // środek elementu nad boomem
gp = 1.5;           // grubość podcięcia
sruba = 4.5;        // srednica sruby
zaokr = 3;          // promień zaokrąglenia
poz_el = 7;         // przesunięcie elementu, przód-tył
poz_sr = 0;         // przesunięcie śruby, przód-tył
nak_sr = 7;         // rozmiar nakrętki
nak_gl = 3;         // głębokość wycięcia pod nakrętkę
zas_sr = 0;         // średnica otworu zasilania
text = "D5";        // tekst
text_s = 5;         // rozmiar tekstu

// małe śruby trzymające element:
nak_el_sr = 5.5;    // rozmiar nakrętki
nak_el_sr_gl = 3;   // głębokość wycięcia na nakrętkę
el_sr = 3.3;        // średnica otworu na śrubę
ms_dist = 22;       // dystans między śrubami

///////////////////////////////////////////////////

$fn=80;

difference() {
    // uchwyt
    translate([0,0,wys/2-zach])
    minkowski() {
    cube([dl-zaokr*2, szer, wys-zaokr*2], center=true);
        rotate([90,0,0])
    cylinder(r=zaokr,h=0.00001, $fn=80);
    }

    // element
    color("red")
    translate([-poz_el,0,el_nb])
    rotate([90,0,0])
    cylinder(h=szer*2, d=d, center=true);

    // podcięcie
    translate([dl/2-poz_el,0,el_nb])
    color("red")
    cube([dl,szer*2,gp], center=true);

    // otwór pod śrubę
    translate([dl/4-poz_sr,0,0])
    color("green")
    cylinder(d=sruba, h=2*wys, center=true);
    
    
    // otwory pod śruby trzymające element
    for(x = [-1,1]) {
        translate([dl/4-poz_sr,ms_dist/2*x,0])
        color("green")
        cylinder(d=el_sr,h=2*wys, center=true);
        
        translate([dl/4-poz_sr,ms_dist/2*x,0])
        color("yellow")
        rotate([0,0,30])
        cylinder(d=nak_el_sr/sin(60)+0.1, h=nak_el_sr_gl*2, center=true, $fn=6);
    }

    // wycięcie nakrętki
    translate([dl/4-poz_sr,0,wys-zach])
    color("yellow")
    rotate([0,0,30])
    cylinder(d=nak_sr/sin(60)+0.1, h=nak_gl*2, center=true, $fn=6);

    // boom
    color("blue")
    translate([0,0,-boom/2])
    cube([4*boom, boom, boom], center=true);

    // wycięcie na podłączenie dipola
    if(zas_sr > 0) {
        color("gray")
        translate([-poz_el,0,el_nb])
        rotate([0,-90,0])
        cylinder(h=wys,d=zas_sr);
    }

    // tekst
    translate([0,0.85*(-szer/2),wys-zach])
    linear_extrude(height = 1, center = true) {
        rotate([0,0,90])
        text(text, size=text_s);
    }
}


