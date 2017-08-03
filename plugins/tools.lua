--Begin Tools.lua :)
local SUDO = 30742221 -- ضع ايديك هنا! <===
function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

local function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

local function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "*List of sudo users :*\n"
   else
  text = "_قائمة المطورين❤️😍:_\n"
  end
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '*List of bot admins :*\n'
   else
 text = "_قائمة ادمنية البوت😌💋 :_\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '_No_ *admins* _available_'
      else
		  		text = '_ لا يوجد ادمنيه 😒☘️_'
           end
		  	end
		  	return text
    end

local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return 'No groups at the moment'
    end
    local message = 'List of Groups:\n*Use #join (ID) to join*\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
        for m,n in pairsByKeys(settings) do
			if m == 'set_name' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				group_name_id = name .. '\n(ID: ' ..group_id.. ')\n\n'
				if name:match("[\216-\219][\128-\191]") then
					group_info = i..' - \n'..group_name_id
				else
					group_info = i..' - '..group_name_id
				end
				i = i + 1
			end
        end
		message = message..group_info
    end
	return message
end

local function botrem(msg)
	local data = load_data(_config.moderation.data)
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function warning(msg)
	local hash = "gp_lang:"..msg.to.id
	local lang = redis:get(hash)
	local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
			if lang then
				tdcli.sendMessage(msg.to.id, 0, 1, 'باقي يوم واحد على انتهاء صلاحية البوت الرجاء التواصل مع المطور لبقاء البوت في المجموعه‼️‼️‼️.', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, 0, 1, '_Group 1 day remaining charge, to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group._', 1, 'md')
			end
		end
	end
end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _بالفعل ادمن عام بالبوت🅿️_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _اصبح ادمن عام للبوت✅_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id_))
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _ليس ادمن عام بالفعل💤_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد ادمن بعد الان🚹_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_هذه الحلو_ "..user_name.." *"..data.id_.."* _من زمان مطور 😍🌐_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_هذه الحلو_ "..user_name.." *"..data.id_.."* _صار مطور💠❤️_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _ليس مطور بالفعل❤️_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد مطور 😇💋_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم ايجاد المستخدم👤_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _بالفعل ادمن 😐👌🏼_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _اصبح ادمن في البوت 💋_", 0, "md")
   end
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _ليس ادمن فعلا💤_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد ادمن بعد الان🚹_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_هذه الحلو_ "..user_name.." *"..data.id_.."* _من زمان مطور 😍🌐_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_هذه الحلو_ "..user_name.." *"..data.id_.."* _صار مطور💠❤️_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _بالفعل ليس مطور❤️_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد مطور 😇💋_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم ايجاد المستخدم👤_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _بالفعل ادمن 😐👌🏼_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _اصبح ادمن في البوت 💋_", 0, "md")
   end
end 
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _ليس ادمن فعلا💤_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد ادمن بعد الان🚹_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_هذه الحلو_ "..user_name.." *"..data.id_.."* _من زمان مطور 😍🌐_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد مطور بعد الان❤️_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _لم يعد مطور بعد الان❤️_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم👤_ "..user_name.." *"..data.id_.."* _بالفعل لبس مطور 😇💋_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم ايجاد المستخدم👤_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function pre_process(msg)
	if msg.to.type ~= 'pv' then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local data = load_data(_config.moderation.data)
		local gpst = data[tostring(msg.to.id)]
		local chex = redis:get('CheckExpire::'..msg.to.id)
		local exd = redis:get('ExpireDate:'..msg.to.id)
		if gpst and not chex and msg.from.id ~= SUDO and not is_sudo(msg) then
			redis:set('CheckExpire::'..msg.to.id,true)
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
			if lang then
				tdcli.sendMessage(msg.to.id, 0, 1, 'باقي يوم واحد على انتهاء صلاحية البوت الرجاء التواصل مع المطور لبقاء البوت في المجموعه‼️‼️‼️.', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Group charged 1 day. to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group._', 1, 'md')
			end
		end
		if chex and not exd and msg.from.id ~= SUDO and not is_sudo(msg) then
			local text1 = 'انتهت صلاحية البوت \n\nID:  <code>'..msg.to.id..'</code>\n\nاذا اردت اخراج البوت البوت اتبع الامر \n\n/leave '..msg.to.id..'\nواذا اردت دخل البوت اتبع الامر التالي :\n/jointo '..msg.to.id..'\n_________________\n واذا اردت اعادة شحن المجموعة اتبع التعلمات التاليه...\n\n<b>برای شحن 1 شهره:</b>\n/plan 1 '..msg.to.id..'\n\n<b>برای شحن 3 شهره:</b>\n/plan 2 '..msg.to.id..'\n\n<b>برای شحن نامحدود:</b>\n/plan 3 '..msg.to.id
			local text2 = '_سوف يقوم البوت بغادرة المجموعه نظرا لعدم الشحن 😽🖐🏿_'
			local text3 = '_Charging finished._\n\n*Group ID:*\n\n*ID:* `'..msg.to.id..'`\n\n*If you want the robot to leave this group use the following command:*\n\n`/Leave '..msg.to.id..'`\n\n*For Join to this group, you can use the following command:*\n\n`/Jointo '..msg.to.id..'`\n\n_________________\n\n_If you want to recharge the group can use the following code:_\n\n*To charge 1 month:*\n\n`/Plan 1 '..msg.to.id..'`\n\n*To charge 3 months:*\n\n`/Plan 2 '..msg.to.id..'`\n\n*For unlimited charge:*\n\n`/Plan 3 '..msg.to.id..'`'
			local text4 = '_Charging finished. Due to lack of recharge remove the group from the robot list and the robot leave the group._'
			if lang then
				tdcli.sendMessage(SUDO, 0, 1, text1, 1, 'html')
				tdcli.sendMessage(msg.to.id, 0, 1, text2, 1, 'md')
			else
				tdcli.sendMessage(SUDO, 0, 1, text3, 1, 'md')
				tdcli.sendMessage(msg.to.id, 0, 1, text4, 1, 'md')
			end
			botrem(msg)
		else
			local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
			local day = (expiretime / 86400)
			if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
				warning(msg)
			end
		end
	end
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
 if tonumber(msg.from.id) == SUDO then
if ((matches[1] == "clear cache" and not Clang) or (matches[1] == "حذف ذاكره " and Clang)) then
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
	 run_bash("rm -rf ./data/photos/*")
    return "*All Cache Has Been Cleared*"
   end
if ((matches[1] == "visudo" and not Clang) or (matches[1] == "رفع مطور" and Clang)) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="visudo"})
      end
   end
