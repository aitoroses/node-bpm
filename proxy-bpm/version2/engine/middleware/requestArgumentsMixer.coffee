_ = require "lodash"

requestArgumentsMixer = (req, res, next) ->

    req.args = {}
    _.assign(req.args, req.body, req.query)
    next()

module.exports = requestArgumentsMixer;