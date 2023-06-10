<script>
export default {
    data() {
        return {
            count: 1,
            allSelected: false,
            user_id: localStorage.getItem('user_id'),
            account_info: null,
            revs: null,
            cart: null,
            order: null,
            order_completed: null,
            errors: false,
            order_status_comp: true,
            check_agree: false,
            points: '',
            modalOrder: false,

        }
    },
    computed: {
        isValid(){
            return this.check_agree && this.points !== '';
        },
        getReviews() {
            axios.get(`/get-reviews-user/${this.user_id}`)
                .then(response => {
                    this.revs = response.data
                })
                .catch(error => {
                    console.log(error)
                    return this.revs == null
                });
            return this.revs
        },
        revsLenght() {
            if (this.getReviews === null) {
                return 0
            } else {
                return this.getReviews.length
            }
        },


        orderLenght() {
            if (this.getOrders === null) {
                return 0
            } else {
                return this.getOrders.length
            }
        },
        order_completedLenght() {
            if (this.getOrdersCompleted === null) {
                return 0
            } else {
                return this.getOrdersCompleted.length
            }
        },



        getCart() {
            axios.get(`/get-cart/${this.user_id}`)
                .then(response => {
                    this.cart = response.data
                })
                .catch(error => {
                    console.log(error)
                });
            return this.cart
        },
        getOrders() {
            axios.get(`/get-orders/${this.user_id}`)
                .then(response => {
                    this.order = response.data
                })
                .catch(error => {
                    console.log(error)
                });
            return this.order
        },
        getOrdersCompleted() {
            axios.get(`/get-orders-completed/${this.user_id}`)
                .then(response => {
                    this.order_completed = response.data
                })
                .catch(error => {
                    console.log(error)
                });
            return this.order_completed
        },
        cardTotal() {
            const selectedProducts = this.getCart.filter(item => item.selected == 'true');
            let total = 0;
            selectedProducts.forEach(item => {
                const price = item.price;
                const quantity = item.quantity;
                const itemTotal = price * quantity;
                total += itemTotal;
            });
            return total.toLocaleString();

        },
        cartLength() {
            const cartLengths = this.getCart.filter(item => item.selected == 'true');
            let total = 0;
            cartLengths.forEach(item => {
                const quantity = item.quantity;
                total += quantity;
            });
            return total;
        },
        cartLengthAll() {
            if (this.getCart === null) {
                return 0
            } else {
                return this.getCart.length
            }
        },

    },
    methods: {
        order_status_active() {
            this.order_status_comp = true
        },
        order_status_completed() {
            this.order_status_comp = false
        },
        selectItem(item) {
            if (item.selected == true) {
                axios.put(`/items-check/${item.id}`, { selected: 'true', user_id: item.user_id })
                    .then((response) => {
                    })
                    .catch(error => {
                        console.log(error);
                    });

            } else {
                axios.put(`/items-check/${item.id}`, { selected: 'false', user_id: item.user_id })
                    .then((response) => {
                    })
                    .catch(error => {
                        console.log(error);
                    });
            }

        },
        close_btn_alert() {
            this.errors = false
        },
        removeSelectedItems() {
            const selItems = this.getCart.filter(item => item.selected == 'true');
            let array = []
            selItems.forEach(item => {
                array.push(item)
            });
            if (array !== []) {
                axios.post('/del-into-cart/', { items: array })
                    .then(response => {
                        console.log(response)
                    })
                    .catch(error => {
                        console.log(error)
                    });
            }
        },
        selectAllItems() {
            if (this.allSelected) {
                axios.post(`/items-check-all/${this.user_id}`, { selected: 'true' })
                    .then((response) => {
                        // console.log(response);
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }
            else {
                axios.post(`/items-check-all/${this.user_id}`, { selected: 'false' })
                    .then((response) => {
                        // console.log(response)
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }

        },
        updateQuantity(id) {
            axios.post('/quantity-plus/', {
                item_id: id.item_id,
                user_id: this.user_id,
            })
                .then((response) => {
                    console.log(response);
                })
                .catch((error) => {
                    console.log(error);
                    this.errors = true
                });
        },
        removeFromCart(id) {
            axios.post('/quantity-minus/', {
                item_id: id.item_id,
                user_id: this.user_id,
            })
                .then((response) => {
                    // console.log(response);
                })
                .catch((error) => {
                    console.log(error);
                });
        },






        btn_del_all() {
            this.btn_del = true
        },
        logout() {
            localStorage.removeItem('token');
            localStorage.removeItem('user_id');
            this.account_info = [];
            this.$store.dispatch('delUserStatus');
            this.$router.push('/')
        },
        async file() {
            const file = await this.$refs.fileInput.files[0];
            const formData = await new FormData();
            formData.append('avatar', file);
            await axios.post(`/update-avatar/${this.user_id}`, formData);
            axios.get(`/account/${this.user_id}`)
                .then(response => {
                    this.account_info = response.data
                })
                .catch(error => (console.log(error)));
        },
        handleFileChange() {
            this.$refs.av_form.submit();
        },
        async delRev(id, index) {
            try {
                await axios.delete(`/del-rev/${id}`)
                this.revs.splice(index, 1);
            } catch (error) {
                console.error(error);
            }
        },
        addToOrders() {
            axios.post('/add-to-orders/', {
                user_id: this.user_id,
                points: this.points,
            })
                .then((response) => {
                    console.log(response);
                    this.modalOrder = true
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        closeModalOrder(){
            this.modalOrder = false
        }

    },
    mounted() {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        axios.get(`/account/${this.user_id}`)
            .then(response => {
                this.account_info = response.data
            })
            .catch(error => (console.log(error)));

        const data = localStorage.getItem('token');
        if (!data) {
            this.$router.push('/auth');
        }
    }
}
</script>
<template>
    <div class="alert_add_to_cart_wrapper" :class="{ alert_add_to_cart_wrapper_open: errors }">
        <div style="padding: 65px 120px;" class="alert_add_to_cart_obj" :class="{ alert_add_to_cart_obj_open: errors }">
            <span class="alert_add_to_cart_ok_wrapper">
                <i style="font-size: 100px !important; font-weight: 200 !important; top: 18%; left: 18%;"
                    class='alert_ok bx bx-search bx-tada'></i>
            </span>
            <span class="alert_add_to_cart_text" style="margin-bottom: 0;">
                Товара больше нет
            </span>
            <span class="btn_close_modal" @click="close_btn_alert">
                <i class='bx bx-x'></i>
            </span>
        </div>
    </div>
    <div class="alert_add_to_cart_wrapper" :class="{ alert_add_to_cart_wrapper_open: modalOrder }">
        <div style="padding: 65px 120px;" class="alert_add_to_cart_obj" :class="{ alert_add_to_cart_obj_open: modalOrder }">
            <span class="alert_add_to_cart_ok_wrapper">
                <i class='alert_ok bx bx-check'></i>
            </span>
            <span class="alert_add_to_cart_text" style="margin-bottom: 0;">
                Заказ оформлен
            </span>
            <span class="btn_close_modal" @click="closeModalOrder">
                <i class='bx bx-x'></i>
            </span>
        </div>
    </div>
    <div class="acc-wrapper">
        <div class="acc-acc">
            <span class="acc-acc-theme" style="padding: 0;" title="изменить аватарку">
                <form>
                    <label for="update-a" class="custom-file-upload">
                        <input id="update-a" type="file" ref="fileInput" accept="image/*" @change="file">
                        <i class='bx bx-pencil bx-sm'></i>
                    </label>
                    <button style="display: none;" type="submit">изменить</button>
                </form>
            </span>
            <span class="acc-acc-avatar-wrapper">
                <span class="acc-acc-avatar-wrapper-wrapper">
                    <img v-for="item in account_info" :src="'http://localhost:5000/uploads/' + item.avatar" alt="">
                </span>
                <span v-for="item in account_info" class="acc-acc-avatar-wrapper-name">
                    {{ item.name }}
                </span>
                <span class="acc-acc-avatar-wrapper-role">
                    пользователь
                </span>
            </span>
            <span class="acc-acc-logout" @click="logout">
                <i class='bx bx-exit bx-sm'></i>
            </span>
        </div>
    </div>
    <div class="u-rev-wrapper">
        <div class="u-rev-left">
            <div class="posted-rev">
                <h3 class="h3-catalog-title" style="padding-top: 20px !important; font-size: 18px; font-weight: 400;">Ваши
                    отзывы</h3>
                <ul class="posted-rev-ul">
                    <li class="posted-rev-item" v-for="(item, index) in getReviews" :key="index" v-if="revsLenght !== 0">
                        <div class="post-rev-right">
                            <i @click="delRev(item.id, index)" class='bx bx-trash bx-sm'></i>
                            <span class="post-rev-right-name">
                                {{ item.item_title }} <span class="post-rev-date">{{ item.date.slice(0, 10) }}</span>
                            </span>
                            <p class="posted-rev-p">
                                {{ item.text }}
                            </p>
                        </div>
                    </li>
                    <li class="posted-rev-item" v-else>
                        <div class="post-rev-right">
                            <p class="posted-rev-p" style="text-align:center;">
                                Новых отзывов нет
                            </p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="u-rev-right">
            <div class="posted-rev">
                <h3 class="h3-catalog-title"
                    style="padding-top: 20px !important; font-size: 18px; font-weight: 400; display: flex; justify-content: space-between;">
                    Заказы
                    <span class="btn-order-wrapper">
                        <span @click="order_status_active" class="btn-order">Активные</span>
                        <span @click="order_status_completed" class="btn-order">Завершенные</span>
                    </span>
                </h3>
                <ul class="posted-rev-ul" v-if="order_status_comp">
                    <li class="posted-rev-item" v-for="item in getOrders" v-if="orderLenght !== 0">
                        <div class="post-rev-right">
                            <span class="post-rev-right-name"
                                style="display: flex; align-items: center; justify-content: space-between;">
                                {{ item.title }}
                                <span v-if="item.status == 'accepted'" class="post-rev-right-name-status status-accepted">
                                    <span class="post-rev-right-name-status-par">
                                        Принят
                                    </span>
                                </span>
                                <span v-if="item.status == 'send'" class="post-rev-right-name-status status-send">
                                    <span class="post-rev-right-name-status-par">
                                        Отправлен
                                    </span>
                                </span>
                                <span v-if="item.status == 'completed'" class="post-rev-right-name-status status-completed">
                                    <span class="post-rev-right-name-status-par">
                                        Завершен
                                    </span>
                                </span>
                            </span>
                            <div class="orders-wrapper">
                                <div class="orders-img-wrapper">
                                    <img :src="'http://localhost:5000/uploads/' + item.img" alt="orders_img">
                                </div>
                                <ul class="orders-ul-wrapper">
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Цена:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.price }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Кол-во:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.quantity }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Цвет:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.color }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Размер:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.size }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Выдача:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.point }}
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="posted-rev-item" v-else>
                        <div class="post-rev-right">
                            <p class="posted-rev-p" style="text-align:center;">
                                Нет активных заказов
                            </p>
                        </div>
                    </li>
                </ul>
                <ul class="posted-rev-ul" v-if="!order_status_comp">
                    <li class="posted-rev-item" v-for="item in getOrdersCompleted" v-if="order_completedLenght !== 0">
                        <div class="post-rev-right">
                            <span class="post-rev-right-name"
                                style="display: flex; align-items: center; justify-content: space-between;">
                                {{ item.title }}
                                <span v-if="item.status == 'accepted'" class="post-rev-right-name-status status-accepted">
                                    <span class="post-rev-right-name-status-par">
                                        Принят
                                    </span>
                                </span>
                                <span v-if="item.status == 'send'" class="post-rev-right-name-status status-send">
                                    <span class="post-rev-right-name-status-par">
                                        Отправлен
                                    </span>
                                </span>
                                <span v-if="item.status == 'completed'" class="post-rev-right-name-status status-completed">
                                    <span class="post-rev-right-name-status-par">
                                        Завершен
                                    </span>
                                </span>
                            </span>
                            <div class="orders-wrapper">
                                <div class="orders-img-wrapper">
                                    <img :src="'http://localhost:5000/uploads/' + item.img" alt="orders_img">
                                </div>
                                <ul class="orders-ul-wrapper">
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Цена:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.price }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Кол-во:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.quantity }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Цвет:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.color }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Размер:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.size }}
                                        </span>
                                    </li>
                                    <li class="orders-item">
                                        <span class="orders-item-title">
                                            Выдача:
                                        </span>
                                        <span class="orders-item-par">
                                            {{ item.point }}
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="posted-rev-item" v-else>
                        <div class="post-rev-right">
                            <p class="posted-rev-p" style="text-align:center;">
                                У вас ни одного завершенного заказа
                            </p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>


    <h2 class="h2-title" style="position: relative; border: none;">Корзина <span class="count_all_in_Cart">{{ cartLength
    }}</span>
    </h2>
    <div>
        <div class="carts">
            <div class="cart_items">
                <div class="check" v-if="cartLengthAll !== 0">
                    <label class="check_label" for="checkbox_select_all">
                        <input v-model="allSelected" @change="selectAllItems" class="main_checkbox" type="checkbox"
                            id="checkbox_select_all" />
                        <span class="checkbox_el"></span>
                        Выбрать все
                    </label>
                    <label class="button_select_sel" for="button_select_del">
                        <input class="btn_del_all" type="button" id="button_select_del" @click="removeSelectedItems" />
                        Удалить выбранные
                    </label>
                </div>
                <div class="cart_all cart_block">
                    <ul>
                        <li class="cartItem" v-for="(item, index) in getCart" key="cart" :key="item.id"
                            v-if="cartLengthAll !== 0">
                            <ul class="cart_main_ul">
                                <li class="index">
                                    <label class="check_label">
                                        <input v-model="item.selected" @change="selectItem(item)" class="main_checkbox"
                                            type="checkbox" />
                                        <span class="checkbox_el"></span>
                                    </label>
                                </li>
                                <li>
                                    <img class="cart_img" :src="'http://localhost:5000/uploads/' + item.img">
                                </li>
                                <li class="title_and_par">
                                    <ul class="text_ul">
                                        <li>{{ item.title }}</li>
                                        <li class="par_text">Цвет: {{ item.color }}</li>
                                        <li class="par_text">Размер: {{ item.size }}</li>
                                    </ul>
                                </li>
                                <li class="counter">
                                    <ul class="counter_ul">
                                        <li>
                                            <span @click="removeFromCart(item)">–</span>
                                        </li>
                                        <li>
                                            <span class="count_item">{{ item.quantity }}</span>
                                        </li>
                                        <li>
                                            <span @click="updateQuantity(item)">+</span>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <ul class="text_ul" style="text-align:right;">
                                        <li>Цена: {{ item.price }} р</li>
                                        <!-- <li class="par_text">Осталось: {{ item.price }}</li> -->
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li class="posted-rev-item" v-else>
                            <div class="post-rev-right">
                                <p class="posted-rev-p" style="text-align:center;">
                                    Вы ничего еще не добавили
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="cart_block cart_total">
                <h2 class="h2-title_cart">Итого <span style="float:right"> {{ cardTotal }} р</span></h2>
                <ul сlass="total_ul">
                    <li class="total_li">Товары <span style="float:right"> {{ cartLength }} </span></li>
                    <li class="total_li">Доставка <span style="float:right">Бесплатно</span></li>
                    <li class="total_li">Оплата <span style="float:right">Карта</span></li>
                    <li class="total_li">
                        Пункт выдачи
                        <div class="c_point_wrapper" style="float:right">
                            <div v-if="points == ''" class="c_point_btn">Не выбрано</div>
                            <div v-else class="c_point_btn">{{ points }}</div>
                            <ul class="c_point_items">
                                <li class="c_point_item">
                                    <input class="select_hidden_input" type="radio" id="point1" value="Пункт выдачи №1"
                                        v-model="points">
                                    <label for="point1">Пункт выдачи №1</label>
                                </li>
                                <li class="c_point_item">
                                    <input class="select_hidden_input" type="radio" id="point2" value="Пункт выдачи №2"
                                        v-model="points">
                                    <label for="point2">Пункт выдачи №1</label>
                                </li>
                                <li class="c_point_item">
                                    <input class="select_hidden_input" type="radio" id="point3" value="Пункт выдачи №4"
                                        v-model="points">
                                    <label for="point3">Пункт выдачи №3</label>
                                </li>
                                <li class="c_point_item">
                                    <input class="select_hidden_input" type="radio" id="point4" value="Пункт выдачи №4"
                                        v-model="points">
                                    <label for="point4">Пункт выдачи №4</label>
                                </li>
                            </ul>
                        </div>


                    </li>
                    <li>
                        <button @click="addToOrders" :disabled="!isValid" style="margin-bottom: 20px; width: 100%" class="btn">
                            Перейти к оплате
                        </button>
                    </li>
                    <li>
                        <label class="check_label check_argee" for="check_argee">
                            <input v-model="check_agree" class="main_checkbox" type="checkbox" id="check_argee" />
                            <span class="checkbox_el"></span>
                            Согласен с условиями Правил пользования торговой площадкой и правилами возврата
                        </label>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
