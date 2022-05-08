const axios = require("axios")
const fs = require("fs")
const path = require('path')
const http = require('http');
const https = require('https');
const StreamZip = require('node-stream-zip');

async function pcloud_showpublink(code, fileid) {
    return new Promise((resolve, reject) => {
        let url = `https://api.pcloud.com/showpublink?code=${code}&fileid=${fileid}`
        axios.get(url)
            .then(res => {
                let data = res.data
                resolve(data)
            })
            .catch(res => resolve(null))
    })
}

async function pcloud_DownLink(folderCode, fileid) {
    return new Promise((resolve, reject) => {
        let url = `https://api.pcloud.com/getpublinkdownload?code=${folderCode}&fileid=${fileid}&forcedownload=true`
        axios.get(url)
            .then(res => {
                let data = res.data
                resolve('https://' + data.hosts[0] + data.path)
            })
            .catch(res => resolve(null))
    })
}

function downloadFile(uri, dest, cb) {
    // 确保dest路径存在
    const file = fs.createWriteStream(dest);

    https.get(uri, (res) => {
        if (res.statusCode !== 200) {
            cb('error', res.statusCode);
            return;
        }

        // 进度
        const len = parseInt(res.headers['content-length']) // 文件总长度
        let cur = 0
        const total = (len / 1048576).toFixed(2) // 转为M 1048576 - bytes in  1Megabyte
        res.on('data', function (chunk) {
            cur += chunk.length
            const progress = cur / len // 当前进度
            const currProgress = (cur / 1048576).toFixed(2) // 当前了多少
            cb('data', progress, currProgress, total)
        })

        res.on('end', () => {
            // console.log('下载结束')
            cb('download')
        })

        // 超时,结束等
        file.on('finish', () => {
            // console.log('文件写入结束')
            file.close(cb('finish'))
        }).on('error', (err) => {
            fs.unlink(dest)
            if (cb) cb('error', err.message)
        })

        res.pipe(file);
    });
}

async function pcloud_download(folderCode, fileid, cb) {
    let uri = await pcloud_DownLink(folderCode, fileid)
    let dest = uri.slice(uri.lastIndexOf('/') + 1)
    let filename = __dirname + "\\..\\download\\" + dest
    console.log(filename)
    downloadFile(uri, filename, (state, progress, currProgress, total) => {
        if (cb) {
            if (state == 'finish') { progress = filename }
            cb(state, progress, currProgress, total)
        }
    })
    return
}

async function pcloud_downloadFolder(folderCode, folderDir, cb) {
    let uri = `https://api.pcloud.com/getpubzip?code=${folderCode}&forcedownload=true`
    let downfile = __dirname + "\\..\\download\\"
    let filename = downfile + "tmp.zip"
    downloadFile(uri, filename, (state, progress, currProgress, total) => {
        if (cb) {
            if (state == 'finish') {
                const zip = new StreamZip({
                    file: filename,
                    storeEntries: true
                });
                let itc = 0
                zip.on('ready', () => {
                    try { fs.mkdirSync(folderDir) } catch { }
                    for (const entry of Object.values(zip.entries())) {
                        if (entry.isDirectory) {
                            itc++
                            try { fs.mkdirSync(folderDir + "\\" + entry.name) } catch { }
                        } else {
                            zip.extract(entry.name, folderDir + "\\" + entry.name, err => {
                                if (err) {
                                    itc++
                                    console.log(folderDir + "\\" + entry.name)
                                }
                            });
                        }
                    }
                });

                zip.on('extract', () => {
                    itc++
                    cb('data', 0.5 + itc / zip.entriesCount * 0.5)
                    // console.log(itc, zip.entriesCount)
                    if (itc == zip.entriesCount) {
                        cb('finish')
                        zip.close();
                    }
                });
            } else {
                cb(state, progress * 0.5)
            }
        }
    })
    // return
}

async function pcloud_text(folderCode, fileid) {
    return new Promise(async (resolve, reject) => {
        let uri = await pcloud_DownLink(folderCode, fileid)
        axios.get(uri)
            .then(res => {
                let data = res.data
                resolve(data)
            })
            .catch(res => resolve(null))
    })
}


module.exports = {
    pcloud_text,
    pcloud_downloadFolder,
    pcloud_download,
    pcloud_showpublink,
    pcloud_DownLink,
    downloadFile
}