module ApiV1Helpers
  def api_get(command, params = {})
    api_call(:get, command, params)
  end

  def api_post(command, params = {})
    api_call(:post, command, params)
  end

  def api_update(command, params = {})
    api_call(:put, command, params)
  end

  def api_call(method, command, params)
    send(method, "/api/v1/#{command}", params: params)
  end

  def parsed_response
    JSON.parse(response.body)
  end

  def expect_status(status)
    expect(parsed_response['status']).to eq status
  end
end