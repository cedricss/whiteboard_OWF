

##extern-type Canvas.surface = Cairo.image_surface
##extern-type Canvas.ctx = Cairo.t

##register create_surface : int, int -> Canvas.surface
let create_surface width height =
  Cairo.image_surface_create Cairo.FORMAT_ARGB32 ~width ~height


##register create : Canvas.surface -> Canvas.ctx
let create surface =
  let ctx = Cairo.create surface in
  Cairo.set_line_width ctx 4. ;
  Cairo.set_line_join ctx Cairo.LINE_JOIN_ROUND ;
  Cairo.set_line_cap ctx Cairo.LINE_CAP_ROUND ;
  ctx

##register save : Canvas.ctx -> void
let save ctx = Cairo.save(ctx)

##register restore : Canvas.ctx -> void
let restore ctx = Cairo.save(ctx)

##register to_data : Canvas.surface -> string
let to_data surface =
  let b = Buffer.create 10000 in
  Cairo_png.surface_write_to_stream surface (Buffer.add_string b);
  Buffer.contents b

##register draw : Canvas.ctx, float, float, float, float -> void
let draw ctx x1 y1 x2 y2=
  Cairo.move_to ctx x1 y1;
  Cairo.line_to ctx x2 y2;
  Cairo.close_path ctx ;
  Cairo.stroke ctx

(* Tranformations (default transform is the identity matrix) *)

##register scale: Canvas.ctx, float, float -> void
let scale c sx sy = Cairo.scale c ~sx ~sy

##register rotate: Canvas.ctx, float -> void
let rotate c angle = Cairo.rotate c ~angle

##register translate: Canvas.ctx, float, float -> void
let translate c tx ty = Cairo.translate c ~tx ~ty

##register set_stroke_style_color: Canvas.ctx, float, float, float -> void
let set_stroke_style_color c red green blue =
  Cairo.set_source_rgb c ~red ~green ~blue

##register set_line_width \ `Cairo.set_line_width` : Canvas.ctx, float -> void
