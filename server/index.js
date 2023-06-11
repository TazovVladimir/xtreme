import express from 'express'
import bodyParser from 'body-parser'
import cors from 'cors'
import mysql from 'mysql'
import { authValidation } from './validations/auth.js'
import { validationResult } from 'express-validator'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import multer from 'multer'
import path from 'path'

const app = express();
const port = 5000;
app.use(cors());
app.use(bodyParser.json());


const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'sport_database'
});

connection.connect((err) => {
    if (err) throw err;
    console.log('--База подключена--');
});

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './uploads');
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});
const upload = multer({ storage: storage });

app.use('/uploads', express.static('uploads'));


app.get('/', (req, res) => {
    res.json({
        info: 'Добро пожловать в API SportRent',
        v: '1.0.0',
    });
});
// reg
app.post('/register', async (req, res) => {
    try {
        const { name, login, password } = req.body;
        await connection.query('SELECT * FROM users WHERE login = ?', [login], async (err, results) => {
            const avatar = 'def.png';
            if (err) throw err;
            if (results.length > 0) {
                res.status(400).json({
                    succes: "false",
                    login: login,
                    msg: `Пользователь с логином ${login} уже существует`,
                });
            } else {
                const salt = await bcrypt.genSalt(10);
                const hash = await bcrypt.hash(password, salt);

                await connection.query('INSERT INTO users (name, login, password, avatar) VALUES (?, ?, ?, ?)', [name, login, hash, avatar], async (err, results) => {
                    const insertedId = results.insertId;
                    // console.log(insertedId)
                    const token = jwt.sign({
                        token_id: insertedId,
                    },
                        'secret123',
                    );
                    console.log(token)
                    res.json({
                        succes: "true",
                        userName: login,
                        userPassword: hash,
                        msg: `Пользователь с именем ${name} создан`,
                        token
                    });
                });

            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка при регистрации"
        })
    }
});


// auth
app.post('/auth', authValidation, async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json(errors.array());
        }
        const { login, password } = req.body;
        await connection.query('SELECT * FROM users WHERE login = ?', [login], async (err, results) => {
            if (err) throw err;
            if (results.length > 0) {
                const isValidPass = await bcrypt.compare(password, results[0].password);
                const token = jwt.sign({
                    token_id: results[0].id,
                },
                    'secret123',
                );
                if (isValidPass) {
                    res.status(200).json({
                        succes: "true",
                        login: login,
                        msg: `Пользователь с логином ${login} авторизован`,
                        token,
                    });
                } else {
                    res.status(401).json({
                        msg: "Неверный логин или пароль"
                    });
                }
            } else {
                res.status(404).json({
                    msg: "Пользователь не найден"
                });
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка при авторизации"
        })
    }
});

