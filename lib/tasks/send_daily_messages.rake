desc "Send messages to friends of the day"
task :send_all_messages => :environment do
  User.all.each do |user|

  	if user.friends.where(fotd: true).count>0 && (user.get_friend_of_the_day)
  		the_fotd = user.get_friend_of_the_day
  		user.send_reminder
  		user.change_friend_of_the_day
  	end
  end
end


