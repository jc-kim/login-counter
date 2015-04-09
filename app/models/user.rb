class User < ActiveRecord::Base
  validate :username_validate, :password_validate

  def username_validate
    if username.nil?
      errors.add(:username, {code: -1})
      return
    end
    unless 5 <= username.length and username.length <= 20
      errors.add(:username, {code: -1})
      return
    end
    unless User.where(username: username).count == 0
      errors.add(:username, {code: -3})
      return
    end
  end

  def password_validate
    if password.nil?
      errors.add(:password, {code: -2})
      return
    end
    unless 8 <= password.length and password.length <= 20
      errors.add(:password, {code: -2})
      return
    end
  end

  def error_code
    return errors[:username][0][:code] if errors[:username].length > 0
    return errors[:password][0][:code] if errors[:password].length > 0
    return nil
  end
end
