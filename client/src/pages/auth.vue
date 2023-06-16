<script>
import axios from 'axios'
export default {
    data() {
        return {
            login: '',
            password: '',
            error: false,
            isDisabled: true,
            isTrue: false,
            isnTrue: true,
            isTruep: false,
            isnTruep: true
        };
    },
    methods: {
        auth() {
            const { login, password } = this;
            try {
                axios.post('/auth', { login, password })
                    .then(response => {
                        localStorage.setItem('token', response.data.token);
                        localStorage.setItem('admin', response.data.admin);
                        this.$store.dispatch('setUserStatus');
                        this.$store.dispatch('setUserId');
                        let admin = localStorage.getItem('admin');
                        this.isError = false;
                        if (admin == '0') {
                            this.$router.push('/account');
                        }else if (admin == '1') {
                            this.$router.push('/admin');
                        }
                        window.location.reload();
                    })
                    .catch(error => (console.log(error)));
            } catch (error) {
                console.error(error);
                this.error = true,
                    this.isnTrue = true,
                    this.isnTruep = true,
                    this.isDisabled = true,
                    this.isTrue = false,
                    this.isTruep = false
            }
        },

        validateInputs() {
            if (this.login.length >= 2) {
                this.isTrue = true
                this.isnTrue = false
                this.error = false
            }
            else {
                this.isTrue = false
                this.isnTrue = true
            }

            if (this.password.length >= 8) {
                this.isTruep = true
                this.isnTruep = false
                this.errorp = false
            }
            else {
                this.isTruep = false
                this.isnTruep = true
            }

            if (this.isTrue == true && this.isTruep == true) {
                this.isDisabled = false;
            } else {
                this.isDisabled = true;
            }
        }
    },
    mounted() {
        const data = localStorage.getItem('token');
        const admin = localStorage.getItem('admin');
        if (data) {
            if (admin == '0') {
                this.$router.push('/account');
            } else if (admin == '1') {
                this.$router.push('/admin');
            }
        }else{
            this.$router.push('/auth');
        }
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    }
};

</script>

<template>
    <section class="section-reg">
        <div class="reg">
            <p class="form-title">Авторизация</p>
            <form @submit.prevent="auth">
                <div class="form-item">
                    <label for="login">
                        Логин:
                        <input :class="{ 'input-error': error }" @input="validateInputs" name="login" type="text"
                            v-model="login" placeholder="Vladimir" required>
                        <i :class="{ 'green': isTrue }" class='bx bx-check bx-sm'></i>
                        <i :class="{ 'red': isnTrue }" class='bx bx-error-circle bx-sm'></i>
                    </label>
                </div>
                <div class="form-item">
                    <label for="password">
                        Пароль:
                        <input :class="{ 'input-error': error }" @input="validateInputs" name="password" type="password"
                            v-model="password" placeholder="Password" required>
                        <i :class="{ 'green': isTruep }" class='bx bx-check bx-sm'></i>
                        <i :class="{ 'red': isnTruep }" class='bx bx-error-circle bx-sm'></i>
                    </label>
                    <span>
                        <router-link tag="a" to="/reg">Нет аккаунта?</router-link>
                    </span>
                </div>
                <button :disabled="isDisabled" type="submit" class="btn">Войти</button>
            </form>
        </div>
    </section>
</template>
<style scoped>
.input-error {
    outline: 1px solid rgb(255, 97, 97);
}

.section-reg {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
}

.warning {
    font-size: 12px;
    color: rgb(255, 147, 147);
    opacity: 60%;
    font-weight: 200;
    margin-bottom: 0;
}

.error {
    width: 100%;
    background-color: rgb(248, 181, 181);
    margin-bottom: 20px;
    border-radius: 2px;
}

.error span {
    padding: 5px 0;
    text-align: center;
    font-size: 15px;
    font-weight: 400;
    color: rgb(136, 5, 5);
}

form {
    width: 300px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
}

.form-item {
    position: relative;
}

.form-item i {
    opacity: 0;
    position: absolute;
    right: 13px;
    top: 36px;
    transition: 200ms opacity ease;
}

.form-item i.green {
    opacity: 1 !important;
    color: var(--input-green);
}

.form-item i.red {
    opacity: 1 !important;
    color: var(--input-red);
}

.form-item:first-child {
    margin-bottom: 18px;
}

input {
    padding-left: 15px;
    width: 100%;
}

.form-title {
    font-size: 24px;
    font-weight: 400;
    color: var(--color-text);
    margin-bottom: 20px;
    text-align: center;
}

span {
    margin: 10px 0;
    display: block;
    font-size: 14px;
    font-weight: 300;
    transition: 200ms all ease;
}

.reg {
    position: relative;
}

.logo-li a img {
    width: 124px;
}

span a {
    color: var(--color-text) !important;
}

span a:hover {
    opacity: 70%;
}

.btn {
    padding: 13px 0 !important;
    background-color: var(--alert-btn);
    color: var(--alert-btn_color);
    font-weight: 400;
    font-size: 16px;
    opacity: 1;
    transition: 200ms all ease;
}
</style>