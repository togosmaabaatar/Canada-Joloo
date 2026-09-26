// macOS: osascript -l JavaScript scripts/extract-guide.js "$PWD"
// Render the original PDF pages using PDFKit; no generated or redrawn illustrations.
ObjC.import('Foundation'); ObjC.import('AppKit'); ObjC.import('PDFKit');
function run(args) {
 const root=args[0], doc=$.PDFDocument.alloc.initWithURL($.NSURL.fileURLWithPath(root+'/assets/guide/alberta-driver-guide-2026.pdf'));
 const begin=args[1]?Number(args[1]):1,end=args[2]?Number(args[2]):doc.pageCount;
 for(let i=begin;i<=end;i++){
  const page=doc.pageAtIndex(i-1),bounds=page.boundsForBox(0),width=1100,height=width*bounds.size.height/bounds.size.width;
  const thumb=page.thumbnailOfSizeForBox($.NSMakeSize(width,height),0);
  const bitmap=$.NSBitmapImageRep.imageRepWithData(thumb.TIFFRepresentation);
  const data=bitmap.representationUsingTypeProperties($.NSJPEGFileType,$({NSImageCompressionFactor:0.82}));
  data.writeToFileAtomically(root+'/assets/guide/page-'+String(i).padStart(3,'0')+'.jpg',true);
 }
 const texts={};
 for(let i=0;i<doc.pageCount;i++) texts[String(i+1)]=ObjC.unwrap(doc.pageAtIndex(i).string)||'';
 $(JSON.stringify(texts)).writeToFileAtomicallyEncodingError(root+'/assets/guide/pages.json',true,$.NSUTF8StringEncoding,null);
 return 'Rendered PDF pages '+begin+'–'+end+' and extracted accessible page text';
}
