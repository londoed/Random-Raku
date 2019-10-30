###########################################
############### IMAGE NOISE ###############
###########################################

use NativeCall;
use SDL2::Raw;

my ($w, $h) = 320, 240;

SDL_Init(VIDEO);

my SDL_Window $window = SDL_Create_Window("White Noise", SDL_WINDOWPOS_CENTERED_MASK, SDL_WINDOWPOS_CENTERED_MASK, $w, $h, RESIZEABLE);
my SDL_Renderer $renderer = SDL_CreateRenderer($window, -1, ACCELERATED +| TARGETTEXTURE);
my $noise_texture = SDL_CreateTexture($renderer, %PIXELFORMAT<RGB332>, STREAMING, $w, $h);
my $pixdatabuf = CArray[int64].new(0, $w, $h, $w);

sub render {
  my $pitch;
  my $cursor;

  my $pixdata = nativecast(Pointer[int64], $pixdatabuf);
  SDL_LockTexture($noise_texture, SDL_Rect, $pixdata, $pitch);

  $pixdata = nativecast(CArray[int8], Pointer.new($pixdatabuf[0]));

  loop (my $row = 0; $row < $h; $row++) {
    loop (my $col = 0; $col < $w; $col++) {
      $pixdata[$cursor + $col] = Bool.roll ?? 0xff !! 0x0;
    }
    $cursor += $pitch;
  }

  SDL_UnlockTexture($noise_texture);
  SDL_RenderCopy($renderer, $noise_texture, SDL_Rect, SDL_Rect);
  SDL_RenderPresent($renderer);
}

my SDL_Event $event .= new;

main: loop {
  while SDL_PollEvent($event) {
    given $casted_event {
      when *.type == QUIT {
        last main;
      }
    }
  }
  render();
  say fps();
}

say '';

sub fps {
  state $fps_frames = 0;
  state $fps_now = now;
  state $fps = '';

  $fps_frames++;

  if now - $fps_now >= 1 {
    $fps = [-] "\b" x 40, ' ' x 20, "\b" x 20, sprintf("FPS: %5.2f ", ($fps_frames / (now - $fps_now)).round(0.01));
    $fps_frames = 0;
    $fps_now = now;
  }
  return $fps;
}