<style scoped>
.c_point_wrapper {
    position: relative;
    transition: 200ms all ease;
    padding-bottom: 20px;
}

.c_point_wrapper:hover {
    color: #fff;
}

.c_point_wrapper:hover .c_point_items {
    display: block;
    background-color: var(--input-focus);
    color: #fff;
    font-weight: 300;

}

.c_point_items {
    display: none;
    border-radius: 7px;
    position: absolute;
    top: 25px;
    right: 0;
    width: 167px;
    z-index: 999999;
}

.c_point_item {
    padding: 3px 15px;
    margin: 10px 0;
    transition: 200ms all ease;
}

.c_point_item label {
    transition: 200ms all ease;
}

.c_point_item label:hover {
    cursor: pointer;
    opacity: 70% !important;
}

.c_point_item label:active {
    opacity: 50% !important;
}

.posted-rev {
    position: relative;
}

.h3-catalog-title {
    position: sticky;
    top: 0;
    padding-top: 50px !important;
    right: 10px;
    z-index: 9999;
    background-color: var(--back);
}

.btn-order-wrapper {
    display: flex;
}

.btn-order-wrapper .btn-order {
    display: block;
    font-size: 16px;
    font-weight: 300;
    margin-right: 10px;
    transition: 200ms all ease;
}

