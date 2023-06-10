import { createRouter, createWebHistory } from "vue-router"
import mainPage from "../pages/mainPage.vue"
import notFoundPage from "../pages/notFoundPage.vue"
import accCart from "../pages/accCart.vue"
import auth from "../pages/auth.vue"
import reg from "../pages/reg.vue"
import clothes from "../pages/clothes.vue"
import shoes from "../pages/shoes.vue"
import inventory from "../pages/inventory.vue"

import cardItem from "../pages/cardItem.vue"
import admin from "../pages/admin.vue"
export default createRouter({
    history: createWebHistory(),
    routes: [
        // home
        { path: '/home', name: 'Главная страница', component: mainPage, alias: '/', meta: { hideHeader: false } },
        // pages-catalog
        { path: '/clothes', name: 'Каталог - ', component: clothes, meta: { hideHeader: false, cat_name: 'одежда' } },
        { path: '/shoes', name: 'Каталог -  ', component: shoes, meta: { hideHeader: false, cat_name: 'обувь' } },
        { path: '/inventory', name: 'Каталог -   ', component: inventory, meta: { hideHeader: false, cat_name: 'инвентарь' } },
        // page-id
        { path: '/card-item/:id', name: 'Карточка товара', component: cardItem, meta: { hideHeader: false } },
        // acc-routers
        { path: '/auth', component: auth, meta: { hideHeader: true } },
        { path: '/reg', component: reg, meta: { hideHeader: true } },
        { path: '/account', name: 'Аккаунт', component: accCart, meta: { hideHeader: false } },
        { path: '/admin', name: 'Админ', component: admin, meta: { hideHeader: false } },
        // 404
        { path: '/:pathMatch(.*)*', name: 'Ссылки не существует', component: notFoundPage, meta: { hideHeader: true } },

    ]
})