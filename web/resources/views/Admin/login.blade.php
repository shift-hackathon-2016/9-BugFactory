<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin login | Ceres</title>

    <!-- Bootstrap -->
    <link href="{{ asset('assets/vendors/bootstrap/dist/css/bootstrap.min.css') }}" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="{{ asset('assets/vendors/font-awesome/css/font-awesome.min.css') }}" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="{{ asset('assets/build/css/custom.min.css') }}" rel="stylesheet">

    <style>
        .error {
            background: #e74c3c;
            font-size: 14px;
            width: 100%;
            display: block;
            line-height: 40px;
            border-radius: 3px;
            color: #fff;
            text-shadow: none;
            font-weight:bold;
        }
    </style>
</head>

<body class="login">
<div>

    <div class="login_wrapper">
        <div class="animate form login_form">
            <section class="login_content">
                <form method="post">
                    <h1>Admin login</h1>
                        {{ csrf_field() }}
                    <div>
                        <input type="text" class="form-control" placeholder="Email" name="email" required="" />
                    </div>
                    <div>
                        <input type="password" class="form-control" placeholder="Password" name="password" required="" />
                    </div>
                    <div>
                        <p class="error">Invalid credentials</p>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-default submit">Log in</button>
                        {{--<a class="reset_pass" href="#">Lost your password?</a>--}}
                        {{-- @todo-mario: do we need forgot pw? --}}
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <div>
                            <p>©2016 All Rights Reserved. Made with love at Shift hackaton ❤️</p>
                        </div>
                    </div>
                </form>
            </section>
        </div>

    </div>
</div>
</body>
</html>
