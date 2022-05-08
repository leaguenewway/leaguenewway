const ini = require("ini")
const fs = require('fs');

function _redIni(file) {
    try {
        fs.readFileSync(file)
    } catch {
        fs.writeFileSync(file, '')
    }
    let ini_ = fs.readFileSync(file).toString()
    if (ini_) { ini_ = ini.parse(ini_) } else { ini_ = {} }
    return ini_
}

function red(file, path, key) {
    let ini_ = _redIni(file)
    if (!ini_[path]) ini_[path] = {}
    return ini_[path][key]
}

function write(file, path, key, value) {
    let ini_ = _redIni(file)
    if (!ini_[path]) ini_[path] = {}
    ini_[path][key] = value
    ini_ = ini.stringify(ini_)
    fs.writeFileSync(file, ini_)
}

module.exports = { red, write }