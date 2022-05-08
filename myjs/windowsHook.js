const os = require("os");
const ffi = require("ffi-napi");
const ref = require("ref-napi");
const Struct = require("ref-struct-di")(ref);

const is64bit = os.arch() === "x64";

// Types
const LONG = is64bit ? ref.types.long : ref.types.int32;
const ULONG = is64bit ? ref.types.ulong : ref.types.uint32;
const INT = ref.types.int;
const UINT = ref.types.uint;
const DWORD = ref.types.uint32; // DWORD always is unsigned 32-bit
const BOOL = ref.types.bool;

const HANDLE = is64bit ? ref.types.uint64 : ref.types.uint32;
const HHOOK = HANDLE;
const HWND = HANDLE;
const HINSTANCE = HANDLE;

const WPARAM = is64bit ? ref.types.uint64 : ref.types.uint32; // typedef UINT_PTR, uint32(x86) or uint64(64)
const LPARAM = is64bit ? ref.types.int64 : ref.types.int32; // typedef LONG_PTR, int32(x86) or int64(64)
const LRESULT = is64bit ? ref.types.int64 : ref.types.int32; // typedef LONG_PTR

const HOOKPROC = "pointer";

// Structures
const POINT = Struct({
    x: LONG,
    y: LONG,
});

const MSG = Struct({
    hwnd: HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
    lPrivate: DWORD,
});

const KBDLLHOOKSTRUCT = Struct({
    vkCode: DWORD,
    scanCode: DWORD,
    flags: DWORD,
    time: DWORD,
    dwExtraInfo: ULONG,
});

// User32 bindings
const user32 = ffi.Library("user32", {
    SetWindowsHookExA: [HHOOK, [INT, HOOKPROC, HINSTANCE, DWORD]],
    SetWindowsHookExW: [HHOOK, [INT, HOOKPROC, HINSTANCE, DWORD]],
    UnhookWindowsHookEx: [BOOL, [HHOOK]],
    CallNextHookEx: [LRESULT, [HHOOK, INT, WPARAM, LPARAM]],
    GetMessageW: [BOOL, [MSG, HWND, UINT, UINT]],
    TranslateMessage: [BOOL, [MSG]],
    DispatchMessageW: [LRESULT, [MSG]],
});
const kernel32 = ffi.Library('kernel32', {
    GetModuleHandleW: [INT, [INT]]
})


// Constants
const WH_KEYBOARD_LL = 13;
const WM_KEYDOWN = 0x0100; // 256
// const WM_KEYUP = 0x0101; // 257
// const WM_SYSKEYDOWN = 0x0104; // 260
// const WM_SYSKEYUP = 0x0105; // 261

let hHook = 0;

// Callback for LL(low-level) hook (doesn`t require dll injection)

// LRESULT CALLBACK LowLevelKeyboardProc(
//     _In_ int    nCode,
//     _In_ WPARAM wParam,
//     _In_ LPARAM lParam
//   );

const keyboardProc = ffi.Callback(
    LRESULT,
    [INT, WPARAM, ref.refType(KBDLLHOOKSTRUCT)],
    (nCode, wParam, lParam) => {
        const param = lParam.deref();
        if (param.vkCode == 32) return 1
        if (wParam === WM_KEYDOWN) {
            const param = lParam.deref();
            const message = {
                event: "key-down",
                data: {
                    vkCode: param.vkCode,
                    scanCode: param.scanCode,
                },
            };
            console.log(`message: ${JSON.stringify(message)}`);
        }
        return user32.CallNextHookEx(
            hHook,
            nCode,
            wParam,
            ref.address(lParam.ref())
        );
    }
);


process.on('exit', () => {
    keyboardProc;
    user32.UnhookWindowsHookEx(hHook)
})

/* Message loop */
// const msg = new MSG();
// const res = user32.GetMessageW(msg.ref(), 0, 0, 0);
// while (res) {
//     user32.TranslateMessage(msg.ref());
//     user32.DispatchMessageW(msg.ref());
// }

module.exports = {
    async hook() {
        /* Set the hook */
        hHook = user32.SetWindowsHookExA(WH_KEYBOARD_LL, keyboardProc, kernel32.GetModuleHandleW(null), 0);
    }
}
