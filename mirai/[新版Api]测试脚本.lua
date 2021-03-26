function printInfo(obj) -- 获取一个对象的所有成员信息
    print(obj)
    print(type(obj)) --对象类型
    for k,v in pairs(obj.__functions) do --全部成员方法
        print(v)
    end
    print()
    for k,v in pairs(obj.__properties) do --全部成员属性
        print(k .. ":" .. tostring(v))
    end
end


--全局事件监听，监听所有bot的所有事件
Event.subscribe(function (event)
    print(type(event)) -- 打印事件类型
    print(event) --或打印事件基本信息
    -- printInfo(event) --打印事件全部成员 
    if (type(event)=="FriendMessageEvent") then --好友消息类型
        print("length:" .. tostring(#event.message)) -- 消息元素个数
        print(event.message) --打印消息的mirai码
        print("message  item 1:" .. tostring(event.message[1])) --获取第一个消息元素
        print("message items:")
        for i,v in ipairs(event.message) do -- 遍历所有消息元素
            print(type(v) .. ":" .. tostring(v) )
        end
    end
end)



local bot = Bot(0,"") --替换为账号密码
bot:login() --登录bot

--所有载入过的bot都会保存到全局变量Bots
for k,v in pairs(Bots) do -- 遍历所有bot
    print(k .. ":" .. tostring(v) )
end

print()

--局部事件监听
bot:subscribe("FriendMessageEvent",function(event) --监听bot下的所有FriendMessageEvent事件
    print("事件监听方式2 捕获事件：")
    print(type(event))
    print(event.message)
end)

--[[
    -- 或：监听bot下的所有事件
    bot:subscribe(function(event)
        print("事件监听方式2 捕获事件：")
        print(type(event))
        print(event.message)
    end)

    -- 或：监听所有bot下的FriendMessageEvent事件
    Event.subscribe("FriendMessageEvent",function(event)
        print("事件监听方式2 捕获事件：")
        print(type(event))
        print(event.message)
    end)
]]


local me = bot:getFriend(2308065470) --获取好友
sleep(2000) --延迟
me:sendMessage(Face(2) .. "Test" .. Face(1)) --发送消息测试


bot:join() --防止退出，在console内可不需要调用
