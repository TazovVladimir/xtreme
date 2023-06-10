<script>
</script>
<template>
<footer>
    <ul class="footer-ul-main">
        <li class="logo-footer">
            <router-link to="/">
                <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="62.000000pt" height="28.000000pt"
                    viewBox="0 0 62.000000 28.000000" preserveAspectRatio="xMidYMid meet">
                    <g transform="translate(0.000000,28.000000) scale(0.100000,-0.100000)" fill="" stroke="none">
                        <path
                            d="M302 230 c-32 -39 -34 -39 -58 -24 -29 20 -30 20 -156 -118 l-80 -88 302 0 303 0 -129 133 c-71 72 -133 133 -139 134 -5 2 -25 -15 -43 -37z m-64 -32 c18 -18 15 -29 -18 -68 l-29 -35 2 45 c4 65 19 84 45 58z m332 -180 c0 -4 -31 -8 -68 -8 -67 0 -68 0 -112 45 l-45 45 35 -6 34 -7 -34 43 c-34 44 -31 45 22 8 39 -27 41 -23 13 30 -25 44 -20 40 64 -47 50 -52 91 -98 91 -103z" />
                    </g>
                </svg>
                <span class="name-comp">xtreme</span>
            </router-link>
        </li>
        <li>
            <ul class="footer-nav">
                <li>
                    <router-link to="/" class="footer-a">
                        Главная
                    </router-link>
                </li>
                <li>
                    <router-link to="/account" class="footer-a">
                        Аккаунт
                    </router-link>
                </li>
                <li>
                    <router-link to="/extreme-item" class="footer-a">
                        Экстремальные товары
                    </router-link>
                </li>
            </ul>
        </li>
    </ul>
</footer>
</template>
<style scoped>
footer {
    border-top: 1px solid var(--footer-border);
    position: relative;
    width: 100%;
    background-color: var(--footer-back);
    padding: 30px 0;
    z-index: 99;

}

.logo-footer a {
    display: flex;
    align-items: center;
    color: var(--footer-logo);
    font-weight: 600;
    font-size: 20px;
    line-height: 23px;
    margin-bottom: 15px;

}

.logo-footer .name-comp {
    padding-left: 10px;
    font-weight: 500;
    letter-spacing: 1px;
}

.logo-footer path {
    fill: var(--footer-logo);
}

.logo-footer svg {
    min-width: 50px;
    max-width: 50px;
}

.footer-nav {
    display: flex;
}

.footer-ul-main {
    width: 100%;
    margin: 0 auto;
}

.footer-ul-main {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.footer-a {
    font-size: 16px;
    font-weight: 300;
    color: var(--footer-nav-a);
    transition: 200ms all ease;
}

.footer-a:hover {
    opacity: 70%;
}

.footer-nav li {
    padding-right: 20px;
}

.footer-nav li:last-child {
    padding-right: 0;
}
</style>