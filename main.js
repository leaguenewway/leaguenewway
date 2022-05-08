const { dialog, shell, app, BrowserWindow, ipcMain } = require('electron')
const path = require('path')
const update = require('./myjs/update')
let win = null
const cp = require('child_process')
const fs = require('fs')


const createWindow = () => {
    win = new BrowserWindow({
        width: 980,
        height: 600,
        minHeight: 490,
        minWidth: 745,
        frame: false,
        webPreferences: {
            // preload: path.join(__dirname, 'preload.js'),
            // 开启node
            nodeIntegration: true,
            contextIsolation: false,
            // nodeIntegrationInWorker :true,
            // 开启remote
            enableRemoteModule: true,
            webSecurity: false
        }
    })

    win.loadFile('./public/index.html')
    win.webContents.openDevTools()
}

app.whenReady().then(() => {
    ipcMain.on('mini', (event) => {
        win.minimize()
    })
    ipcMain.on('quit', (event) => {
        app.quit()
    })
    ipcMain.on('init', (event) => {
        app.quit()
    })
    ipcMain.on('showMessageBox', (event, body) => {
        dialog.showMessageBox(body)
    })

    ipcMain.on('updateVer', (event,) => {
        update.update((s, p) => {
            win.webContents.send('updatePr', s, p)
            // console.log(s, p)
            if (s == 'finish') {
                let batfile = __dirname + '\\..\\..\\updata.bat'
                fs.writeFileSync(batfile,
                    `
                    cd ${__dirname + '\\..\\..'}
                    ${__dirname.split('\\')[0]}
                    del /f /s /q resources
                    rd /s /q resources
                    ren resources2 resources
                    start testapp.exe
                    exit
                    `
                )
                cp.spawn(`start ${batfile}`, { shell: true })
                setTimeout(() => {
                    app.quit()
                }, 100);
            }
        })
    })


    require("./myjs/buildScript").buildScript()
    createWindow()
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})


app.on('web-contents-created', (e, webContents) => {
    webContents.on('new-window', (event, url) => {
        event.preventDefault();
        shell.openExternal(url);
    });
});




