class PdfsController < ApplicationController
  def open_pdf
    pdf_path = params['path']
    full_path = File.expand_path(pdf_path)

    system("wsl-open #{full_path}")
  end
end
