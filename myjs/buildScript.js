const path = require('path')
var fs = require('fs');
const ini = require("./ini")
const ffi = require("ffi-napi");
const ref = require("ref-napi");
const iconv = require('iconv-lite');
const appdata = process.env.ALLUSERSPROFILE
const { dialog, app } = require('electron')
const windowsHook = require("./windowsHook")

function buildScript() {
    // windowsHook.hook()
    copyDir(path.join(__dirname, '..\\lnw'), appdata + '\\lnw')
    ini.write(appdata + "\\lnw.ini", "set", "path", appdata + '\\lnw\\')

    // initRun()
}


var initi = null
function initRun() {
    if (initi != null) return
    initi = setInterval(async () => {
        let game = await getProcessWmic("League of Legends.exe")
        if (game.length == 0) {
            let client = await getProcessWmic("LeagueClient.exe")
            let clientPath = client[0].ExecutablePath + '\\..'
            let gamePath = clientPath + '\\..\\game'
            let hidPath = gamePath + '\\hid.dll'
            try {
                fs.writeFileSync(hidPath, fs.readFileSync(appdata + '\\lnw\\hid.dll'));
            } catch {
                console.log(hidPath)
                console.log(appdata + '\\lnw\\hid.dll')
                initClose()
                await dialog.showMessageBox({
                    title: '错误',
                    message: "文件覆盖失败\n请使用文件粉碎工具粉碎游戏GAME目录下的hid.dll"
                })
                app.quit()
            }
        }
    }, 1000);
}

function initClose() {
    if (initi == null) return
    clearInterval(initi)
    initi = null
}



const INT = ref.types.int;
const kernel32 = ffi.Library('kernel32', {
    GetCurrentProcess: [INT, []],
    QueryFullProcessImageNameA: [INT, [INT, INT, INT, INT]],
    OpenProcess: ['int32', ['int32', 'int32', 'int32']],
    CloseHandle: ['bool', ['int32']],
    TerminateProcess: ['bool', [INT, INT]]
})

function getProcessPath(e) {
    let path_ = Buffer.alloc(0xff)
    let length_ = Buffer.alloc(4)
    length_.writeInt32LE(0xff)
    let handle = kernel32.OpenProcess(1024, 0, e)
    kernel32.QueryFullProcessImageNameA(handle, 0, path_.address(), length_.address())
    path_ = iconv.decode(path_.slice(0, length_.readInt32LE()), 'gb2312').toString('utf8')
    kernel32.CloseHandle(handle)
    return path_
}


const cp = require("child_process")
async function getProcessWmic(e) {
    return new Promise((resolve, reject) => {
        cp.exec(`wmic process where name="${e}" get /VALUE`, { encoding: 'utf8' }, (err, stdout, stderr) => {
            if (err || stderr) {
                resolve([]);
            }
            const group = stdout.trim().split(/[\r\r\n]{5,}/);
            const jsonGroup = [];
            for (const item of group) {
                const list = item.split(/\r\r\n/);
                const jsonItem = {};
                for (const d of list) {
                    const eqPos = d.indexOf('=');
                    jsonItem[d.slice(0, eqPos)] = d.slice(eqPos + 1);
                }
                if (!jsonItem['Caption']) continue
                jsonItem['ExecutablePath'] = getProcessPath(jsonItem['ProcessId'])
                jsonGroup.push(jsonItem);
            }
            resolve(jsonGroup);
        })
    })
}



// tmp.
/*
 * 复制目录、子目录，及其中的文件
 * @param src {String} 要复制的目录
 * @param dist {String} 复制到目标目录
 */
function copyDir(src, dist) {
    fs.access(dist, function (err) {
        if (err) {
            // 目录不存在时创建目录
            fs.mkdirSync(dist);
        }
        _copy(null, src, dist);
    });

    function _copy(err, src, dist) {
        if (err) {
            return err;
        } else {
            fs.readdir(src, function (err, paths) {
                if (err) {
                    return (err)
                } else {
                    paths.forEach(function (path) {
                        var _src = src + '/' + path;
                        var _dist = dist + '/' + path;
                        fs.stat(_src, function (err, stat) {
                            if (err) {
                                return (err);
                            } else {
                                // 判断是文件还是目录
                                if (stat.isFile()) {
                                    fs.writeFileSync(_dist, fs.readFileSync(_src));
                                } else if (stat.isDirectory()) {
                                    // 当是目录是，递归复制
                                    return copyDir(_src, _dist)
                                }
                            }
                        })
                    })
                }
            })
        }
    }
}

module.exports = { buildScript, initRun, initClose }