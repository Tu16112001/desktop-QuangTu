angular.module('app',[]);

angular.module('app').controller('MainController',function(){
    var vm = this;
    vm.title = 'Learn Angular by example';
    vm.searchInput = "";
    vm.shows = [
        {
            title : 'doi mat co lua',
            author : 'Nguyen Hung Son',
            favorite : true
        },
        {
            title : 'Life of pi',
            author : 'Davan',
            favorite : false
        },{
            title : 'Learn Angular by example',
            author : 'FPT-aptech',
            favorite : true
        },
        {
            title : 'Ho nha Trai',
            author : 'Nguyen Anh Tu',
            favorite :false
        },
        {
            title : 'Hoc  code today',
            author : 'PFT',
            favorite : true
        },
    ];
    vm.orders = [
        {
            id : 1,
            title: 'author Ascending',
            key : 'Author',
            reverse: false
        },
        {
            id : 1,
            title: 'author Ascending',
            key : 'Author',
            reverse: true
        },
        {
            id : 1,
            title: 'title Ascending',
            key : 'title',
            reverse: false
        },
        {
            id : 1,
            title: 'title Ascending',
            key : 'title',
            reverse: true
        },
    ];
    vm.order = vm.orders[0],
    vm.new = {};
    vm.addShow = function() {
        vm.Shows.push(vm.new);
        vm.new = {}
    };
});