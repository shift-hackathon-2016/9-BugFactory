@extends('Admin.Base.outer')

@section('content')
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Task categories</h3>
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
                                        <th class="column-title">ID </th>
                                        <th class="column-title">Parent ID </th>
                                        <th class="column-title">Name </th>
                                        <th class="column-title no-link last"><span class="nobr">Action</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    @foreach($categories as $category)
                                    <tr class="even pointer">
                                        <td class=" ">{{ $category->id }}</td>
                                        <td class=" ">{{ $category->parent_id }}</td>
                                        <td class=" ">{{ $category->name }}</td>
                                        <td class=" last"><a href="/task-categories/edit/{{ $category->id }}">Edit</a>
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
