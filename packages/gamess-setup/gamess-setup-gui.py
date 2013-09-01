# -*- coding: utf-8 -*-

import sys
import wx
import os

import config
import download
import compile

class Frame(wx.Frame):
    def __init__(self, prefix):
        self.prefix = prefix

        wx.Frame.__init__(self, None, -1, "GAMESS Setup", size = (420,280))
        self.panel = wx.Panel(self, -1)

        layout = wx.BoxSizer(wx.VERTICAL)

        self.radio_download = wx.RadioButton(self.panel, -1, "Download source tarball from official website")
        self.radio_download.SetValue(True)
        layout.Add(self.radio_download, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        grid_1 = wx.FlexGridSizer(2, 3)
        self.text_username = wx.TextCtrl(self.panel, -1, value = 'source', size = (285, -1))
        # self.text_password = wx.TextCtrl(self.panel, -1, style = wx.TE_PASSWORD)
        self.text_password = wx.TextCtrl(self.panel, -1)
        grid_1.Add(wx.StaticText(self.panel, -1, '     '), 0)
        grid_1.Add(wx.StaticText(self.panel, -1, "Username:"), 0, wx.RIGHT, 4)
        grid_1.Add(self.text_username, 1, wx.EXPAND, 4)
        grid_1.Add(wx.StaticText(self.panel, -1, '     '), 0)
        grid_1.Add(wx.StaticText(self.panel, -1, "Password:"), 0, wx.RIGHT | wx.TOP, 4)
        grid_1.Add(self.text_password, 1, wx.EXPAND | wx.TOP, 4)
        layout.Add(grid_1, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        self.radio_local = wx.RadioButton(self.panel, -1, "Use a tarball (*.tar.gz) on local storage")
        layout.Add(self.radio_local, 0, wx.LEFT | wx.RIGHT | wx.TOP, 10)

        grid_2 = wx.FlexGridSizer(2, 3)
        self.text_file = wx.TextCtrl(self.panel, -1, size = (325, -1), style = wx.TE_READONLY)
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
        self.button_cancel = wx.Button(self.panel, -1, "Cancel", size=(70,30))
        self.button_cancel.Bind(wx.EVT_BUTTON, self.OnClose)
        self.button_install = wx.Button(self.panel, -1, "Install", size=(70,30))
        self.button_install.Bind(wx.EVT_BUTTON, self.OnInstall)
        box_1.Add(self.button_cancel, 0, wx.LEFT | wx.BOTTOM, 5)
        box_1.Add(self.button_install, 0, wx.LEFT | wx.BOTTOM, 5)
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
            username = self.text_username.GetValue()
            password = self.text_password.GetValue()
            if (username and password):
                ret = download.Download(username, password, self.prefix + '/source')
                if (ret != 0):
                    dialog = wx.MessageDialog(None, 'Invalid username and/or password', 'Error', wx.OK | wx.ICON_ERROR)
                    dialog.ShowModal()
                    dialog.Destroy()
                    return
                ret = compile.CompileAndInstall(self.prefix + '/source/gamess-current.tar.gz', self.prefix)
                if (ret != 0):
                    dialog = wx.MessageDialog(None, 'Error occured during compilation', 'Error', wx.OK | wx.ICON_ERROR)
                    dialog.ShowModal()
                    dialog.Destroy()
                    return
            else:
                dialog = wx.MessageDialog(None, 'Please input username and password', 'Error', wx.OK | wx.ICON_ERROR)
                dialog.ShowModal()
                dialog.Destroy()
                return
        else:
            file = self.text_file.GetValue()
            if (file):
                ret = compile.CompileAndInstall(file, self.prefix)
                if (ret != 0):
                    dialog = wx.MessageDialog(None, 'Error occured during compilation', 'Error', wx.OK | wx.ICON_ERROR)
                    dialog.ShowModal()
                    dialog.Destroy()
                    return
            else:
                dialog = wx.MessageDialog(None, 'Please specify source archive', 'Error', wx.OK | wx.ICON_ERROR)
                dialog.ShowModal()
                dialog.Destroy()
                return
        dialog = wx.MessageBox('Installation completed', 'GAMESS Setup')
        self.Destroy()

if __name__ == '__main__':
    if (len(sys.argv) < 2):
        print "Usage:", sys.argv[0], "prefix"
        sys.exit(127)
    prefix = sys.argv[1]
    app = wx.App()
    frame = Frame(prefix)
    frame.Show()
    app.MainLoop()
    app.Destroy()
