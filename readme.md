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

Install `npm` (and also `node.js`), `Ruby on Rails` (via `RVM` if possible)

Clone the depot :
`$ git clone git@github.com:Manawasp/nourriture-frontend-app.git`

I use bower so you should to install it :
`$ npm install bower`

Initialization :
```
$ bundle install
$ rake bower:instal
```

### Start in development

**Don't forget to run the [api server](https://github.com/Manawasp/goodrecipes-api)**

Run server :
`rails s -p 3000`

And go to [localhost:3000](http://localhost:3000)

You need to add `guard start` to compile html.haml in app/assets/templates -> public/templates

## Source

- [food api documentation](http://docs.foodapicn.apiary.io/)
- [food api server](https://github.com/ftb59/Nourriture)
- [installation Rails via RVM - recommended](http://doc.ubuntu-fr.org/rubyonrails)
- [AngularJS](http://angularjs.org)
- [Material Design for AngularJS](http://material.angularjs.org)
- [BootstrapCSS](http://getbootstrap.com/)
