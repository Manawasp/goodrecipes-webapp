angular.module('app').controller('ContactChipDemoCtrl', DemoCtrl);

function DemoCtrl ($timeout, $q, authorization, api, ingredientService) {
  var self = this;

  self.readonly = true;
  self.querySearch = querySearch;
  self.allContacts = loadContacts();
  self.contacts = ingredientService.getSearch();
  self.filterSelected = true;

  /**
   * Search for contacts.
   */
  function querySearch (query) {
    var results = undefined
    if (query && query.length > 0) {
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "http://localhost:8080/ingredients/search", false);
      xhr.setRequestHeader("Content-Type", "application/json")
      xhr.send(JSON.stringify({name:query, limit:4}));
      if(xhr.status == 200) {
        console.log("OKOKK")
        solution = JSON.parse(xhr.response)
        for (i = 0; i < solution.length; i++) {
          solution[i].image = solution[i].icon;
        }
        return solution.ingredients
      }
      else {
        console.log(xhr.status)
        console.log(xhr.body)
        console.log("PUTIAIN")
      }
      // data = ingredientService.search(query, [], [], [], 0, 10)
      // console.log("success: ")
      // console.log(data)
      // return data
    } else {
      console.log("else")
      return []
    }
    console.log("pas le temps")
    return []
  }

  /**
   * Create filter function for a query string
   */
  function createFilterFor(query) {
    var lowercaseQuery = angular.lowercase(query);

    return function filterFn(contact) {
      return (contact._lowername.indexOf(lowercaseQuery) != -1);;
    };

  }

  function loadContacts() {
    var contacts = [];

    return contacts.map(function (c, index) {
      var contact = {
        name: c.name,
        icon: c.icon
      };
      contact._lowername = contact.name.toLowerCase();
      return contact;
    });
  }
}
