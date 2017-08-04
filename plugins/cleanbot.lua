--Start By @saad7m or @kenamch

local function run(msg, matches)
if matches[1] == 'clean bots' or matches[1] == 'حذف البوتات' and is_owner(msg) then
  function clbot(arg, data)
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	end
    tdcli.sendMessage(msg.to.id, msg.id, 1, '_تم ازالة جميع البوتات 🚹🚫_', 1, 'md')
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil)
  end
end

return { 

patterns ={ 

'^(clean bots)$',
'^(حذف البوتات)$'
 
 },
  run = run
}
 
 --End By @saad7m
 -- Channel @kenamch
 --Please Not Clean This Text 
