const mysrv = function (srv) {
    srv.on('displayMsg', function (req, res) {
        return "Hello " + req.data.msg;
    });
}

module.exports = mysrv;