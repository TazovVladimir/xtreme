<script>
export default {
    data() {
        return {
            account_info: null,
            user_id: localStorage.getItem('user_id'),
            name: null,
            is_drop_type: false,
            is_drop_color: false,
            rangeValue: 11800,
            selected_type: '',
            search_value: '',
            selected_color: '',
            sort_value: 'new',
            items: [],
            openInputs: false,
            Allorder: [],
            status: '',

            // formData
            formData: {
                // form-select
                selected_cat_form: '',
                selected_type_form: '',
                selected_color_form: '',
                selected_size_form: '',
                // form-inputs
                form_manufacturer: '',
                form_title: '',
                form_description: '',
                form_newPrice: '',
                form_weight: '',
                form_material: '',
                form_count_in_store: ''
            }
        }
    },
    // dsadsadsadassdasa
    mounted() {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        axios.get(`/account/${this.user_id}`)
            .then(response => {
                this.account_info = response.data,
                    this.name = this.account_info[0].name
            })
            .catch(error => (console.log(error)));
        axios
            .get('/get-all-by-catalog-type?category=all')
            .then(response => {
                this.items = response.data
            })
            .catch(error => {
                console.error(error);
            })

    },
    methods: {
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
        },
        openAddInputs() {
            this.openInputs = true;
        },
        closeInputs() {
            this.openInputs = false;
        },
        submitForm() {
            const formData = new FormData();
            formData.append('selected_cat_form', this.formData.selected_cat_form);
            formData.append('selected_type_form', this.formData.selected_type_form);
            formData.append('selected_color_form', this.formData.selected_color_form);
            formData.append('selected_size_form', this.formData.selected_size_form);
            formData.append('form_manufacturer', this.formData.form_manufacturer);
            formData.append('form_title', this.formData.form_title);
            formData.append('form_description', this.formData.form_description);
            formData.append('form_newPrice', this.formData.form_newPrice);
            formData.append('form_weight', this.formData.form_weight);
            formData.append('form_material', this.formData.form_material);
            formData.append('form_count_in_store', this.formData.form_count_in_store);
            formData.append('images', this.$refs.form_img1.files[0]);
            formData.append('images', this.$refs.form_img2.files[0]);
            formData.append('images', this.$refs.form_img3.files[0]);
            formData.append('images', this.$refs.form_img4.files[0]);
            formData.append('images', this.$refs.form_img5.files[0]);


            axios.post('/add-new-item', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            })
                .then(response => {
                    console.log(response.data);
                })
                .catch(error => {
                    console.log(error);
                });
        },
        deleteItemById(id) {
            axios.delete('/del-item-id/' + id)
                .then(response => {
                    console.log(response.data);
                })
                .catch(error => {
                    console.log(error);
                });
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
        changeStatus(id, status) {
            if (status == '1') {
                this.status = 'accepted'
            } else if (status == '2') {
                this.status = 'send'
            } else if (status == '3') {
                this.status = 'completed'
            }
            axios.post('/update-status', {
                id: id,
                status: this.status,
            })
                .then((response) => {
                    console.log(response)
                })
                .catch((error) => {
                    console.log(error);
                });
        }

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
            return filteredItems;
        },
        cardLength() {
            return this.filteredItems.length
        },
        getAllOrders() {
            axios.get(`/get-all-orders`)
                .then(response => {
                    this.Allorder = response.data
                })
                .catch(error => {
                    console.log(error)
                });
            return this.Allorder
        },
    }
}
</script>
<template>
    <section>
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
                        администратор
                    </span>
                </span>
                <span class="acc-acc-logout" @click="logout">
                    <i class='bx bx-exit bx-sm'></i>
                </span>
            </div>
        </div>
    </section>
    <h3 class="h3-catalog-title">
        Заявки
    </h3>
    <div class="main-table orderss">
        <table cellpadding='0' cellspacing='0' style='border-collapse:collapse; border-radius: 10px;'>
            <tr class="table_titles">
                <th>id</th>
                <th>id клиента</th>
                <th>id товара</th>
                <th>Название</th>
                <th>Сумма</th>
                <th>Цвет</th>
                <th>Размер</th>
                <th>Количество</th>
                <th>Выдача</th>
                <th>Статус</th>
            </tr>
            <tr class="table_par" v-for="item in getAllOrders">
                <td>
                    {{ item.id }}
                </td>
                <td>
                    {{ item.user_id }}
                </td>
                <td>
                    {{ item.item_id }}
                </td>
                <td>
                    {{ item.title }}
                </td>
                <td>
                    {{ item.price }}
                </td>
                <td>
                    {{ item.color }}
                </td>
                <td>
                    {{ item.size }}
                </td>
                <td>
                    {{ item.quantity }}
                </td>
                <td>
                    {{ item.point }}
                </td>
                <td>
                    <div class="c_point_wrapper">
                        <div v-if="item.status == 'accepted'" class="c_point_btn">Принят</div>
                        <div v-if="item.status == 'send'" class="c_point_btn">Отправлен</div>
                        <div v-if="item.status == 'completed'" class="c_point_btn">Завершен</div>
                        <ul class="c_point_items">
                            <li class="c_point_item" @click="changeStatus(item.id, 1)">
                                Принят
                            </li>
                            <li class="c_point_item" @click="changeStatus(item.id, 2)">
                                Отправлен
                            </li>
                            <li class="c_point_item" @click="changeStatus(item.id, 3)">
                                Завершен
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <section>
        <div class="filter_wrapper">
            <h3 class="h3-catalog-title" style="position:relative;display:flex; align-items:center;">
                Товары
                <span class="btn_add" v-if="openInputs == false" @click="openAddInputs" title="Добавить товары">
                    <i class='bx bx-plus'></i>
                </span>
            </h3>
            <div class="add_items_form_wrapper" v-if="openInputs">
                <span @click="closeInputs" class="btn_close_modal"><i class="bx bx-x"></i></span>
                <h3 class="h3-catalog-title">Добавление нового товара</h3>
                <form @submit.prevent="submitForm">
                    <div class="add_items_form_wrapper_left">
                        <div class="form_items">
                            <ul class="drop_itemss_wrapper">
                                <li class="drop_itemss_wrapper_item">
                                    <div class="drop_itemss_wrapper_item_btn">
                                        <i class='bx bx-category'></i>
                                        <span v-if="formData.selected_cat_form == ''"
                                            class="filter_drop_btn_title">Каталог</span>
                                        <span v-else class="filter_drop_btn_title">Каталог - {{ formData.selected_cat_form
                                        }}</span>
                                        <i class="arrow-right bx bx-chevron-down bx-sm" style="display: block;"></i>
                                    </div>
                                    <div class="drop_itemss_wrapper_item_el">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="clothes" value="clothes"
                                                v-model="formData.selected_cat_form">
                                            <label for="clothes">Одежда</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="shoes" value="shoes"
                                                v-model="formData.selected_cat_form">
                                            <label for="shoes">Обувь</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="inventory" value="inventory"
                                                v-model="formData.selected_cat_form">
                                            <label for="inventory">Инвентарь</label>
                                        </div>
                                    </div>
                                </li>
                                <li class="drop_itemss_wrapper_item">
                                    <div class="drop_itemss_wrapper_item_btn">
                                        <i class="lists bx bx-list-ul"></i>
                                        <span v-if="formData.selected_type_form == ''"
                                            class="filter_drop_btn_title">Тип</span>
                                        <span v-else class="filter_drop_btn_title">Тип - {{ formData.selected_type_form
                                        }}</span>
                                        <i class="arrow-right bx bx-chevron-down bx-sm" style="display: block;"></i>
                                    </div>

                                    <!-- clothes -->
                                    <div class="drop_itemss_wrapper_item_el" v-if="formData.selected_cat_form == 'clothes'">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="jackets" value="jackets"
                                                v-model="formData.selected_type_form">
                                            <label for="jackets">Куртки</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="t_shirt" value="t_shirt"
                                                v-model="formData.selected_type_form">
                                            <label for="t_shirt">Футболки</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="trousers" value="trousers"
                                                v-model="formData.selected_type_form">
                                            <label for="trousers">Брюки</label>
                                        </div>
                                    </div>
                                    <!-- shoes -->
                                    <div class="drop_itemss_wrapper_item_el" v-if="formData.selected_cat_form == 'shoes'">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="boots" value="boots"
                                                v-model="formData.selected_type_form">
                                            <label for="boots">Ботинки</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="sneakers" value="sneakers"
                                                v-model="formData.selected_type_form">
                                            <label for="sneakers">Кроссовки</label>
                                        </div>
                                    </div>
                                    <!-- inventory -->
                                    <div class="drop_itemss_wrapper_item_el"
                                        v-if="formData.selected_cat_form == 'inventory'">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="snowboard" value="snowboard"
                                                v-model="formData.selected_type_form">
                                            <label for="snowboard">Сноуборды</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="roller_skates"
                                                value="roller_skates" v-model="formData.selected_type_form">
                                            <label for="roller_skates">Ролик. коньки</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="skateboard"
                                                value="skateboard" v-model="formData.selected_type_form">
                                            <label for="skateboard">Скейтборды</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="ski" value="ski"
                                                v-model="formData.selected_type_form">
                                            <label for="ski">Горные лыжи</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="helmet" value="helmet"
                                                v-model="formData.selected_type_form">
                                            <label for="helmet">Шлем</label>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Производитель:
                                </span>
                                <input required v-model="formData.form_manufacturer" type="text" placeholder="Nike">
                            </label>

                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Название:
                                </span>
                                <input required v-model="formData.form_title" type="text" placeholder="Dickies New Sarpy">
                            </label>
                        </div>

                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Описание:
                                </span>
                                <textarea required v-model="formData.form_description"
                                    placeholder="Прочный бомбер с капюшоном с классической"></textarea>
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Изображения 1:
                                </span>
                                <!--  -->
                                <input required ref="form_img1" accept="image/*" type="file">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Изображение 2:
                                </span>
                                <!--  -->
                                <input required ref="form_img2" accept="image/*" type="file">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Изображение 3:
                                </span>
                                <!--  -->
                                <input required ref="form_img3" accept="image/*" type="file">
                            </label>
                        </div>
                        <div class="form_items btn_wrapper">
                            <button type="submit" class="btn">
                                Добавить
                            </button>
                        </div>

                    </div>
                    <div class="add_items_form_wrapper_right">
                        <div class="form_items">
                            <ul class="drop_itemss_wrapper">
                                <li class="drop_itemss_wrapper_item">
                                    <div class="drop_itemss_wrapper_item_btn">
                                        <i class='bx bx-palette'></i>
                                        <span v-if="formData.selected_color_form == ''"
                                            class="filter_drop_btn_title">Цвет</span>
                                        <span v-else class="filter_drop_btn_title">Цвет - {{ formData.selected_color_form
                                        }}</span>
                                        <i class="arrow-right bx bx-chevron-down bx-sm" style="display: block;"></i>
                                    </div>
                                    <div class="drop_itemss_wrapper_item_el">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="black" value="black"
                                                v-model="formData.selected_color_form">
                                            <label for="black">Черный</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="white" value="white"
                                                v-model="formData.selected_color_form">
                                            <label for="white">Белый</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="blue" value="blue"
                                                v-model="formData.selected_color_form">
                                            <label for="blue">Синий</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="brown" value="brown"
                                                v-model="formData.selected_color_form">
                                            <label for="brown">Коричневый</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="grey" value="grey"
                                                v-model="formData.selected_color_form">
                                            <label for="grey">Серый</label>
                                        </div>
                                    </div>
                                </li>
                                <li class="drop_itemss_wrapper_item">
                                    <div class="drop_itemss_wrapper_item_btn">
                                        <i class='bx bx-expand'></i>
                                        <span v-if="formData.selected_size_form == ''"
                                            class="filter_drop_btn_title">Размер</span>
                                        <span v-else class="filter_drop_btn_title">Размер - {{ formData.selected_size_form
                                        }}</span>
                                        <i class="arrow-right bx bx-chevron-down bx-sm" style="display: block;"></i>
                                    </div>
                                    <div class="drop_itemss_wrapper_item_el">
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="40" value="40"
                                                v-model="formData.selected_size_form">
                                            <label for="40">40</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="41" value="41"
                                                v-model="formData.selected_size_form">
                                            <label for="41">41</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="42" value="42"
                                                v-model="formData.selected_size_form">
                                            <label for="42">42</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="43" value="43"
                                                v-model="formData.selected_size_form">
                                            <label for="43">43</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="44" value="44"
                                                v-model="formData.selected_size_form">
                                            <label for="44">44</label>
                                        </div>
                                        <div class="filter_drop_item">
                                            <input class="select_hidden_input" type="radio" id="45" value="45"
                                                v-model="formData.selected_size_form">
                                            <label for="45">45</label>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Цена:
                                </span>
                                <input required v-model="formData.form_newPrice" type="number" placeholder="4543">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Вес:
                                </span>
                                <input v-model="formData.form_weight" type="number" placeholder="340">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Материал:
                                </span>
                                <textarea required v-model="formData.form_material" placeholder="100% полиамид"></textarea>
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Осталось на складе:
                                </span>
                                <input required v-model="formData.form_count_in_store" type="number" placeholder="23">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Изображение 4:
                                </span>
                                <input required ref="form_img4" accept="image/*" type="file">
                            </label>
                        </div>
                        <div class="form_items">
                            <label for="">
                                <span class="form_items_title">
                                    Изображение 5:
                                </span>
                                <input required ref="form_img5" accept="image/*" type="file">
                            </label>
                        </div>

                    </div>
                </form>
            </div>
            <ul class="filter_ul">
                <li class="filter_item" title="Изменить тип">
                    <div class="filter_drop">
                        <div class="filter_drop_btn" @click="open_drop_type">
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
                                <input class="select_hidden_input" type="radio" id="jackets" value="jackets"
                                    v-model="selected_type">
                                <label for="jackets">Куртка</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="t_shirt" value="t_shirt"
                                    v-model="selected_type">
                                <label for="t_shirt">Футболки</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="trousers" value="trousers"
                                    v-model="selected_type">
                                <label for="trousers">Брюки</label>
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
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="snowboard" value="snowboard"
                                    v-model="selected_type">
                                <label for="snowboard">Сноуборды</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="roller_skates" value="roller_skates"
                                    v-model="selected_type">
                                <label for="roller_skates">Ролик. коньки</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="skateboard" value="skateboard"
                                    v-model="selected_type">
                                <label for="skateboard">Скейтборды</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="ski" value="ski"
                                    v-model="selected_type">
                                <label for="ski">Горные лыжи</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="helmet" value="helmet"
                                    v-model="selected_type">
                                <label for="helmet">Шлем</label>
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
                                <input class="select_hidden_input" type="radio" id="blue" value="blue"
                                    v-model="selected_color">
                                <label for="blue">Синий</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="brown" value="brown"
                                    v-model="selected_color">
                                <label for="brown">Коричневый</label>
                            </div>
                            <div class="filter_drop_item">
                                <input class="select_hidden_input" type="radio" id="grey" value="grey"
                                    v-model="selected_color">
                                <label for="grey">Серый</label>


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
            <h3 v-if="selected_type == 'jackets'" class="h3-catalog-title" style="padding: 0 !important;">Куртки</h3>
            <h3 v-if="selected_type == 't_shirt'" class="h3-catalog-title" style="padding: 0 !important;">Футболки</h3>
            <h3 v-if="selected_type == 'trousers'" class="h3-catalog-title" style="padding: 0 !important;">Брюки</h3>
            <h3 v-if="selected_type == 'sneakers'" class="h3-catalog-title" style="padding: 0 !important;">Кроссовки</h3>
            <h3 v-if="selected_type == 'boots'" class="h3-catalog-title" style="padding: 0 !important;">Ботинки</h3>
            <h3 v-if="selected_type == 'snowboard'" class="h3-catalog-title" style="padding: 0 !important;">Сноуборд</h3>
            <h3 v-if="selected_type == 'roller_skates'" class="h3-catalog-title" style="padding: 0 !important;">Роликовые
                коньки</h3>
            <h3 v-if="selected_type == 'skateboard'" class="h3-catalog-title" style="padding: 0 !important;">Скейтборд</h3>
            <h3 v-if="selected_type == 'ski'" class="h3-catalog-title" style="padding: 0 !important;">Горные лыжи</h3>
            <h3 v-if="selected_type == 'helmet'" class="h3-catalog-title" style="padding: 0 !important;">Шлем</h3>
            <h3 v-if="selected_type == ''" class="h3-catalog-title" style="padding: 0 !important;">Все товары</h3>
            <span style="padding: 12px 0 10px 10px;" class="count-all">{{ cardLength }}</span>
        </div>
        <div v-if="filteredItems.length == 0">
            <h3 class="h3-catalog-title">
                По результатам ваших параметров ничего не найдено...
            </h3>
        </div>
        <div v-else class="main-table">
            <table cellpadding='0' cellspacing='0' style='border-collapse:collapse'>
                <tr class="table_titles">
                    <th>id</th>
                    <th>Пол</th>
                    <th>Название</th>
                    <th>Описание</th>
                    <th>Старая цена</th>
                    <th>Новая цена</th>
                    <th>Размер</th>
                    <th>Цвет</th>
                    <th>Осталось</th>
                    <th>Производитель</th>
                    <th>Материал</th>
                    <th>Вес</th>
                    <th>img1</th>
                    <th>img2</th>
                    <th>img3</th>
                    <th>img4</th>
                    <th>img5</th>
                    <th>Действия</th>
                </tr>
                <tr class="table_par" v-for="item in filteredItems">
                    <td>
                        {{ item.id }}
                    </td>
                    <td>
                        <input class="table-input-sex" type="text" :value="item.sex">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.title">
                    </td>
                    <td>
                        <textarea>{{ item.description }}</textarea>
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.old_price">
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.new_price">
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.size">
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.color">
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.count_in_store">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.manufacturer">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.material">
                    </td>
                    <td>
                        <input class="table-input-num" type="text" :value="item.weight">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.img1">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.img2">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.img3">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.img4">
                    </td>
                    <td>
                        <input class="table-input" type="text" :value="item.img5">
                    </td>
                    <td class="fixed-cotrols">
                        <span class="contol_wrapper" title="Сохранить">
                            <i class='bx bx-check'></i>
                        </span>
                        <span class="contol_wrapper" @click="deleteItemById(item.id)" title="Удалить">
                            <i class='bx bx-trash'></i>
                        </span>
                    </td>
                </tr>
            </table>
        </div>
    </section>
