local targetSelect = require("scripts.targetSelect.targetSelect")
local evade = require("scripts.Evade.Evade")
local Zeri = {}
Zeri.fq = {{
    s = {974, 169.16540527344, 358},
    p1 = {3860.4404296875, 95.748046875, 524.28466796875},
    t = {4020, 95.748046875, 534},
    p2 = {1165.5595703125, 146.79541015625, 382.78729248047}
}, {
    s = {374, 176.76359558105, 858},
    p1 = {473.01409912109, 95.747680664063, 3233.8798828125},
    t = {500, 95.748016357422, 3922},
    p2 = {364.28778076172, 161.47839355469, 1082.8682861328}
}, {
    s = {774, 56.194198608398, 13106},
    p1 = {762.70135498047, 52.838012695313, 11485.58984375},
    t = {758, 52.83810043335, 10804},
    p2 = {759.28338623047, 53.416259765625, 12926.041015625}
}, {
    s = {3920, 52.838096618652, 14078},
    p1 = {1935.5610351563, 57.47998046875, 13955.545898438},
    t = {1576, 58.2936668396, 13930},
    p2 = {2885.1767578125, 52.838256835938, 14010.66796875}
}, {
    s = {700, 52.838287353516, 7506},
    p1 = {609.32952880859, 95.747924804688, 4558.40234375},
    t = {608, 95.748046875, 4508},
    p2 = {695.060546875, 52.838500976563, 7322.2685546875}
}, {
    s = {4476, 95.748107910156, 536},
    p1 = {7566.3872070313, 49.444702148438, 728.34381103516},
    t = {7668, 49.443820953369, 736},
    p2 = {4918.7084960938, 41.804321289063, 559.42156982422}
}, {
    s = {13272, 40.038230895996, 1058},
    p1 = {11991.806640625, 51.272094726563, 935.95861816406},
    t = {10434, 51.397708892822, 788},
    p2 = {12730.5390625, 53.186279296875, 991.64758300781}
}, {
    s = {13872, 46.720001220703, 1800},
    p1 = {14139.147460938, 53.657470703125, 4319.5439453125},
    t = {14144, 53.650276184082, 4386},
    p2 = {13910.6015625, 50.2158203125, 1912.0432128906}
}, {
    s = {10552, 51.746356964111, 7454},
    p1 = {10910.739257813, -53.341552734375, 5663.955078125},
    t = {10944, -68.613159179688, 5494},
    p2 = {10618.958984375, 51.722412109375, 7016.9926757813}
}, {
    s = {8474, -49.775676727295, 5732},
    p1 = {7495.4892578125, 8.4268798828125, 6527.1416015625},
    t = {7312, 52.101749420166, 6678},
    p2 = {8308.958984375, -14.3740234375, 5872.3095703125}
}, {
    s = {6574, 52.06579208374, 7258},
    p1 = {5408.9790039063, -36.17919921875, 8314.47265625},
    t = {5204, -46.697559356689, 8500},
    p2 = {6487.9404296875, 43.95458984375, 7460.4360351563}
}, {
    s = {6388, -54.600479125977, 9102},
    p1 = {7419.4169921875, 34.706665039063, 8236.75390625},
    t = {7572, 52.557502746582, 8106},
    p2 = {6782.9145507813, -13.3408203125, 8797.23828125}
}, {
    s = {5224, 56.787845611572, 11356},
    p1 = {5940.0810546875, -0.3841552734375, 9637.314453125},
    t = {6038, -44.11279296875, 9468},
    p2 = {5293.5307617188, 46.307250976563, 11175.078125}
}, {
    s = {7252, 56.47679901123, 11884},
    p1 = {4891.4990234375, 56.477661132813, 12054.572265625},
    t = {4558, 56.524894714355, 12078},
    p2 = {7116.1782226563, 56.476928710938, 11916.46875}
}, {
    s = {8374, 50.42024230957, 10416},
    p1 = {8092.3212890625, 56.47705078125, 11574.333007813},
    t = {8044, 56.47679901123, 11776},
    p2 = {8348.205078125, 50.429931640625, 10557.700195313}
}, {
    s = {4206, 50.234798431396, 5062},
    p1 = {2890.0080566406, 56.9853515625, 6562.7514648438},
    t = {2790, 56.84395980835, 6680},
    p2 = {4110.630859375, 50.264770507813, 5182.4970703125}
}, {
    s = {2230, 51.317184448242, 9484},
    p1 = {1832.1934814453, 52.838134765625, 8279.3115234375},
    t = {1744, 52.710597991943, 8012},
    p2 = {2118.5502929688, 51.86181640625, 9324.1494140625}
}, {
    s = {3836, -71.140808105469, 10830},
    p1 = {5473.6401367188, 56.900024414063, 11049.129882813},
    t = {5570, 56.853202819824, 11060},
    p2 = {4195.8037109375, -80.240356445313, 10865.638671875}
}, {
    s = {4374, -71.240600585938, 10156},
    p1 = {4538.6254882813, 50.273681640625, 11202.779296875},
    t = {4592, 55.080028533936, 11538},
    p2 = {4386.841796875, -71.24072265625, 10329.498046875}
}, {
    s = {9704, -23.952575683594, 6394},
    p1 = {8798.8974609375, 53.056274414063, 7110.8237304688},
    t = {8370, 53.728191375732, 7448},
    p2 = {9588.125, -8.8704833984375, 6523.5625}
}, {
    s = {9858, 50.770561218262, 8866},
    p1 = {9541.2587890625, 53.021606445313, 7665.23828125},
    t = {9462, 52.798965454102, 7370},
    p2 = {9782.880859375, 86.168823242188, 8511.4248046875}
}, {
    s = {9968, 51.498168945313, 9118},
    p1 = {11690.720703125, 52.374755859375, 9438.001953125},
    t = {11786, 52.306301116943, 9454},
    p2 = {10585.211914063, 63.933227539063, 9252.517578125}
}, {
    s = {12022, 52.640338897705, 7756},
    p1 = {11585.55078125, 52.248046875, 9228.26953125},
    t = {11466, 52.306301116943, 9624},
    p2 = {11935.045898438, 52.60205078125, 8074.5532226563}
}, {
    s = {10642, 52.306301116943, 9820},
    p1 = {12001.362304688, 52.312133789063, 8284.83203125},
    t = {12064, 52.315002441406, 8208},
    p2 = {10821.552734375, 53.52685546875, 9662.72265625}
}, {
    s = {10796, 52.083442687988, 7470},
    p1 = {10374.526367188, 15.869873046875, 6112.841796875},
    t = {10306, -71.240600585938, 5896},
    p2 = {10744.36328125, 51.88427734375, 7327.8671875}
}, {
    s = {11398, -43.053363800049, 5334},
    p1 = {12820.375, 51.364013671875, 3580.4577636719},
    t = {12908, 51.366901397705, 3470},
    p2 = {11601.587890625, -3.004638671875, 5063.0263671875}
}, {
    s = {13062, 51.747932434082, 5110},
    p1 = {12129.727539063, -66.247436523438, 3824.8583984375},
    t = {12032, -66.247200012207, 3694},
    p2 = {12909.8984375, 51.536743164063, 4886.1962890625}
}, {
    s = {10254, 49.171325683594, 2836},
    p1 = {7952.8325195313, 51.579467773438, 3008.408203125},
    t = {7612, 52.565864562988, 3034},
    p2 = {10034.990234375, 51.95703125, 2885.5224609375}
}, {
    s = {9522, 64.147476196289, 3558},
    p1 = {8963.3203125, -71.057006835938, 5363.71484375},
    t = {8930, -71.240600585938, 5470},
    p2 = {9463.21484375, 63.687622070313, 3783.6616210938}
}, {
    s = {9234, 57.099044799805, 3834},
    p1 = {10394.618164063, 54.525024414063, 3806.3500976563},
    t = {11032, -61.377674102783, 3792},
    p2 = {9216.876953125, 56.197509765625, 3849.1062011719}
}, {
    s = {10410, 48.820335388184, 3358},
    p1 = {9053.8779296875, 52.796752929688, 4353.3715820313},
    t = {9040, 52.793571472168, 4364},
    p2 = {10319.529296875, 48.540771484375, 3384.1518554688}
}, {
    s = {3446, 23.105821609497, 9350},
    p1 = {2507.3562011719, -34.302001953125, 11368.477539063},
    t = {2348, 30.423551559448, 11706},
    p2 = {3363.2766113281, 18.3984375, 9526.1865234375}
}, {
    s = {1794, 52.83810043335, 9888},
    p1 = {2675.8081054688, -71.240600585938, 11004.538085938},
    t = {2848, -71.240600585938, 11220},
    p2 = {1898.4658203125, 52.838012695313, 9951.326171875}
}, {
    s = {3924, -68.09831237793, 9434},
    p1 = {4246.7163085938, 50.616333007813, 7489.2763671875},
    t = {4252, 50.54711151123, 7460},
    p2 = {3924.841796875, -54.916870117188, 9291.5029296875}
}, {
    s = {4076, 50.981212615967, 7406},
    p1 = {4404.6708984375, -66.658935546875, 8903.55078125},
    t = {4430, -66.285987854004, 9016},
    p2 = {4306.3081054688, 48.559448242188, 8444.919921875}
}, {
    s = {2574, 54.325500488281, 9806},
    p1 = {3065.0971679688, 51.758422851563, 8443.7578125},
    t = {3100, 51.769203186035, 8346},
    p2 = {2655.0676269531, 53.736450195313, 9594.26171875}
}, {
    s = {8958, 50.83012008667, 9564},
    p1 = {7647.4169921875, 52.560791015625, 9159.3671875},
    t = {7380, 52.872596740723, 9074},
    p2 = {8672.30859375, 50.635864257813, 9474.7861328125}
}, {
    s = {5848, 51.789558410645, 5332},
    p1 = {7124.7822265625, 61.548950195313, 5740.7778320313},
    t = {7418, 52.610366821289, 5836},
    p2 = {6179.1235351563, 48.526611328125, 5437.8129882813}
}, {
    s = {5078, 50.615909576416, 7548},
    p1 = {5126.8608398438, 50.785034179688, 6159.2260742188},
    t = {5130, 50.475868225098, 6100},
    p2 = {5099.1713867188, 50.284545898438, 7425.3510742188}
}, {
    s = {4874, 50.233406066895, 5758},
    p1 = {3389.849609375, 54.035522460938, 5510.9599609375},
    t = {2950, 52.47135925293, 5438},
    p2 = {4645.34765625, 50.979858398438, 5746.271484375}
}, {
    s = {2874, 50.695121765137, 7058},
    p1 = {3302.9873046875, 57.044311523438, 5643.8422851563},
    t = {3412, 54.108184814453, 5288},
    p2 = {2957.0407714844, 52.169921875, 6760.8354492188}
}, {
    s = {12272, 51.728649139404, 5058},
    p1 = {11841.329101563, 51.708862304688, 6335.4448242188},
    t = {11760, 51.7272605896, 6574},
    p2 = {12194.700195313, 51.978271484375, 5331.2797851563}
}, {
    s = {14472, 167.1734161377, 13956},
    p1 = {14293.116210938, 91.429931640625, 10850.7578125},
    t = {14296, 91.429809570313, 10910},
    p2 = {14473.828125, 150.45202636719, 13638.76953125}
}, {
    s = {14218, 91.429840087891, 10506},
    p1 = {14142.799804688, 52.30615234375, 7130.6186523438},
    t = {14146, 52.306301116943, 7358},
    p2 = {14238.083984375, 92.767578125, 10228.552734375}
}, {
    s = {11034, 91.429840087891, 14380},
    p1 = {13818.3359375, 167.15026855469, 14495.938476563},
    t = {14030, 171.97770690918, 14504},
    p2 = {10762.940429688, 91.429809570313, 14372.6484375}
}, {
    s = {8024, 52.838096618652, 14180},
    p1 = {10404.74609375, 91.429809570313, 14369.025390625},
    t = {10564, 91.429809570313, 14380},
    p2 = {8031.5224609375, 52.83837890625, 14176.6640625}
}, {
    s = {8176, 52.83810043335, 14180},
    p1 = {5248.6303710938, 52.838012695313, 14133.452148438},
    t = {5178, 52.83810043335, 14130},
    p2 = {8334.876953125, 52.837890625, 14180.012695313}
}, {
    s = {10170, 51.158893585205, 796},
    p1 = {7968.521484375, 49.542236328125, 704.97924804688},
    t = {8670, 50.055519104004, 734},
    p2 = {10458.155273438, 51.198974609375, 785.19403076172}
}, {
    s = {760, 52.83810043335, 10304},
    p1 = {680.57855224609, 52.838134765625, 8325.306640625},
    t = {722, 52.83810043335, 9354},
    p2 = {750.85607910156, 52.838012695313, 10771.98046875}
}}
Zeri.b = {}
Zeri.b.fq = false
Zeri.b.fqh = 0
Zeri.b.fqd = false
Zeri.b.cw = false
Zeri.b.cef = false
Zeri.b.crc = 0
Zeri.b.fqfs = 0
Zeri.b.lnc = false
Zeri.b.lw = false
Zeri.b.le = false
Zeri.b.lmp = 70
Zeri.b.hw = false
Zeri.menu = function()
    core.menu.Text("连招设置")
    Zeri.b.cw = core.menu.Checkbox("Zeri", "使用W", Zeri.b.cw)
    core.menu.SameLine()
    Zeri.b.ceaw = core.menu.Checkbox("Zeri", "近身E远离敌人", Zeri.b.ceaw)
    core.menu.SameLine()
    Zeri.b.cef = core.menu.Checkbox("Zeri", "使用E追击", Zeri.b.cef)
    Zeri.b.crc = core.menu.SliderFloat("Zeri", "当R命中X人时使用R,0为关闭", Zeri.b.crc, 0, 5)
    Zeri.b.crc = math.floor(Zeri.b.crc)

    core.menu.Separator()
    core.menu.Text("骚扰设置")
    Zeri.b.hw = core.menu.Checkbox("Zeri", "骚扰使用W", Zeri.b.hw)

    core.menu.Separator()
    core.menu.Text("清线设置")
    Zeri.b.lnc = core.menu.Checkbox("Zeri", "仅非对线时启用清线", Zeri.b.lnc)
    core.menu.SameLine()
    Zeri.b.lw = core.menu.Checkbox("Zeri", "清线使用W", Zeri.b.lw)
    core.menu.SameLine()
    Zeri.b.le = core.menu.Checkbox("Zeri", "清线使用E", Zeri.b.le)
    if (Zeri.b.lnc == false) then
        Zeri.b.lmp = core.menu.SliderFloat("Zeri", "清线蓝量控制", Zeri.b.lmp, 0, 100)
    end

    core.menu.Separator()
    core.menu.Text("翻墙设置")
    Zeri.b.fq = core.menu.Checkbox("Zeri", "启用翻墙", Zeri.b.fq)
    core.menu.SameLine()
    Zeri.b.fqh = core.menu.KeySelect("Zeri", "翻墙触发热键", Zeri.b.fqh)
    core.menu.SameLine()
    Zeri.b.fqd = core.menu.Checkbox("Zeri", "绘制翻墙信息", Zeri.b.fqd)
    Zeri.b.fqfs = core.menu.Combo("Zeri", "翻墙方式", Zeri.b.fqfs, {"距离鼠标最近", "距离人物最近"})
