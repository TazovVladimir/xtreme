<script>
</script>
<template>
    <div class="main">
        <h1>ОЙ! что-то пошло не так...</h1>
        <p class="notfound">
            404
        </p>
        <p class="p">
            Похоже, мы не можем найти нужную вам страницу...
        </p>
        <router-link to="/">
            <span>На главную</span>
        </router-link>
    </div>
</template>
<style scoped>
.main {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
}

h1 {
    color: var(--color-text);
    font-size: 30px;
    text-align: center;
}

.notfound {
    text-align: center;
    font-size: 200px;
    font-weight: 500;
    color: var(--color-404);
}

p {
    text-align: center;
    margin: 10px 0;
}

.p {
    text-align: center;
    font-weight: 200;
    font-size: 18px;
    color: var(--drop-a);
}

span {
    display: block;
    text-align: center;
    color: var(--btn-b);
    font-weight: 400;
}

span:hover {
    opacity: 70%;
}
</style>