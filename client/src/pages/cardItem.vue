<script>
import notFoundPage from '../pages/notFoundPage.vue'
export default {
    data() {
        return {
            selectedImg: '',
            isZoom: false,
            x: '',
            y: '',
            isBtn: true,
            error: [],
            array: [],
            user_id: localStorage.getItem('user_id'),
            account_info: null,
            name: '',
            text: '',
            avatar: '',
            id: '',
            revs: null,
            isDisabled: true,
            close_btn_alert_btn: false,
            items: [],
        }
    },
    computed: {
        showImg() {
            if (!this.selectedImg) {
                return this.items[0].img1
            }
            else {
                return this.selectedImg
            }
        },
        // cardId() {
        //     return +this.$route.params.id;
        // },
        checkedAll() {
            if (this.checkedSize != 'не выбрано' && this.checkedColor != 'не выбрано') {
                this.isBtn = false
            }
        },
        // getItem() {
        //     return this.$store.getters.getProduct(this.cardId)
        // },
        discountCount() {
            if (this.items[0].old_price >= 0) {
                return Math.round(((this.items[0].old_price - this.items[0].new_price) / this.items[0].old_price) * 100)
            }
        },

        getReviews() {
            try {
                axios.get(`/get-reviews/${this.id}`)
                    .then(response => {
                        this.revs = response.data
                    })
                    .catch(error => {
                        console.log(error)
                        return this.revs == []
                    });
                return this.revs
            } catch (err) {
                console.error('Error:', err);
            }

        },
        revsLenght() {
            if (this.getReviews === null) {
                return 0
            } else {
                return this.getReviews.length
            }

        },
        getItems() {
            axios
                .get(`/get-by-id/${this.id}`)
                .then(response => {
                    this.items = response.data
                })
                .catch(error => {
                    console.error(error);
                })
            return this.items
        }
    },
    mounted() {
        this.id = this.$route.params.id

        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });

        axios.get(`/account/${this.user_id}`)
            .then(response => {
                this.account_info = response.data
                this.name = response.data[0].name,
                    this.avatar = response.data[0].avatar
            })
            .catch(error => (console.log(error)));
    },
    methods: {
        zoomImgLeave() {
            this.isZoom = false
        },
        pos(e) {
            this.x = 600 - e.clientX
            this.y = 300 - e.clientY
            this.isZoom = true
        },
        checkedItems() {
            axios.post('/add-cart', {
                user_id: this.user_id,
                item_id: this.id,
                title: this.items[0].title,
                price: this.items[0].new_price,
                img: this.items[0].img1,
                color: this.items[0].color,
                size: this.items[0].size,
                quantity: 1,
                selected: 'true'
            }).then(response => {
                // this.cart = response.data;
                this.close_btn_alert_btn = true
            });



        },
        addReviews() {
            axios.post('/post-reviews/', {
                item_id: this.id,
                user_id: this.user_id,
                item_title: this.items[0].title,
                user_avatar: this.avatar,
                text: this.text,
                user_name: this.name,
            })
                .then((response) => {
                    this.text = '',
                        this.rating = ''
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        validateInputs() {
            if (this.text.length >= 5) {
                this.isDisabled = false;
            } else {
                this.isDisabled = true;
            }
        },
        close_btn_alert() {
            this.close_btn_alert_btn = false
        },
        goBack() {
            this.$router.go(-1)
        },
        goToCart() {
            this.$router.push('/account')
        }
    },
    components: {
        notFoundPage
    }
}

</script>
<template>
    <div v-if="true">
        <div class="btn_back" @click="goBack">
            <i class="arrow-right bx bx-chevron-left bx-sm"></i>
            <span>
                Назад
            </span>
        </div>
        <h3 class="h3-catalog-title" v-for="item in getItems">
            <span v-if="item.type == 't_shirt'">
                Футболка
            </span>
            <span v-else-if="item.type == 'jackets'">
                Куртка
            </span>
            <span v-else-if="item.type == 'trousers'">
                Брюки
            </span>
            <span v-else-if="item.type == 'sneakers'">
                Кроссовки
            </span>
            <span v-else-if="item.type == 'boots'">
                Ботинки
            </span>
            <span v-else-if="item.type == 'snowboard'">
                Сноуборд
            </span>
            <span v-else-if="item.type == 'roller_skates'">
                Роликовые коньки
            </span>
            <span v-else-if="item.type == 'skateboard'">
                Скейтборд
            </span>
            <span v-else-if="item.type == 'ski'">
                Горные лыжи
            </span>
            <span v-else-if="item.type == 'helmet'">
                Шлем
            </span>
            - <span class="span_value">{{ item.title }}</span>
        </h3>
        <div class="card_product">
            <div class="product_images">
                <ul class="main_img" v-for="item in getItems">
                    <li v-if="item.old_price" class="discountCount">-{{ discountCount }}%</li>
                    <li>
                        <img :src="'http://localhost:5000/uploads/' + showImg" :class="{ hideMainIng: isZoom }">
                    </li>
                    <li class="zoom" @mousemove="pos" @mouseleave="zoomImgLeave">
                        <img class="hide" :class="{ show: isZoom }" :src="'http://localhost:5000/uploads/' + showImg"
                            :style="{ transform: 'scale(1.8) translate(' + x / 2.5 + 'px,' + y / 2.5 + 'px)' }">
                    </li>
                </ul>
                <ul class="item_img_wrapper" v-for="item in getItems">
                    <li class="item_img" v-if="item.img1 != ''">
                        <label for="img1">
                            <img :src="'http://localhost:5000/uploads/' + item.img1">
                        </label>
                        <input class="input_img" type="radio" :value="item.img1" v-model="selectedImg" id="img1">
                    </li>
                    <li class="item_img" v-if="item.img2 != ''">
                        <label for="img2">
                            <img :src="'http://localhost:5000/uploads/' + item.img2">
                        </label>
                        <input class="input_img" type="radio" :value="item.img2" v-model="selectedImg" id="img2">
                    </li>
                    <li class="item_img" v-if="item.img3 != ''">
                        <label for="img3">
                            <img :src="'http://localhost:5000/uploads/' + item.img3">
                        </label>
                        <input class="input_img" type="radio" :value="item.img3" v-model="selectedImg" id="img3">
                    </li>
                    <li class="item_img" v-if="item.img4 != ''">
                        <label for="img4">
                            <img :src="'http://localhost:5000/uploads/' + item.img4">
                        </label>
                        <input class="input_img" type="radio" :value="item.img4" v-model="selectedImg" id="img4">
                    </li>
                    <li class="item_img" v-if="item.img5 != ''">
                        <label for="img5">
                            <img :src="'http://localhost:5000/uploads/' + item.img5">
                        </label>
                        <input class="input_img" type="radio" :value="item.img5" v-model="selectedImg" id="img5">
                    </li>
                </ul>
            </div>
            <ul class="product_param_ul" v-for="item in getItems">
                <li class="product_param_li">
                    <span class="span_main">Производитель: </span>
                    <span class="span_value">{{ item.manufacturer }}</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Название: </span>
                    <span class="span_value">{{ item.title }} </span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Артикул: </span>
                    <span class="span_value">{{ item.id }}</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Цена: </span>
                    <span class="span_value">{{ item.new_price }} р</span>
                </li>
                <li class="product_param_li" v-if="item.old_price">
                    <span class="span_main">Старая цена: </span>
                    <span class="span_value" style="text-decoration: line-through;">{{ item.old_price }} р</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Пол: </span>
                    <span class="span_value">{{ item.sex }}</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">О товаре: </span>
                    <span class="span_value">{{ item.description }}</span>
                </li>
                <li class="product_param_li" v-if="item.material != 0">
                    <span class="span_main">Материал: </span>
                    <span class="span_value">{{ item.material }}</span>
                </li>
                <li class="product_param_li" v-if="item.weight != 0">
                    <span class="span_main">Вес: </span>
                    <span class="span_value">{{ item.weight }} гр</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Осталось: </span>
                    <span v-if="item.count_in_store != 0" class="span_value">{{ item.count_in_store }}</span>
                    <span v-else class="span_value">нет в наличии</span>
                </li>
                <li class="product_param_li" v-if="revsLenght != 0">
                    <span class="span_main">Отзывы: </span>
                    <span class="span_value">{{ revsLenght }}</span>
                </li>
                <li class="product_param_li" v-else>
                    <span class="span_main">Отзывы: </span>
                    <span class="span_value">нет отзывов</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Размер: </span>
                    <span class="span_value">{{ item.size }}</span>
                </li>
                <li class="product_param_li">
                    <span class="span_main">Цвет: </span>
                    <span class="span_value" v-if="item.color == 'black'">
                        черный
                    </span>
                    <span class="span_value" v-else-if="item.color == 'white'">
                        белый
                    </span>
                    <span class="span_value" v-else-if="item.color == 'blue'">
                        синий
                    </span>
                    <span class="span_value" v-else-if="item.color == 'brown'">
                        коричневый
                    </span>
                    <span class="span_value" v-else-if="item.color == 'grey'">
                        серый
                    </span>
                </li>
                <li @click="checkedItems" style="width: 300px" class="btn" v-if="getItems[0].count_in_store != 0 && user_id">
                    Добавить в корзину
                </li>
                <button disabled class="btn" v-else-if="!user_id" style="width:300px; font-size: 16px; font-weight: 300;">
                    Вы не авторизованы
                </button>
                <button disabled class="btn" v-else style="width:300px; font-size: 16px; font-weight: 300;">
                    Товара нет в наличии
                </button>

            </ul>
            <div class="alert_add_to_cart_wrapper" :class="{ alert_add_to_cart_wrapper_open: close_btn_alert_btn }">
                <div class="alert_add_to_cart_obj" :class="{ alert_add_to_cart_obj_open: close_btn_alert_btn }">
                    <span class="alert_add_to_cart_ok_wrapper">
                        <i class='alert_ok bx bx-check'></i>
                    </span>
                    <span class="alert_add_to_cart_text">
                        Товар добавлен в корзину
                    </span>
                    <div class="btn btn_alert" @click="goToCart">
                        В корзину
                    </div>
                    <span class="btn_close_modal" @click="close_btn_alert">
                        <i class='bx bx-x'></i>
                    </span>
                </div>
            </div>
        </div>
        <div class="post-rev" v-if="user_id">
            <h3 class="h3-catalog-title" style="padding-top: 0;">Оставить отзыв</h3>
            <div class="post-rev-item">
                <div class="post-rev-left-avatar-wrapper">
                    <img v-for="item in account_info" :src="'http://localhost:5000/uploads/' + item.avatar" alt="">
                </div>
                <div class="post-rev-right">
                    <span class="post-rev-right-name" v-for="item in account_info">
                        {{ item.name }}
                    </span>
                    <form class="post-rev-form" @submit.prevent="addReviews()">
                        <input v-model="name" required type="text" placeholder="Введите">
                        <textarea @input="validateInputs" v-model="text" placeholder="Текст отзыва"></textarea>
                        <button class="btn" type="submit" :disabled="isDisabled">
                            Оставить отзыв
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="posted-rev" v-if="revsLenght !== 0">
            <h3 class="h3-catalog-title" style="padding-top: 0;">Отзывы</h3>
            <ul class="posted-rev-ul">
                <li class="posted-rev-item" v-for="item in getReviews">
                    <div class="post-rev-left-avatar-wrapper">
                        <img :src="'http://localhost:5000/uploads/' + item.user_avatar" alt="">
                    </div>
                    <div class="post-rev-right">
                        <span class="post-rev-right-name">
                            {{ item.user_name }} <span class="post-rev-date">{{ item.date.slice(0, 10) }}</span>
                        </span>
                        <p class="posted-rev-p">
                            {{ item.text }}
                        </p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div v-else>
        <h3 class="h3-catalog-title">
            Товар « {{ id }} » не найден
        </h3>
    </div>
</template>
<style scoped>
.btn_back {
    margin-top: 20px;
    display: block;
    display: flex;
    align-items: center;
    padding: 10px 10px 10px 10px;
    width: 160px;
    height: 40px;
    color: var(--filter-color);
    background-color: var(--filter-back);
    transition: 200ms all ease;
    border-radius: 7px;
    position: relative;
}

.btn_back i {
    position: absolute;
    top: 55%;
    transform: translate(3px, -50%);
}

.btn_back:hover {
    cursor: pointer;
    background-color: var(--filter-back-hover);
}

.btn_back:active {
    background-color: var(--filter-back-active);
}

.btn_back span {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
    font-size: 18px;
}

.post-rev-right-name {
    font-size: 18px;
    color: var(--color-text);
    font-weight: 400;
}

.post-rev-right {
    margin-left: 20px;
    width: 100%;
}

.posted-rev-p {
    font-weight: 300;
    line-height: 28px;
    font-size: 16px;
    padding: 25px;
    border-radius: 7px;
    margin-top: 20px;
    color: var(--input-color);
    background-color: var(--input-back);
}

.post-rev,
.posted-rev {
    margin-top: 20px;
    border-radius: 8px;
    padding: 30px;
    background-color: var(--back);
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.13);
}

.posted-rev-item {
    display: flex;
    padding-top: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid var(--border);
}

.posted-rev-item:last-child {
    padding-bottom: 0;
    border-bottom: none;
}

.post-rev-item {
    display: flex;
}

.post-rev-left-avatar-wrapper {
    background-color: aliceblue;
    width: 75px;
    height: 75px;
    border-radius: 50%;
}

.post-rev-left-avatar-wrapper img {
    width: 75px;
    height: 75px;
    border-radius: 50%;
    object-fit: cover;
}

.post-rev-date {
    margin-left: 10px;
    font-size: 14px;
    font-weight: 300;
    color: #727272;
}

.zoom {
    overflow: hidden;
    position: absolute;
    top: 0;
    width: 450px;
    height: 480px;
    cursor: pointer;
    border: 1px solid var(--nav-back);
}

.card_product {
    display: flex;
    border-radius: 8px;
    padding: 20px;
    background-color: var(--back);
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.13);
}

