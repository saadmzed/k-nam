local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return 'انت لست ادمن في البوت 😀🚹'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '_Group is already added_'
else
return '_المجموعه مضافه بالفعل✅_'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
		  lock_join = 'no',
		  lock_edit = 'no',
		  lock_arabic = 'no',
		  lock_mention = 'no',
		  lock_all = 'no',
		  num_msg_max = '5',
		  set_char = '40',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photo = 'no',
                  mute_gif = 'no',
                  mute_location = 'no',
                  mute_document = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                  mute_all = 'no',
				  mute_keyboard = 'no',
				  mute_game = 'no',
				  mute_inline = 'no',
				  mute_tgservice = 'no',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*Group has been added*'..msg_caption
else
  return '_تم تفعيل البوت في المجموعه☘️_'..msg_caption
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_'
   else
     return 'انت لست ادمن في البوت 😀🚹'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '_Group is not added_'
else
    return '_لم يتم اضافه المجموعه‼️_'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*Group has been removed*'
 else
  return '_تم ازالة المجموعه🚹_'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_کلمه_ *"..word.."* _بالفعل  ممنوعه🌐_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_کلمه_ *"..word.."* _تم اضافتها الى قائمة المنع✅_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_کلمه_ *"..word.."* _تم حذفها من قائمة المنع 👌🏼_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_کلمه_ *"..word.."* _ليست ممنوعه‼️_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "_Group is not added_"
 else
    return '_لم يتم اضافه المجموعه‼️_'
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "_لا يوجد مدراء في المجموعه_"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*قائمة المدراء:*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "_Group is not added_"..msg_caption
else
    return '_لم يتم اضافه المجموعه‼️_'
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "_لا يوجد مشرفين في المجموعه_"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*قائمة المدراء:*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_ لم يتم اضافه المجموعه☘️_", 0, "md")
     end
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مضاف الى القائمه البيظاء👾*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيظاء ✅*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *ليس في القائمه البيظاء 🌐*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم حذفه من الثائمه البيظاء*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مشرف في المجموعه☘️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مشرف في المجموعه🌐*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مدير في المجموعه👾*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مدير في المجموعه ✅*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *لم يعد مشرف بعد الان 🚹*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *بالفعل ليس مشرف 💠*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل ليس مدير 👾☘️*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مدي������ بعد الان😄💋*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم ايجاد العضو ‼️_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_المجموعه ليست مضافه☘️‼️_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مضاف الى القائمه البيظاء👾*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيظاء ✅*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *ليس في القائمه البيظاء 🌐*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم حذفه من القائمه البيظاء 🤖*", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مشرف في المجموعه❤️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مشرف في المجموعه😁💋*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مدير  في المجموعه☘️❤️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مدير في المجموعه😘☘️*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *لم يعد مشرف بعد  الان🤣‼️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل ليس مشرف 😏💔*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل ليس مدير💠😄*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مدير بعد الان😝‼️*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "معلومات عن المستخدم :[ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم ايجاد العضو ‼️_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم تفعيل المجموعه👾‼️_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مضاف الى القائمه البيظاء👾*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيظاء ✅*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *ليس في القائمه البيظاء 🌐*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم حذفه من القائمه البيظاء 🤖*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مشرف في المجموعه❤️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مشرف في المجموعه😁💋*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل مدير  في المجموعه☘️❤️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *اصبح مدير في المجموعه😘☘️*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *لم يعد مشرف بعد  الان🤣‼️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل ليس مشرف 😏💔*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *بالفعل ليس مدير💠😄*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *لم يعد مدير بعد الان😝‼️*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'لا يوجد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'معلومات عن المستخدم :[ '..data.id_..' ] :\nالمعرف : '..username..'\nالاسم : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم ايجاد العضو ‼️_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم ايجاد العضو ‼️_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "*Link* _Posting Is Already Locked_"
elseif lang then
 return "_الروابط بالفعل مقفوله😐☘️_"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Link* _Posting Has Been Locked_"
else
 return "_تم قفل الروابط❤️_"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "*Link* _Posting Is Not Locked_" 
elseif lang then
return "_الروابط بالفعل غير مقفوله❤️_"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Link* _Posting Has Been Unlocked_" 
else
return "_تم فتح الروابط❤️_"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "*Tag* _Posting Is Already Locked_"
elseif lang then
 return "_التاك#-@ بالفعل مقفول☄️_"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Tag* _Posting Has Been Locked_"
else
 return "_تم قفل التاك#-@🔥_"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "*Tag* _Posting Is Not Locked_" 
elseif lang then
 return "_التاك#-@ بالفعل  مفتوح 💧_"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Tag* _Posting Has Been Unlocked_" 
else
 return "_ تم فتح التاك#-@ 🌞_"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "*Mention* _Posting Is Already Locked_"
elseif lang then
 return "_المنشن بالفعل مقفول😄_"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "*Mention* _Posting Has Been Locked_"
else 
 return "_تم قفل المنشن 😉_"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "*Mention* _Posting Is Not Locked_" 
elseif lang then
 return "_المنشن بالفعل مفتوح😐❤️_"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Mention* _Posting Has Been Unlocked_" 
else
return "_تم فتح المنشن😁👍🏽_"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "*Arabic/Persian* _Posting Is Already Locked_"
elseif lang then
 return "_العربيه بالفعل مقفوله❤️_"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Arabic/Persian* _Posting Has Been Locked_"
else
 return "_تم قفل العربيه😍❤️_"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "*Arabic/Persian* _Posting Is Not Locked_" 
elseif lang then
return "_العربيه بالفعل مفتوحه🙊_"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Arabic/Persian* _Posting Has Been Unlocked_" 
else
return "_تم فتح العربيه👍🏽_"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "*Editing* _Is Already Locked_"
elseif lang then
 return "_التعديل بالفعل مقفول😁_"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Editing* _Has Been Locked_"
else
 return "_تم قفل التعديل 😊_"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "*Editing* _Is Not Locked_" 
elseif lang then
return "_بالتعديل بالفعل  مفتوحه😙_"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Editing* _Has Been Unlocked_" 
else
return "_تم فتح التعديل😝_"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "*Spam* _Is Already Locked_"
elseif lang then
return "_الكلايش بالفعل مقفوله 🤣_"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Spam* _Has Been Locked_"
else
return "_تم قفل الكلايش 😆👌🏼_"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "*Spam* _Posting Is Not Locked_" 
elseif lang then
return "_الكلايش بالفعل مفتوحه😁_"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "*Spam* _Posting Has Been Unlocked_" 
else
return "_تم فتح الكلايش 😝_"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "*Flooding* _Is Already Locked_"
elseif lang then
return "_التكرار بالفعل مقفول🙈_"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Flooding* _Has Been Locked_"
else
return "_تم قفل التكرار 🤑_"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "*Flooding* _Is Not Locked_" 
elseif lang then
return "_التكرار بالفعل مفتوح😃_"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Flooding* _Has Been Unlocked_" 
else
return "_تم فتح التكرار😆_"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "*Bots* _Protection Is Already Enabled_"
elseif lang then
 return "_البوتات بالفعل مقفوله😆_"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Bots* _Protection Has Been Enabled_"
else
 return "_البوتات بالفعل مقفوله 😐_"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "*Bots* _Protection Is Not Enabled_" 
elseif lang then
return "_البوتات بالفعل مفتوحه🤣_"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Bots* _Protection Has Been Disabled_" 
else
return "_تم فتح البوتات 😙_"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "*Lock Join* _Is Already Locked_"
elseif lang then
 return "_الدخول بالفعل مقفول🤑👌🏼_"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Join* _Has Been Locked_"
else
 return "_تم قفل الدخول 😆❤️"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "*Lock Join* _Is Not Locked_" 
elseif lang then
 return "_الدخول بالفعل مفتوح🤣"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Join* _Has Been Unlocked_" 
else
 return "_تم فتح الدخول🙊"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "*Markdown* _Posting Is Already Locked_"
elseif lang then
 return "_الماركدون مقفوله بالفعل😊_"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Markdown* _Posting Has Been Locked_"
else
 return "_تم قفل الماركدون ❤️_"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "*Markdown* _Posting Is Not Locked_"
elseif lang then
 return "_الاعانات الخطيه  بالفعل مفتوحه💋_"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Markdown* _Posting Has Been Unlocked_"
else
 return "_تم فتح الاعانات الخطيه ❤️_"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "*Webpage* _Is Already Locked_"
elseif lang then
 return "_صفحات الويب بالفعل مقفوله😜_"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Webpage* _Has Been Locked_"
else
 return "_تم قفل صفحات الويب 🙁_"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "*Webpage* _Is Not Locked_" 
elseif lang then
 return "_صفحات الويب بالفعل مفتوحه😘_"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Webpage* _Has Been Unlocked_" 
else
 return "_تم فتح ��فحات الويب 🤠_"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "*Pinned Message* _Is Already Locked_"
elseif lang then
 return "_التثبيت بالفعل مقفول😜_"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pinned Message* _Has Been Locked_"
else
 return "_تم قفل التثبيت 😑_"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "*Pinned Message* _Is Not Locked_" 
elseif lang then
 return "_التثبيت بالفعل  مفتوح😩_"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Pinned Message* _Has Been Unlocked_" 
else
 return "_تم فتح التثبيت😤_"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "انت لست مدير 😜☘️"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'غير محدوده!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' يوم'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "*Group Settings:*\n_Lock edit :_ *"..settings.lock_edit.."*\n_Lock links :_ *"..settings.lock_link.."*\n_Lock tags :_ *"..settings.lock_tag.."*\n_Lock Join :_ *"..settings.lock_join.."*\n_Lock flood :_ *"..settings.flood.."*\n_Lock spam :_ *"..settings.lock_spam.."*\n_Lock mention :_ *"..settings.lock_mention.."*\n_Lock arabic :_ *"..settings.lock_arabic.."*\n_Lock webpage :_ *"..settings.lock_webpage.."*\n_Lock markdown :_ *"..settings.lock_markdown.."*\n_Group welcome :_ *"..settings.welcome.."*\n_Lock pin message :_ *"..settings.lock_pin.."*\n_Bots protection :_ *"..settings.lock_bots.."*\n_Flood sensitivity :_ *"..NUM_MSG_MAX.."*\n_Character sensitivity :_ *"..SETCHAR.."*\n_Flood check time :_ *"..TIME_CHECK.."*\n*____________________*\n_Expire Date :_ *"..expire_date.."*\n*Bot channel*: @BeyondTeam\n*Group Language* : *EN*"
else
local settings = data[tostring(target)]["settings"] 
 text = "*اعدادات القفل 🌝✨ :*\n_قفل🎗 التعديل :_ *"..settings.lock_edit.."*\n_قفل🎗 الروابط :_ *"..settings.lock_link.."*\n_قفل🎗 الدخول :_ *"..settings.lock_join.."*\n_قفل🎗 التاك  :_ *"..settings.lock_tag.."*\n_قفل🎗 التكرار :_ *"..settings.flood.."*\n_قفل🎗 الكلايش :_ *"..settings.lock_spam.."*\n_قفل🎗 المنشن :_ *"..settings.lock_mention.."*\n_قفل🎗 العربيه :_ *"..settings.lock_arabic.."*\n_قفل🎗 الويب :_ *"..settings.lock_webpage.."*\n_قفل🎗 الماركدون :_ *"..settings.lock_markdown.."*\n_تفعيل الترحيب :_ *"..settings.welcome.."*\n_قفل🎗 التثبيت :_ *"..settings.lock_pin.."*\n_قفل🎗 البوتات :_ *"..settings.lock_bots.."*\n_عدد التكرار بالمجموعه :_ *"..NUM_MSG_MAX.."*\n_عدد الاحرف المسموح بها  :_ *"..SETCHAR.."*\n_ زمن كتم التكرار ⏱:_ *"..TIME_CHECK.."*\n*____________________*\n_صلاحية المجموعه :_ *"..expire_date.."*\n*Bot CHANNEL*: @kenamch\n*Group Language* : *ar*"
end
return text
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "انت لست مدير 😜☘️"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "*Mute All* _Is Already Enabled_" 
elseif lang then
return "_قفل الكل بالفعل مفعل👍🏽_"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute All* _Has Been Enabled_" 
else
return "_تم قفل الكل 😷_"
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "انت لست مدير 😜☘️"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "*Mute All* _Is Already Disabled_" 
elseif lang then
return "_قفل الكل بالفعل معطل😄_"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute All* _Has Been Disabled_" 
else
return "_تم الغاء قفل الكل😝_"
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "*Mute Gif* _Is Already Enabled_"
elseif lang then
return "_المتحركه بالفعل مقفوله🤡_"
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "*Mute Gif* _Has Been Enabled_"
else
return "_تم قفل المتحركه🤣_"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "*Mute Gif* _Is Already Disabled_" 
elseif lang then
return "_المتحركه بالفعل مفتوحه😫_"
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Gif* _Has Been Disabled_" 
else
return "_تم فتح المتحركه👍🏽_"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "*Mute Game* _Is Already Enabled_"
elseif lang then
return "_الالعاب بالفعل مقفوله👍🏽_"
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Game* _Has Been Enabled_"
else
 return "_تم قفل الالعاب😄_"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "*Mute Game* _Is Already Disabled_" 
elseif lang then
return "_لالعاب بالفعل مفتوحه🙈_"
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Mute Game* _Has Been Disabled_" 
else
return "_تم فتح الالعاب 🙊_"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
 return "*Mute Inline* _Is Already Enabled_"
elseif lang then
return "_انلاين بالفعل مقفول 😊_"
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Inline* _Has Been Enabled_"
else
return "_تم قفل الانلاين 😀_"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "*Mute Inline* _Is Already Disabled_" 
elseif lang then
return "_الانلاين بالفعل مفتوح😝_"
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Inline* _Has Been Disabled_" 
else
return "_تم فتح الانلاين😐_"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "*Mute Text* _Is Already Enabled_"
elseif lang then
 return "_الكتابه بالفعل مقفوله😁_"
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Text* _Has Been Enabled_"
else
 return "_تم قفل الكتابه ☺️_"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "*Mute Text* _Is Already Disabled_"
elseif lang then
 return "_الكتابه بالفعل مفتوحه😄_"
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Text* _Has Been Disabled_" 
else
 return "_تم فتح الكتابه😁_"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "*Mute Photo* _Is Already Enabled_"
elseif lang then
 return "_الصور بالفعل مقفوله😀_"
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Photo* _Has Been Enabled_"
else
 return "_تم قفل الصور😄_"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "*Mute Photo* _Is Already Disabled_" 
elseif lang then
 return "_الصور بالفعل مفتوحه😏_"
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Photo* _Has Been Disabled_" 
else
 return "_تم فتح الصور 😙_"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "*Mute Video* _Is Already Enabled_"
elseif lang then
 return "_الفديو بالفعل مقفول🙊_"
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "*Mute Video* _Has Been Enabled_"
else
 return "_تم قفل الفديو 😛_"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "*Mute Video* _Is Already Disabled_" 
elseif lang then
 return "_الفديو بالفعل مفتوح😆_"
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Video* _Has Been Disabled_" 
else
 return "_تم فتح الفديو 😅_"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "*Mute Audio* _Is Already Enabled_"
elseif lang then
 return "_الاغاني بالفعل تم قفلهاها☘️_"
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Audio* _Has Been Enabled_"
else 
return "_تم قفل الاغاني☘️_"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "*Mute Audio* _Is Already Disabled_" 
elseif lang then
return "_الاغاني بالفعل مفتوحه☘️_"
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Mute Audio* _Has Been Disabled_"
else
return "_تم فتح الاغاني☘️_"
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "*Mute Voice* _Is Already Enabled_"
elseif lang then
return "_البصمه بالفعل  مقفوله😄_"
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Voice* _Has Been Enabled_"
else
return "_تم قفل البصمه🙂_"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "*Mute Voice* _Is Already Disabled_" 
elseif lang then
return "_البصمه بالفعل مفتوحه😐_"
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Mute Voice* _Has Been Disabled_" 
else
return "_تم فتح البصمه😀_"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "*Mute Sticker* _Is Already Enabled_"
elseif lang then
return "_الملسقات بالفعل  مقفوله😐_"
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Sticker* _Has Been Enabled_"
else
return "_تم قفل الملسقات😒_"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "*Mute Sticker* _Is Already Disabled_" 
elseif lang then
return "_الملسقات بالفعل  مفتوحه🌞_"
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Mute Sticker* _Has Been Disabled_"
else
return "_تم فتح الملسقات 😃_"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "*Mute Contact* _Is Already Enabled_"
elseif lang then
return "_الجهات بالفعل مقفوله😐_"
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Contact* _Has Been Enabled_"
else
return "_تم قفل الجهات😀_"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "*Mute Contact* _Is Already Disabled_" 
elseif lang then
return "_الجهات بالفعل مفتوحه😃_"
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Contact* _Has Been Disabled_" 
else
return "_تم فتح الجهات😝_"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "*Mute Forward* _Is Already Enabled_"
elseif lang then
return "_التوجيه بالفعل مقفول😀_"
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Forward* _Has Been Enabled_"
else
return "_تم قفل التوجيه🤣_"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "*Mute Forward* _Is Already Disabled_"
elseif lang then
return "_التوجيه بالفعل مفتوح😘_"
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Mute Forward* _Has Been Disabled_" 
else
return "_اتم فتح التوجيه😜_"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "*Mute Location* _Is Already Enabled_"
elseif lang then
return "_الموقع بالفعل مقفول🤗_"
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "*Mute Location* _Has Been Enabled_"
else
return "_تم قفل الموقع 😛_"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "*Mute Location* _Is Already Disabled_" 
elseif lang then
return "_الموقع بالفعل مفتوح🤠_"
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Location* _Has Been Disabled_" 
else
return "_تم فتح الموقع ☺️_"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "*Mute Document* _Is Already Enabled_"
elseif lang then
return "_الملفات بالفعل مقفوله🌞_"
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Document* _Has Been Enabled_"
else
return "_تم قفل الملفات🤣_"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "انت لست مدير 😜☘️"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "*Mute Document* _Is Already Disabled_" 
elseif lang then
return "_الملفات بالفعل مفتوحه😛_"
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Document* _Has Been Disabled_" 
else
return "_تم فتح الملفات😌_"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "*Mute TgService* _Is Already Enabled_"
elseif lang then
return "_الاشعارات مقفوله🙂_"
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute TgService* _Has Been Enabled_"
else
return "_تم قفل الاشعارات🙂_"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "*Mute TgService* _Is Already Disabled_"
elseif lang then
return "_الاشعارات بالفعل مفتوحه_"
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute TgService* _Has Been Disabled_"
else
return "_تم فتح الاشعارات 🙂_"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "*Mute Keyboard* _Is Already Enabled_"
elseif lang then
return "_الكيبورد بالفعل مقفول😝_"
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Mute Keyboard* _Has Been Enabled_"
else
return "_تم قفل الكيبورد😊_"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "انت لست مدير 😜☘️"
end 
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "*Mute Keyboard* _Is Already Disabled_"
elseif lang then
return "_الكيبورد بالفعل مفتوح😇_"
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Keyboard* _Has Been Disabled_"
else
return "_تم فتح الكيبورد🙃_"
end 
end
end
----------MuteList---------
local function mutes(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"	
else
 return "_انت لست مدير☘️_"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"		
end
end
if not lang then
local mutes = data[tostring(target)]["mutes"] 
 text = " *Group Mute List* : \n_Mute all : _ *"..mutes.mute_all.."*\n_Mute gif :_ *"..mutes.mute_gif.."*\n_Mute text :_ *"..mutes.mute_text.."*\n_Mute inline :_ *"..mutes.mute_inline.."*\n_Mute game :_ *"..mutes.mute_game.."*\n_Mute photo :_ *"..mutes.mute_photo.."*\n_Mute video :_ *"..mutes.mute_video.."*\n_Mute audio :_ *"..mutes.mute_audio.."*\n_Mute voice :_ *"..mutes.mute_voice.."*\n_Mute sticker :_ *"..mutes.mute_sticker.."*\n_Mute contact :_ *"..mutes.mute_contact.."*\n_Mute forward :_ *"..mutes.mute_forward.."*\n_Mute location :_ *"..mutes.mute_location.."*\n_Mute document :_ *"..mutes.mute_document.."*\n_Mute TgService :_ *"..mutes.mute_tgservice.."*\n_Mute Keyboard :_ *"..mutes.mute_keyboard.."*\n*____________________*\n*Bot channel*: @BeyondTeam\n*Group Language* : *EN*"
else
local mutes = data[tostring(target)]["mutes"] 
 text = " *اعدادات القفل2 💭☘️* : \n_قفل 💭 الكل : _ *"..mutes.mute_all.."*\n_قفل 💭 المتحركه :_ *"..mutes.mute_gif.."*\n_قفل 💭 الكتابه :_ *"..mutes.mute_text.."*\n_قفل 💭 انلاين :_ *"..mutes.mute_inline.."*\n_قفل 💭 الالعاب :_ *"..mutes.mute_game.."*\n_قفل 💭 الصور :_ *"..mutes.mute_photo.."*\n_قفل 💭 الفديو :_ *"..mutes.mute_video.."*\n_قفل 💭 الاغاني :_ *"..mutes.mute_audio.."*\n_قفل 💭 البصمه :_ *"..mutes.mute_voice.."*\n_قفل 💭 الملسقات :_ *"..mutes.mute_sticker.."*\n_قفل 💭 الجهات :_ *"..mutes.mute_contact.."*\n_قفل 💭 التوجيه :_ *"..mutes.mute_forward.."*\n_قفل 💭 الموقع :_ *"..mutes.mute_location.."*\n_قفل 💭 الملفات :_ *"..mutes.mute_document.."*\n_قفل 💭 الاشعارات :_ *"..mutes.mute_tgservice.."*\n_قفل 💭 الكيبورد:_ *"..mutes.mute_keyboard.."*\n*____________________*\n*BOT CHANNEL*: @kenamch\n*Group Language* : *AR*"
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if ((matches[1] == "add" and not Clang) or (matches[1] == "تفعيل" and Clang)) then
return modadd(msg)
end
if ((matches[1] == "rem" and not Clang) or (matches[1] == "تعطيل" and Clang)) then
return modrem(msg)
end
if not data[tostring(msg.to.id)] then return end
if (matches[1] == "id" and not Clang) or (matches[1] == "ايدي" and Clang) then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"✳️ايدي المجموعه:"..msg.to.id.."\n ❇️ايديك:"..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_لا يوجد صوره لك ...!_\n\n>  ايدي المجموعه☘️ :_ `"..msg.to.id.."`\n_ايديك❤️:_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] and is_mod(msg) then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1] == "pin" and not Clang) or (matches[1] == "تثبيت" and Clang)) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "_تم تثبيت الرساله♨️_"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "_تم تثبيت الرساله✅_"
end
end
end
if ((matches[1] == 'unpin' and not Clang) or (matches[1] == "الغاء تثبيت" and Clang)) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "_تم الغاء الرساله المثبته🌀_"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "_تم الغاء الرساله المثبته♻️_"
end
end
end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "السته البيظاء" and Clang)) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "السته البيظاء" and Clang)) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1] == "setowner" and not Clang) or (matches[1] == 'رفع مشرف' and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1] == "remowner" and not Clang) or (matches[1] == "حذف مشرف" and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1] == "promote" and not Clang) or (matches[1] == "رفع مدير" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1] == "demote" and not Clang) or (matches[1] == "حذف مدير" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if ((matches[1] == "lock" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "الروابط" and Clang)) then
return lock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "التاك" and Clang)) then
return lock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "المنشن" and Clang)) then
return lock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "العربيه" and Clang)) then
return lock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "التعديل" and Clang)) then
return lock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "الكلايش" and Clang)) then
return lock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "التكرار" and Clang)) then
return lock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "البوتات" and Clang)) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "الماركدون" and Clang)) then
return lock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "الصفحات" and Clang)) then
return lock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "الدخول" and Clang)) then
return lock_join(msg, data, target)
end
end

