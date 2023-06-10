<script>
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';
import $ from 'jquery';
import 'slick-carousel';


export default {
    data() {
        return {
            items: [],
            items2: [],
        }
    },
    mounted() {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        this.getFirst();
        this.getSecond();
    },
    methods: {
        getFirst() {
            axios.get('/get-all-recent').then(response => {
                this.items = response.data;
                this.$nextTick(() => {
                    this.initializeSlider();
                });
            }).catch(error => {
                console.error(error);
            });
        },
        getSecond() {
            axios.get('/get-all-random').then(response => {
                this.items2 = response.data;
                this.$nextTick(() => {
                    this.initializeSlider2();
                });
            }).catch(error => {
                console.error(error);
            });
        },
        initializeSlider() {
            $(this.$refs.slick).slick({
                slidesToShow: 4.5,
                slidesToScroll: 3,
                prevArrow: $(".custom-prev"),
                nextArrow: $(".custom-next"),
                infinite: false,
                speed: 500,
                autoplay: true,
                autoplaySpeed: 2000,
            });
        },
        initializeSlider2() {
            $(this.$refs.slick2).slick({
                slidesToShow: 4.5,
                slidesToScroll: 3,
                prevArrow: $(".custom-prev"),
                nextArrow: $(".custom-next"),
                infinite: false,
                speed: 500,
                autoplay: true,
                autoplaySpeed: 2000,
            });
        },
    },
}
</script>
<template>
    <section>
        <h3 class="h3-catalog-title">
            Недавно добавленные
        </h3>
        <ul ref="slick" class="cards slick-slider">
            <li class="card-item slide" v-for="item in items" :key="item.id">
                <div class="card_img_top">
                    <img class="card-img" :src="'http://localhost:5000/uploads/' + item.img1">
                    <div v-if="item.old_price" class="discountCount">
                        -{{ Math.round(((item.old_price - item.new_price) / item.old_price) * 100) }}%</div>
                </div>
                <ul class="mini-card">
                    <li class="card-item-title">{{ item.title }}</li>
                    <li class="card-text">{{ item.description }}</li>
                    <li class="card-price">
                        <span class="item-price-new">{{ item.new_price }} р</span>
                        <span v-if="item.old_price" class="item-price-old">{{ item.old_price }} р</span>
                    </li>
                    <router-link :to="`/card-item/${item.id}`">
                        <button class="btn btn-card">Перейти</button>
                    </router-link>
                </ul>
            </li>
        </ul>
    </section>
    <section>
        <h3 class="h3-catalog-title">
            Вам может понравится
        </h3>
        <ul ref="slick2" class="cards slick-slider">
            <li class="card-item slide" v-for="item in items2" :key="item.id">
                <div class="card_img_top">
                    <img class="card-img" :src="'http://localhost:5000/uploads/' + item.img1">
                    <div v-if="item.old_price" class="discountCount">
                        -{{ Math.round(((item.old_price - item.new_price) / item.old_price) * 100) }}%</div>
                </div>
                <ul class="mini-card">
                    <li class="card-item-title">{{ item.title }}</li>
                    <li class="card-text">{{ item.description }}</li>
                    <li class="card-price">
                        <span class="item-price-new">{{ item.new_price }} р</span>
                        <span v-if="item.old_price" class="item-price-old">{{ item.old_price }} р</span>
                    </li>
                    <router-link :to="`/card-item/${item.id}`">
                        <button class="btn btn-card">Перейти</button>
                    </router-link>
                </ul>
            </li>
        </ul>
    </section>
</template>
<style scoped>
.cards {
    display: flex !important;
}

.card-img {
    width: 150px !important;
    height: 200px;
}

.card_img_top {
    width: 200px;
    height: 200px;
}

.card-item {
    width: 200px !important;
}

.mini-card {
    height: 160px;
}

.btn-card {
    width: 160px;
    text-align: center;
}

.discountCount {
    position: absolute;
    bottom: 10px;
    right: 10px;
    z-index: 999;
    padding: 4px 8px 4px 8px;
    border-radius: 5px;
    background-color: var(--discountCount_back);
    color: var(--discountCount_color);
}
</style>