.btn-order-wrapper .btn-order:hover {
    opacity: 60%;
    cursor: pointer;
}

.btn-order-wrapper .btn-order:active {
    opacity: 40%;
}

.btn-order-wrapper .btn-order:last-child {
    margin-right: 0;
}

.orders-item {
    display: flex;
    margin-bottom: 7px !important;
}

.orders-item-title {
    display: block;
    color: var(--color-text);
    font-size: 17px;
    font-weight: 300;
    min-width: 80px;
}

.orders-item-par {
    display: block;
    color: var(--drop-a);
    font-size: 17px;
    font-weight: 300;
    min-width: 100px;
}

.orders-item {
    margin-bottom: 5px;
}

.orders-wrapper {
    margin-top: 13px;
    display: flex;
}

.orders-img-wrapper {
    min-width: 80px;
    min-height: 80px;
    max-width: 80px;
    max-height: 80px;
    border-radius: 7px;
    border: 1px solid #00000009;
    margin-right: 15px;
}

.orders-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 7px;
}

.post-rev-right-name-status {
    display: block;
    border: 1px solid #fff;
    width: 110px;
    height: 30px;
    border-radius: 8px;
    position: relative;
}

.post-rev-right-name-status span {
    display: block;
    position: absolute;
    top: 46%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
    line-height: 15px;
    font-weight: 300;
    font-size: 16px;
}

