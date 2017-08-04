--Begin Warn.lua By @saad7m #kenamch
	local function action_by_reply(TM, BD)
local cmd = TM.cmd
if not tonumber(BD.sender_user_id_) then return false end
if BD.sender_user_id_ then
  if cmd == "warn" then
local function warn_cb(TM, BD)
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = 'warn:'..BD.id_
local warnhash = redis:get(hashwarn) or 1
local setwarn = tonumber(warnhash) + 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكنني تحذير نفسي ☹️🖐🏿*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكن تحذير الادمنيه والمطورين ☹️🖐🏿*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكن تحذير الادمنيه والمطورين 🤕🐍*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:del(hashwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\nNumber of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* لقد تجاوز عدد التحذيرات وتم طرده 🚫\nعدد التحذيرات : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:set(hashwarn, setwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *انتبه‼️هذا تحذير قد تتعرض للطرد*\n*العدد الاقصى لتحذيراتك: "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = BD.sender_user_id_
  }, warn_cb, {chat_id=BD.chat_id_,user_id=BD.sender_user_id_,msg=TM.msg})
  end
   if cmd == "unwarn" then
local function unwarn_cb(TM, BD)
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = 'warn:'..BD.id_
local warnhash = redis:get(hashwarn) or 0
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
if not redis:get(hashwarn) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *لم يتلقى اي تحذير ⁉️*", 0, "md")
    end
  else
redis:del(hashwarn)
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_جميع تحذيرات🚹_ "..user_name.." *"..BD.id_.."* *تم حذفها 🗑*", 0, "md")
      end
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = BD.sender_user_id_
  }, unwarn_cb, {chat_id=BD.chat_id_,user_id=BD.sender_user_id_})
    end
else
    if lang then
  return tdcli.sendMessage(BD.chat_id_, "", 0, "_المستخدم👤 غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(BD.chat_id_, "", 0, "*المستخدم👤غير موجود*", 0, "md")
      end
   end
end
	local function action_by_username(TM, BD)
    if BD.id_ then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = 'warn:'..BD.id_
local warnhash = redis:get(hashwarn) or 1
local setwarn = tonumber(warnhash) + 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.type_.user_.username_ then
user_name = '@'..check_markdown(BD.type_.user_.username_)
else
user_name = check_markdown(BD.title_)
end
   if cmd == "warn" then
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكنني تحذير نفسي ☹️🖐🏿*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكن تحذير الادمنيه والمطورين ☹️🖐🏿*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكن تحذير الادمنيه والمطورين 🤕🐍*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:del(hashwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\nNumber of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* لقد تجاوز عدد التحذيرات وتم طرده 🚫\nعدد التحذيرات : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:set(hashwarn, setwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *انتبه‼️هذا تحذير قد تتعرض للطرد*\n*العدد الاقصى لتحذيراتك: "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:get(hashwarn) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *لم يتلقى اي تحذير ⁉️*", 0, "md")
    end
  else
redis:del(hashwarn)
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_جميع تحذيرات🚹_ "..user_name.." *"..BD.id_.."* *تم حذفها 🗑*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤 غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*المستخدم👤غير موجود*", 0, "md")
      end
   end
end
	local function action_by_id(TM, BD)
    if BD.id_ then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = 'warn:'..BD.id_
local warnhash = redis:get(hashwarn) or 1
local setwarn = tonumber(warnhash) + 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
   if cmd == "warn" then
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكنني تحذير نفسي ☹️🖐🏿*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*لا يمكن تحذير الادمنيه والمطورين 🤕🐍*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:del(hashwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\n_Number of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* لقد تجاوز عدد التحذيرات وتم طرده 🚫\nعدد التحذيرات : "..max_warn.."/"..warnhash.."", 0, "md")
    end
else
redis:set(hashwarn, setwarn)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *انتبه‼️هذا تحذير قد تتعرض للطرد*\n*العدد الاقصى لتحذيراتك: "..max_warn.."/"..warnhash.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:get(hashwarn) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..BD.id_.."* *لم يتلقى اي تحذير ⁉️*", 0, "md")
    end
  else
redis:del(hashwarn)
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_جميع تحذيرات🚹_ "..user_name.." *"..BD.id_.."* *تم حذفها 🗑*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_المستخدم👤 غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*المستخدم👤غير موجود*", 0, "md")
      end
   end
end

local function kenamch(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
		if ((matches[1]:lower() == 'setwarn' and not Clang) or (matches[1] == "ضع تحذير" and Clang)) then
			if not is_mod(msg) then
				return
			end
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 20 then
     if not lang then
				return "_Wrong number, range is_ *[1-20]*"
    else
				return "_انتباه‼️ يمكنك وضع [1-20] كحد اقصى_"
      end
    end
			local warn_max = matches[2]
   redis:set('max_warn:'..msg.to.id, warn_max)
    if not lang then
     return "*Warn maximum* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_💯 الحد الاقصى للتحذير هوه :_ *[ "..matches[2].." ]*"
		end
  end
if ((matches[1] == "warn" and not Clang) or (matches[1] == "تحذير" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="warn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="warn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="warn"})
      end
   end
if ((matches[1] == "unwarn" and not Clang) or (matches[1] == "الغاء تحذير" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="unwarn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="unwarn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="unwarn"})
     end
	end
end

return {
  patterns = {
  "^(warn)$",
  "^(warn) (.*)$",
  "^(unwarn)$",
  "^(unwarn) (.*)$",
"^(setwarn) (%d+)$",
  "^(تحذير)$",
  "^(تحذير) (.*)$",
  "^(الغاء تحذير)$",
  "^(الغاء تحذير) (.*)$",
"^(ضع تحذير) (%d+)$",

  },
  run = kenamch
}

