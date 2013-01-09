require 'tout'

# client init and auth
client = Tout.client("ad82fd3d54c5c6e6aec55042de3698b26564dcea48830904b97a1e77016dbbcb",
                                 "75264c828906dac3c67e2bb00ec824afc4505972bfbdc8a4be51128cd1aa2309",
                                 "http://qa.tout.com")
client.auth()

puts '######################'
puts '# me api usage'
puts '######################'
client.get_me()

=begin
puts '######################'
puts '# search api usage'
puts '######################'
client.search_hashtags('lol', 2, 4)
client.search_users('aaron', 2, 4)
client.search_touts('lol', 2, 4)

puts '######################'
puts '# users api usage'
puts '######################'
=end
collection = client.search_users('aaronterrell')
p collection
uid = collection.users[0].uid
user = client.retrieve_user(uid)
#p user
#p user.fullname
client.retrieve_user_likes(uid)
#touts = client.retrieve_user_touts(uid)
#users = client.retrieve_user_followers(uid)

collection = client.featured_touts()
p collection.touts
p collection.pagination

client.retrieve_conversation("iummti53")
