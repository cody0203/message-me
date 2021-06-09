class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'

    if current_user
      current_user.online = true
      current_user.save!
      @users = User.all
      ActionCable.server.broadcast 'appearance_channel', { users: @users }
    end
  end

  def unsubscribed
    if current_user
      current_user.online = false
      current_user.save!
      @users = User.all
      ActionCable.server.broadcast 'appearance_channel', { users: @users }
    end
  end
end
