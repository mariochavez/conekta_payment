# ConektaPayment
ConektaPayment es un Rails engine para procesar pagos a través del servicio [Conekta.io](http://conekta.io).

Este Rails engine se encarga de Tokenizar la información de la tarjeta bancaria para evitar guardar la información en nuestra aplicación y delegar tal responsabilidad a Conekta.io.

##### NOTA: Este proyecto es un `spike` de unas cuantas horas para hacerlo funcionar, aún está incompleto y necesita un poco más de trabajo.

## Cómo usar ConektaPayment?
Actualemente ConektaPayment no ha sido liberado en Rubygems, así que si deseas utilizarlo en tu proyecto tienes que agregar la referencia en tu _Gemfile_ de la siguiente forma:

    gem 'conekta_payment', github: 'mariochavez/conekta_payment'

Antes de iniciar tu servidor de Rails hay que poner en las siguientes variables de ambiente las llaves pública y privada que obtienes al resgistrarte en Conekta.io

    export CONEKTA_PUBLIC_KEY='mi llave publica'
    export CONEKTA_PRIVATE_KEY='mi llave privada'

Para tener acceso al engine desde tu aplicación de Rails es necesario montar el engine en tu archivo de rutas como sigue:

    Rails.application.routes.draw do
      mount ConektaPayment::Engine => "/conekta_payment"
    end

En donde `/conekta_payment/pagar` es la URL de acceso, obviamente esta puede cambiar a algo que haga más sentido en tu aplicación, por ejemplo:

    Rails.application.routes.draw do
      mount ConektaPayment::Engine => "/procesar"
    end

Este engine espera que tu `ApplicationController` exponga el método `shopping_cart_hash` con la información de tu carrito de compras como se muestra a continuación, este `hash` es utilizado para mostrar en la página de confirmación lo que el cliente esta comprando y calcular el total a cobrar.

    def shopping_cart_hash
      {
        cart_id: 1,
        subtotal: 200.00,
        description: 'Compra de eBooks Aprendiendo Ruby on Rails 4.0',
        items: [
          {
            product_id: 1,
            name: 'eBook Aprendiendo Ruby on Rails 4.0',
            price: 200.00,
            quantity: 1
          }
        ]
      }
    end

![conekta_payment](https://cloud.githubusercontent.com/assets/59968/5365083/707c5b58-7fae-11e4-9ac0-b2d24e308449.png)

## Personalización
Para personalizar el `look & feel` de la aplicación sólo es neceasario recrear las vistas del engine dentro de `views/conekta_payment` y poner tu lado creativo en ellas ;)

## Problemas?
Por favor usar los issues aquí en Github para reportar cualquier problema.

## Contribuir
Con mucho gusto acepto Pull requests con pruebas y con información detalla de que es lo que estas tratando de solucionar. El objetivo de esta engine es que no tener que pensar en el procesamiento de pagos y que simplemente pase, el poder agregarla a un proyecto y en custion de minutos ya poder aceptar pagos electrónicos.

## License
This project rocks and uses MIT-LICENSE.
