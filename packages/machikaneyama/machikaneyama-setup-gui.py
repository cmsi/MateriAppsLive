# -*- coding: utf-8 -*-

import sys
import wx
import os

import download
import compile

url = "http://kkr.phys.sci.osaka-u.ac.jp/download.cgi"
dir = "cpa2002v009c"
file = dir + ".tar.gz"

class Frame(wx.Frame):
    def __init__(self):
        wx.Frame.__init__(self, None, -1, "Machikaneyama Setup", size = (350,250))
        self.panel = wx.Panel(self, -1)

        layout = wx.BoxSizer(wx.VERTICAL)

        self.radio_download = wx.RadioButton(self.panel, -1, "Download source code from official website")
        self.radio_download.SetValue(True)
        layout.Add(self.radio_download, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        grid_1 = wx.FlexGridSizer(2, 3)
        self.text_email = wx.TextCtrl(self.panel, -1, size = (1000, -1))
        # self.text_password = wx.TextCtrl(self.panel, -1, style = wx.TE_PASSWORD)
        self.text_password = wx.TextCtrl(self.panel, -1)
        grid_1.Add(wx.StaticText(self.panel, -1, '     '), 0)
        grid_1.Add(wx.StaticText(self.panel, -1, "Email:"), 0, wx.RIGHT, 4)
        grid_1.Add(self.text_email, 1, wx.EXPAND, 4)
        grid_1.Add(wx.StaticText(self.panel, -1, '     '), 0)
        grid_1.Add(wx.StaticText(self.panel, -1, "Password:"), 0, wx.RIGHT | wx.TOP, 4)
        grid_1.Add(self.text_password, 1, wx.EXPAND | wx.TOP, 4)
        layout.Add(grid_1, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        self.radio_local = wx.RadioButton(self.panel, -1, "Use source code on local storage")
        layout.Add(self.radio_local, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        grid_2 = wx.FlexGridSizer(2, 3)
        self.text_file = wx.TextCtrl(self.panel, -1, size = (1000, -1), style = wx.TE_READONLY)
        self.button_choose = wx.Button(self.panel, -1, "Choose")
        self.button_choose.Bind(wx.EVT_BUTTON, self.OnChoose)
        grid_2.Add(wx.StaticText(self.panel, -1, '     '), 0)
        grid_2.Add(wx.StaticText(self.panel, -1, "File:"), 0, wx.RIGHT | wx.TOP, 4)
        grid_2.Add(self.text_file, 1, wx.EXPAND | wx.TOP, 4)
        grid_2.Add(wx.StaticText(self.panel, -1, ''), 0)
        grid_2.Add(wx.StaticText(self.panel, -1, ''), 0)
        grid_2.Add(self.button_choose, 0, wx.TOP, 4)
        layout.Add(grid_2, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        box_1 = wx.BoxSizer(wx.HORIZONTAL)
        self.button_install = wx.Button(self.panel, -1, "Install", size=(70,30))
        self.button_install.Bind(wx.EVT_BUTTON, self.OnInstall)
        self.button_cancel = wx.Button(self.panel, -1, "Cancel", size=(70,30))
        self.button_cancel.Bind(wx.EVT_BUTTON, self.OnClose)
        box_1.Add(self.button_install, 0, wx.LEFT | wx.BOTTOM, 5)
        box_1.Add(self.button_cancel, 0, wx.LEFT | wx.BOTTOM, 5)
        layout.Add(box_1, 0, wx.ALIGN_BOTTOM | wx.ALIGN_RIGHT | wx.RIGHT | wx.TOP, 10)
        
        self.panel.SetSizer(layout)
        
        self.Bind(wx.EVT_CLOSE, self.OnClose)

    def OnClose(self, event):
        self.Destroy()

    def OnChoose(self, event):
        wildCard = "tar.gz file (*.tar.gz)|*.tar.gz|All files (*.*)|*.*"
        if (self.text_file.GetValue()):
            path = os.path.dirname(self.text_file.GetValue())
        else:
            path = os.environ['HOME']
        dialog = wx.FileDialog(self, "Choose a source archive", path, '', wildCard, wx.OPEN)
        if dialog.ShowModal() == wx.ID_OK:
            self.text_file.SetValue(dialog.GetPath())
            self.radio_local.SetValue(True)
        dialog.Destroy()

    def OnInstall(self, event):
        if (self.radio_download.GetValue()):
            email = self.text_email.GetValue()
            password = self.text_password.GetValue()
            prefix = os.environ['HOME']
            compiler = 'gfortran-mp-4.7'
            option = ''
            if (email and password):
                ret = download.Download(url, file, email, password)
                if (ret != 0):
                    dialog = wx.MessageDialog(None, 'Invalid email and/or password', 'Error', wx.OK | wx.ICON_ERROR)
                    dialog.ShowModal()
                    dialog.Destroy()
                    return
                ret = compile.CompileAndInstall(dir, file, prefix, compiler, option)
            else:
                dialog = wx.MessageDialog(None, 'Please input email and password', 'Error', wx.OK | wx.ICON_ERROR)
                dialog.ShowModal()
                dialog.Destroy()
                return
        else:
            print "local"
        dialog = wx.MessageBox('Installation completed', 'Machikaneyama Setup')
        self.Destroy()

if __name__ == '__main__':
    app = wx.App()
    frame = Frame()
    frame.Show()
    app.MainLoop()
    app.Destroy()