.status-accepted {
    background-color: var(--accepted-background) !important;
    border: 1px solid var(--accepted-border) !important;
}

.status-accepted span {
    color: var(--accepted-text);
}

.status-send {
    background-color: var(--send-background) !important;
    border: 1px solid var(--send-border) !important;
}

.status-send span {
    color: var(--send-text);
}

.status-completed {
    background-color: var(--completed-background) !important;
    border: 1px solid var(--completed-border) !important;
}

.status-completed span {
    color: var(--completed-text);
}




.posted-rev-p {
    padding: 10px 0 !important;
    opacity: 70%;
    font-weight: 300;
    line-height: 28px;
}

.posted-rev-item {
    margin-bottom: 20px;
}

.post-rev-date {
    font-size: 14px;
    opacity: 80%;
    margin-left: 10px;
}

.post-rev-right-name {
    color: var(--input-color);
    font-size: 18px;
}

.post-rev-right {
    position: relative;
    background-color: var(--input-back);
    padding: 20px;
    border-radius: 7px;
}

.post-rev-right i {
    position: absolute;
    top: 10px;
    right: 8px;
    padding: 10px;
    color: var(--icon-trash);
    transition: 200ms all ease;
}

.post-rev-right i:hover {
    color: var(--icon-trash-hover);
    cursor: pointer;
}

