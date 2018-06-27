class PDF::Reader
  class Stream
    # Overrides: https://github.com/yob/pdf-reader/blob/master/lib/pdf/reader/stream.rb#L47-L68
    #
    # Disables the reading of stream objects. Makes the PDF Reader
    # Filter classes obsolete.
    #
    # Returns a string
    def unfiltered_data
      ''
    end
  end
end
