# Convert boolean strings to Bools
requestArgumentsConverter = (req, res, next) ->
    for own key, value of req.args
        if req.args.hasOwnProperty(key)
	        if value is 'true' then req.args[key] = true
	        else if value is 'false' then req.args[key] = false
        
    next();

module.exports = requestArgumentsConverter;