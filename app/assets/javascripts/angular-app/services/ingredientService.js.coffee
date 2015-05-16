angular.module('app')
  .factory('ingredientService', ($http, $q, apiService) ->
      current_ingredient = {}
      ingredientsCarabage = []
      ingredientsSearchCarbage = []
      view = false
      searchState = {lock: true}

      return (
        setLock: (v)->
          searchState.lock = v
        getLock: ()->
          return searchState.lock
        clean: () ->
          ingredientsSearchCarbage.length = 0
        getSearch: () ->
          return ingredientsSearchCarbage
        create: (data) ->
          req = $http.post(apiService.url() + '/ingredients', data)
          return req
        get: (idhash) ->
          req = $http.get(apiService.url() + '/ingredients/' + idhash)
          return req
        search: (name, labels, savours, blacklist, offset, limit) ->
          data = {}
          if name && name.length > 0
            data.name = name
          if labels && labels.length > 0
            data.labels = labels
          if savours && savours.length > 0
            data.savours = savours
          if blacklist && blacklist.length > 0
            data.blacklist = blacklist
          if offset && offset.length > 0
            data.offset = offset
          if limit
            data.limit = limit
          req = $http.post(apiService.url() + '/ingredients/search', data).success((data) ->
            return data.ingredients
          ).error((data) ->
            return []
          )
          return req
        update: (data) ->
          req = $http.patch(apiService.url() + '/ingredients/' + data.id, data)
          return req
        image: (data) ->
          req = $http.post(apiService.url() + '/ingredients/' + data.id + '/pictures', data)
          return req
          console.log(type)
        setCurrent: (data) ->
          current_ingredient = data
        getCurrent: () ->
          return current_ingredient
        setView: (dview) ->
          view = dview
        getView: () ->
          return view
        garbageInit: (objTab)->
          ingredientsCarabage.splice(0,ingredientsCarabage.length)
          for key of objTab
            ingredientsCarabage.push objTab[key]
        garbageAdd: (obj)->
          ingredientsCarabage.unshift(obj)
        garbageUpdate: (obj)->
          console.log("UPDATE")
          for key of ingredientsCarabage
            if ingredientsCarabage[key].id == obj.id
              console.log("update works !")
              ingredientsCarabage[key] = obj
              return true
          console.log("pas marche...")
          return false
        garbage: () ->
          return ingredientsCarabage
      )
  )