.post-rev-right i:active {
    color: rgb(165, 165, 165);
}

.custom-file-upload {
    position: relative;
    display: inline-block;
    cursor: pointer;
    width: 45px;
    min-height: 45px;
    max-height: 45px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: 600;
}

.acc-acc-theme form {
    width: 45px;
    min-height: 45px;
    max-height: 45px;
}

.custom-file-upload i {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
}




input[type="file"] {
    display: none;
}

.u-rev-wrapper {
    margin: 20px 0;
    display: flex;
    justify-content: space-between;
}

.u-rev-left {
    background-color: var(--back);
    padding: 0 20px 20px 20px;
    border-radius: 10px;
    width: 49%;
    min-height: 200px;
    max-height: 600px;
    overflow-y: scroll;
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.13);
}

.u-rev-left::-webkit-scrollbar {
    display: none;
}


.u-rev-right {
    background-color: var(--back);
    padding: 0 20px 20px 20px;
    border-radius: 10px;
    width: 49%;
    min-height: 200px;
    max-height: 600px;
    overflow-y: scroll;
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.13);
}

.u-rev-right::-webkit-scrollbar {
    display: none;
}

.acc-wrapper {
    margin-top: 20px;
    background-color: var(--back);
    padding: 10px 0;
    border-radius: 10px;
    position: relative;
    height: 260px;
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.13);
}

