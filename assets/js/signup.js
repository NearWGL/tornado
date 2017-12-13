


$(document).ready(function() {

    $('#registration-form').validate({

        rules: {
            email: {
                remote: {
                    url: ajaxPath,
                    type: "post"
                }
            },
            password2: {
                equalTo: "#password1"
            },
        },
        messages: {
            email: {
                email: "Введите корректный email",
                remote: "Пользователь с такой почтой уже существует"
            },
            password2: {
                equalTo: "Пароли не совпадают"
            }
        },

    })
})