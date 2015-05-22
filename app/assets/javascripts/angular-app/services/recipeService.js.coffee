angular.module('app')
  .factory('recipeService', ($http, apiService) ->
      current_recipe = {}
      view = false
      searchObject = {recipe: {created_by: "", description: "", labels: [], blacklist: []}, labels: [{'c': false, 'name': 'breakfast & brunch'}, {'c': false, 'name': 'appetizer'}, {'c': false, 'name': 'dessert'}, {'c': false, 'name': 'healty'}, {'c': false, 'name': 'main dish'}, {'c': false, 'name': 'pasta'}, {'c': false, 'name': 'slow cooker'}, {'c': false, 'name': 'vegetarian'}, {'c': false, 'name': 'sauce'}, {'c': false, 'name': 'cheese'}, {'c': false, 'name': 'fruit'}, {'c': false, 'name': 'vegetable'}, {'c': false, 'name': 'sea food'}, {'c': false, 'name': 'fish'}, {'c': false, 'name': 'spicy'}, {'c': false, 'name': 'meat'}, {'c': false, 'name': 'chicken'}, {'c': false, 'name': 'beef'}], denied: [{'c': false, 'name': 'arachide'}, {'c': false, 'name': 'egg'}, {'c': false, 'name': 'milk'}, {'c': false, 'name': 'halal'}, {'c': false, 'name': 'kascher'}],data:{offset:0,limit:12,results:0,pagination:[]},more_recipe: []}


      return (
        updatePage: (value)->
          if value > 0
            searchObject.data.page    = value
            searchObject.data.offset  = (value - 1) * searchObject.data.limit
            this.getApplySearch(()->
              searchObject.data.pagination.length = 0
              console.log("updated... ? page:" + searchObject.data.page)
              n = searchObject.data.page - 4
              while (n < (searchObject.data.page + 4))
                if (n > 0 && ((n-1)*searchObject.data.limit) < searchObject.data.results)
                  searchObject.data.pagination.push n
                n += 1
            )
        getMoreRecipe: ()->
          return more_recipe
        getApplySearch: (callback)->
          this.search(searchObject.recipe.description,
                                    searchObject.data.offset,
                                    searchObject.data.limit,
                                    searchObject.recipe.created_by
          ).success((data) ->
            searchObject.more_recipe.length = 0
            searchObject.data.results = data.max
            for recipe in data.recipes
              searchObject.more_recipe.push recipe
            callback()
          ).error((data) ->
            console.log "error data in search ingredient"
            # console.log data
          )
        getSearchRecipe: () ->
          return searchObject.recipe
        getSearchHardReset: ()->
          this.getSearchReset()
          searchObject.recipe.description = ""
        getSearchReset: ()->
          searchObject.recipe.created_by = ""
          for label in searchObject.labels
            label.c = false
          for deny in searchObject.denied
            deny.c = false
          searchObject.recipe.labels.length = 0
          searchObject.recipe.blacklist.length = 0
        getSearch: () ->
          return searchObject
        create: (data) ->
          req = $http.post(apiService.url() + '/recipes/', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/recipes/' + idhash)
          return req
        search: (name, offset, limit, created_by) ->
          data = {}
          if name && name.length > 0
            data.title = name
          if offset
            data.offset = offset
          if limit
            data.limit = limit
          if created_by && created_by.length > 0
            data.created_by = created_by
          console.log(data)
          req = $http.post(apiService.url() + '/recipes/search', data)
          return req
        update: (data) ->
          req = $http.patch(apiService.url() + '/recipes/' + data.id, data)
          return req
        delete: (id) ->
          req = $http.delete(apiService.url() + '/recipes/' + id, {})
          return req
        image: (data) ->
          req = $http.post(apiService.url() + '/recipes/' + data.id + '/pictures', data)
          return req
          console.log(type)
        searchFavorite: (offset, limit)->
          req = $http.post(apiService.url() + '/favorites/search', {offset: offset, limit: limit})
          return req
        favorite: (id) ->
          req = $http.post(apiService.url() + '/favorites/recipes/' + id)
          return req
        unfavorite: (id) ->
          req = $http.delete(apiService.url() + '/favorites/recipes/' + id)
          return req
        setCurrent: (data) ->
          current_recipe = data
        getCurrent: () ->
          return current_recipe
        setView: (dview) ->
          view = dview
        getView: () ->
          return view
      )
  )
