helpers do
  def cdnjs_library(cdnjslib)
    cdnjslib = ('//cdnjs.cloudflare.com/ajax/libs/'+cdnjslib) unless cdnjslib[0..1] == '//'
    %Q{<script src="#{cdnjslib}" type="text/javascript"></script>}
  end
end