.product_images {
    width: 450px;
}

.product_param_ul {
    margin-left: 20px;
    width: 100%;
}

.span_main {
    color: var(--color-text);
    font-weight: 400;
    font-size: 18px;
}

.product_param_li {
    padding-bottom: 10px;
}

.span_value {
    font-size: 16px;
    color: var(--drop-a);
    font-weight: 300;
}

.main_img {
    margin-bottom: 10px;
    height: 480px;
    width: 450px;
    position: relative;
    background-color: #fff;
}

.hide {
    opacity: 0;
}

.show {
    opacity: 1;
}

.main_img li img {
    width: 100%;
    height: 480px;
    object-fit: contain;
}

.item_img_wrapper {
    display: grid;
    grid-template-columns: repeat(5, 75px);
    height: 55px;
    width: 450px;
    justify-content: space-between;
}


.item_img {
    border: 1px solid var(--nav-back);
}

.item_img:hover {
    cursor: pointer;
    opacity: 70%;
}

.item_img img {
    height: 55px;
    width: 75px;
    object-fit: cover;
    cursor: pointer;
}

input {
    display: none;
}

.hideMainIng {
    opacity: 10%;
}

.choose_color {
    display: block;
    width: 35px;
    height: 22px;
    border-radius: 5px;
    border: 1px solid var(--nav-back);
    font-weight: 400;
    background-color: var(--nav-back);
    font-size: 16px;
    color: var(--drop-a);
    text-align: center;
}

.choose_color:hover {
    cursor: pointer;
    opacity: 70%;
}

.choose_color_black {
    background-color: rgb(0, 0, 0);
}

.choose_color_white {
    background-color: rgb(255, 255, 255);
}

.colors {
    padding-top: 10px;
    display: flex;

}

.colors li {
    margin-right: 10px;
    align-items: center;
    justify-content: center
}

label {
    display: flex;
}

.h3-card-title {
    color: var(--color-text);
    padding-top: 10px;
}

.discountCount {
    position: absolute;
    padding: 4px 8px 4px 8px;
    border-radius: 5px;
    background-color: var(--discountCount_back);
    color: var(--discountCount_color);
    ;
    top: 20px;
    left: 20px;
    font-size: 18px;
    font-weight: 500;
    letter-spacing: 1px;
}

.btn {
    padding: 15px 70px 15px 70px;
    border-radius: 7px;
    font-size: 16px;
    transition: 200ms all ease;
}
</style>