class TwoFactor < ActiveRecord::Base
  belongs_to :member

  before_validation :gen_code, on: :create
  after_update :send_notification

  validates_presence_of :member, :otp_secret, :refreshed_at

  attr_accessor :otp

  SUBCLASS = ['app', 'sms', 'email', 'wechat']

  validates_uniqueness_of :type, scope: :member_id

  scope :activated, -> { where(activated: true) }
  scope :require_signin, -> { where(require_signin: 1) }

  class << self
    def by_type(type)
      return if not SUBCLASS.include?(type.to_s)

      klass = "two_factor/#{type}".camelize.constantize
      klass.find_or_create_by(type: klass.name)
    end

    def activated?
      activated.any?
    end

    def require_signin?
      require_signin.any?
    end
  end

  def verify?
    msg = "#{self.class.name}#verify? is not implemented."
    raise NotImplementedError.new(msg)
  end

  def expired?
    Time.now >= 30.minutes.since(refreshed_at)
  end

  def refresh!
    gen_code
    save
  end

  def active!
    update activated: true, last_verify_at: Time.now
  end

  def set_require_signin
    update require_signin: 1
  end

  def reset_require_signin
    update require_signin: nil
  end

  def deactive!
    update activated: false, require_signin: nil
  end

  private

  def gen_code
    msg = "#{self.class.name}#gen_code is not implemented."
    raise NotImplementedError.new(msg)
  end

  def send_notification
    msg = "#{self.class.name}#send_notification is not implemented."
    raise NotImplementedError.new(msg)
  end

end