// account
app.get('/account/:id', async (req, res) => {
    try {
        const id = await req.params.id;
        const query = await `SELECT id, name, avatar FROM users WHERE id = ${id}`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(404).json({
                    msg: "Не найдено",
                });
            } else {
                if (results == '') {
                    res.status(404).json({
                        msg: "Не найдено",
                    });
                }
                else {
                    res.json(results);
                }
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// change avatar
app.post('/update-avatar/:id', upload.single('avatar'), (req, res) => {
    const userId = req.params.id;
    const avatar = `${req.file.filename}`;
    const query = `UPDATE users SET avatar = '${avatar}' WHERE id = ${userId};`;
    connection.query(query, [userId], (err, results, fields) => {
        if (err) throw err;
        res.send('Аватарка обновлена');
    });
});

// post rev
app.post('/post-reviews', (req, res) => {
    const { item_id, user_id, item_title, text, user_avatar, user_name } = req.body;

    const date = new Date();

    const dateString = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;


    connection.query(`INSERT INTO rev (item_id, user_id, item_title, text, user_avatar, user_name, date) VALUES (?, ?, ?, ?, ?, ?, '${dateString}')`, [item_id, user_id, item_title, text, user_avatar, user_name], (err, results) => {
        if (err) throw err;
        res.json({ id: results.insertId, item_id, user_id, item_title, text, user_avatar, user_name, date });
    });
});
// get rev
app.get('/get-reviews/:id', (req, res) => {
    try {
        const id = req.params.id;
        const sql = `SELECT * FROM rev WHERE item_id = '${id}' ORDER BY id DESC`
        connection.query(sql, (err, results) => {
            if (err) throw err;
            res.send(results);
        })
    } catch (err) {
        res.status(500).json({
            error: err
        })
    }
});
// get rev by user_id
app.get('/get-reviews-user/:id', (req, res) => {
    const id = req.params.id;
    connection.query(`SELECT * FROM rev WHERE user_id = '${id}' ORDER BY id DESC`, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});
// del rev by id
app.delete('/del-rev/:id', (req, res) => {
    try {
        const id = req.params.id;
        const query = `DELETE FROM rev WHERE id = ${id}`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(404).json({
                    msg: "Не найдено",
                });
            } else {
                if (results == '') {
                    res.status(404).json({
                        msg: "Не найдено",
                    });
                }
                else {
                    res.json({
                        results,
                        msg: `id: ${id} успешно удален`
                    });
                }
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// get catalog clothes
app.get('/get-all-by-catalog-type', (req, res) => {
    try {
        const category = req.query.category;
        if (category != 'all') {
            const query = `SELECT * FROM all_catalog WHERE category = ?`;
            connection.query(query, category, (err, results) => {
                if (err) {
                    res.status(500).json({
                        msg: "error"
                    });
                } else {
                    res.json(results);
                }
            });
        }
        else {
            const query = `SELECT * FROM all_catalog`;
            connection.query(query, category, (err, results) => {
                if (err) {
                    res.status(500).json({
                        error: "error"
                    });
                } else {
                    res.json(results);
                }
            });
        }
    } catch (err) {
        res.status(500).json({
            error: "error"
        })
    }
});
// get all catalog by id
app.get('/get-by-id/:id', (req, res) => {
    try {
        const id = req.params.id;
        const query = `SELECT * FROM all_catalog WHERE id = ${id}`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(404).json({
                    error: "404 not found",
                });
            } else {
                if (results == '') {
                    res.status(404).json({
                        error: "404 not found",
                    });
                }
                else {
                    res.json(results);
                }
            }
        });
    } catch (err) {
        res.status(500).json({
            error: err
        })
    }
});
// add-to-cart
//v-3
app.post('/add-cart', (req, res) => {
    try {
        const { user_id, item_id, title, price, img, color, size, quantity, selected } = req.body;
        // проверка что уже есть
        const checkCartItemQuery = `SELECT * FROM cart WHERE user_id = ${user_id} AND item_id = ${item_id}`;
        connection.query(checkCartItemQuery, (err, results) => {
            if (err) throw err;
            if (results.length > 0) {
                // 
                const quantity = results[0].quantity
                // console.log(quantity)
                const srcCountInStore = `SELECT * FROM all_catalog WHERE id = ${item_id}`
                connection.query(srcCountInStore, (err, results) => {
                    if (err) throw err;
                    let count_in_store = results[0].count_in_store
                    // ищем остались ли
                    if (count_in_store > 0) {
                        // да остались
                        const addToCartReqAndDelCount = `UPDATE all_catalog SET count_in_store = ${count_in_store - 1} WHERE id = ${item_id}`
                        connection.query(addToCartReqAndDelCount, (err, results) => {
                            if (err) throw err;
                            // console.log(count_in_store - 1)
                            const addToCartReq = `UPDATE cart SET quantity = ${quantity + 1} WHERE user_id = ${user_id} AND item_id = ${item_id}`
                            connection.query(addToCartReq, (err, results) => {
                                if (err) throw err;
                                res.send(results);
                                // console.log(results)
                            })
                        })
                    } else {
                        // не остались
                        console.log('Товара больше нет на складе')
                    }
                })

            } else {
                // нет
                const sql = 'INSERT INTO cart (user_id, item_id, title, price, img, color, size, quantity, selected) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
                const values = [user_id, item_id, title, price, img, color, size, quantity, selected];
                connection.query(sql, values, (err, result) => {
                    if (err) throw err;
                    const srcCountInStore = `SELECT * FROM all_catalog WHERE id = ${item_id}`
                    connection.query(srcCountInStore, (err, results) => {
                        if (err) throw err;
                        let count_in_store2 = results[0].count_in_store
                        const addToCartReqAndDelCount = `UPDATE all_catalog SET count_in_store = ${count_in_store2 - 1} WHERE id = ${item_id}`
                        connection.query(addToCartReqAndDelCount, (err, results) => {
                            if (err) throw err;
                            res.send(results);
                        })
                    })
                });
            }
        })
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }

});
// get cart by user_id
app.get('/get-cart/:id', (req, res) => {
    try {
        const id = req.params.id;
        connection.query(`SELECT * FROM cart WHERE user_id = '${id}'`, (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// get orders by user_id !completed
app.get('/get-orders/:id', (req, res) => {
    try {
        const id = req.params.id;
        connection.query(`SELECT * FROM orders WHERE user_id = '${id}' && status != 'completed'`, (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// get orders by user_id == completed
app.get('/get-orders-completed/:id', (req, res) => {
    try {
        const id = req.params.id;
        connection.query(`SELECT * FROM orders WHERE user_id = '${id}' && status = 'completed'`, (err, results) => {
            if (err) throw err;
            res.json(results);
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// ++quantity
app.post('/quantity-plus', (req, res) => {
    try {
        const { item_id, user_id } = req.body;
        connection.query(`SELECT * FROM all_catalog WHERE id = '${item_id}'`, (err, results) => {
            if (err) throw err;
            let count_in_store = results[0].count_in_store
            if (count_in_store == 0) {
                console.log('нет больше на складе');
                res.status(304).json({
                    msg: "Товара больше нет"
                })
            } else {
                connection.query(`SELECT * FROM cart WHERE item_id = '${item_id}'`, (err, results) => {
                    if (err) throw err;
                    let quantity = results[0].quantity
                    const addToCartReq = `UPDATE cart SET quantity = ${quantity + 1} WHERE user_id = ${user_id} AND item_id = ${item_id}`
                    connection.query(addToCartReq, (err, results) => {
                        if (err) throw err;
                        const addToCartReqAndDelCount = `UPDATE all_catalog SET count_in_store = ${count_in_store - 1} WHERE id = ${item_id}`
                        connection.query(addToCartReqAndDelCount, (err, results) => {
                            if (err) throw err;
                            res.send(results);
                        })
                    })
                })
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// --quantity
app.post('/quantity-minus', (req, res) => {
    try {
        const { item_id, user_id } = req.body;
        connection.query(`SELECT * FROM cart WHERE user_id = '${user_id}' AND item_id = '${item_id}' `, (err, results) => {
            if (err) throw err;
            if (results.length > 0) {
                let quantity = results[0].quantity
                if (quantity != 1) {
                    const addToCartReq = `UPDATE cart SET quantity = ${quantity - 1} WHERE user_id = ${user_id} AND item_id = ${item_id}`
                    connection.query(addToCartReq, (err, results) => {
                        if (err) throw err;
                        if (results) {
                            connection.query(`SELECT * FROM all_catalog WHERE id = '${item_id}'`, (err, results) => {
                                if (err) throw err;
                                if (results.length > 0) {
                                    let count_in_store = results[0].count_in_store
                                    const addToCartReqAndDelCount = `UPDATE all_catalog SET count_in_store = ${count_in_store + 1} WHERE id = ${item_id}`
                                    connection.query(addToCartReqAndDelCount, (err, results) => {
                                        if (err) throw err;
                                        res.send(results);
                                    })
                                }
                            })
                        }
                    })
                }
                else {
                    console.log('равно 0')
                }
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// /items-check
app.put('/items-check/:id', (req, res) => {
    try {
        const itemId = req.params.id;
        const selected = req.body.selected;
        const user_id = req.body.user_id;
        connection.query('UPDATE cart SET selected = ? WHERE id = ? AND user_id = ?', [selected, itemId, user_id], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Ошибка сервера' });
            } else {
                res.sendStatus(200);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }

});

// item-check-all
app.post('/items-check-all/:id', (req, res) => {
    try {
        const user_id = req.params.id;
        const selected = req.body.selected;
        connection.query('UPDATE cart SET selected = ? WHERE user_id = ?', [selected, user_id], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Ошибка сервера' });
            } else {
                res.sendStatus(200);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
})

// del item into cart
app.post('/del-into-cart/', (req, res) => {
    try {
        const items = req.body.items;

        items.forEach(item => {
            const id = item.id
            const item_id = item.item_id
            const quantity = item.quantity
            connection.query(`UPDATE all_catalog SET count_in_store = count_in_store + ${quantity}  WHERE id = ${item_id}`, (error, results) => {
                if (error) {
                    console.error(error);
                } else {
                    // console.log(results)
                    connection.query(
                        'DELETE FROM cart WHERE id = ?', [id], (err, result) => {
                            if (err) throw err;
                        })
                }
            });
        });
        res.send(result);
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// get catalog_recent
app.get('/get-all-recent', (req, res) => {
    try {
        const query = `SELECT * FROM all_catalog`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(500).json({
                    msg: "Ошибка"
                });
            } else {
                res.json(results);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// get catalog подборка
app.get('/get-all-random', (req, res) => {
    try {
        const query = `SELECT * FROM all_catalog ORDER BY RAND() LIMIT 20;`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(500).json({
                    msg: "Ошибка"
                });
            } else {
                res.json(results);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});


// /add-new-item
app.post('/add-new-item', upload.array('images', 5), (req, res) => {
    try {
        const { selected_cat_form, selected_type_form, selected_color_form, selected_size_form, form_manufacturer, form_title, form_description, form_newPrice, form_weight, form_material, form_count_in_store } = req.body;
        const images = req.files.map((file) => file.filename);
        const sql = 'INSERT INTO all_catalog (category, type, color, size, manufacturer, title, description, new_price, weight, material, count_in_store, img1, img2, img3, img4, img5, sex) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        const values = [selected_cat_form, selected_type_form, selected_color_form, selected_size_form, form_manufacturer, form_title, form_description, form_newPrice, form_weight, form_material, form_count_in_store, ...images, 'мужской'];

        connection.query(sql, values, (err, result) => {
            if (err) {
                console.error('Ошибка при добавлении товара в базу данных: ', err);
                res.status(500).send('Ошибка сервера');
            } else {
                console.log('Товар успешно добавлен в базу данных');
                res.status(200).send('Товар успешно добавлен');
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }

});
// del items admin by id
app.delete('/del-item-id/:id', (req, res) => {
    try {
        const id = req.params.id;
        const query = `DELETE FROM all_catalog WHERE id = ${id}`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(404).json({
                    msg: "Не найдено",
                });
            } else {
                if (results == '') {
                    res.status(404).json({
                        msg: "Не найдено",
                    });
                }
                else {
                    res.json({
                        results,
                        msg: `id: ${id} успешно удален`
                    });
                }
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});

// add-to-orders
app.post('/add-to-orders', (req, res) => {
    try {
        const { user_id, points } = req.body;
        const query = `SELECT * FROM cart WHERE user_id = ${user_id}  && selected = 'true';`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(500).json({
                    err: `Ошибка ${err}`
                });
            } else {
                const ids = results.map(item => [item.id]);
                const query = 'INSERT INTO orders (user_id, item_id, title, price, img, color, size, quantity, status, point) VALUES ?';
                const values = results.map(item => [item.user_id, item.item_id, item.title, item.price = item.price * item.quantity, item.img, item.color, item.size, item.quantity, 'accepted', points]);
                connection.query(query, [values], (error, results) => {
                    if (error) {
                        console.error('Ошибка при сохранении заказа:', error);
                        res.status(500).json({ error: 'Ошибка при сохранении заказа' });
                    } else {
                        const query = `DELETE FROM cart WHERE id IN (${ids})`;
                        connection.query(query, (err, results) => {
                            if (err) {
                                res.status(404).json({
                                    msg: "Не найдено",
                                });
                            } else {
                                res.status(200).send(`Товар успешно добавлен ${results}`);
                            }
                        });
                    }
                });
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});

// get all orders
app.get('/get-all-orders', (req, res) => {
    try {
        const query = `SELECT * FROM orders ORDER BY id DESC`;
        connection.query(query, (err, results) => {
            if (err) {
                res.status(500).json({
                    msg: "Ошибка"
                });
            } else {
                res.json(results);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
});
// update status
app.post('/update-status', (req, res) => {
    try {
        const id = req.body.id;
        const status = req.body.status;
        connection.query('UPDATE orders SET status = ? WHERE id = ?', [status, id], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Ошибка сервера' });
            } else {
                res.sendStatus(200);
            }
        });
    } catch (err) {
        res.status(500).json({
            msg: "Произошла ошибка на стороне сервера"
        })
    }
})


app.listen(port, () => {
    console.log(`Сервер запущен на порту -- ${port} --`);
});
