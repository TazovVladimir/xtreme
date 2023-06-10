<script setup>
import mainHeader from './components/header.vue'
import mainMain from './components/main.vue'
import mainFooter from './components/footer.vue'
</script>

<script>
export default {
  data() {
    return {
      
    }
  },
  components:{
    mainHeader,
    mainFooter,
    mainMain
  }
}
</script>

<template>
  <mainHeader v-if="!$route.meta.hideHeader" />
  <mainMain />
  <mainFooter v-if="!$route.meta.hideHeader" />
</template>

<style scoped>

</style>
