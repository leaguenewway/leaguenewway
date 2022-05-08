const { contextBridge, ipcRenderer } = require('electron')

contextBridge.exposeInMainWorld('electronAPI', {
    test: (e) => ipcRenderer.send('test', e),
    mini: () => ipcRenderer.send('mini'),
    quit: () => ipcRenderer.send('quit')
})