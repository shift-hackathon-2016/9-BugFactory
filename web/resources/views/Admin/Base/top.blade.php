<div class="top_nav">
    <div class="nav_menu">
        <nav class="" role="navigation">
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <img src="{{ Auth::user()->getAvatarUrl() }}" alt="">{{ Auth::user()->getFullName() }}
                        <span class=" fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu pull-right">
                        <li><a href="/logout"><i class="fa fa-sign-out pull-right"></i>Logout</a></li>
                    </ul>
                </li>

            </ul>
        </nav>
    </div>
</div>
