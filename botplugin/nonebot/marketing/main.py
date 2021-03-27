# -*- coding: utf-8 -*-


async def getParameters(msg):
    parameter = {}
    try:
        msgList = str(msg).strip().split(' ')
        if msgList[0] == '营销号' or msgList[0] == '营销' or msgList[0] == 'yxh':
            parameter['status'] = True
            parameter['subject'] = msgList[1]
            parameter['event'] = msgList[2]
            if len(msgList) == 4:
                parameter['statement'] = msgList[3]
            else:
                parameter['statement'] = ''
            return msgList
        else:
            parameter['status'] = False
            return parameter
    except:
        parameter['status'] = False
        return parameter


async def getMessage(bot, userGroup, msg):
    parameter = await getParameters(msg)
    if parameter['status'] == False:
        return
    content = ('[subject][event]是怎么回事呢？[subject]相信大家都很熟悉，' +
                '但是[subject][event]是怎么回事呢，下面就让小编带大家一起了解吧。\n' +
                '[subject][event]，其实就是[statement]，大家可能会很惊讶[subject]' +
                '怎么会[event]呢？但事实就是这样，小编也感到非常惊讶。\n' +
                '这就是关于[subject][event]的事情了，大家有什么想法呢，欢迎在群聊告诉小编一起讨论哦！')
    content = content.replace('[subject]', parameter['subject']).replace('[event]', parameter['event'])
    if parameter['statement'] == '':
        content = content.replace('[statement]', parameter['subject'] + parameter['event'])
    else:
        content = content.replace('[statement]', parameter['statement'])
    await bot.send_group_msg(group_id = int(userGroup), message = str(content))

    