if ((matches[1] == "desudo" and not Clang) or (matches[1] == "حذف مطور" and Clang)) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="desudo"})
      end
   end
end
		if ((matches[1] == "config" and not Clang) or (matches[1] == "رفع الكل" and Clang)) and is_admin(msg) then
			return set_config(msg)
		end
if is_sudo(msg) then
   		if ((matches[1]:lower() == 'add' and not Clang) or (matches[1] == "تفعيل" and Clang)) and not redis:get('ExpireDate:'..msg.to.id) then
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 180, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_البوت يعمل لمدة ثلاث دقائق مؤقته الرجاء شحن المجموعة😽🖐🏿_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Group charged 3 minutes  for settings._', 1, 'md')
				end
		end
		if ((matches[1] == 'rem' and not Clang) or (matches[1] == "تعطيل" and Clang)) then
			if redis:get('CheckExpire::'..msg.to.id) then
				redis:del('CheckExpire::'..msg.to.id)
			end
			redis:del('ExpireDate:'..msg.to.id)
		end
		if ((matches[1]:lower() == 'gid' and not Clang) or (matches[1] == "ايد كروب" and Clang)) then
			tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..msg.to.id..'`', 1,'md')
		end
		if ((matches[1] == 'leave' and not Clang) or (matches[1] == "خروج" and Clang)) and matches[2] then
			if lang then
				tdcli.sendMessage(matches[2], 0, 1, 'سوف اغادر المجموعه😽🖐🏿.\nالرجاء مراسلة المطور لغرض الشحن.', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, 'سوف اقوم بمغادرة المجموعه'..matches[2]..' 😽🖐🏿', 1,'md')
			else
				tdcli.sendMessage(matches[2], 0, 1, '_Robot left the group._\n*For more information contact The SUDO.*', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, '*Robot left from under group successfully:*\n\n`'..matches[2]..'`', 1,'md')
			end
		end
		if ((matches[1]:lower() == 'charge' and not Clang) or (matches[1] == "شحن" and Clang)) and matches[2] and matches[3] then
		if string.match(matches[2], '^-%d+$') then
			if tonumber(matches[3]) > 0 and tonumber(matches[3]) < 1001 then
				local extime = (tonumber(matches[3]) * 86400)
				redis:setex('ExpireDate:'..matches[2], extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdcli.sendMessage(SUDO, 0, 1, 'تم شحن المجموعه  '..matches[2]..' بمدة '..matches[3]..' يوم', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, 'من قبل مطور البوت`'..matches[3]..'` استخدام الامر\nلعرض المده المتبقيه للشحن /check مع الايدي...',1 , 'md')
				else
					tdcli.sendMessage(SUDO, 0, 1, '*Recharged successfully in the group:* `'..matches[2]..'`\n_Expire Date:_ `'..matches[3]..'` *Day(s)*', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, '*Robot recharged* `'..matches[3]..'` *day(s)*\n*For checking expire date, send* `/check`',1 , 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الايام يجب ان تكون من 1 الى 1000 الصلاحيه._', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Expire days must be between 1 - 1000_', 1, 'md')
				end
			end
		end
		end
		if ((matches[1]:lower() == 'plan' and not Clang) or (matches[1] == "خطه" and Clang)) then 
		if matches[2] == 'a' and matches[3] then
		if string.match(matches[3], '^%d+$') then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..matches[3], timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'خطه  A تم تفعيلها '..' بنجاج😽🖐🏿\nتم شحن المجموعه لمدة 30 يوم اي( 1 شهر )', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '_تم تزويد المجموعه بشحن مدة 30 يوم😉✨!_', 1, 'md')
			else
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '*Plan A Successfully Activated!\nThis group recharged with plan 1 for 30 days (1 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `30` *Days (1 Month)*', 1, 'md')
			end
		end
		end
		if matches[2] == 'b' and matches[3] then
		if string.match(matches[3], '^%d+$') then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..matches[3],timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'خطه B تم تفعيلها '..' بنجاج👩🏼🤘🏽\nتم شحن المجموعه لمدة 90 يوم اي( 3 شهر )', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'تم تفعيل البوت لمدة 90 يوم 😉✨', 1, 'md')
			else
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '*Plan B Successfully Activated!\nThis group recharged with plan 2 for 90 days (3 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `90` *Days (3 Months)*', 1, 'md')
			end
		end
		end
		if matches[2] == 'c' and matches[3] then
		if string.match(matches[3], '^%d+$') then
			redis:set('ExpireDate:'..matches[3],true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'تم اعطاء صلاحيه للمجموعه! '..' \nالبوت صالح لمدى الحياة😋!', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'تم تفعيل البوت بمده ! ( غير محدوده )', 1, 'md')
			else
				tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '*Plan C Successfully Activated!\nThis group recharged with plan 3 for unlimited*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `Unlimited`', 1, 'md')
			end
		end
		end
		end
		if ((matches[1]:lower() == 'jointo' and not Clang) or (matches[1] == "دخول عبر" and Clang)) and matches[2] then
		if string.match(matches[2], '^-%d+$') then
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, 'سآقوم باضافتك لهذه المجموعه'..matches[2]..' اضافه کردم.', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, '_لقد انضم الادمن._', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '*I added you to this group:*\n\n`'..matches[2]..'`', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, 'Admin Joined!', 1, 'md')
			end
		end
		end
