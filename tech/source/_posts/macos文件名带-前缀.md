---
title: macos文件名带._前缀
categories:
  - [macOS]
tags:
  - macOS
  - 文件名前缀
date: 2024-10-25 17:35:09
mathjax:
---

**macOS系统中文件名带._前缀的文件**

这些以._开头的文件是由Finder创建的隐藏文件，主要用于存储文件的元数据信息。通常不会对用户造成直接影响，但如果你希望避免它们被创建，可以通过以下方法禁用：

1. ‌**通过终端命令禁用**‌：

   - 打开终端应用程序（可以在应用程序/实用工具/终端中找到）。

   - 输入以下命令并按回车键：

     ```bash
     defaults write com.apple.desktopservices DSDontWriteNetworkStores -booltrue
     ```

     这个命令将禁用在网络共享文件夹中创建**".DS_Store"**文件和**"._"**开头的隐藏文件。

   - 输入以下命令并按回车键：

     ```bash
     defaults write com.apple.desktopservices DSDontWriteUSBStores -booltrue
     ```

     这个命令将禁用在外部存储设备中创建**"._"**开头的隐藏文件。

   - 退出终端应用程序。现在，Finder 将不会在外部存储设备或网络共享文件夹中创建 `._` 开头的隐藏文件或文件夹‌1。

2. ‌**删除现有的._文件**‌：

   - 打开终端应用程序。

   - 输入以下命令并按回车键：

     ```bash
     find . -name "._*" | xargs rm -f
     ```

     这个命令会删除当前目录及其子目录下所有以**"._"**开头的文件‌。

通过以上方法，你可以有效地管理macOS系统中的 `._` 文件，避免它们被创建或删除现有的文件。

