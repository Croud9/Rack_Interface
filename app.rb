require_relative 'time_format'

class App

  def call(env)
    request = Rack::Request.new(env)
    reply = Rack::Response.new
    reply['Content-Type'] = 'text/plain'
    time_format(request.params, reply)
    reply.finish
  end

  private

  def time_format(params, reply)
    if params.has_key?('format')
      format = TimeFormat.new
      format.call(params['format'])
      if format.wrong_format?
        reply.status = 400
        reply.body = [format.formatted_time]
      else
        reply.status = 200
        reply.body = [format.formatted_time]
      end
    else
      reply.status = 404
      reply.body = ['Not Found']
    end
  end
end