</template>
<style scoped>
.c_point_btn {
    transition: 100ms all ease;
}

.c_point_btn:hover {
    cursor: pointer;
    opacity: 60%;
}

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

.c_point_item {
    transition: 200ms all ease;
}

.c_point_item:hover {
    cursor: pointer;
    opacity: 70% !important;
}

.c_point_item:active {
    opacity: 50% !important;
}

.orderss {
    display: block;
    width: 100% !important;
}

.orderss table {
    width: 100%;
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

.acc-acc-theme form {
    width: 45px;
    min-height: 45px;
    max-height: 45px;
}

.custom-file-upload input[type="file"] {
    display: none;
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

.custom-file-upload i {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
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








.contol_wrapper {
    display: block;
}

.contol_wrapper i {
    font-size: 20px;
    padding: 12px;
    border-radius: 5px;
    transition: 200ms all ease;
    text-align: center !important;
    width: 100%;
    margin-bottom: 5px;
}

.contol_wrapper i:hover {
    cursor: pointer;
    background-color: var(--table-body);
}

.contol_wrapper i:active {
    cursor: pointer;
    opacity: 70%;
}

.btn_add {
    margin-left: 15px;
    display: flex;
    position: absolute;
    left: 73px;
}

.btn_add i {
    padding: 8px;
    border-radius: 7px;
    background-color: var(--btn-add-back);
    color: var(--btn-add-el);
    font-weight: 500;
    font-size: 20px;
    transition: 200ms all ease;
}

.btn_add i:hover {
    opacity: 80%;
    cursor: pointer;
}

.btn_add i:active {
    opacity: 60%;
}


/* form */
.add_items_form_wrapper {
    width: 100%;
    background-color: var(--back);
    padding: 10px 30px 85px 30px;
    border-radius: 7px;
    margin-bottom: 20px;
    position: relative;
    box-shadow: 0px 5px 13px -3px rgba(34, 60, 80, 0.2);
}

.form_items {
    margin-bottom: 15px;
}

.form_items label {
    display: flex;
    flex-direction: column;
    font-size: 17px;
}

.add_items_form_wrapper form {
    display: flex;
    justify-content: space-between;
}

.add_items_form_wrapper_left {
    width: 49%;
}

.add_items_form_wrapper_right {
    width: 49%;
}

.form_items label textarea {
    margin: 0 !important;
    margin-top: 10px !important;
    font-weight: 300;
}

.form_items label input {
    font-weight: 300;
    padding-left: 20px !important;
}


.drop_itemss_wrapper {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.drop_itemss_wrapper_item {
    width: 49%;
    background-color: var(--input-back);
    color: var(--input-color);
    border-radius: 7px;
    font-size: 18px;
    padding: 9px 11px 9px 16px;
}

.drop_itemss_wrapper_item_btn {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.drop_itemss_wrapper_item_btn i {
    font-size: 20px;
}

.drop_itemss_wrapper_item {
    position: relative;
}

.drop_itemss_wrapper_item:hover {
    cursor: pointer;
    background-color: var(--input-focus);
}

.drop_itemss_wrapper_item:hover .drop_itemss_wrapper_item_el {
    display: block;
    background-color: var(--input-focus);
}

.drop_itemss_wrapper_item_el {
    position: absolute;
    z-index: 999;
    display: none;
    background-color: var(--input-focus);
    color: var(--input-color);
    left: 0;
    padding: 15px 0 10px 2px;
    width: 100%;
    top: 35px;
    border-radius: 5px;
    font-size: 18px;
    font-weight: 300;
    transition: 200ms all ease;
}

.btn_wrapper {
    position: absolute;
    bottom: -30px;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%)
}

.btn {
    background-color: var(--alert-btn);
    color: var(--alert-btn_color);
    font-size: 16px;
    font-weight: 400;
    width: 100%;
    padding: 13px 100px;
}
</style>