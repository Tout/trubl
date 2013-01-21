require 'tout'

# client init and auth
client = Tout.client("5fb8f651e3b0cc32b05c8615359dbe5b7d9ef72b97dac38ff97a189a87cacd31",
                                 "f678d51356c6299e564164ff5bdadfdaabcf545f957293411a4bacc249c3fb44",
                                 "http://localhost")

#fail()

# client_credential, read only
client.auth()

puts '######################'
puts '# me api usage'
puts '######################'
client.get_me()


puts '######################'
puts '# search api usage'
puts '######################'
collection = client.search_hashtags('lol', 2, 4)
p collection.pagination
p collection.hashtags
collection = client.search_users('aaron', 2, 4)
p collection.pagination
p collection.users
collection = client.search_touts('lol', 2, 4)
p collection.pagination
p collection.touts

puts '######################'
puts '# users api usage'
puts '######################'
collection = client.search_users('aaronterrell')
p collection.pagination
p collection.users
uid = collection.users[0].uid
p uid
user = client.retrieve_user(uid)
p user
p user.fullname
likes = client.retrieve_user_likes(uid)
p likes
collection = client.retrieve_user_touts(uid)
p collection.pagination
p collection.touts
collection = client.retrieve_user_followers(uid)
p collection.pagination
p collection.users

puts '######################'
puts '# touts api usage'
puts '######################'
collection = client.featured_touts()
p collection.pagination
p collection.touts
collection = client.latest_touts()
p collection.pagination
p collection.touts
conversation = client.retrieve_conversation("iummti53")
p conversation
