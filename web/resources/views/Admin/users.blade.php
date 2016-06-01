@extends('Admin.Base.outer')

@section('content')
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Users</h3>
                </div>

            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="clearfix"></div>

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">


                        <div class="x_content">

                            <div class="table-responsive">
                                <table class="table table-striped jambo_table bulk_action">
                                    <thead>
                                    <tr class="headings">
                                        <th class="column-title">Email</th>
                                        <th class="column-title">First name</th>
                                        <th class="column-title">Last Name</th>
                                        <th class="column-title">Created</th>
                                        <th class="column-title">Updated</th>
                                        <th class="column-title no-link last"><span class="nobr">Action</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    @foreach($users as $user)
                                        <tr class="even pointer">
                                            <td class=" ">{{ $user->email }}</td>
                                            <td class=" ">{{ $user->first_name }}</td>
                                            <td class=" ">{{ $user->last_name }}</td>
                                            <td class=" ">{{ $user->created_at }}</td>
                                            <td class=" ">{{ $user->updated_at }}</td>
                                            <td class=" last"><a href="/users/edit/{{ $user->id }}">Edit</a>
                                            </td>
                                        </tr>
                                    @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop
