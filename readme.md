# Food Project

## Tools

For this project I use :    
- Haml (Html preprocessing)
- SCSS/SASS (CSS preprocessing)
- CoffeeScrip (JavaScript preprocessing)
- BoostrapCSS (framework css) | note : need to be deleted
- AngularJS Material Design (framework css)
- AngularJS (framework JS, v1.3.x)
- Rails (v4.1.4)

## Clone depot, Init & Start

### Clone & Initialization

Clone the depot :    
`$ git clone git@github.com:Manawasp/nourriture-frontend-app.git`    

Initialization :    
```
$ bundle install
$ rake bower:instal
```

### Start

*Don't forget to run the api server & mongodb*    


Run server :
`rails s`    

And go to [http://localhost:3000](localhost:3000)    

### Start in development

You need to add `guard start` to compile html.haml in app/assets/templates -> public/templates

## Source

- [food api documentation](http://docs.foodapicn.apiary.io/)
- [food api server](https://github.com/ftb59/Nourriture)
- [installation Rails via RVM - recommended](http://doc.ubuntu-fr.org/rubyonrails)
- [AngularJS](http://angularjs.org)
- [Material Design for AngularJS](http://material.angularjs.org)
- [BootstrapCSS](http://getbootstrap.com/)