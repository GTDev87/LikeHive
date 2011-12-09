class User
  include Mongoid::Document
  authenticates_with_sorcery!

  embeds_one :profile, class_name: "UserProfile"
  accepts_nested_attributes_for :profile
  validates_presence_of :profile
  attr_accessible :profile_attributes
  
  embeds_one :habitation, class_name: "UserHabitation"
  accepts_nested_attributes_for :habitation
  validates_presence_of :habitation
  attr_accessible :habitation_attributes

  embeds_one :personality, class_name: "UserPersonality"
  validates_presence_of :personality
  accepts_nested_attributes_for :personality
  attr_accessible :personality_attributes

  embeds_one :mailbox, class_name: "UserMailbox"
  validates_presence_of :mailbox
  accepts_nested_attributes_for :mailbox
  attr_accessible :mailbox_attributes
  
  embeds_one :network, class_name: "UserNetwork"
  validates_presence_of :network
  accepts_nested_attributes_for :network
  attr_accessible :network_attributes
  
  field :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, :presence => true, :email => true
  validates_presence_of :email
  attr_accessible :email
  
  field :username
  validates_uniqueness_of :username
  validates_presence_of :username
  attr_accessible :username

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  attr_accessible :password
  
  attr_accessible :password_confirmation, :remember_me
  
  #virtual attributes
  attr_accessible :virtual_like_box, :virtual_like_name
  attr_accessor :virtual_like_name, :virtual_like_box
  
  after_save :assign_like
  after_save :assign_multiple_likes
  
  after_create :initialize_mailbox#HACK KILL THIS LATER WHEN MONGOID IS COMPETNENT  
  
  def add_likes(likes_names)
    @personality.get_new_likes(likes_names).each do |like|
      UserLikeLinker.link_user_and_like(self, like)
    end
  end
  
  def add_like(like_name)
    UserLikeLinker.link_user_and_like(self, self.personality.get_new_like(like_name))    
  end  
  
private
  def initialize_mailbox
    #####################HACK THIS IS A TEMPORARY METHOD TILL MONGOID FIX #900 ###################
    #######################HACK NEED TO FIND WAY OF AUTOINITIALIZING MAILBOX#################
    if self.mailbox == nil
      self.create_mailbox
      self.mailbox.user = self
      self.mailbox.save!
    end
    if self.network == nil
      self.create_network
      self.network.user = self
      self.network.save!
    end
  end
  
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
  end  
  
  def assign_multiple_likes
    #maybe move sanitization up to here
    if @virtual_like_box == nil then return end
    virtual_likes_names = StringFormatter.lowercase(@virtual_like_box)
    @virtual_like_box = nil
    add_likes(virtual_likes_names)
  end
  
  def assign_like
    #maybe move sanitization up to here and here
    if @virtual_like_name == nil then return end
    virtual_like_name = StringFormatter.lowercase(@virtual_like_name)
    @virtual_like_name = nil
  
    add_like(virtual_like_name)
  end  
end

