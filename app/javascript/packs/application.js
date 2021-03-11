//= require jquery

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

$(document).ready(function () {

    function showTextField() {
        $(".in-place-edit").removeClass("non-editable");
    }

    $(".finance-submit").click(showTextField);
});