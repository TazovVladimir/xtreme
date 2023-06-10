import { createApp } from 'vue'
import App from './App.vue'
import router from "./routes/router"
import "@/axios"
import store from './store'
import './assets/main.css'


import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'

library.add(fas)

// Vue.component('font-awesome-icon', FontAwesomeIcon)



createApp(App)
    .use(router)
    .use(store)
    .use(fas)
    .mount('#app')
