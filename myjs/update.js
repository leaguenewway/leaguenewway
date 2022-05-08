const pcloud = require('./pcloud')
const fs = require('fs')


function version() {
    let data = fs.readFileSync(__dirname + '\\..\\package.json').toString()
    return JSON.parse(data).version
}

async function version_Server() {
    let data = await pcloud.pcloud_text("kZMWepVZPAWWedcfRdBlFdzvOF0TFkDjznEX", "39795024698")
    return data.version
}

async function checkupdate() {
    console.log(version(), await version_Server())
    return (version() != await version_Server())
    // return

}

async function update(callback) {
    await pcloud.pcloud_downloadFolder('kZMWepVZPAWWedcfRdBlFdzvOF0TFkDjznEX', __dirname + '\\..\\..\\..\\resources2', (state, p) => {
        callback(state, p)
    })
}

module.exports = {
    checkupdate,
    version,
    version_Server,
    update
}