class TimeFormat
  attr_reader :time_formatted

  AVAILABLE_FORMATS = {
    year:   '%Y',
    month:  '%m',
    day:    '%d',
    hour:   '%H',
    minute: '%M',
    second: '%S'
  }

  def call(params)
    @time_formatted = []
    @invalid_formats = []
    formats = params.split(",")

    time_check(formats)
    return wrong_format unless @invalid_formats.empty?
  end

  def time_check(formats)
    time = []
    formats.each do |format|
      AVAILABLE_FORMATS.has_key?(format) ? time << Time.now.strftime(AVAILABLE_FORMATS[format]) : @invalid_formats << format
    end
    @time_formatted = time.join("-")
  end

  def wrong_format
    @wrong_format = true
    @time_formatted = "Unknown time format: #{@invalid_formats}\n"
  end

  def wrong_format?
    @wrong_format
  end
end
