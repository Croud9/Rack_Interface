class TimeFormat
  attr_reader :invalid_formats

  AVAILABLE_FORMATS = {
    year:   '%Y',
    month:  '%m',
    day:    '%d',
    hour:   '%H',
    minute: '%M',
    second: '%S'
  }

  def initialize(params)
    @time_formatted = []
    @invalid_formats = []
    @formats = params['format'].split(",")
  end

  def time_call
    @formats.each do |format|
      AVAILABLE_FORMATS[format] ? @time_formatted << AVAILABLE_FORMATS[format] : @invalid_formats << format
    end
  end

  def time
    Time.now.strftime(@time_formatted.join('-'))
  end

  def success?
    @time_formatted.empty?
  end
end