.acc-acc-avatar-wrapper {
    display: block;
}

.acc-acc-avatar-wrapper-wrapper {
    background-color: rgb(112, 112, 112);
    width: 122px;
    height: 122px;
    border-radius: 50%;
    display: block;
}

.acc-acc-avatar-wrapper-name {
    margin-top: 10px;
    font-size: 20px;
    font-weight: 400;
    display: block;
    text-align: center;
    color: var(--color-text);
}

.acc-acc-avatar-wrapper-role {
    font-weight: 300;
    margin-top: 5px;
    display: block;
    text-align: center;
    color: var(--drop-a);
}

.acc-acc-avatar-wrapper img {
    width: 122px;
    height: 122px;
    border-radius: 50%;
    object-fit: cover;
}

.acc-acc-theme {
    display: block;
    transition: 200ms all ease;
    padding: 10px;
    background-color: var(--icon-back);
    border-radius: 7px;
}

.acc-acc-theme:hover,
.acc-acc-logout:hover {
    opacity: 70%;
    cursor: pointer;
}

.acc-acc-theme:active,
.acc-acc-logout:active {
    opacity: 50%;
}

.acc-acc-theme i {
    color: var(--icon-color);
}

.acc-acc-logout {
    display: block;
    transition: 200ms all ease;
    padding: 10px;
    background-color: var(--icon-back);
    border-radius: 7px;
}

