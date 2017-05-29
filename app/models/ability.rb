class Ability
  include CanCan::Ability


  # the class is automatically generated
  # the main thing is that there should be a 'current_user' method defined



  def initialize(user)
    #we define here all the rules and permissions to out application
    # Define abilities for the passed in user here. For example:


  #if user is not signed in, current_user will return nil so we set it to 'User.new' if user is not signed in to ease writing rules by simply doing 'user.id' which will return nil instead of raising an exception
  user ||= User.new

  alias_action :create, :read, :update, :destroy, to: :crud

  #this rule specifies that the user can crud a question if the question created is the same as user who is currently logged in
  #remember that this defined the rule but you still have to enforce the rule yourself by using it in your views and controllers

  if user.is_admin?
    can :manage, :all?
  end
  #manage option in cancancan gives the user the ability to do anything
  #and not just CRUD; it includes other actions such as publish, activate, disable, etc


  can :crud, Question do |question|
      question.user == user
    end

    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