end
	if ((matches[1]:lower() == 'savefile' and not Clang) or (matches[1] == "حفظ فايل" and Clang)) and matches[2] and is_sudo(msg) then
		if msg.reply_id  then
			local folder = matches[2]
            function get_filemsg(arg, data)
				function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' or data.content_.ID == 'MessagePhoto' or data.content_.ID == 'MessageSticker' or data.content_.ID == 'MessageAudio' or data.content_.ID == 'MessageVoice' or data.content_.ID == 'MessageVideo' or data.content_.ID == 'MessageAnimation' then
                        if data.content_.ID == 'MessageDocument' then
							local doc_id = data.content_.document_.document_.id_
							local filename = data.content_.document_.file_name_
                            local pathf = tcpath..'/data/document/'..filename
							local cpath = tcpath..'/data/document'
                            if file_exi(filename, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(doc_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>فايل</b> <code>'..folder..'</code> <b>تم الحفظ</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>File</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessagePhoto' then
							local photo_id = data.content_.photo_.sizes_[2].photo_.id_
							local file = data.content_.photo_.id_
                            local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
							local cpath = tcpath..'/data/photo'
                            if file_exi(file..'_(1).jpg', cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(photo_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصور</b> <code>'..folder..'</code> <b>تم حفظ</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Photo</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
		                if data.content_.ID == 'MessageSticker' then
							local stpath = data.content_.sticker_.sticker_.path_
							local sticker_id = data.content_.sticker_.sticker_.id_
							local secp = tostring(tcpath)..'/data/sticker/'
							local ffile = string.gsub(stpath, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(stpath, pfile)
                                file_dl(sticker_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الملسقات</b> <code>'..folder..'</code> <b>تم حفظ</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Sticker</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAudio' then
						local audio_id = data.content_.audio_.audio_.id_
						local audio_name = data.content_.audio_.file_name_
                        local pathf = tcpath..'/data/audio/'..audio_name
						local cpath = tcpath..'/data/audio'
							if file_exi(audio_name, cpath) then
								local pfile = folder
								os.rename(pathf, pfile)
								file_dl(audio_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصوتيات</b> <code>'..folder..'</code> <b>تم حفظ</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Audio</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
							else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
							end
						end
						if data.content_.ID == 'MessageVoice' then
							local voice_id = data.content_.voice_.voice_.id_
							local file = data.content_.voice_.voice_.path_
							local secp = tostring(tcpath)..'/data/voice/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(voice_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>البصمات</b> <code>'..folder..'</code> <b>تخزين.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Voice</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageVideo' then
							local video_id = data.content_.video_.video_.id_
							local file = data.content_.video_.video_.path_
							local secp = tostring(tcpath)..'/data/video/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(video_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الفديوهات</b> <code>'..folder..'</code> <b>تخزين.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Video</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAnimation' then
							local anim_id = data.content_.animation_.animation_.id_
							local anim_name = data.content_.animation_.file_name_
                            local pathf = tcpath..'/data/animation/'..anim_name
							local cpath = tcpath..'/data/animation'
                            if file_exi(anim_name, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(anim_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصور المتحركه</b> <code>'..folder..'</code> <b>تخزين.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Gif</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف غير موجود ارسل الملف مره اخرى_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end
	if msg.to.type == 'channel' or msg.to.type == 'chat' then
		if ((matches[1] == 'charge' and not Clang) or (matches[1] == "شحن" and Clang)) and matches[2] and not matches[3] and is_sudo(msg) then
			if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
				local extime = (tonumber(matches[2]) * 86400)
				redis:setex('ExpireDate:'..msg.to.id, extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id)
						end
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'تم شحن المجموعه\n البوت صالح لغايه'..matches[2]..' يوم من الان', 1, 'md')
					tdcli.sendMessage(SUDO, 0, 1, 'تم تزويد المجموعه بشحن لمده '..matches[2]..'يوم  ايدي المجموعه : `'..msg.to.id..'` ☘️.', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'تم شحن المجموعه\n البوت صالح لغايه'..matches[2]..' يوم من الان', 1, 'md')
					tdcli.sendMessage(SUDO, 0, 1, 'تم تزويد المجموعه بشحن لمده '..matches[2]..'يوم  ايدي المجموعه : `'..msg.to.id..'` ☘️.', 1, 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_يمكن تمديد مدة الصلاحيه من 1 الى 1000 يوم._', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Expire days must be between 1 - 1000_', 1, 'md')
				end
			end
		end
		if ((matches[1]:lower() == 'check' and not Clang) or (matches[1] == "الصلاحيه" and Clang)) and is_mod(msg) and not matches[2] then
			local check_time = redis:ttl('ExpireDate:'..msg.to.id)
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '_Unlimited Charging!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_Expire until_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_Expire until_ '..min..' _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_Expire until_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_Expire until_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_Expire until_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_Expire until_ *'..year..'* _year_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			else
				if check_time == -1 then
					remained_expire = '_صلاحية المجموعه لا نهائيه ‼️!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..month..'* _شهر_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..year..'* _سال_ *'..month..'* _شهر_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			end
		end
	end
	if ((matches[1] == 'check' and not Clang) or (matches[1] == "الصلاحيه" and Clang)) and is_mod(msg) and matches[2] then
		if string.match(matches[2], '^-%d+$') then
			local check_time = redis:ttl('ExpireDate:'..matches[2])
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '_Unlimited Charging!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_Expire until_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_Expire until_ '..min..' _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_Expire until_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_Expire until_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_Expire until_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_Expire until_ *'..year..'* _year_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
		else
				if check_time == -1 then
					remained_expire = '_صلاحية المجموعه لا نهائيه ‼️!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..month..'* _شهر_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_المجموعه صالحه لغاية_ *'..year..'* _سال_ *'..month..'* _شهر_ *'..day..'* _يوم و_ *'..hours..'* _ساعه و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانيه باقيه_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			end
		end
		end
if ((matches[1] == "adminprom" and not Clang) or (matches[1] == "رفع مساعد" and Clang)) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="adminprom"})
      end
   end
if ((matches[1] == "admindem" and not Clang) or (matches[1] == "حذف مساعد" and Clang)) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.to.id,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="admindem"})
      end
   end

if ((matches[1] == 'creategroup' and not Clang) or (matches[1] == "اصنع مجموعه" and Clang)) and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
  if not lang then
return '_Group Has Been Created!_'
  else
return '_تم صنع مجموعه عزيزي_'
   end
end

if ((matches[1] == 'createsuper' and not Clang) or (matches[1] == "اصنع خارقه" and Clang)) and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat(text, 1, '', dl_cb, nil)
   if not lang then 
return '_SuperGroup Has Been Created!_'
  else
return '_تم صنع مجموعه خارقه عزيزي_'
   end
end

if ((matches[1] == 'tosuper' and not Clang) or (matches[1] == "تحويل سوبر" and Clang)) and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat(text, 1, '@BeyondTeam', (function(b, d) tdcli.addChatMember(d.id_, msg.from.id, 0, dl_cb, nil) end), nil)
   if not lang then 
return '_SuperGroup Has Been Created and_ [`'..msg.from.id..'`] _Joined To This SuperGroup._'
  else
return '_تم تحويل المجموعه عزيزي_ [`'..msg.from.id..'`] _يمكنك الدخول الان_'
   end
end

if ((matches[1] == 'import' and not Clang) or (matches[1] == "دخول بواسطة" and Clang)) and is_admin(msg) then
if matches[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or matches[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
local link = matches[2]
if link:match('t.me') then
link = string.gsub(link, 't.me', 'telegram.me')
end
tdcli.importChatInviteLink(link, dl_cb, nil)
   if not lang then
return '*Done!*'
  else
return '*تم الدخول بنجاح!*'
  end
  end
end

if ((matches[1] == 'setbotname' and not Clang) or (matches[1] == "تغيير اسم البوت" and Clang)) and is_sudo(msg) then
tdcli.changeName(matches[2])
   if not lang then
return '_Bot Name Changed To:_ *'..matches[2]..'*'
  else
return '_تم تغيير اسم البوت💫👍🏻:_ \n*'..matches[2]..'*'
   end
end

if ((matches[1] == 'setbotusername' and not Clang) or (matches[1] == "تغيير معرف البوت" and Clang)) and is_sudo(msg) then
tdcli.changeUsername(matches[2])
   if not lang then
return '_Bot Username Changed To:_ @'..matches[2]
  else
return '_تم تغيير معرف البوت💫👍🏻:_ \n@'..matches[2]..''
   end
end

if ((matches[1] == 'delbotusername' and not Clang) or (matches[1] == "حذف معرف البوت" and Clang)) and is_sudo(msg) then
tdcli.changeUsername('')
   if not lang then
return '*Done!*'
  else
return '*تم حذف معرف البوت🌜!*'
  end
end

if ((matches[1] == 'markread' and not Clang) or (matches[1] == "القراءه" and Clang)) and is_sudo(msg) then
if ((matches[2] == 'on' and not Clang) or (matches[2] == "تفعيل" and Clang)) then
redis:set('markread','on')
   if not lang then
return '_Markread >_ *ON*'
else
return '_علامة القراءه >_ *تعمل*'
   end
end
if ((matches[2] == 'off' and not Clang) or (matches[2] == "تعطيل" and Clang)) then
redis:set('markread','off')
  if not lang then
return '_Markread >_ *OFF*'
   else
return '_علامة القراءه >_ *معطله*'
      end
   end
end

if ((matches[1] == 'bc' and not Clang) or (matches[1] == "ارسال الى" and Clang)) and is_admin(msg) then
		local text = matches[2]
tdcli.sendMessage(matches[3], 0, 0, text, 0)	end

if ((matches[1] == 'broadcast' and not Clang) or (matches[1] == "اذاعه" and Clang)) and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end

  if is_sudo(msg) then
	if ((matches[1]:lower() == "sendfile" and not Clang) or (matches[1] == "ارسال فايل" and Clang)) and matches[2] and matches[3] then
		local send_file = "./"..matches[2].."/"..matches[3]
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, msg_caption, dl_cb, nil)
	end
	if ((matches[1]:lower() == "sendplug" and not Clang) or (matches[1] == "جلب ملف" and Clang)) and matches[2] then
	    local plug = "./plugins/"..matches[2]..".lua"
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, plug, msg_caption, dl_cb, nil)
    end
  end

    if ((matches[1]:lower() == 'save' and not Clang) or (matches[1] == "احفظ" and Clang)) and matches[2] and is_sudo(msg) then
        if tonumber(msg.reply_to_message_id_) ~= 0  then
            function get_filemsg(arg, data)
                function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' then
                        fileid = data.content_.document_.document_.id_
                        filename = data.content_.document_.file_name_
						file_dl(document_id)
						sleep(1)
                        if (filename:lower():match('.lua$')) then
                            local pathf = tcpath..'/data/document/'..filename
                            if pl_exi(filename) then
                                local pfile = 'plugins/'..matches[2]..'.lua'
                                os.rename(pathf, pfile)
								tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Plugin</b> <code>'..matches[2]..'</code> <b>Has Been Saved.</b>', 1, 'html')
                            else
                                tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
                            end
                        else
                            tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file is not Plugin File._', 1, 'md')
                        end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end

if ((matches[1] == 'sudolist' and not Clang) or (matches[1] == "المطورين" and Clang)) and is_sudo(msg) then
return sudolist(msg)
    end
if ((matches[1] == 'chats' and not Clang) or (matches[1] == "المجموعات" and Clang)) and is_admin(msg) then
return chat_list(msg)
    end
   if ((matches[1]:lower() == 'join' and not Clang) or (matches[1] == "دخول" and Clang)) and is_admin(msg) and matches[2] then
	   tdcli.sendMessage(msg.to.id, msg.id, 1, 'I Invite you in '..matches[2]..'', 1, 'html')
	   tdcli.sendMessage(matches[2], 0, 1, "Admin Joined!🌚", 1, 'html')
    tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
  end
		if ((matches[1] == 'rem' and not Clang) or (matches[1] == "تعطيل" and Clang)) and matches[2] and is_admin(msg) then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   tdcli.sendMessage(matches[2], 0, 1, "Group has been removed by admin command", 1, 'html')
    return '_Group_ *'..matches[2]..'* _removed_'
		end
if matches[1] == 'كينام'  or matches[1] == "المطور" then
return tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
    end
if ((matches[1] == 'adminlist' and not Clang) or (matches[1] == "المساعدين" and Clang)) and is_admin(msg) then
return adminlist(msg)
    end
     if ((matches[1] == 'leave' and not Clang) or (matches[1] == "غادر" and Clang)) and is_admin(msg) then
  tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
   end
     if ((matches[1] == 'autoleave' and not Clang) or (matches[1] == "غادر تلقائي" and Clang)) and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if ((matches[2] == 'enable' and not Clang) or (matches[2] == "تفعيل" and Clang)) then
    redis:del(hash)
   return 'Auto leave has been enabled'
--Disable Auto Leave
     elseif ((matches[2] == 'disable' and not Clang) or (matches[2] == "تعطيل" and Clang)) then
    redis:set(hash, true)
   return 'Auto leave has been disabled'
--Auto Leave Status
      elseif ((matches[2] == 'status' and not Clang) or (matches[2] == "الحاله" and Clang)) then
      if not redis:get(hash) then
   return 'Auto leave is enable'
       else
   return 'Auto leave is disable'
         end
      end
   end


if matches[1] == "h4" or matches[1] == "H4" and not Clang and is_mod(msg) then
if not lang then
text = [[
🔖*нєℓρ MαƬαƊσR Ɓσт*
⚡️*тo ѕee тнe coммαɴdѕ oғ yoυr deѕιred ιтeм ѕυвмιт*
🌐 _ҽɳɠʅιʂԋ cσɱɱαɳԃʂ :_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Visudo* `[username|id|reply]`
⏺_اضافه مطور_
*Desudo* `[username|id|reply]`
🔸_حذف مطور _
*Sudolist* 
⏺_لآضهار قائمة المطورين_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Adminprom* `[username|id|reply]`
🔸_لآضافة مساعد مطور_
*Admindem* `[username|id|reply]`
⏺_لحذف مساعد مطور_
*Adminlist* 
🔸_لآضهار قائمة المساعدين_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Leave* 
⏺_لآخراج البوت من المجموعه_
*Autoleave* `[disable/enable]`
🔸_لآخراج البوت بشكل تلقائي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Creategroup* `[text]`
⏺_لصنع مجموعه عاديه_
*Createsuper* `[text]`
🔸_لصنع مجموعه خارقه_
*Tosuper* 
⏺_تحويل من عاديه الى خارقه_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Chats*
🔸_لآضهار مجموعات البوت_
*Join* `[id]`
⏺_لدخولك مجموعه بواسطة البوت_
*Rem* `[id]`
🔸_لحذف مجموعه عن طريق الايدي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Import* `[link]`
⏺_لآضافة البوت عن طريق رابط_
*Setbotname* `[text]`
🔸_لتغيير اسم البوت_
*Setbotusername* `[text]`
⏺_لتغيير معرف البوت_
*Delbotusername* 
🔸_لحذف معرف البوت_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Markread* `[off/on]`
⏺_حالة القراءه_
*Broadcast* `[text]`
🔸_لآرسال اذاعه عامه للمجموعات_
*Bc* `[text]` `[gpid]`
⏺_لآرسال اذاعه خاصه لمجموعه_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Sendfile* `[cd]` `[file]`
🔸_لارسال ملف الى مجلد معين_
*Sendplug* `[plug]`
⏺_لجلب ملف من السرفر_
*Save* `[plugin name] [reply]`
🔸_لحفظ ملف بالرد_
*Savefile* `[address/filename] [reply]`
⏺_لحفظ ملف مع رابط واسم الملف_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Clear cache*
🔸_لمسح الذاكره المخبئيه للبوت.telegram-cli/data_
*Check*
⏺_لاضهار مدة الصلاحيه_
*Check* `[GroupID]`
🔸_لاضهار مدة الصلاحيه مع الايدي_
*Charge* `[GroupID]` `[Number Of Days]`
⏺_لوضع مدة الصلاحيه مع عدد الايام بالايدي_
*Charge* `[Number Of Days]`
🔸_لوضع مدة الصلاحيه مع عدد الايام_
*Jointo* `[GroupID]`
⏺_لآضافة البوت عبر الايدي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Leave* `[GroupID]`
🔸_لآخراج البوت عن طريق الايدي_
*Setmanager* `[username|id|reply]`
⏺_رفع اداري في المجموعه اذا كان البوت منشىء_
*Config*
🔸_رفع جميع ادمنية المجموعه معا_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⌨️ ℓαηgυαgє вσт єηgℓιѕн !
_لتغيير لغة البوت_ 
*Setlang* `[en , ar]`
_لتغيير لغة الاوامر_ 
*setcmd* `[en , ar]`
➖➖➖
👤 *ρσωєяɗ Ɓу :* @saad7m
🗣 *ƇнαηηєƖ :* @kenamch
]]..msg_caption
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
🔖*нєℓρ MαƬαƊσR Ɓσт*
⚡️*тo ѕee тнe coммαɴdѕ oғ yoυr deѕιred ιтeм ѕυвмιт*
🌐 _ҽɳɠʅιʂԋ cσɱɱαɳԃʂ :_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Visudo* `[username|id|reply]`
⏺_اضافه مطور_
*Desudo* `[username|id|reply]`
🔸_حذف مطور _
*Sudolist* 
⏺_لآضهار قائمة المطورين_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Adminprom* `[username|id|reply]`
🔸_لآضافة مساعد مطور_
*Admindem* `[username|id|reply]`
⏺_لحذف مساعد مطور_
*Adminlist* 
🔸_لآضهار قائمة المساعدين_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Leave* 
⏺_لآخراج البوت من المجموعه_
*Autoleave* `[disable/enable]`
🔸_لآخراج البوت بشكل تلقائي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Creategroup* `[text]`
⏺_لصنع مجموعه عاديه_
*Createsuper* `[text]`
🔸_لصنع مجموعه خارقه_
*Tosuper* 
⏺_تحويل من عاديه الى خارقه_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Chats*
🔸_لآضهار مجموعات البوت_
*Join* `[id]`
⏺_لدخولك مجموعه بواسطة البوت_
*Rem* `[id]`
🔸_لحذف مجموعه عن طريق الايدي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Import* `[link]`
⏺_لآضافة البوت عن طريق رابط_
*Setbotname* `[text]`
🔸_لتغيير اسم البوت_
*Setbotusername* `[text]`
⏺_لتغيير معرف البوت_
*Delbotusername* 
🔸_لحذف معرف البوت_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Markread* `[off/on]`
⏺_حالة القراءه_
*Broadcast* `[text]`
🔸_لآرسال اذاعه عامه للمجموعات_
*Bc* `[text]` `[gpid]`
⏺_لآرسال اذاعه خاصه لمجموعه_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Sendfile* `[cd]` `[file]`
🔸_لارسال ملف الى مجلد معين_
*Sendplug* `[plug]`
⏺_لجلب ملف من السرفر_
*Save* `[plugin name] [reply]`
🔸_لحفظ ملف بالرد_
*Savefile* `[address/filename] [reply]`
⏺_لحفظ ملف مع رابط واسم الملف_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Clear cache*
🔸_لمسح الذاكره المخبئيه للبوت.telegram-cli/data_
*Check*
⏺_لاضهار مدة الصلاحيه_
*Check* `[GroupID]`
🔸_لاضهار مدة الصلاحيه مع الايدي_
*Charge* `[GroupID]` `[Number Of Days]`
⏺_لوضع مدة الصلاحيه مع عدد الايام بالايدي_
*Charge* `[Number Of Days]`
🔸_لوضع مدة الصلاحيه مع عدد الايام_
*Jointo* `[GroupID]`
⏺_لآضافة البوت عبر الايدي_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
*Leave* `[GroupID]`
🔸_لآخراج البوت عن طريق الايدي_
*Setmanager* `[username|id|reply]`
⏺_رفع اداري في المجموعه اذا كان البوت منشىء_
*Config*
🔸_رفع جميع ادمنية المجموعه معا_
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⌨️ ℓαηgυαgє вσт єηgℓιѕн !
_لتغيير لغة البوت_ 
*Setlang* `[en , ar]`
_لتغيير لغة الاوامر_ 
*setcmd* `[en , ar]`
➖➖➖
👤 *ρσωєяɗ Ɓу :* @saad7m
🗣 *ƇнαηηєƖ :* @kenamch
]]..msg_caption
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end

end
if matches[1] == "م4" and Clang and is_mod(msg) then
if not lang then
text = [[

🔰 اوامر المطور 🔰
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ تفعيل , تعطيل
✰》 تعطيل [مع الايدي]
⚜️ حضر عام
⚜️ الغاء العام
⚜️ المحضورين عام
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》رفع مطور 
✰》 حذف مطور
✰》 المطورين
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لترقية مساعد مطور
✰》 مساعد مطور 
✰》️ حذف مساعد 
✰》 المساعدين
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 اصنع  مجموعه[مع اسم]
✰》 اصنع خارقه[مع اسم]
✰》 تحويل سوبر
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآضهار مجموعات البوت
✰》 المجموعات
⚜️ ليقوم البوت بآضافة المطور لمجموعه
✰》 دخول [مع ايدي الكروب]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآضافة البوت عبر 
✰》 دخول عبر[رابط]
✰》  دخول عبر[ايدي
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 تغییر اسم البوت [الاسم]
✰》 تغییر معرف البوت [المعرف]
✰》 حذف معرف البوت
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 القراءه[تعطيل , تفعيل]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 اذاعه [مع النص]
⚜️ لآرسال اذاعه خاصه بمجموعه
✰》 ارسال الى [الرساله] [ايدي المجموعه]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآرسال ملف الى مجلد معين بالسرفر
✰》 ارسال ملف [cd] [الملف]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 جلب ملف [اسم الملف]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لحفظ ملف معين بالرد
✰》 حفظ 
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لمسح ذاكرة البوت المخبئيه
✰》 حذف ذاكره
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 الصلاحيه
✰》 شحن [عدد الايام]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لرفع جميع اداريين المجموعه
✰》 رفع الكل
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآخراج البوت
✰》 غادر
✰》 غادر [ايدي المجموعه]
✰》 تفعيل - تعطيل خروج تلقائي
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
لتغيير اللغه [اللغه] [عربي ,انكلش]
لتغيير الاوامر [الاوامر] [عربي ,انكلش]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
🔰 اوامر المطور 🔰
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ تفعيل , تعطيل
✰》 تعطيل [مع الايدي]
⚜️ حضر عام
⚜️ الغاء العام
⚜️ المحضورين عام
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》رفع مطور 
✰》 حذف مطور
✰》 المطورين
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لترقية مساعد مطور
✰》 مساعد مطور 
✰》️ حذف مساعد 
✰》 المساعدين
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 اصنع  مجموعه[مع اسم]
✰》 اصنع خارقه[مع اسم]
✰》 تحويل سوبر
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآضهار مجموعات البوت
✰》 المجموعات
⚜️ ليقوم البوت بآضافة المطور لمجموعه
✰》 دخول [مع ايدي الكروب]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآضافة البوت عبر 
✰》 دخول عبر[رابط]
✰》  دخول عبر[ايدي
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 تغییر اسم البوت [الاسم]
✰》 تغییر معرف البوت [المعرف]
✰》 حذف معرف البوت
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 القراءه[تعطيل , تفعيل]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 اذاعه [مع النص]
⚜️ لآرسال اذاعه خاصه بمجموعه
✰》 ارسال الى [الرساله] [ايدي المجموعه]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآرسال ملف الى مجلد معين بالسرفر
✰》 ارسال ملف [cd] [الملف]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 جلب ملف [اسم الملف]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لحفظ ملف معين بالرد
✰》 حفظ 
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لمسح ذاكرة البوت المخبئيه
✰》 حذف ذاكره
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✰》 الصلاحيه
✰》 شحن [عدد الايام]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لرفع جميع اداريين المجموعه
✰》 رفع الكل
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
⚜️ لآخراج البوت
✰》 غادر
✰》 غادر [ايدي المجموعه]
✰》 تفعيل - تعطيل خروج تلقائي
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
لتغيير اللغه [اللغه] [عربي ,انكلش]
لتغيير الاوامر [الاوامر] [عربي ,انكلش]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end

end
end

return { 
patterns = {                                                                   
"^(h4)$", 
"([Hh]4)$", 
"^(config)$", 
"^(visudo)$", 
"^(desudo)$",
"^(sudolist)$",
"^(visudo) (.*)$", 
"^(desudo) (.*)$",
"^(adminprom)$", 
"^(admindem)$",
"^(adminlist)$",
"^(adminprom) (.*)$", 
"^(admindem) (.*)$",
"^(leave)$",
"^(autoleave) (.*)$", 
"^(كينام)$",
"^(creategroup) (.*)$",
"^(createsuper) (.*)$",
"^(tosuper)$",
"^(chats)$",
"^(clear cache)$",
"^(join) (-%d+)$",
"^(rem) (-%d+)$",
"^(import) (.*)$",
"^(setbotname) (.*)$",
"^(setbotusername) (.*)$",
"^(delbotusername) (.*)$",
"^(markread) (.*)$",
"^(bc) +(.*) (-%d+)$",
"^(broadcast) (.*)$",
"^(sendfile) (.*) (.*)$",
"^(save) (.*)$",
"^(sendplug) (.*)$",
"^(savefile) (.*)$",
"^([Aa]dd)$",
"^([Gg]id)$",
"^([Cc]heck)$",
"^([Cc]heck) (-%d+)$",
"^([Cc]harge) (-%d+) (%d+)$",
"^([Cc]harge) (%d+)$",
"^([Jj]ointo) (-%d+)$",
"^([Ll]eave) (-%d+)$",
"^([Pp]lan) ([abc]) (%d+)$",
"^([Rr]em)$",
	"^(م4)$",
	"^(رفع الكل)$",
	"^(تفعيل)$",
	"^(تعطيل)$",
    "^(تعطيل) (-%d+)$",	
    "^(اوامر المطور)$",
    "^(الحاله)$",
	"^(المطورين)$",
	"^(ايد كروب)$",
	"^(اصنع مجموعه) (.*)$",
	"^(دخول عبر) (-%d+)$",
	"^(اصنع خارقه) (.*)$",
	"^(حفظ فايل) (.*)$",
	"^(رفع مطور)$",
	"^(رفع مطور) (.*)$",	
	"^(حذف مطور)$",
	"^(حذف مطور) (.*)$",	
	"^(رفع مساعد)$",
	"^(حذف مساعد)$",
	"^(حذف مساعد) (.*)$",
	"^(ارسال فایل) (.*)$",
	"^(حذف معرف البوت) (.*)$",
    "^(تغيير معرف البوت) (.*)$",
	"^(تغيير اسم البوت) (.*)$",
	"^(تحويل سوبر)$",
	"^(اذاعه) (.*)$",
	"^(المجموعات)$",
	"^(غادر)$",
	"^(غادر) (-%d+)$",	
	"^(جلب ملف) (.*)$",
	"^(المساعدين)$",
	"^(خروج تلقائي) (.*)$",
    "^(شحن) (-%d+) (%d+)$",
    "^(شحن) (%d+)$",	
    "^(خطه) ([abc]) (%d+)$",
    "^(الصلاحيه)$",
    "^(الصلاحيه) (-%d+)$",
    "^(حفظ) (.*)$",
    "^(القراءه) (.*)$",
    "^(ارسال) +(.*) (-%d+)$",
	"^(دخول) (-%d+)$",
	"^(حذف ذاكره )$",
	"^(المطور)$",
}, 
run = run, pre_process = pre_process
}
-- #End By @kenamch
