<script>
import axios from 'axios'
export default {
    data() {
        return {
            name: '',
            login: '',
            password: '',
            error: false,
            isDisabled: true,
            isTrue: false,
            isnTrue: true,
            isTruep: false,
            isnTruep: true,
            isTruepp: false,
            isnTruepp: true
        };
    },
    methods: {
        async reg() {
            const { name, login, password } = this;
            try {
                const response = await axios.post('/register', { name, login, password });
                localStorage.setItem('token', response.data.token);
                this.isError = false;
                await this.$store.dispatch('setUserStatus');
                await this.$store.dispatch('setUserId');
                await this.$router.push('/account');
            } catch (error) {
                console.error(error),
                    this.error = true,
                    this.isnTrue = true,
                    this.isnTruep = true,
                    this.isDisabled = true,
                    this.isTrue = false,
                    this.isTruep = false,
                    this.isTruepp = false,
                    this.isnTruepp = false
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
            if (this.name.length >= 2) {
                this.isTruepp = true
                this.isnTruepp = false
                this.errorp = false
            }
            else {
                this.isTruepp = false
                this.isnTruepp = true
            }

            if (this.isTrue == true && this.isTruep == true && this.isTruepp == true) {
                this.isDisabled = false;
            } else {
                this.isDisabled = true;
            }
        }

    },
    mounted() {
        const data = localStorage.getItem('token');
        if (data) {
            this.$router.push('/');
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
            <p class="form-title">Регистрация</p>
            <form @submit.prevent="reg">
                <div class="form-item">
                    <label for="name">
                        Имя:
                        <input :class="{ 'input-error': error }" @input="validateInputs" name="name" type="text"
                            v-model="name" placeholder="Владимир" required>
                        <i :class="{ 'green': isTruepp }" class='bx bx-check bx-sm'></i>
                        <i :class="{ 'red': isnTruepp }" class='bx bx-error-circle bx-sm'></i>
                    </label>
                </div>
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
                        <router-link tag="a" to="/auth">Есть аккаунт?</router-link>
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
    margin-bottom: 18px;
}

.form-item:last-child {
    margin-bottom: 0;
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