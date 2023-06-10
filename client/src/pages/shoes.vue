<script>
import axios from 'axios'
export default {
    data() {
        return {
            isFull: false,
            is_drop_type: false,
            is_drop_color: false,
            rangeValue: 11800,
            selected_type: '',
            search_value: '',
            selected_color: '',
            sort_value: 'new',
            items: [],
        }
    },

    methods: {
        full() {
            this.isFull = true
            localStorage.cardFull = 'full'

        },
        short() {
            this.isFull = false
            localStorage.cardFull = 'short'
        },
        open_drop_type() {
            this.is_drop_type = !this.is_drop_type
        },
        open_drop_color() {
            this.is_drop_color = !this.is_drop_color
        },
        resetALL() {
            this.is_drop_type = false,
                this.is_drop_color = false,
                this.rangeValue = 11800,
                this.selected_type = '',
                this.search_value = '',
                this.selected_color = '',
                this.sort_value = 'new'
        }
    },
    mounted() {
        if (localStorage.cardFull == 'short') {
            this.isFull = false
        }
        else {
            this.isFull = true
        };
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        axios
            .get('/get-all-by-catalog-type?category=shoes')
            .then(response => {
                this.items = response.data
            })
            .catch(error => {
                console.error(error);
            })
    },
    computed: {
        filteredItems() {
            const filteredItems = this.items.filter(item => {
                const searchQueryMatch = item.title.toLowerCase().includes(this.search_value.toLowerCase());
                const selectedTypeMatch = this.selected_type.length === 0 || this.selected_type.includes(item.type);
                const selectedColorMatch = this.selected_color.length === 0 || this.selected_color.includes(item.color);
                const priceMatch = this.rangeValue === 0 || item.new_price <= this.rangeValue;
                return searchQueryMatch && selectedTypeMatch && selectedColorMatch && priceMatch;
            });
            if (this.sort_value === 'cheap') {
                filteredItems.sort((a, b) => {
                    return a.new_price - b.new_price;
                });
            }
            else if (this.sort_value === 'expensive') {
                filteredItems.sort((a, b) => {
                    return (a.new_price - b.new_price) * -1;
                });
            }
            else if (this.sort_value === 'new') {
                filteredItems.sort((a, b) => {
                    return (a.id - b.id) * -1;
                });
            }
            else if (this.sort_value === 'old') {
                filteredItems.sort((a, b) => {
                    return a.id - b.id;
                });
            }
            return filteredItems;
        },
        cardLength() {
            return this.filteredItems.length
        },
    }
}

