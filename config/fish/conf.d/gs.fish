if type -q gs
    function pdf_compress_low
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$argv:r:r-compressed.pdf" $argv
    end

    function pdf_compress_medium
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$argv:r:r-compressed.pdf" $argv
    end

    function pdf_compress_high
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$argv:r:r-compressed.pdf" $argv
    end

    function pdf_compress_highest
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$argv:r:r-compressed.pdf" $argv
    end
end
