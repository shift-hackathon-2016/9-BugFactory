@extends('Admin.Base.outer')

@section('content')
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Edit Category</h3>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel">
                        <div class="x_content">
                            <br />
                            <form method="post" id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                {{ csrf_field() }}

                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Parent category ID<span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                        <input type="text" name="parent_id" @if(old('parent_id') !== null) value="{{ old('parent_id') }}" @else value="{{ $category->parent_id }}" @endif required="required" class="form-control col-md-7 col-xs-12">

                                        @if($errors->has('parent_id'))
                                            <ul class="parsley-errors-list filled" id="parsley-id-5">
                                                <li class="parsley-required">{{ $errors->first('parent_id') }}</li>
                                            </ul>
                                        @endif
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Name<span class="required">*</span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                        <input type="text" name="name" @if(old('name') !== null) value="{{ old('name') }}" @else value="{{ $category->name }}" @endif" required="required" class="form-control col-md-7 col-xs-12">

                                        @if($errors->has('name'))
                                            <ul class="parsley-errors-list filled" id="parsley-id-5">
                                                <li class="parsley-required">{{ $errors->first('name') }}</li>
                                            </ul>
                                        @endif
                                    </div>
                                </div>

                                <div class="ln_solid"></div>
                                <div class="form-group">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                        <button type="submit" class="btn btn-success">Submit</button>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
@stop
