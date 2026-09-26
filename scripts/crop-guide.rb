# Original handbook figures, cropped without redrawing. Coordinates: y, x, height, width.
require 'json'
root = File.expand_path('..', __dir__)
figures = {
 'stop'=>[28,1445,45,180,180], 'yield'=>[28,264,533,177,204],
 'wrong-way'=>[28,630,534,140,205], 'do-not-enter'=>[28,880,534,175,175],
 'railway'=>[28,1135,530,185,185], 'no-stop-tracks'=>[28,1420,532,230,190],
 'no-left'=>[31,320,584,174,174], 'no-right'=>[31,320,830,174,175],
 'no-uturn'=>[31,558,583,176,176], 'no-passing'=>[31,557,831,180,176],
 'left-only'=>[31,285,96,175,175], 'straight-only'=>[31,757,96,170,175],
 'red-light'=>[24,855,47,98,202], 'yellow-light'=>[24,414,534,94,202],
 'green-light'=>[24,1147,534,94,202],
 'right-of-way'=>[62,78,45,296,472], 'left-turn'=>[62,487,45,340,472],
 't-intersection'=>[62,78,532,289,470],
 'following-distance'=>[92,1385,46,252,955],
 'school-bus'=>[103,744,98,895,956],
 'trailer-turn'=>[123,64,533,418,468]
}
Dir.mkdir(root+'/assets/figures') unless Dir.exist?(root+'/assets/figures')
figures.each do |name,(page,y,x,h,w)|
 ok=system('sips','--cropToHeightWidth',h.to_s,w.to_s,'--cropOffset',y.to_s,x.to_s,root+format('/assets/guide/page-%03d.jpg',page),'--out',root+'/assets/figures/'+name+'.jpg',out:File::NULL)
 raise name unless ok
end
File.write(root+'/assets/figures/manifest.json',JSON.pretty_generate(figures.transform_values{|v| {pdfPage:v[0],printedPage:v[0]-2,crop:{y:v[1],x:v[2],height:v[3],width:v[4]},source:'../guide/alberta-driver-guide-2026.pdf'}}))
