original:

repo: https://github.com/bodrovis/Sitepoint-source/tree/master/Chat_with_ActionCable_and_Devise

web: https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/

creo que los pasos desde ahi para poder ejecutarlo fueron:

obviamente ya tengo ruby 2.3.1p112 y Rails 5.1.3 ya instalados

bundle install

rails generate devise:install
rails generate devise User
rails generate devise:views
rails db:migrate

sobre la db, estos comandos son mas probables(segun los apuntes de Matias Vives):

rake db:create
rake db:reset db:migrate


hasta aca es lo basico, hay un tipo fosuserbundle de symfony que se llama devise, permite
-logearse
-crear usuarios
-cambiar contraseña
-etc

una seccion para crear room chats y enviar texto

los demas usuarios entran al room y hacen lo mismo

CAMBIOS PRINCIPALES A HACER:

los room chat son publicos, uno lo crea, cualquiera lo ve y se mete (WRONG!) quiero que sea privado, so...
-uno crea un room e invita solo a los usuarios con los que quiere escribir (OK)
-solo esos usuarios pueden enviar texto (OK)
-nadie que no este invitado puede siquiera ver el room (OK)

los mensajes se guardan en la db en texto plano (WRONG!) quiero que sea privado privado, so...
-hay que encriptar, despues se ve si con encriptacion asimetrica, simetrica o alguna otra que encuentre por ahi

CAMBIOS no tan PRINCIPALES A HACER:
-menu bonito en el header con opciones de navegacion(OK)
-la identificacion de los usuarios es por email, podrian loguearse solo con correos del dominio de la empresa, en vez de gmail, outlook, etc (por ahora solo puse que el email no se puede editar)

https://stackoverflow.com/questions/26721790/rails-configuration-secret-key-base-returning-nil/26722044#26722044
http://api.rubyonrails.org/classes/ActiveSupport/MessageEncryptor.html
https://stackoverflow.com/questions/5492377/encrypt-decrypt-using-rails

dentro de un controlador, render plain: params[:paramentro].inspect es como el var_dump de php
en la vista <%= link_to 'somewhere', image, method: :delete, data: {confirm: 'seguro?'}%>