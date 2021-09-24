function IGS.BoolRequest(title, text, cback)
	local m = uigs.Create("XeninUI.Frame", function(self)
		self:SetTitle(title)
		self:SetWide(ScrW() * 0.35)
		self:MakePopup()
	end)

	local txt = string.Wrap("BATTLEPASS_Item_Completed", text, m:GetWide() - 10)
	local y = 50

	for _,line in ipairs(txt) do
		uigs.Create("DLabel", function(self, p)
			self:SetText(line)
			self:SetFont("BATTLEPASS_Item_Completed")
			self:SetTextColor(IGS.col.TEXT_HARD)
			self:SizeToContents()
			self:SetPos((p:GetWide() - self:GetWide()) / 2, y)
			y = y + self:GetTall() + 2
		end, m)
	end

	y = y + 5
	m.btnOK = uigs.Create("XeninUI.ButtonV2", function(self, p)
		self:SetText("Да")
		self:SetRoundness(4)
		self:SetPos(10, y + 5)
		self:SetSolidColor(Color(49, 160, 99))
		self:SetStartColor(Color(50, 163, 101))
		self:SetEndColor(Color(68, 196, 157))
		self:SetSize(p:GetWide() / 2 - 25, 50)
		self.DoClick = function()
			p:Remove()
			cback(true)
		end
	end, m)

	m.btnCan = uigs.Create("XeninUI.ButtonV2", function(self, p)
		self:SetText("Нет")
		self:SetRoundness(4)
		self:SetSolidColor(Color(155, 93, 77))
		self:SetStartColor(Color(155, 93, 77))
		self:SetEndColor(Color(155, 93, 77))
		self:SetPos(p.btnOK:GetWide() + 25, y + 5)
		self:SetSize(p.btnOK:GetWide() + 15, 50)
		self.DoClick = function()
			p:Remove()
			cback(false)
		end
		y = y + self:GetTall() + 15
	end, m)

	m:SetTall(y)
	m:Center()

	return m
end

function IGS.StringRequest(title, text, default, cback)
	local m = uigs.Create("igs_frame", function(self)
		self:SetTitle(title)
		self:ShowCloseButton(false)
		self:SetWide(ScrW() * .3)
		self:MakePopup()
	end)

	local txt = string.Wrap("BATTLEPASS_Item_Completed", text, m:GetWide() - 10)
	local y = 25

	for _, v in ipairs(txt) do
		uigs.Create("DLabel", function(self, p)
			self:SetText(v)
			self:SetFont("BATTLEPASS_Item_Completed")
			self:SetTextColor(IGS.col.TEXT_HARD)
			self:SizeToContents()
			self:SetPos((p:GetWide() - self:GetWide()) / 2, y)
			y = y + self:GetTall()
		end, m)
	end

	y = y + 5
	local tb = uigs.Create("DTextEntry", function(self, p)
		self:SetPos(5, y + 5)
		self:SetSize(p:GetWide() - 10, 25)
		self:SetValue(default or '')
		y = y + self:GetTall() + 10
		self.OnEnter = function()
			p:Remove()
			cback(self:GetValue())
		end
	end, m)

	local btnOK = uigs.Create("igs_button", function(self, p)
		self:SetText("ОК")
		self:SetPos(5, y)
		self:SetSize(p:GetWide() / 2 - 7.5, 25)
		self.DoClick = function()
			p:Remove()
			cback(tb:GetValue())
		end
	end, m)

	uigs.Create("igs_button", function(self)
		self:SetText("Отмена")
		self:SetPos(btnOK:GetWide() + 10, y)
		self:SetSize(btnOK:GetWide(), 25)
		self.DoClick = function()
			m:Remove()
		end
		y = y + self:GetTall() + 5
	end, m)

	m:SetTall(y)
	m:Center()

	return m
end


local null = function() end
function IGS.ShowNotify(sText, sTitle, fOnClose)
	local m = IGS.BoolRequest(sTitle or "[IGS] Оповещение", sText, fOnClose or null)
	m.btnCan:Remove() -- оставляем только 1 кнопку

	local _,y = m.btnOK:GetPos()
	m.btnOK:SetText("ОК")
	m.btnOK:SetPos((m:GetWide() - m.btnOK:GetWide()) / 2, y)

	return m
end

function IGS.WIN.ActivateCoupon()
	IGS.StringRequest("Активация купона",
		"Если у вас есть донат купон, то введите его ниже",
	nil,function(val)
		IGS.UseCoupon(val,function(errMsg)
			if errMsg then
				IGS.ShowNotify(errMsg, "Ошибка активации купона")
			else
				IGS.ShowNotify("Деньги начислены на ваш счет. Можете посмотреть на это в транзакциях, переоткрыв донат меню", "Успешная активации купона")
			end
		end)
	end)
end


-- IGS.ShowNotify(("test "):rep(10), nil, function()
-- 	print("Нотификашка закрылась")
-- end)

IGS.OpenURL = gui.OpenURL

-- IGS.UI()
