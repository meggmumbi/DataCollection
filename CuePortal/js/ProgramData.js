'use-strict';
$('#checkBoxAllGoods').click(function () {
    var checked = this.checked;
})
var td2 = $(".tablePrograms")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });

        if (selected_arr.length > 0) {
            $("#rfiresponsefeedback").css("display", "block");

        } else {
            $("#rfiresponsefeedback").css("display", "none");
            selected_arr = [];
        }

    });
//var selected_arr = [];
var PrimaryInitiative = new Array();
$(".btn_applyallselectedActvities").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        $.each($(".tablePrograms tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedprograms').val();
            var Targets = {};
            Targets.targetNumber = ($(this).find('td').eq(2).text());
            Targets.ApplicationNo = $("#txtapplicationNo").val();
            PrimaryInitiative.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
        Swal.fire({
            title: "Confirm Program Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center",

        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewProgrammeAccreditations.aspx/SubmitSelectedCategories",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Programs Submitted!",
                                text: registerstatus,
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("The selected programs have been successfully submitted!");
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $("#feedback").html("The selected programs have been successfully submitted!");
                                $("#feedback").reset();
                            });
                            PrimaryInitiative = [];
                            //$('#primaryActivities').modal('hide');
                            //$.modal.close();
                            document.location.reload();
                            window.location.href = 'InstitutionAccreditationBundledProgrammes.aspx?applicationNo=' + $("#txtapplicationNo").val();
                           // window.location("InstitutionAccreditationBundledProgrammes.aspx");
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "feedback Error!!!",
                                text: registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("The selected programs could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiative = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled programs submission!',
                    'error'
                );
            }
        });

    });


