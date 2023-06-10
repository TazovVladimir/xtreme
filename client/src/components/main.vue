<script>
import notFoundPage from "../pages/notFoundPage.vue"
import accCart from "../pages/accCart.vue"

export default {
    components: {
        notFoundPage,
        accCart,
    },
    data() {
        return {
            ifOut: 'true',
            posY: 0,
            margin: 0,
            account_info: null,
            user_id: localStorage.getItem('user_id'),
        }
    },
    created() {
        window.addEventListener('scroll', this.handleScroll);
    },
    unmounted() {
        window.removeEventListener('scroll', this.handleScroll);
    },
    methods: {
        handleScroll() {
            if (scrollY > 250 && scrollY > this.posY) {
                this.ifOut = false
            }
            else {
                this.ifOut = true
            }
            this.posY = scrollY
        },
        auth() {
            this.$router.push('/auth')
        },
        toAcc() {
            this.$router.push('/account')
        }
    },
    mounted() {
        const data = localStorage.getItem('token');
        if (data) {
            this.$store.dispatch('setUserStatus');
            this.$store.dispatch('setUserId');
            axios.get(`/account/${this.user_id}`)
                .then(response => {
                    this.account_info = response.data
                })
                .catch(error => (console.log(error)));
        }
        else {
            this.$store.dispatch('delUserStatus');
            this.$store.dispatch('delUserId');
        }

    }, computed: {
        isAuth() {
            return this.$store.state.user;
        },
    }
}
</script>
<template>
    <main v-if="!$route.meta.hideHeader">
        <div class="top-menu" :class="{ out: !ifOut }">
            <h2 class="h2">{{ $route.name }} <span class="h2-span">{{ $route.meta.cat_name }}</span></h2>
            
            <div class="acc-par">
                <!-- <span class="acc-par-cart">
                    <i class="p-icon-catalog bx bx-cart bx-sm"></i>
                </span> -->
                <ul class="to-acc" v-if="isAuth" @click="toAcc">
                    <li class="to-acc-items to-acc-items-avatar-wrapper">
                        <img v-for="item in account_info" :src="'http://localhost:5000/uploads/' + item.avatar"
                            alt="avatar">
                    </li>
                    <li class="to-acc-items to-acc-items-name" v-for="item in account_info">
                        {{ item.name }}
                    </li>
                </ul>


                <ul v-else class="to-acc-to" @click="auth()">
                    <li class="to-acc-items to-acc-items-auth">
                        Войти
                    </li>
                </ul>
            </div>

        </div>
        <router-view />
    </main>
    <main style="margin-left: 0; padding: 0; background-color: var(--back);;" v-else>
        <router-view />
    </main>
</template>
  
<style scoped>
.acc-par {
    display: flex;
    align-items: center;
}
.h2-span{
    font-weight: 400;
    font-size: 18px;
    color: var(--drop-a);
    padding-left: 3px;
}
.to-acc-items-cart {
    position: absolute;
    left: 0;
}

.out {
    transform: translateY(-100%);
}

main {
    padding: 20px;
    margin-left: 340px;
    background-color: var(--main);
    min-height: 100vh;
    position: relative;
    padding-top: 75px;
}

.to-acc-items-avatar-wrapper {
    margin-left: 6px;
    background-color: #535353;
    border-radius: 50%;
}

.top-menu {
    transition: transform 300ms ease;
    top: 0;
    left: 338px;
    right: 0;
    padding: 0 22px;
    position: fixed;
    z-index: 99999999;
    background-color: var(--back);
    display: flex;
    justify-content: space-between;
    align-items: center;
    /* border-bottom: 1px solid var(--border); */
    box-shadow: 0px 10px 5px -6px  var(--main-top);
}

h2 {
    font-weight: 400;
    font-size: 20px;
    color: var(--color-text);
    padding: 25px 0;
}

.to-acc {
    /* background-color: var(--back); */
    bottom: 20px;
    padding: 4px 17px 5px 17px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    transition: 200ms all ease;
}

.to-acc-to {
    bottom: 20px;
    padding: 6px 65px 6px 65px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    transition: 200ms all ease;
    background-color: var(--alert-btn);
    color: var(--alert-btn_color);
}

.to-acc-to li {
    color: var(--alert-btn_color);
}

.to-acc-to:hover {
    opacity: 70%;
    cursor: pointer;
}

.to-acc-to:active {
    opacity: 50%;
}

.to-acc-items-auth {
    padding-left: 24px;
    text-align: center;
    width: 100%;
    color: #fff;
}

.to-acc:hover {
    background-color: var(--nav-back);
    cursor: pointer;
}

.to-acc:active {
    opacity: 50%;
}

.to-acc-items-avatar-wrapper {
    width: 46px;
    height: 46px;
}

.to-acc-items-avatar-wrapper img {
    width: 46px;
    height: 46px;
    border-radius: 50%;
    object-fit: cover;
}

.to-acc-items i {
    color: #fff;
    position: absolute;
    right: 14px;
    top: 50%;
    transform: translate(0, -50%);
}

.to-acc-items-name {
    font-size: 18px;
    font-weight: 400;
    color: var(--color-text);
    margin-left: 15px;
}

.to-acc-items-auth {
    text-align: center;
    width: 100%;
    color: var(--color-text);
    padding: 5px 0;
}
</style>