.acc-acc-logout i {
    color: var(--icon-color);
}

.acc-acc {
    position: absolute;
    width: 300px;
    /* height: 200px; */
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
    display: flex;
    justify-content: space-between;
    align-items: center;
}



.cart_main_ul {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
}


.cart_img {
    width: 120px;
    height: 120px;
    object-fit: cover;
    border-radius: 7px;
    border: 1px solid var(--nav-back);
}

.text_ul {
    margin-left: 20px;
    color: var(--color-text);
}

.text_ul li {
    margin-bottom: 10px;
}

.par_text {
    font-size: 15px;
    color: var(--drop-a);
}

.cartItem {
    margin-bottom: 20px;
    border-bottom: 1px solid var(--border);
}

.cartItem:last-child {
    margin-bottom: 0;
    border: none;
}

.index {
    color: var(--color-text);
    margin-right: 5px;
    display: flex;
    align-items: center;
}



.count_all_in_Cart {
    font-size: 18px;
    color: var(--drop-a);
    font-weight: 400;
    position: absolute;
    top: 15px;
    left: 102px;

}






.carts {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.cart_block {
    background-color: var(--back);
    padding: 20px;
    border-radius: 7px;
    box-shadow: 0px 5px 13px -3px rgb(34 60 80 / 10%);
}

.cart_items {
    width: 65%;
}



.cart_total {
    width: 33%;
    height: 100%;
}


.check {
    margin-bottom: 10px;
    background-color: var(--back);
    padding: 20px;
    border-radius: 7px;
    box-shadow: 0px 5px 13px -3px rgb(34 60 80 / 10%);
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.button_select_sel {
    color: var(--drop-a);
}

.button_select_sel:hover {
    color: var(--btn-back-a-hover);
    cursor: pointer;
}

.btn_del_all {
    width: 30px;
}

.h2-title_cart {
    padding: 0 0 10px 0;
    font-weight: 500;
    font-size: 20px;
    line-height: 28px;
    border-bottom: 1px solid var(--border);
    margin-bottom: 10px;
    color: var(--color-text);
}

.cart_all {
    max-height: 65vh;
    overflow: scroll;
}

.cart_all::-webkit-scrollbar {
    display: none;
}

.total_ul {
    display: flex;
    flex-direction: column;
}

.total_li {
    padding-bottom: 15px;
    color: var(--drop-a);
    font-size: 16px;
    font-weight: 400;
}

.check_argee {
    font-size: 14px;
    color: var(--drop-a);
}

.counter {
    display: flex;
    align-items: center;
}

.counter_ul {
    display: flex;
    background-color: var(--nav-back);
    border-radius: 5px;
}

.counter_ul li {
    width: 35px;
    height: 35px;
    color: var(--logo);
    font-weight: 500;
    border-right: 1px solid var(--border);
    position: relative;
}

.counter_ul li span {
    padding: 10px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%)
}

.counter_ul li:last-child {
    border: none;
}

.counter_ul li:hover {
    opacity: 70%;
    cursor: pointer;
}

.title_and_par {
    width: 165px;
}

.count_item {
    color: var(--color-text);
}
</style>