if ((matches[1] == "unlock" and not Clang) or (matches[1] == "فتح" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "الروابط" and Clang)) then
return unlock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "التاك" and Clang)) then
return unlock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "المنشن" and Clang)) then
return unlock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "العربيه" and Clang)) then
return unlock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "التعديل" and Clang)) then
return unlock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "الكلايش" and Clang)) then
return unlock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "التكرار" and Clang)) then
return unlock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "البوتات" and Clang)) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "الماركدون" and Clang)) then
return unlock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "الصفحات" and Clang)) then
return unlock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "الدخول" and Clang)) then
return unlock_join(msg, data, target)
end
end
if ((matches[1] == "mute" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "all" and not Clang) or (matches[2] == "الكل" and Clang)) then
return mute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "المتحركه" and Clang)) then
return mute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "الكتابه" and Clang)) then
return mute_text(msg ,data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "الصور" and Clang)) then
return mute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "الفديو" and Clang)) then
return mute_video(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "الاغاني" and Clang)) then
return mute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "البصمه" and Clang)) then
return mute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "الملسقات" and Clang)) then
return mute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "الجهات" and Clang)) then
return mute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "التوجيه" and Clang)) then
return mute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "الموقع" and Clang)) then
return mute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "الملفات" and Clang)) then
return mute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then
return mute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "انلاين" and Clang)) then
return mute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "الالعاب" and Clang)) then
return mute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "الكيبورد" and Clang)) then
return mute_keyboard(msg ,data, target)
end
end

