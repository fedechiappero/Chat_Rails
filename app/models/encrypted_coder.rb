# lib/encrypted_coder.rb
# custom coder for Rails serialized attribute
# more examples: https://github.com/rails/rails/tree/4-2-stable/activerecord/lib/active_record/coders
# encrypted value has to be stored as base64 because it's not UTF-safe
class EncryptedCoder
  def load(value)
    return if value.nil?

    Marshal.load(
        Crypt.decrypt(
            Base64.decode64(value)))
  end

  def dump(value)
    Base64.encode64(
        Crypt.encrypt(
            Marshal.dump(value)))
  end
end