end
Zeri.fqit = {
    s = {},
    p = {}
}

Zeri.FaceToTarget = function(target)
    local a1 = core.math.LineVector(core.G.myself:position(), target:position())
    local a2 = core.math.LineVector(core.G.myself:position(), core.game.mousePosition())
    return math.abs(a1 - a2) < 30
end

Zeri.tick = function()
    local myhero = core.G.myself
    if (Zeri.b.fq) then
        local mixs = {}
        local mixp = {}
        local mixd = 15000
        for i, v in pairs(Zeri.fq) do
            local d1 = core.math.calculationDistance(core.game.mousePosition(), v.s)
            local d2 = core.math.calculationDistance(core.game.mousePosition(), v.t)
            if (Zeri.b.fqfs == 0) then
                d1 = core.math.calculationDistance(core.game.mousePosition(), v.s)
                d2 = core.math.calculationDistance(core.game.mousePosition(), v.t)
            else
                d1 = myhero:calculationDistance(v.s)
                d2 = myhero:calculationDistance(v.t)
            end
            if (d1 < mixd or d2 < mixd) then
                mixs = d1 < d2 and v.s or v.t
                mixp = d1 < d2 and v.p1 or v.p2
                mixd = d1 < d2 and d1 or d2
            end
        end
        Zeri.fqit = {
            s = mixs,
            p = mixp
        }
    end

    local _W = core.spell(myhero, 1)
    local _E = core.spell(myhero, 2)
    local _R = core.spell(myhero, 3)
    -- --------------------连招----------------------
    if (core.script.fitMode() == Enum.fitMode.combo) then
        if (_E:canCast()) then
            if (Zeri.b.ceaw) then
                local mixtarget = targetSelect.Target(300)
                if (mixtarget:canMakeTarget()) then
                    _E:cast_postion(evade.GetSafePos(core.math.LineVectorTo(mixtarget:position(), myhero:position(), 0,
                        600, 0)))
                end
            end
            if (Zeri.b.cef) then
                local target = targetSelect.Target(825 + 275)
                if (target:canMakeTarget() and myhero:calculationDistance(target:position()) > 725 and
                    Zeri.FaceToTarget(target)) then
                    _E:cast_postion(evade.GetSafePos(core.math.LineVectorTo(target:position(), myhero:position(), 0,
                        600, 0)))
                end
            end
        end
        if (Zeri.b.cw and _W:canCast()) then
            local target = targetSelect.Target(_W:range())
            if (target:canMakeTarget()) then
                local castpos, p = Prediction.PredictionPos(target, _W:range(), 1800, 90, 1)
                if (p >= 0.5 and not Prediction.check_Obstruct(castpos, nil, 90, true)) then
                    _W:cast_postion(castpos)
                end
            end
        end
        if (Zeri.b.crc and _R:canCast()) then
            if (Zeri.b.crc ~= 0) then
                local count = 0
                for i, v in pairs(core.game:AIHeroClient()) do
                    if (v:canMakeTarget() and v:team() == core.G.team_enemy and myhero:calculationDistance(v:position()) <
                        _R:range() * 0.8) then
                        count = count + 1
                    end
                end
                if (count >= Zeri.b.crc) then
                    _R:cast_postion(myhero:position())
                end
            end
        end
    end
    -- --------------------连招----------------------
    -- --------------------骚扰----------------------
    if (core.script.fitMode() == Enum.fitMode.harass) then
        if (Zeri.b.hw and _W:canCast()) then
            target = targetSelect.Target(_W:range())
            if (target:canMakeTarget()) then
                local castpos, p = Prediction.PredictionPos(target, _W:range(), 1800, 90, 1)
                if (p >= 0.5 and not Prediction.check_Obstruct(castpos, nil, 90, true)) then
                    _W:cast_postion(castpos)
                end
            end
        end
    end
    -- --------------------骚扰----------------------
    -- --------------------清线----------------------
    if (core.script.fitMode() == Enum.fitMode.laneclear) then
        local canlaneclear = false
        if (Zeri.b.lnc) then
            canlaneclear = (not targetSelect.Target(2000):canMakeTarget() and true or false)
        else
            canlaneclear = (myhero:mp() / myhero:mpMax() > Zeri.b.lmp / 100 and true or false)
        end
        if (canlaneclear) then
            if (Zeri.b.le and _E:canCast()) then
                target = targetSelect.Soldier(825)
                if (target:canMakeTarget()) then
                    _E:cast_postion(core.game.mousePosition())
                end
            end
            if (Zeri.b.lw and _W:canCast()) then
                target = targetSelect.Soldier(_W:range()*0.75)
                if (target:canMakeTarget()) then
                    _W:cast_postion(target:position())
                end
            end
        end
    end
    -- --------------------清线----------------------