if ((matches[1] == "unmute" and not Clang) or (matches[1] == "فتح" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "all" and not Clang) or (matches[2] == "الكل" and Clang)) then
return unmute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "المتحركه" and Clang)) then
return unmute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "الكتابه" and Clang)) then
return unmute_text(msg, data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "الصور" and Clang)) then
return unmute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "الفديو" and Clang)) then
return unmute_video(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "الاغاني" and Clang)) then
return unmute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "البصمه" and Clang)) then
return unmute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "الملسقات" and Clang)) then
return unmute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "الجهات" and Clang)) then
return unmute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "التوجيه" and Clang)) then
return unmute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "الموقع" and Clang)) then
return unmute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "الملفات" and Clang)) then
return unmute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then
return unmute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "انلاين" and Clang)) then
return unmute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "الالعاب" and Clang)) then
return unmute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "الكيبورد" and Clang)) then
return unmute_keyboard(msg ,data, target)
end
end
if ((matches[1] == "gpinfo" and not Clang) or (matches[1] == "معلومات" and Clang)) and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "*معلومات المجموعه :*\n_عدد المدراء☘️ :_ *"..data.administrator_count_.."*\n_عدد الاعضاء🔰 :_ *"..data.member_count_.."*\n_عدد الاعضاء المحظورين🚫 :_ *"..data.kicked_count_.."*\n_ايدي المجموعه💠 :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if ((matches[1] == 'newlink' and not Clang) or (matches[1] == "رابط جديد" and Clang)) and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink"..msg_caption, 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ البوت ليس مالك المجموعه _\n_ استخدم الامر (ضع رابط)☘️_ "..msg_caption, 1, 'md')
     end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_تم صنع رابط المجموعه☘️_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if ((matches[1] == 'setlink' and not Clang) or (matches[1] == "ضع رابط" and Clang)) and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return '_ارسل رابط المجموعه الان📋_'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "_تم وضع رابط الجديد☘️_"
		 	end
       end
		end
    if ((matches[1] == 'link' and not Clang) or (matches[1] == "الرابط" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "اذا كانت مجموعه البوت يجب عليك صنع رابط استخدم الامر (رابط جديد) ☘️ اما اذا لم تكن مجموعه لكروب استخدم الامر (ضع رابط) ❤️"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp..msg_caption
     else
      text = "<b>رابط المجموعه:</b>\n"..linkgp..msg_caption
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if ((matches[1] == 'linkpv' and not Clang) or (matches[1] == "رابط خاص" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "اذا كانت مجموعه البوت يجب عليك صنع رابط استخدم الامر (رابط جديد) ☘️ اما اذا لم تكن مجموعه لكروب استخدم الامر (ضع رابط) ❤️"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>رابط المجموعه"..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
         end
      if not lang then
        return "*Group Link Was Send In Your Private Message*"
       else
        return "_تم ارسال رابط المجموعه الى خاصك🙈_"
        end
     end
  if ((matches[1] == "setrules" and not Clang) or (matches[1] == "ضع قوانين" and Clang)) and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "_تم وضع قوانين المجموعه😀_"
   end
  end
  if ((matches[1] == "rules" and not Clang) or (matches[1] == "القوانين" and Clang)) then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡��� Repeated failure to comply with these rules will cause ban."..msg_caption
    elseif lang then
      rules = "ℹ️ القوانين الافتراضيه:\n1️⃣ عدم تكرار الرسائل لتجنب الطرد.\n2️⃣ الكلايش الطويله ممنوعه.\n3️⃣ السب والشتم ممنوع.\n4️⃣ الاعلانات والروابط ممنوعه.\n5️⃣ الزحف ومضايقة الاعضاء طرد.\n➡️ احترم تحترم واخلاقك تعكس تربيتك.\n"..msg_caption
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if ((matches[1] == "res" and not Clang) or (matches[1] == "فحص" and Clang)) and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1] == "whois" and not Clang) or (matches[1] == "تدقيق" and Clang)) and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if ((matches[1]:lower() == 'setchar' and not Clang) or (matches[1] == "حساسيه الاحرف" and Clang)) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_حد الحروف المسموح بها اصبح  :_ *[ "..matches[2].." ]*"
		end
  end
  if ((matches[1]:lower() == 'setflood' and not Clang) or (matches[1] == "ضع تكرار" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
    else
    return '_الحد الاقصى للتكرار اصبح _ *'..tonumber(matches[2])..''
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' and not Clang) or (matches[1] == "وقت كتم التكرار" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_Wrong number, range is_ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*"
    else
    return "_عدد التكرار بالكتم اصبح  :_ *[ "..matches[2].." ]*"
    end
       end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "حذف" and Clang)) and is_owner(msg) then
			if ((matches[2] == 'mods' and not Clang) or (matches[2] == "المدراء" and Clang)) then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "_No_ *moderators* _in this group_"
             else
            return "_لا يوجد مدراء 😘_"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *moderators* _has been demoted_"
          else
            return "_تم حذف كل المدراء🤣_"
			end
         end
			if ((matches[2] == 'filterlist' and not Clang) or (matches[2] == "الكلمات الممنوعه" and Clang)) then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*Filtered words list* _is empty_"
         else
            return "_قائمه المنع خاليه 😌_"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*Filtered words list* _has been cleaned_"
           else
            return "_تم حذف قائمه المنع 😗_"
           end
			end
			if ((matches[2] == 'rules' and not Clang) or (matches[2] == "القوانين" and Clang)) then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "_No_ *rules* _available_"
             else
            return "_لا يوجد قوانين 😍❤️_"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Group rules* _has been cleaned_"
          else
            return "_تم حذف قوانين المجموعه😀_"
			end
       end
			if ((matches[2] == 'welcome' and not Clang) or (matches[2] == "الترحيب" and Clang)) then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
            return "_لا يوجد رساله ترحيب😍❤️_"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "_تم حذف رساله الترحيب😄_"
			end
       end
			if ((matches[2] == 'about' and not Clang) or (matches[2] == "الوصف" and Clang)) then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
            return "_لا يوجد وصف في المجموعه🤣_"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
            return "_تم حذف وصف المجموعه🕺_"
             end
		   	end
        end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "حذف" and Clang)) and is_admin(msg) then
			if ((matches[2] == 'owners' and not Clang) or (matches[2] == "المشرفين" and Clang)) then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
            return "_لا يوجد مشرفين في المجموعه😃_"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "_جيمع المشرفين تم حذفهم☘️_"
          end
			end
     end
