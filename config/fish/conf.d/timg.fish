if type -q timg
    set -gx TIMG_DEFAULT_TITLE "%b (%wx%h)"
    abbr ils 'timg --grid=3x1 --upscale=i --center --title --frames=1 -bgray -Bdarkgray *'
    abbr icat timg
end
