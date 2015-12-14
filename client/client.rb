require 'json'
require 'libmagellan'

MAGELLAN_CONSUMER_KEY = ENV['MAGELLAN_CONSUMER_KEY']
MAGELLAN_CONSUMER_SECRET = ENV['MAGELLAN_CONSUMER_SECRET']
MAGELLAN_CLIENT_VERSION = "DefaultStage1"
MAGELLAN_HTTP_SERVER = "https://nebula-001a-web.magellanic-clouds.net"
MAGELLAN_MQTT_SERVER_HOST = "nebula-001a-mqtt.magellanic-clouds.net"
MAGELLAN_MQTT_SERVER_PORT = 1883

class MagellanClient

  class << self
    def run(args)
      instance = MagellanClient.new
      instance.run(args)
    end
  end

  def run(args)
    command = args.shift
    if command
      case command.to_sym
      when :rooms then get_rooms()
      when :login then post_login(args)
      when :chat then publish_message(args)
      else help()
      end
    else
      help()
    end
  end

  private

  # Get rooms list.
  # @return
  def get_rooms
    rooms = parse_body(http_request("/rooms").body, [])
    rooms.each do |room|
      puts "[#{room['id'].to_s.rjust(2)}] #{room['name']}"
    end
  end

  # Enter room with username
  # @param [Array] Arguments
  def post_login(args)
    room_id = args.shift
    if room_id.nil? or room_id.empty?
      puts "Please enter room id"
      exit(0)
    end
    username = args.shift
    if username.nil? or username.empty?
      puts "Please enter your name"
      exit(0)
    end

    res = parse_body(http_request("/rooms/#{room_id}/users", :post, {name: username}).body, {})
    if res['result']
      puts "Login Success"
      # Start subscribe
      target_topic = "worker/rooms/#{room_id}"
      client.subscribe(target_topic) do |topic, message|
        puts "[#{topic}] #{message}"
      end
    else
      error = res['error']
      puts "Login Failured: #{error}"
    end
  end

  # Publish message to room
  # @param [Array] Arguments
  def publish_message(args)
    room_id = args.shift
    if room_id.nil? or room_id.empty?
      puts "Please enter room id"
      exit(0)
    end

    message = (args.shift || "").dup
    target_topic = "worker/rooms/#{room_id}"
    payload = {name: 'Tarou', message: message}.to_json
    client.publish(target_topic, payload)
  end
  
  # Create and return MAGELLAN client instance.
  # @return [Libmagellan] MAGELLAN client
  def client
    @client_ ||= Libmagellan.new(MAGELLAN_HTTP_SERVER,
                                 consumer_key: MAGELLAN_CONSUMER_KEY,
                                 consumer_secret: MAGELLAN_CONSUMER_SECRET,
                                 client_version: MAGELLAN_CLIENT_VERSION,
                                 mqtt_host: MAGELLAN_MQTT_SERVER_HOST,
                                 mqtt_port: MAGELLAN_MQTT_SERVER_PORT)
  end

  def http_request(path, method=:get, body="", headers={})
    client.request(path, method, body, headers)
  end

  def parse_body(body, default_value=nil)
    JSON.parse(body)
  rescue JSON::ParserError
    default_value
  end

  # Show help
  def help
    puts <<__HELP__
Usage:

  $ bundle exec ruby client.rb COMMAND [ARGS,]

Commands:

  client.rb rooms       # Get rooms list

__HELP__
  end

end

MagellanClient.run(ARGV.dup)
