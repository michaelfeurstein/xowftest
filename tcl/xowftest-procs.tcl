::xo::db::require package xowf

# Define the package type

namespace eval ::xowftest {

  ::xo::PackageMgr create ::xowftest::Package \
      -package_key "xowftest" -pretty_name "XOWF Test" \
      -superclass ::xowf::Package

  Package ad_instproc initialize {} {
        Testing initialize
  } {
        ns_log notice "++++ CALL ::xowftest::initialize"
        next
  }

  Package default_package_parameters {
    parameter_page en:xowftest-default-parameter
  }

  Package default_package_parameter_page_info {
    name en:xowftest-default-parameter
    title "XowfTest Default Parameters"
    instance_attributes {
      MenuBar t top_includelet none production_mode t with_user_tracking t with_general_comments f
      with_digg f with_tags f
      ExtraMenuEntries {{config -use xowftest}}
      with_delicious f with_notifications f security_policy ::xowiki::policy1
    }
  }
}

#
# ::xowftest::menubar
# based on ::tlf_podcast::menubar
#
# Usage:
# ::xo::Page set_property doc menubar [::xowftest::menubar]
# only how exactly
# I would like to create a custom minimal menu
#

ad_proc -public ::xowftest::menubar {
	{-storyboard "0"}
} {
	Try and replicate tlf_podcast menubar approach

	@param storyboard if specified, tells the menu we are operating in the context of a specific storyboard.

	@return HTML to render the menu
} {
	set package_id [::xo::cc set package_id]
	set package_url [$package_id set package_url]
	set m [::xowiki::MenuBar new -id menubar]
	$m add_menu \
	  -name "Index" \
	  -label "Storyboards"
	$m add_menu_item \
	  -name "Index.Startseite" \
	  -item [list \
	  			label "Hallo" \
				url $package_url]
	return [$m render-bootstrap]
}


#
# ::xowiki::MenuBar
#
# the message key does not work
#

namespace eval ::xowiki {
  ::xowiki::MenuBar instproc config=xowftest {
    {-bind_vars {}}
    -current_page:required
    -package_id:required
    -folder_link:required
    -return_url
  } {
    :config=default \
        -bind_vars $bind_vars \
        -current_page $current_page \
        -package_id $package_id \
        -folder_link $folder_link \
        -return_url $return_url

    return {
      {entry -name New.Extra.Storyboard -form en:monaco.form}
    }
  }
}
