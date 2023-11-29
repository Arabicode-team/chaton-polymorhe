class UserMailer < ApplicationMailer
    default from: ENV['MAILJET_DEFAULT_FROM']
  
    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'https://piece-of-shit.fly.dev/users/new' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end

    # def new_guest_email(attendance)
    #   @attendance = attendance
    #   @user = attendance.user
    #   @event = attendance.event
    #   @url  = 'https://piece-of-shit.fly.dev/users/new' 
    #   mail(to: @user.email, subject: 'New Guest Confirmation')
    # end
  end