/**
 * Created by alan.flores on 3/22/17.
 */
function checkCampsNull(){

    var error = false;
    var args = Array.from(arguments);
    args.some(function(element) {

        if(element.val() === null || element.val() === undefined || element.val() == '' || element.val() === ''){
            alert("Falta llenar un campo obligatorio...");
            element.focus();
            error = true;
            return true;
        }
        return false;
    });

    return error;
}