end

Zeri.draw = function()
    local myhero = core.G.myself
    if (Zeri.b.fqd and Zeri.b.fq) then
        for fi, fv in pairs(Zeri.fq) do
            if (myhero:calculationDistance(fv.s) > 800 and myhero:calculationDistance(fv.t) > 800) then
                goto nodraw
            end
            core.draw.drawcircle(fv.s, 50, 5, 10, {0, 1, 0.5, 1})
            core.draw.drawcircle(fv.t, 50, 5, 10, {0, 1, 0.5, 1})
            core.draw.drawline(fv.s, fv.t, 5, {0, 1, 0.5, 1})
            ::nodraw::
        end
        if (myhero:calculationDistance(Zeri.fqit.s) < 800) then
            core.draw.drawcircle(Zeri.fqit.s, 50, 5, 10, {1, 1, 0, 1})
        end
    end
    local Rbuff = myhero:getBuff("rstacks", true, false, true)
    if (Rbuff:autoCount() == 1) then
        local time = Rbuff:timeEnd() - core.game.time(0)
        if (time > 0) then
            local pos = core.game.Vector3T2(myhero:position())
            pos[1] = pos[1] + 40
            pos[2] = pos[2] - 40
            core.draw.drawline2d(pos, {pos[1] + 100, pos[2]}, 10, {0, 0, 0, 0.3})
            core.draw.drawline2d(pos, {pos[1] + 100 * (time / 6), pos[2]}, 10, {0.03, 0.43, 0.14, 1})
            core.draw.drawVectorReact2d(pos, {pos[1] + 100, pos[2]}, 5, 1, {0.03, 0.04, 0.05, 1})
            pos[1] = pos[1] + 10
            pos[2] = pos[2] - 20
            local color = time > 2 and {1, 1, 1, 1} or {1, 0, 0, 1}
            core.draw.drawfont2d(pos, "R:" .. tostring(math.floor(time * 100) / 100), color, 15)
        end
    end
end

Zeri.message = function(msg, wParam, lParam)
    local myhero = core.G.myself
    if (msg == 256) then
        if (wParam == 112) then
            pos = myhero:position()
            print(pos[1], ",", pos[2], ",", pos[3])
        end
        if (wParam == 113) then
            pos = core.game.mousePosition()
            print(pos[1], ",", pos[2], ",", pos[3])
        end
        if (Zeri.b.fq and wParam == Zeri.b.fqh) then
            local _E = core.spell(myhero, 2)
            if (_E:canCast()) then
                myhero:movTo(Zeri.fqit.s)
                if (myhero:calculationDistance(Zeri.fqit.s) < 15) then
                    core.spell(myhero, 2):cast_postion(Zeri.fqit.p)
                end
            end
        end
    end
end

if (core.G.myself:name() ~= "Zeri") then
    return nil
end
local register = require("_SDK.register")
register.init({
    name = " Zeri",
    tick = Zeri.tick,
    menu = Zeri.menu,
    draw = Zeri.draw,
    message = Zeri.message,
    addbuff = function(buff)
        print(buff:name(),buff:type())
    end
})
return Zeri
