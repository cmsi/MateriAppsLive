# -*- coding: utf-8 -*-

import sys
import wx

class Frame(wx.Frame):
    def __init__(self):
        wx.Frame.__init__(self, None, -1, "Machikaneyama Setup", size = (350,250))
        self.panel = wx.Panel(self, -1)
        self.panel.SetBackgroundColour("#F0F0F0")

        layout = wx.BoxSizer(wx.VERTICAL)

        radio_1 = wx.RadioButton(self.panel, -1, "Download source code from official website")
        radio_1.SetValue(True)
        layout.Add(radio_1, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        layout_2 = wx.FlexGridSizer(2, 3)
        text_2_1 = wx.StaticText(self.panel, -1, '     ')
        text_2_2 = wx.StaticText(self.panel, -1, "Email:")
        text_2_3 = wx.TextCtrl(self.panel, -1, size = (1000, -1))
        text_2_4 = wx.StaticText(self.panel, -1, '     ')
        text_2_5 = wx.StaticText(self.panel, -1, "Password:")
        text_2_6 = wx.TextCtrl(self.panel, -1, style = wx.TE_PASSWORD)
        layout_2.Add(text_2_1, 0)
        layout_2.Add(text_2_2, 0, wx.RIGHT, 4)
        layout_2.Add(text_2_3, 1, wx.EXPAND, 4)
        layout_2.Add(text_2_4, 0)
        layout_2.Add(text_2_5, 0, wx.RIGHT | wx.TOP, 4)
        layout_2.Add(text_2_6, 1, wx.EXPAND | wx.TOP, 4)
        layout.Add(layout_2, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        radio_2 = wx.RadioButton(self.panel, -1, "Use source code on local storage")
        layout.Add(radio_2, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        layout_3 = wx.FlexGridSizer(2, 3)
        text_3_1 = wx.StaticText(self.panel, -1, '     ')
        text_3_2 = wx.StaticText(self.panel, -1, "File:")
        text_3_3 = wx.TextCtrl(self.panel, -1, size = (1000, -1))
        text_3_4 = wx.StaticText(self.panel, -1, '')
        text_3_5 = wx.StaticText(self.panel, -1, '')
        button_3_6 = wx.Button(self.panel, -1, "Choose")
        layout_3.Add(text_3_1, 0)
        layout_3.Add(text_3_2, 0, wx.RIGHT | wx.TOP, 4)
        layout_3.Add(text_3_3, 1, wx.EXPAND | wx.TOP, 4)
        layout_3.Add(text_3_4, 0)
        layout_3.Add(text_3_5, 0)
        layout_3.Add(button_3_6, 0, wx.TOP, 4)
        layout.Add(layout_3, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        layout_1 = wx.BoxSizer(wx.HORIZONTAL)
        button_1_1 = wx.Button(self.panel, -1, "Install", size=(70,30))
        button_1_2 = wx.Button(self.panel, -1, "Cancel", size=(70,30))
        layout_1.Add(button_1_1, 0, wx.LEFT | wx.BOTTOM, 5)
        layout_1.Add(button_1_2, 0, wx.LEFT | wx.BOTTOM, 5)
        layout.Add(layout_1, 0, wx.ALIGN_BOTTOM | wx.ALIGN_RIGHT | wx.RIGHT | wx.TOP, 10)
        
        self.panel.SetSizer(layout)
        
        self.Bind(wx.EVT_CLOSE, self.OnClose)

    def OnClose(self, event):
        self.Destroy()

if __name__ == '__main__':
    app = wx.App()
    frame = Frame()
    frame.Show()
    app.MainLoop()
    app.Destroy()
