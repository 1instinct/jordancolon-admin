module ConversationHelper
  def fetch_users(user_hash)
    user_hash = [user_hash[:sender_id],user_hash[:sender_type], user_hash[:receiver_id], user_hash[:receiver_type]]
    users = []
    if user_hash.second == "Spree::User"
      user_1 = Spree::User.find_by_id(user_hash.first)
      users << {
        type: 'User',
        id: user_1&.id,
        name:  user_1&.email
      }
    elsif user_hash.second == "Contact"
      user_1 = Contact.find_by_id(user_hash.first)
      users << {
        type: 'Contact',
        id: user_1&.id,
        name:  user_1&.full_name
      }
    end
    if user_hash.fourth == "Spree::User"
      user_2 = Spree::User.find_by_id(user_hash.third)
      users << {
        type: 'User',
        id: user_2&.id,
        name:  user_2&.email
      }
    elsif user_hash.fourth == "Contact"
      user_2 = Contact.find_by_id(user_hash.third)
      users << {
        type: 'Contact',
        id: user_2&.id,
        name:  user_2&.email
      }
    end
    return users
  end

  def fetch_users_from_message(message_id)
    message = Message.find_by_id(message_id)
    users = []
    if message.sender_type == "Spree::User"
      users << {
        type: 'User',
        id: message&.sender&.id,
        name:  message&.sender&.email
      }
    elsif message.sender_type == "Contact"
      users << {
        type: 'Contact',
        id: message&.sender&.id,
        name: message&.sender&.full_name
      }
    end
    if message.receiver_type == "Spree::User"
      users << {
        type: 'User',
        id: message&.receiver&.id,
        name:  message&.receiver&.email
      }
    elsif message.receiver_type == "Contact"
      users << {
        type: 'Contact',
        id: message&.receiver&.id,
        name: message&.receiver&.full_name
      }
    end
    puts "********************#{users.inspect}"
    return users
  end

  def fetch_user(user)
    if user.class.to_s == "Spree::User"
      user = Spree::User.find_by_id(user)
      user = {
        type: 'User',
        id: user&.id,
        name:  user&.email
      }
    elsif user.class.to_s == "Contact"
      user_1 = Contact.find_by_id(user.id)
      user = {
        type: 'Contact',
        id: user&.id,
        name:  user&.full_name
      }
    end
    return user
  end
end
