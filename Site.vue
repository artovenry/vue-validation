<template lang="pug">
  mixin errorsFor(attr)
    ul(v-show=`$store.state.${attr}.errors.length && $store.state.${attr}.notifying`)
      li(v-html="item" v-for=`item in $store.state.${attr}.errors`)
  form
    fieldset
      legend message
      input(type="text" v-model="message")
      +errorsFor("message")

    fieldset
      legend amount
      input(type="number" min="0"  max="10" v-model.number="amount")
      +errorsFor("amount")
    p
      input(type="button" @click="$store.commit('toggleAll')" value="validate")
</template>

<script lang="coffee">
  import model from "model"
  export default
    computed: do ->
      _.mapObject model, (item, attr)->
        get:      -> @$store.state[attr].value
        set: (val)-> @$store.commit "#{attr}/validate", val
</script>