</script>
<template>
    <div class="filter_wrapper">
        <h3 class="h3-catalog-title">Поиск товара</h3>
        <ul class="filter_ul">
            <li class="filter_item" title="Изменить тип">
                <div class="filter_drop">
                    <div class="filter_drop_btn" @click="open_drop_type" >
                        <i class='lists bx bx-list-ul'></i>
                        <span class="filter_drop_btn_title">Тип</span>
                        <div v-if="is_drop_type == false">
                            <i style="display: block;" class='arrow-right bx bx-chevron-down bx-sm'></i>
                        </div>
                        <div v-else>
                            <i style="display: block;" class='arrow-right bx bx-chevron-up bx-sm'></i>
                        </div>
                    </div>
                    <div class="filter_drop_el" :class="{ filter_drop_el_show: is_drop_type }">
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="type_reset" value=""
                                v-model="selected_type">
                            <label for="type_reset">Все из категории</label>
                        </div>
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="sneakers" value="sneakers"
                                v-model="selected_type">
                            <label for="sneakers">Кроссовки</label>
                        </div>
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="boots" value="boots"
                                v-model="selected_type">
                            <label for="boots">Ботинки</label>
                        </div>
                    </div>
                </div>
            </li>
            <li class="search_wrapper" title="Поиск">
                <span class="search_el"><i class='bx bx-search'></i></span>
                <input type="search" v-model="search_value" id="search" placeholder="Поиск">
            </li>
            <li class="filter_item filter_price" title="Изменить цену">
                <span class="filter_price_title">Цена:</span>
                <span class="input_range">
                    <input type="range" v-model="rangeValue" min="1000" max="12000" step="400">
                    <span class="input_range_line"></span>
                </span>
                <span class="filter_price_value">{{ rangeValue }} р.</span>
            </li>
            <li class="filter_item" title="Изменить цвет">
                <div class="filter_drop paint">
                    <div class="filter_drop_btn_paint" @click="open_drop_color">
                        <i class='lists bx bx-palette'></i>
                    </div>
                    <div class="filter_drop_el" :class="{ filter_drop_el_show: is_drop_color }">
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="color_reset" value=""
                                v-model="selected_color">
                            <label for="color_reset">Все цвета</label>
                        </div>
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="black" value="black"
                                v-model="selected_color">
                            <label for="black">Черный</label>
                        </div>
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="white" value="white"
                                v-model="selected_color">
                            <label for="white">Белый</label>
                        </div>
                        <div class="filter_drop_item">
                            <input class="select_hidden_input" type="radio" id="brown" value="brown"
                                v-model="selected_color">
                            <label for="brown">Коричневый</label>
                        </div>
                    </div>
                </div>
            </li>
            <li class="filter_item" title="Очистить">
                <div class="filter_drop paint">
                    <div class="filter_drop_btn_paint" @click="resetALL()">
                        <i class='lists bx bx-x'></i>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="flex" style="display: flex; align-items: center;">
        <h3 v-if="selected_type == 'sneakers'" class="h3-catalog-title" style="padding: 0 !important;">Кроссовки</h3>
        <h3 v-if="selected_type == 'boots'" class="h3-catalog-title" style="padding: 0 !important;">Ботинки</h3>
        <h3 v-if="selected_type == ''" class="h3-catalog-title" style="padding: 0 !important;">Все товары</h3>
        <span style="padding: 12px 0 10px 10px;" class="count-all">{{ cardLength }}</span>
    </div>
    <ul class="sorting">
        <li class="sorting-title">Сортировать по:</li>
        <li class="sorting-item">
            <input class="sorting_hidden_input" type="radio" value="new" id="new" v-model="sort_value">
            <label for="new">новые</label>
        </li>
        <li class="sorting-item">
            <input class="sorting_hidden_input" type="radio" value="old" id="old" v-model="sort_value">
            <label for="old">старые</label>
        </li>
        <li class="sorting-item">
            <input class="sorting_hidden_input" type="radio" value="cheap" id="cheap" v-model="sort_value">
            <label for="cheap">дешевле</label>
        </li>
        <li class="sorting-item">
            <input class="sorting_hidden_input" type="radio" value="expensive" id="expensive" v-model="sort_value">
            <label for="expensive">дороже</label>
        </li>
    </ul>
    <ul class="display">
        <li class="sorting-title">Отображение:</li>
        <li @click="short()" class="sorting-item">
            <i class='bx bxs-grid-alt bx-sm view_mode_color'></i>
        </li>
        <li @click="full()" class="sorting-item">
            <i class='bx bxs-collection bx-sm view_mode_color'></i>
        </li>
    </ul>
    <div v-if="filteredItems.length == 0">
        <h3 class="h3-catalog-title">
            По результатам ваших параметров ничего не найдено...
        </h3>
    </div>
    <div v-else>
        <ul class="cards" :class="{ cards_full: isFull }">
            <router-link tag="li" class="card-item" :class="{ card_item_full: isFull }" v-for="item in filteredItems"
                :key="item.id" :to="`/card-item/${item.id}`">
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
                    <li class="card-icons">
                        <i class='bx bx-brush'></i>
                        <span class="rating-value" v-if="item.color == 'black'">
                            черный
                        </span>
                        <span class="rating-value" v-else-if="item.color == 'white'">
                            белый
                        </span>
                        <span class="rating-value" v-else-if="item.color == 'brown'">
                            коричневый
                        </span>
                    </li>
                    <li class="card-icons">
                        <i class='bx bx-male-sign'></i>
                        <span class="rating-value">{{ item.sex }}</span>
                    </li>
                    <button class="btn btn-card">Перейти</button>
                </ul>
            </router-link>
        </ul>
    </div>
</template>
<style scoped>
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