require_relative 'time_format'

class App

  def call(env)
    @request = Rack::Request.new(env)
    time_format
  end

  private

  def time_format
    return not_found unless @request.get? && @request.path == '/time'
    format = TimeFormat.new(@request.params)
    format.time_call

    if format.success?
      result(format)
    else
      unknown_format(format)
    end
  end

  def result(format)
    build_response(200, format.time)
  end

  def unknown_format(format)
    build_response(400, "Unknown time format [#{format.invalid_formats.join('-')}]")
  end

  def not_found
    build_response(404, 'Not found!')
  end

  def build_response(status, body)
     Rack::Response.new(body, status, {'Content-Type' => 'text/plain'}).finish
  end
end
