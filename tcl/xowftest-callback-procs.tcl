namespace eval ::xowftest {

  ad_proc -private after-instantiate {-package_id:required } {
    Callback when this an xowf instance is created
  } {
    ns_log notice "++++ BEGIN ::xowftest::after-instantiate -package_id $package_id"

    #
    # Create a parameter page for convenience
    #
    ::xowftest::Package configure_fresh_instance \
        -package_id $package_id \
        -parameters [::xowftest::Package default_package_parameters] \
        -parameter_page_info [::xowftest::Package default_package_parameter_page_info]

	#
	# Create a form with monaco editor
	#
	
	set template {
  		@editor@
	}
	set fc {
  		{_name:text,required,label=Storyboard Name}	
	  	editor:monaco_storyboard
		_page_order:hidden
		_nls_language:hidden
		_description:hidden
		_creator:hidden
		_title:hidden
	}

	# Create a form instance in memory
	set form_id [::xowiki::Form new -destroy_on_cleanup \
             -package_id $package_id \
             -parent_id [$package_id folder_id] \
             -name "en:monaco.form" \
             -anon_instances "t" \
             -form {} \
             -text [list $template text/html] \
             -form_constraints $fc]

	# save the form to the root folder of the package
	$form_id save_new


    ns_log notice "++++ END ::xowftest::after-instantiate -package_id $package_id"
  }
}
