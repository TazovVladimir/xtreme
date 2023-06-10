import { createStore } from 'vuex'
import axios from 'axios'
const store = createStore({
    state: {
        sportItems: [
            { id: 0, img1: 'nikeImg1.png', img2: 'nikeImg2.png', img3: 'nikeImg3.png', img4: 'nikeImg4.png', img5: 'nikeImg5.png', category: 'Кроссовки', sex: 'female', title: 'Nike Odyssey React', text: 'Спортивные товары — группа товаров для всех видов физической культуры, туризма, спортивных занятий и игр. Включает инвентарь, оборудование, одежду и обувь', newPrice: 3230, oldPrice: 0, rating: 3.5, msg: 2, selected: false },
            { id: 1, img1: 'NikeVentureImg1.png', img2: 'NikeVentureImg2.png', img3: 'NikeVentureImg3.png', img4: 'NikeVentureImg4.png', img5: 'NikeVentureImg5.png', category: 'Кроссовки', sex: 'female', title: 'Nike Venture Runner', text: 'Спортивные товары — группа товаров для всех видов физической культуры, туризма, спортивных занятий и игр. Включает инвентарь, оборудование, одежду и обувь', newPrice: 6805, oldPrice: 8323, rating: 3.5, msg: 2, selected: false },
            { id: 2, img1: 'adidasFootballImg1.png', img2: 'adidasFootballImg2.png', img3: 'adidasFootballImg3.png', img4: 'adidasFootballImg4.png', img5: 'adidasFootballImg5.png', title: 'Adidas Speedflow Messi.1', category: 'Кроссовки', sex: 'male', text: 'Спортивные товары — группа товаров для всех видов физической культуры, туризма, спортивных занятий и игр. Включает инвентарь, оборудование, одежду и обувь', newPrice: 3544, oldPrice: 7654, rating: 3.5, msg: 2, selected: false },
            { id: 3, img1: 'adidasOZWEEGOimg1.png', img2: 'adidasOZWEEGOimg2.png', img3: 'adidasOZWEEGOimg3.png', img4: 'adidasOZWEEGOimg4.png', img5: 'adidasOZWEEGOimg5.png', title: 'Adidas OZWEEGO PURE', category: 'Кроссовки', sex: 'male', text: 'Спортивные товары — группа товаров для всех видов физической культуры, туризма, спортивных занятий и игр. Включает инвентарь, оборудование, одежду и обувь', newPrice: 3544, oldPrice: 7654, rating: 3.5, msg: 2, selected: false },
            { id: 4, img1: 'card1.png', img2: 'card2.jpg', img3: 'card3.jpg', img4: 'card4.jpg', img5: 'card5.jpg', title: 'Кроссовки Nike4', category: 'Кроссовки', sex: 'male', text: 'Споfdfdfdddddddddddddddddddd dddddddddddddddddd ddddddddddddddddddddd fdfdfd ртивfdfdfdfdные товары — fdfdгруппа товаров ddddddddd ddddfddddddddd dddddddddd ddдля всех видов физической культуры, туризма, спортивных занятий и игр. Включает инвентарь, оборудование, одежду и обувь', newPrice: 3544, oldPrice: 7654, rating: 3.5, msg: 2, selected: false },
        ],
        cartItems: [],
        user: false,

    },
    actions: {
        getCart(context, array) {
            context.commit('addCart', array)
        },
        removeSelectedItems({ commit }) {
            commit('removeSelectedItems')
        },
        setUserStatus({ commit }) {
            commit('setUser');
        },
        delUserStatus({ commit }) {
            commit('delUser');
        },
        setUserId() {
            const token = localStorage.getItem('token');
            const tokenParts = token.split('.');
            const payload = JSON.parse(atob(tokenParts[1]));
            if (token) {
                localStorage.setItem('user_id', payload.token_id);
            }
        },
        delUserId(){
            localStorage.removeItem('user_id');
        }
    },
    mutations: {
        addCart(state, item) {
            const existingItem = state.cartItems.find((i) => i.id === item.id);
            if (existingItem) {
                existingItem.quantity++;
            } else {
                state.cartItems.push({ ...item, quantity: 1 });
            }
        },
        updateCartItemQuantity(state, { item, quantity }) {
            const existingItem = state.cartItems.find((i) => i.id === item.id);
            if (existingItem) {
                existingItem.quantity++
            }
        },
        removeFromCart(state, item) {
            const existingItem = state.cartItems.find((i) => i.id === item.id);
            if (existingItem.quantity != 1) {
                existingItem.quantity--
            }
            else {
                return 1
            }
        },

        removeSelectedItems(state) {
            state.cartItems = state.cartItems.filter(item => !item.selected)
        },
        setUser(state) {
            state.user = true;
        },
        delUser(state) {
            state.user = false;
        },

    },
    getters: {
        getData(state) {
            return state.sportItems
        },
        getProduct: (state) => (id) => {
            return state.sportItems.find(item => item.id === id)
        },
        getCart(state) {
            return state.cartItems
        },
        cartTotal(state) {
            return state.cartItems.reduce((acc, item) => {
                return acc + (item.newPrice * item.quantity)
            }, 0)
        }
    },
})

export default store