if ((matches[1] == "setname" and not Clang) or (matches[1] == "ضع اسم" and Clang)) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1] == "setabout" and not Clang) or (matches[1] == "ضع وصف" and Clang)) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "_تم وضع وصف للمجموعه☹️_"
      end
  end
  if ((matches[1] == "about" and not Clang) or (matches[1] == "الوصف" and Clang)) and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "_لا يوجد وصف للمجموعه💋_"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1] == 'filter' and not Clang) or (matches[1] == "منع" and Clang)) and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1] == 'unfilter' and not Clang) or (matches[1] == "سماح" and Clang)) and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1] == 'filterlist' and not Clang) or (matches[1] == "الكلمات الممنوعه" and Clang)) and is_mod(msg) then
    return filter_list(msg)
  end
if ((matches[1] == "settings" and not Clang) or (matches[1] == "اعدادات" and Clang)) then
return group_settings(msg, target)
end
if ((matches[1] == "mutelist" and not Clang) or (matches[1] == "اعدادات2" and Clang)) then
return mutes(msg, target)
end
if ((matches[1] == "modlist" and not Clang) or (matches[1] == "قائمة المدراء" and Clang)) then
return modlist(msg)
end
if ((matches[1] == "ownerlist" and not Clang) or (matches[1] == "قائمة المشرفين" and Clang)) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1] == "whitelist" and not Clang) or (matches[1] == "السته البيظاء" and Clang)) and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if ((matches[1]:lower() == "option" and not Clang) or (matches[1] == "الاوامر" and Clang)) and is_mod(msg) then
local function inline_query_cb(arg, data)
      if data.results_ and data.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, data.inline_query_id_, data.results_[0].id_, dl_cb, nil)
    else
    if not lang then
    text = "*Helper is offline*\n\n"
        elseif lang then
    text = "البوت الشفاف غير  متصل ‼️"
    end
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(helper_id, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end

if (matches[1]:lower() == "setlang" and not Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "ar" then
redis:set(hash, true)
   return "*اصبحت لغة البوت : عربيه*"..msg_caption
    elseif matches[2] == "en" then
 redis:del(hash)
return "_Group Language Set To:_ EN"..msg_caption
end
end
if (matches[1] == 'اللغه' and Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "عربي" then
redis:set(hash, true)
return "*اصبحت لغة البوت : عربيه*"..msg_caption
  elseif matches[2] == "انكلش" then
 redis:del(hash)
return "_Group Language Set To:_ EN"..msg_caption
end
end

if (matches[1]:lower() == "setcmd" and not Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
if matches[2] == "ar" then
redis:set(hash, true)
   if lang then
return "*اصبحت لغة اوامر البوت :عربيه*"..msg_caption
else
return "_Bot Commands Language Set To:_ ar"..msg_caption
end
end
end

if (matches[1]:lower() == "اوامر انكلش" and Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
redis:del(hash)
   if lang then
return "*اصبحت لغة اوامر البوت : انكليزيه*"..msg_caption
else
return "_Bot Commands Language Set To:_ EN"..msg_caption
end
end

if matches[1] == "help" and is_mod(msg) or matches[1] == "Help" and is_mod(msg) or matches[1] == "مساعده" or matches[1] == "الاوامر" and is_mod(msg) then
if not lang then
text = [[🔖*нєℓρ kenam Ɓσт*
⚡️*тo ѕee тнe coммαɴdѕ oғ yoυr deѕιred ιтeм ѕυвмιт*
🌐 _ҽɳɠʅιʂԋ cσɱɱαɳԃʂ :_
👆 `To Get Help mods`
*👉🏻 h1*
➖➖➖
👆 `To Get Help Lock 👁‍🗨`
*👉🏻 h2*
➖➖➖
👆 `To Get Help Mute 👁‍🗨`
*👉🏻 h3*
➖➖➖
👆 `To Get Help sudo 👁‍🗨`
*👉🏻 h4*
➖➖➖
👆 `To Get Help Warn 👁‍🗨`
*👉🏻 h5*
➖➖➖
👆 `To Get Help Fun 👁‍🗨`
*👉🏻 h6*
➖➖➖
⌨️ لغة البوت الحاليه (الانكلش) !
_لتغيير لغة البوت ارسل_ 
*Setlang* `[en , ar]`
_لتغيير لغة الاوامر ارسل_ 
*Setcmd* `[en , ar]`
➖➖➖➖➖➖➖➖➖
👤 *ρσωєяɗ Ɓу :* @saad7m
]]
elseif lang then
text = [[🔖*нєℓρ kenam Ɓσт*
⚡️*اختر احد الاوامر التاليه لاضهار قوائم المساعدة*
_._
🎗*👈🏻 م1*
⏺#لعرض اوامر الاداره 👁‍🗨
➖➖➖
🎗*👈🏻 م2*
🔸#لعرض اوامر القفل👁‍🗨
➖➖➖
🎗*👈🏻 م3*
⏺#لعرض اوامر الكتم👁‍🗨
➖➖➖
🎗*👈🏻 م4*
🔸#لعرض اوامر المطورين👁‍🗨
➖➖➖
🎗*👈🏻 م5*
⏺#اوامر التحذير والمسح👁‍🗨
➖➖➖
🎗*👈🏻 م6*
🔸#اوامر اضافيه👁‍🗨
➖➖➖
⌨️ لغة البوت العربيه !
_لتغيير اللغه_
 *اللغه* `[عربي ,انكلش]`
_لتغيير الاوامر_
`*الاوامر*[عربي , انكلش]`
➖➖➖➖➖➖➖➖➖
👤 *ρσωєяɗ Ɓу :* @saad7m
]]
end
return text
end

if matches[1] == "h2" and is_mod(msg) or matches[1] == "H2" and is_mod(msg) or matches[1] == "م2" and is_mod(msg)then
if not lang then
text = [[
💠*EngliSh CoMmAnDs :*
#Lock commands 
🔒*Lock* مع الاوامر ادناه 👇للقفل

🔓*Unlock* مع الاوامر ادناه 👇للفتح
〰〰〰〰〰⛓

`[link] , [username] , [hashtag]`

`[edit] , [arabic] , [webpage]`

`[markdown] , [spam] , [flood]`

`[bots] , [mention] , [join]`
 
 *⌨️ LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , ar]`
*To Change The commands* `[Setcmd]` `[en , ar]`
➖➖➖➖➖➖➖➖➖
 ]]
elseif lang then
text = [[
#الاوامر بالعربيه 👁‍🗨

🔇قفل مع الاوامر ادناه 👇للقفل

🔊فتح مع الاوامر ادناه 👇للفتح
〰〰〰〰〰⛓

 `[🔹الروابط🔹][🔹التاك @-#-/ 🔹]`
 
 `[🔹التعديل🔹][🔹العربيه🔹][🔹الصفحات🔹]`
 
 `[🔹البوتات🔹][🔹الكلايش🔹][🔹التكرار🔹]`
 
 `[🔹الماركدون🔹][🔹المنشن🔹][🔹الدخول🔹]`
 
⌨️ لغة البوت العربيه !
لتغيير اللغه [اللغه] [عربي ,انكلش]
لتغيير الاوامر [الاوامر] [عربي ,انكلش]
➖➖➖➖➖➖➖➖➖➖➖➖
]]
end
return text
end

if matches[1] == "h3" and is_mod(msg) or matches[1] == "H3" and is_mod(msg) or matches[1] == "م3" and is_mod(msg)then
if not lang then
text = [[
#Mute commands
🔇*mute* مع الاوامر ادناه 👇للقفل

🔊*unmute* مع الاوامر ادناه 👇للفتح
〰〰〰〰〰⛓

`[gif] , [photo] , [document]`

`[sticker] , [video] , [text]`

`[forward] , [location] , [audio]`

`[all] , [contact] ,[tgservice]`

`[inline] , [voice] , [keyboard]`
 
 *⌨️ LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , ar]`
*To Change The commands* `[Setcmd]` `[en , ar]`
➖➖➖➖➖➖➖➖➖
]]
elseif lang then
text = [[
#الاوامر بالعربيه 👁‍🗨

🔇قفل مع الاوامر ادناه 👇للقفل

🔊فتح مع الاوامر ادناه 👇للفتح
〰〰〰〰〰⛓

 `[🔹المتحركه🔹][🔹الصور🔹][🔹الملفات🔹]`
 
 `[🔹الملسقات🔹][🔹الفديو🔹][🔹النص🔹]`
 
 `[🔹التوجيه🔹][🔹الموقع🔹][🔹الصوت🔹]`
 
 `[🔹البصمات🔹][🔹الجهات🔹][🔹الاشعارات🔹]`
 
 `[🔹الشفافه🔹][🔹الكل🔹][🔹الكيبورد🔹]`
 
⌨️ لغة البوت العربيه !
لتغيير اللغه [اللغه] [عربي ,انكلش]
لتغيير الاوامر [الاوامر] [عربي ,انكلش]
➖➖➖➖➖➖➖➖➖➖➖➖
]]
end
return text
end

if matches[1] == "h1" and is_mod(msg) or matches[1] == "H1" and is_mod(msg) or matches[1] == "م1" and is_mod(msg) then
if not lang then
text = [[
💠*EngliSh CoMmAnDs :*
#Modhelp
⚡️لمنع كلمه
*Filter* `[text]`
💥للسماح بالكلمه
*Unfilter* `[text]`
⚡️تفعيل وتعطيل الترحيب
*Welcome* `[enable-disable]`
💥رفع مدير
*Promote* `[username , id , reply]`
💥تنزيل مدير 
*Demote* `[username , id , reply]`
💥اعدادات المجموعه
*Settings*
⚡️قائمة المدراء
*Modelist*
💥المالكين او المشرفين
*Ownerlist*
⚡️المكتومين
*Silentlist*
💥الكلمات الممنوعه
*Filterlist*
⚡️لوضع عدد التكرار
*Setflood* `[1-50]`
💥لوضع [قوانين,اسم,رابط,وصف]للمجموعه
*Set* `[rules , name , link , about]`
⚡️لوضع نص الترحيب
*Setwelcome* `[text]`
💥معلومات مستخدم بالمعرف
*Res* `[username]`
⚡️معلومات مستخدم بالايدي
*Whois* `[id]`
💥تثبيت رسائل بالرد
*Pin* `[reply]`
⚡️الغاء تثبيت الرساله
*Unpin* `[reply]`
💥القوانين
*Rules* 
⚡️الوصف
*About*
💥معلومات المجموعه
*Gpinfo*
⚡️لاضهار الرابط
*Link*
 *⌨️ LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , ar]`
➖➖➖
]]
elseif lang then
text = [[
💠_الاوامر العربيه :_
#اوامر الاداره
⚡====================
💥مسح رسائل مستخدم
⚡️*مسح الكل* 
⚡======================
💥*منع* `[الكلمه]`
⚡️*سماح* `[الكلمه]`
💥==
⚡️*الترحيب* `[تفعيل-تعطيل]`
💥======================
⚡️*رفع مشرف* 
⚡️*حذف مشرف* 
⚡️*رفع مدير* 
⚡️*حذف مدير* 
💥======================
💥اعدادات
💥اعدادات2
⚡️قائمة المدراء
⚡️*قائمة المشرفين*
⚡️*الكلمات الممنوعه*
⚡️لوضع عدد التكرار
⚡️*ضع تكرار* `[1-50]`
💥==
⚡️*ضع* `[قوانين , اسم , رابط , وصف, ترحيب]`
💥معلومات مستخدم بالمعرف
⚡️*تدقيق* `[username]`
⚡️معلومات مستخدم بالايدي
⚡️*فحص* `[id]`
💥تثبيت الرسائل
⚡️*تثبيت* `[بالرد]`
⚡️*الغاء تثبيت* `[بالرد]`
💥القوانين
⚡️الوصف
💥معلومات المجموعه
⚡️*معلومات*
⚡️لاضهار الرابط
⚡️*الرابط*
*⌨️ لغة البوت العربيه !*
_لتغيير اللغه_ `[اللغه]` `[عربي ,انكلش]`
لتغيير الاوامر [الاوامر] [عربي ,انكلش]
➖➖➖
]]
end
return text
end

if matches[1] == "h5" or matches[1] == "H5" or matches[1] == "م5" then
if not lang then
text = [[
̶M̶α̶Ƭ̶α̶Ɗ̶σ̶R̶ ̶M̶υ̶т̶є̶т̶ι̶м̶є̶ ̶Ƈ̶σ̶м̶м̶α̶η̶ɗ̶ѕ:
*⚡️тo ѕee тнe coммαɴdѕ oғ yoυr deѕιred ιтeм ѕυвмιт*
🌐 ҽɳɠʅιʂԋ cσɱɱαɳԃʂ :
*👈🏻 Mute all*
⏺Mute groups
➖➖➖
*👈🏻 Mute* (hour) (minute)  (seconds)
🔸Mute group at this time 
➖➖➖
*👈🏻 Mutehours* (number)
⏺Mute group at this time 
➖➖➖
*👈🏻 Muteminutes* (number)
🔸Mute group at this time 
➖➖➖
*👈🏻 Muteseconds* (number)
⏺Mute group at this time 
➖➖➖
*👈🏻 Unmute all*
🔸Unmute group at this time 
➖➖➖
*⌨️ LanGuage BoT EngliSh !*
_To Change The LanGuage_
*👈🏻 Setlang* [en , ar]
➖➖➖
👤 ρσωєяɗ Ɓу : @saad7m
🗣 ƇнαηηєƖ : @kenamch
]]
elseif lang then
text = [[
اوامر التحذير والكتم 👁‍🗨
⭐️⭐️⭐️⭐️⭐️⭐️⭐️
warn groups
💎 ضع تحذير [العدد]
💎 تحذير 
💎 الغاء تحذير 
〰〰〰〰〰〰⚡️
🔕 كتم
🔔 الغاء كتم
⚡ ️المكتومين
🔕 حضر
🔔 الغاء حضر
⚡ ️المحضورين
🔕 طرد
〰〰〰〰〰〰⚡️
👁‍🗨 الكتم المؤقت↘️
🔇 صامت لمدة `[ساعات]``[دقائق]`
🔉 الغاء الصامت
〰〰〰〰〰〰⚡️
🗯 مسح الرسائل
🗯 مسح `[العدد]` لغاية 1000
🗯 مسح رسائلي
🗯 مسح شامل
🗯 حذف `[بالرد]`
〰〰〰〰〰〰⚡️
📌 حذف = مع الاوامر ادناه
📌 `[البوتات,المحضورين,المكتومين]`
📌 `[الكلمات الممنوعه,الوصف]`
📌 `[المدراء,المشرفين,القوانين]`

الاوامر تعمل `[بالرد💰بالمعرف💰بالايدي]`
➖➖➖
]]
end
return text
end

if matches[1] == "ping" or matches[1] == "Ping" or matches[1] == "متصل" and is_mod(msg) then
text = [[
ببہۣۧﭑلہۣۧتہۣۧآكہۣۧيہۣۧيہۣۧڊ مہۣۧتہۣۧصہۣۧلہۣۧ 👁‍🗨🌚
]]
return text
end
--------------------- Welcome -----------------------
	if ((matches[1] == "welcome" and not Clang) or (matches[1] == "الترحيب" and Clang)) and is_mod(msg) then
		if ((matches[2] == "enable" and not Clang) or (matches[2] == "تفعيل" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome* _is already enabled_"
       elseif lang then
				return "_الترحيب بالفعل مفعل 🤑_"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "_Group_ *welcome* _has been enabled_"
       elseif lang then
				return "_تم تفعيل الترحيب 😍_"
          end
			end
		end
		
		if ((matches[2] == "disable" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
				return "_الترحيب بالفعل معطل 😇_"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "_تم تعطيل ترحيب المجموعه☘️_"
          end
			end
		end
end
	if ((matches[1] == "setwelcome" and not Clang) or (matches[1] == "ضع ترحيب" and Clang)) and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"..msg_caption
       else
		return "_تم وضع نص الترحيب على 🚹🐰 :_\n*"..matches[2].."*\n\n*يمكنك ايضا اضافة :*\n_{gpname} اسم المجموعه_\n_{rules} ➣اضهار القوانين 👁‍🗨_\n_{name} ➣ اسم المستخدم الجديد_\n_{username} ➣ معرف المستخدم الجديد_"..msg_caption
        end
     end
	end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '_Robot isn\'t Administrator, Please promote to Admin!_', 1, "md")
			else
    return tdcli.sendMessage(msg.to.id, 0, 1, '_انتباه‼️\n  الرجاء رفع البوت ادمن في المجموعه ليقوم بالعمل 👍🏽❤️._', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_ﺄﺈهٰ۪۫لٰ۪۫ﺄﺈ وٰ۪۫سٰ۪۫هٰ۪۫لٰ۪۫ﺄﺈ بٰ۪۫كٰ۪۫مٰ۪۫😍☘️_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@BeyondTeam"
    elseif lang then
     rules = "ℹ️ القوانين الافتراضيه:\n1️⃣ عدم تكرار الرسائل لتجنب الطرد.\n2️⃣ الكلايش الطويله ممنوعه.\n3️⃣ السب والشتم ممنوع.\n4️⃣ الاعلانات والروابط ممنوعه.\n5️⃣ الزحف ومضايقة الاعضاء طرد.\n➡️ احترم تحترم واخلاقك تعكس تربيتك.\n" end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^[!/#](id)$",
"^[!/#](ping)$",
"^[!/#](h1)$",
"^([Hh]1)$",
"^[!/#](h2)$",
"^([Hh]2)$",
"^[!/#](h3)$",
"^([Hh]3)$",
"^[!/#](h5)$",
"^([Hh]5)$",
"^[!/#](id) (.*)$",
"^[!/#](pin)$",
"^[!/#](unpin)$",
"^[!/#](gpinfo)$",
"^[!/#](test)$",
"^[!/#](add)$",
"^[!/#](rem)$",
"^[!/#](option)$",
"^[!/#](whitelist) ([+-])$",
"^[!/#](whitelist) ([+-]) (.*)$",
"^[#!/](whitelist)$",
"^[!/#](setowner)$",
"^[!/#](setowner) (.*)$",
"^[!/#](remowner)$",
"^[!/#](remowner) (.*)$",
"^[!/#](promote)$",
"^[!/#](promote) (.*)$",
"^[!/#](demote)$",
"^[!/#](demote) (.*)$",
"^[!/#](modlist)$",
"^[!/#](ownerlist)$",
"^[!/#](lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^[!/#](settings)$",
"^[!/#](mutelist)$",
"^[!/#](mute) (.*)$",
"^[!/#](unmute) (.*)$",
"^[!/#](link)$",
"^[!/#](linkpv)$",
"^[!/#](setlink)$",
"^[!/#](newlink)$",
"^[!/#](rules)$",
"^[!/#](setrules) (.*)$",
"^[!/#](about)$",
"^[!/#](setabout) (.*)$",
"^[!/#](setname) (.*)$",
"^[!/#](clean) (.*)$",
"^[!/#](setflood) (%d+)$",
"^[!/#](setchar) (%d+)$",
"^[!/#](setfloodtime) (%d+)$",
"^[!/#](res) (.*)$",
"^[!/#](whois) (%d+)$",
"^[!/#](help)$",
"^[!/#](setlang) (.*)$",
"^[!/#](setcmd) (.*)$",
"^[#!/](filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^[#!/](filterlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^[!/#](welcome) (.*)$",
"^(اللغه) (.*)$",
"^(اوامر انكلش)$",
"^(ايدي)$",
"^(ايدي) (.*)$",
'^(اعدادات)$',
'^(الاوامر)$',
'^(تثبيت)$',
'^(الغاء تثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(رفع مساعد)$',
'^(رفع مساعد) (.*)$',
'^(حذف مساعد) (.*)$',
'^(حذف مساعد)$',
'^(السته البيظاء) ([+-]) (.*)$',
'^(السته البيظاء) ([+-])$',
'^(السته البيظاء)$',
'^(رفع مشرف)$',
'^(رفع مشرف) (.*)$',
'^(حذف مشرف) (.*)$',
'^(حذف مشرف)$',
'^(رفع مدير)$',
'^(رفع مدير) (.*)$',
'^(حذف مدير)$',
'^(حذف مدیر) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(كتم) (.*)$',
'^(الغاء الكتم) (.*)$',
'^(رابط جديد)$',
"^(رابط خاص)$",
'^(معلومات)$',
'^(القوانين)$',
'^(الرابط)$',
'^(ضع رابط)$',
'^(ضع قوانين) (.*)$',
'^(فحص) (.*)$',
'^(تدقيق) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(وقت كتم التكرار) (%d+)$',
'^(حساسيه الاحرف) (%d+)$',
'^(حذف) (.*)$',
'^(الوصف)$',
'^(ضع اسم) (.*)$',
'^(ضع وصف) (.*)$',
'^(الكلمات الممنوعه)$',
'^(اعدادات2)$',
'^(قائمة المشرفين)$',
'^(قائمة المدراء)$',
'^(مساعده)$',
'^(م2)$',
'^(م3)$',
'^(م1)$',
'^(م5)$',
'^(متصل)$',
'^(منع) (.*)$',
'^(سماح) (.*)$',
'^(الترحيب) (.*)$',
'^(ضع ترحيب) (.*)$',
},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #kenamch#
