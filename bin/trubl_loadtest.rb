require 'trubl'

client_id = ENV["CLIENT_ID"]
client_secret = ENV["CLIENT_SECRET"]
callback_url = ENV["CALLBACK_URL"]
user_email = ENV['API_TEST_CLIENT_USER_EMAIL']
password = ENV['API_TEST_CLIENT_USER_PASSWORD']
auth_site = ENV['AUTH_SITE']
uri_host = ENV['URI_HOST']

usersfile = File.open("usernames.txt")
usersarray = Array.new

until usersfile.eof
  u = usersfile.readline
  usersarray << u.strip
end

usersfile.close


usersarray.each do |u|
  puts "\n \n \n now creating Touts as user #{u} \n \n \n"

  client = Trubl.client(client_id, client_secret, callback_url, email: u, password: password, auth_site: auth_site, uri_host: uri_host)
  client.user_auth()

  htfile = File.open("hashtags.txt")
  htarray = Array.new

  until htfile.eof
    htarray << htfile.readline
    end

  htfile.close

  puts "\n \n \n now creating #{htarray.count} touts \n \n \n"

  htarray.each do |i|
    timestamp = Time.now.to_s
    hashtag = i
    tdesc = "#" + hashtag + " " + timestamp
    file = File.open("test.mp4")
    payload = {tout: { data: file, text: tdesc}}
    tout = client.create_tout(payload)
  #  puts tout
    file.close
  end

end