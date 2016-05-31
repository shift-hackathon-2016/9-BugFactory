@extends('Admin.Base.outer')

@section('content')
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Contacts Design</h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_content">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 text-center">

                                </div>

                                <div class="clearfix"></div>

                                {{-- @todo-mario: remove placeholders --}}
                                @foreach($users as $user)
                                <div class="col-md-4 col-sm-4 col-xs-12 profile_details">
                                    <div class="well profile_view">
                                        <div class="col-sm-12">
                                            <h4 class="brief"><i>Digital Strategist</i></h4>
                                            <div class="left col-xs-7">
                                                <h2>{{ $user->getFullName() }}</h2>
                                                <p><strong>About: </strong> Web Designer / UX / Graphic Artist / Coffee Lover </p>
                                                <ul class="list-unstyled">
                                                    <li><i class="fa fa-building"></i> Address: </li>
                                                    <li><i class="fa fa-phone"></i> Phone #: </li>
                                                </ul>
                                            </div>
                                            <div class="right col-xs-5 text-center">
                                                <img src="https://scontent.xx.fbcdn.net/v/t1.0-1/p160x160/13173889_904055209705974_243839054961463998_n.jpg?oh=7c0d379e3bcdbb557609d6df6da702a2&oe=57C1B6D9" alt="" class="img-circle img-responsive">
                                            </div>
                                        </div>
                                        <div class="col-xs-12 bottom text-center">
                                            <div class="col-xs-12 col-sm-6 emphasis">
                                                <p class="ratings">
                                                    <a>4.0</a>
                                                    <a href="#"><span class="fa fa-star"></span></a>
                                                    <a href="#"><span class="fa fa-star"></span></a>
                                                    <a href="#"><span class="fa fa-star"></span></a>
                                                    <a href="#"><span class="fa fa-star"></span></a>
                                                    <a href="#"><span class="fa fa-star-o"></span></a>
                                                </p>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 emphasis">
                                                <button type="button" class="btn btn-success btn-xs"> <i class="fa fa-user">
                                                    </i> <i class="fa fa-comments-o"></i> </button>
                                                <button type="button" class="btn btn-primary btn-xs">
                                                    <i class="fa fa-user"> </i> View Profile
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                @endforeach

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop
