---
title: AWS命令
categories:
  - [aws]
tags:
  - aws
date: 2023-08-10 09:03:30
mathjax:
---

## 

# AWS安装

[安装或更新最新版本的 AWS CLI - AWS Command Line Interface (amazon.com)](https://docs.aws.amazon.com/zh_cn/cli/latest/userguide/getting-started-install.html)

## Linux平台

```bash
apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

更新：

```bash
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

## MacOS平台

```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

<!--more-->

## Windows平台

### 安装和更新要求

- 我们在 Microsoft 支持的 64 位 Windows 版本上支持 AWS CLI。
- 安装软件的管理员权限

### 安装或更新 AWS CLI

要在 Windows 上更新当前安装的 AWS CLI，请在每次更新以覆盖以前版本时下载一个新的安装程序。AWS CLI 会定期更新。要查看最新版本的发布时间，请参阅 *GitHub* 上的 [AWS CLI 版本 2 更改日志](https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst?plain=1)。

1. 下载并运行适用于 Windows（64 位）的 AWS CLI MSI 安装程序：

   https://awscli.amazonaws.com/AWSCLIV2.msi

   或者，您可以运行 `msiexec` 命令来运行 MSI 安装程序。

   ```
   C:\> msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
   ```

   有关可与 `msiexec` 一起使用的各种参数，请参阅 *Microsoft Docs* 网站上的 [msiexec](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)。

2. 要确认安装，请打开 **Start**（开始）菜单，搜索 `cmd` 以打开命令提示符窗口，然后在命令提示符处使用 `aws --version` 命令。

   ```
   C:\> aws --version
   aws-cli/2.7.24 Python/3.8.8 Windows/10 exe/AMD64 prompt/off
   ```

   如果 Windows 无法找到该程序，您可能需要关闭并重新打开命令提示符窗口以刷新该路径，按照[纠正 AWS CLI 错误](https://docs.aws.amazon.com/zh_cn/cli/latest/userguide/cli-chap-troubleshooting.html)中的说明排除故障。

# AWS命令

## 先决条件

[使用 AWS CLI 版本 2 的先决条件 - AWS Command Line Interface (amazon.com)](https://docs.aws.amazon.com/zh_cn/cli/latest/userguide/getting-started-prereqs.html)

### 步骤 1：注册 AWS

如果您还没有 AWS 账户，请完成以下步骤来创建一个。

**注册 AWS 账户**

1. 打开 [https://portal.aws.amazon.com/billing/signup](http://portal.aws.amazon.com/billing/signup)。

2. 按照屏幕上的说明进行操作。

   在注册时，您将接到一通电话，要求您使用电话键盘输入一个验证码。

   当您注册 AWS 账户 时，系统将会创建一个 *AWS 账户根用户*。根用户有权访问该账户中的所有 AWS 服务 和资源。作为安全最佳实践，请 [为管理用户分配管理访问权限](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html)，并且只使用根用户执行 [需要根用户访问权限的任务](https://docs.aws.amazon.com/general/latest/gr/root-vs-iam.html#aws_tasks-that-require-root)。

### 步骤 2：创建 IAM 用户账户

要创建管理员用户，请选择以下选项之一。

| 选择一种方法来管理您的管理员      | To                                                           | By                                                           | 您也可以                                                     |
| :-------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 在 IAM Identity Center 中（建议） | 使用短期凭证访问 AWS。这符合安全最佳实践。有关最佳实践的信息，请参阅《IAM 用户指南》中的 [IAM 中的安全最佳实践](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#bp-users-federation-idp)。 | 有关说明，请参阅《AWS IAM Identity Center (successor to AWS Single Sign-On) 用户指南》中的[入门](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html)。 | 按照《AWS Command Line Interface 用户指南》中的[配置 AWS CLI 以使用 AWS IAM Identity Center (successor to AWS Single Sign-On)](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html)，配置编程式访问。 |
| 在 IAM 中（不推荐使用）           | 使用长期凭证访问 AWS。                                       | 按照《IAM 用户指南》中的[创建您的首个 IAM 管理员用户和组](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html)的说明操作。 | 按照《IAM 用户指南》中的[管理 IAM 用户的访问密钥](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)，配置编程式访问。 |

### 步骤 3：创建访问密钥 ID 和秘密访问密钥

要进行 CLI 访问，您需要访问密钥 ID 和秘密访问密钥。如果可能，请使用临时凭证代替长期访问密钥。临时凭证包括访问密钥 ID、秘密访问密钥，以及一个指示凭证何时到期的安全令牌。有关更多信息，请参阅《AWS 一般参考》中的[管理 AWS 访问密钥的最佳实践](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html)。

访问密钥包含访问密钥 ID 和秘密访问密钥，用于签署对 AWS 发出的编程请求。如果没有访问密钥，您可以使用进行创建AWS Management Console。作为最佳实践，请勿在不必要时对任何任务使用AWS 账户根用户访问密钥。而是为自己[创建一个具有访问密钥的新管理员 IAM 用户](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html)。

仅当创建访问密钥时，您才能查看或下载秘密访问密钥。以后您无法恢复它们。不过，您随时可以创建新的访问密钥。您还必须拥有执行所需 IAM 操作的权限。有关更多信息，请参阅 *IAM 用户指南*中的[访问 IAM 资源所需的权限](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_permissions-required.html)。

**为 IAM 用户创建访问密钥**

1. 登录 AWS Management Console，单击 https://console.aws.amazon.com/iam/ 打开 IAM 控制台。

2. 在导航窗格中，选择 **Users**（用户）。

3. 选择要为其创建访问密钥的用户的名称，然后选择 **Security credentials (安全凭证)** 选项卡。

4. 在 **Access keys**（访问密钥）部分中，选择 **Create access key**（创建访问密钥）。

5. 要查看新访问密钥对，请选择 **Show (显示)**。关闭此对话框后，您将无法再次访问该秘密访问密钥。您的凭证与下面类似：

   - 访问密钥 ID：AKIAIOSFODNN7EXAMPLE
   - 秘密访问密钥：wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

6. 要下载密钥对，请选择 **Download .csv file**（下载 .csv 文件）。将密钥存储在安全位置。关闭此对话框后，您将无法再次访问该秘密访问密钥。

   请对密钥保密以保护您的AWS 账户，切勿通过电子邮件发送密钥。请勿对企业外部共享密钥，即使有来自 AWS 或 Amazon.com 的询问。合法代表 Amazon 的任何人永远都不会要求您提供密钥。

7. 下载 `.csv` 文件之后，选择 **Close (关闭)**。在创建访问密钥时，预设情况下，密钥对处于活动状态，并且您可以立即使用此密钥对。

## 用户名与密码

```bash
xxxx@gmail.com
***
```

**访问Access Key ID与Security Access Key**

```
右上角：登录用户名，Security credentials
```

![image-20221204082711086](AWS%E5%91%BD%E4%BB%A4/image-20221204082711086.png)

```
访问密钥（访问密钥ID和秘密访问密钥）
```

![image-20221208075227452](AWS%E5%91%BD%E4%BB%A4/image-20221208075227452.png)

**创建新的访问密钥**

![image-20221208075628187](AWS%E5%91%BD%E4%BB%A4/image-20221208075628187.png)

## configure命令

wein用户：

```bash
AWS Access Key ID：
AKIASTMG7JHR4CSLFXDD

AWS Secret Access Key:
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
```

```bash
aws configure
AWS Access Key ID [None]: AKIASTMG7JHR4CSLFXDD
AWS Secret Access Key [None]: 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
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

### 多个用户

```bash
aws configure --profile wein
```

```
AWS Access Key ID [None]: AKIASTMG7JHR4CSLFXDD
AWS Secret Access Key [None]: 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
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

```bash
aws configure --profile ly
```

```
AWS Access Key ID [None]: AKIA4M6JODLWBZRMDADD
AWS Secret Access Key [None]: x0Se4XlTW9Dq9wZcL/BiYD44talGcAItaIFDFDF
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

### config与credentials配置文件

**.aws/config文件**

```bash
[profile wein]
region = ap-northeast-1
output = json
[profile ly]
region = ap-northeast-1
output = json
```

**.aws/credentials文件**

```bash
[wein]
aws_access_key_id = AKIASTMG7JHR4CSLFXDD
aws_secret_access_key = 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
[ly]
aws_access_key_id = AKIA4M6JODLWBZRMDADD
aws_secret_access_key = x0Se4XlTW9Dq9wZcL/BiYD44talGcAItaIFDFDF
```

## ec2命令

### describe-instances子命令

```bash
aws ec2 describe-instances

aws ec2 describe-instances --profile ly
aws ec2 describe-instances --profile wein
```

### run-instance：创建实例

例一、在东京区域，用【Ubuntu Server 22.04 LTS x64】的操作系统镜像，创建一个未命名的类型为t2.micro的实例。

```bash
aws ec2 run-instances --region ap-northeast-1 --image-id ami-03f4fa076d2981b45 --instance-type t2.micro --key-name win10 --security-group-ids sg-06b75fd317ff4083f
```

例二、在东京区域，用【Ubuntu Server 22.04 LTS x64】的操作系统镜像，创建一个名为【wein-jp1】的类型为t2.micro的实例。

```bash
aws ec2 run-instances --image-id ami-03f4fa076d2981b45 --instance-type t2.micro --key-name win10 --security-group-ids sg-06b75fd317ff4083f --tag-specifications="ResourceType=instance,Tags=[{Key=Name,Value=wein-jp1}]"
```

例三、在东京区域，用【Ubuntu Server 22.04 LTS x64】的操作系统镜像，创建2个名为【wein-jp1】的类型为t2.micro的实例。

```bash
aws ec2 run-instances --image-id ami-03f4fa076d2981b45 --instance-type t2.micro --key-name win10 --security-group-ids sg-06b75fd317ff4083f --count 2 --tag-specifications="ResourceType=instance,Tags=[{Key=Name,Value=wein-jp1}]"
```

例四、在首尔区域，用【Ubuntu Server 22.04 LTS x64】的操作系统镜像，创建一个名为【wein-kr】的类型为t2.micro的实例。

```bash
aws ec2 run-instances --region ap-northeast-2 --image-id ami-0e9bfdb247cc8de84 --instance-type t2.micro --key-name win10 --security-group-ids sg-094aa8e316c86fd4a --tag-specifications="ResourceType=instance,Tags=[{Key=Name,Value=wein-kr}]"
```

```
注意：
1、更换区域之前，需要使用aws configure命令重新配置一下区域，或者指定区域（--region）。
2、AMI Image ID不一样，不同区域的Amazon Machine Image的ID是不一样的。
3、密钥对（--key-name）可能不一样，与在该区域上传或者常见的密钥对有关。
4、安全组ID（--security-group-ids）不一样。
```

**AMI（Amazon Machine Image）说明：**

| 序号 | 区域名称 |    区域代码    |              AMI名称               |        AMI ID         |
| :--: | :------: | :------------: | :--------------------------------: | :-------------------: |
|  1   |   东京   | ap-northeast-1 |    Ubuntu Server 22.04 LTS x64     | ami-03f4fa076d2981b45 |
|  2   |   东京   | ap-northeast-1 |     Red Hat Enterprise Linux 9     | ami-083594d506bfbc152 |
|  3   |   东京   | ap-northeast-1 |        Mac OS Vertuna 13.0         | ami-00fd7f8c5e696ed64 |
|  4   |   东京   | ap-northeast-1 | Microsoft Windows Server 2022 Base | ami-099772c3838a3bec1 |
|  5   |   首尔   | ap-northeast-2 |    Ubuntu Server 22.04 LTS x64     | ami-0e9bfdb247cc8de84 |

### create-tags创建标签

```bash
aws ec2 create-tags --resources i-092c4e990c44739ec --tags Key=Name,Value="wein-jp1"
```

### start-instances启动实例

```bash
aws ec2 start-instances --instance-ids i-02bd34b35eea828b7

aws ec2 start-instances --instance-ids i-02bd34b35eea828b7 i-0b8b9da1319d1cf5f
```

### stop-instances停止实例

```bash
aws ec2 stop-instances --instance-ids i-02bd34b35eea828b7

aws ec2 stop-instances --instance-ids i-02bd34b35eea828b7 i-0b8b9da1319d1cf5f
```

**用指定profile取停止实例**

```bash
aws ec2 stop-instances --instance-ids i-05281fe68647384f3 --profile ly
```

### terminate-instances终止实例

```bash
aws ec2 terminate-instances --instance-ids i-087bbf8fb1155790e

aws ec2 terminate-instances --instance-ids i-087bbf8fb1155790e i-0b8b9da1319d1cf5f
```

## 自动关机与重启脚本

**编写脚本文件reboot-instances.sh**

**Ly2主机（主机：id2，重启id1的实例）：**

```bash
#!/bin/bash
date
instance_ids1="i-00fa54da169727f55" # wein
aws --profile wein ec2 stop-instances --instance-ids $instance_ids1
echo "Sleeping 5 minutes ..."
sleep 5m # sleep 5 minutes
aws --profile wein ec2 start-instances --instance-ids $instance_ids1
```

**wein主机（主机：id1，重启id2的实例）：**

```bash
#!/bin/bash
date
instance_ids2="i-05281fe68647384f3" # ly
aws --profile ly ec2 stop-instances --instance-ids $instance_ids2
echo "Sleeping 5 minutes ..."
sleep 5m # sleep 5 minutes
aws --profile ly ec2 start-instances --instance-ids $instance_ids2
```

**定时执行**

```bash
crontab -e

增加以下一行： # m h  dom mon dow   command
15 4 * * * /root/reboot-instances.sh >> reboot-instances.log 2>&1
```



## lightsail命令

### get-instance命令

执行以下命令：

```bash
aws lightsail get-instance --instance-name Ubuntu-1
```

说明：

```bash
--instance-name：要求提供实例名称参数
实例名称：Ubuntu-1
```

输出：

```bash
{
    "instance": {
        "name": "Ubuntu-1",
        "arn": "arn:aws:lightsail:ap-northeast-2:179061082595:Instance/1b1b1883-032a-40bd-b14e-887bb42e2f89",
        "supportCode": "689501495065/i-00169949f7cee4c6f",
        "createdAt": "2022-11-30T19:37:02.781000+08:00",
        "location": {
            "availabilityZone": "ap-northeast-2a",
            "regionName": "ap-northeast-2"
        },
        "resourceType": "Instance",
        "tags": [],
        "blueprintId": "ubuntu_20_04",
        "blueprintName": "Ubuntu",
        "bundleId": "small_2_0",
        "isStaticIp": false,
        "privateIpAddress": "172.26.6.63",
        "publicIpAddress": "52.79.253.60",
        "ipv6Addresses": [
            "2406:da12:ee4:a200:5bda:4ada:645e:6db6"
        ],
        "ipAddressType": "dualstack",
        "hardware": {
            "cpuCount": 1,
            "disks": [
                {
                    "createdAt": "2022-11-30T19:37:02.781000+08:00",
                    "sizeInGb": 60,
                    "isSystemDisk": true,
                    "iops": 180,
                    "path": "/dev/sda1",
                    "attachedTo": "Ubuntu-1",
                    "attachmentState": "attached"
                }
            ],
            "ramSizeInGb": 2.0
        },
        "networking": {
            "monthlyTransfer": {
                "gbPerMonthAllocated": 3072
            },
            "ports": [
                {
                    "fromPort": 0,
                    "toPort": 65535,
                    "protocol": "-1",
                    "accessFrom": "Anywhere (0.0.0.0/0 and ::/0)",
                    "accessType": "public",
                    "commonName": "",
                    "accessDirection": "inbound",
                    "cidrs": [
                        "0.0.0.0/0"
                    ],
                    "ipv6Cidrs": [
                        "::/0"
                    ],
                    "cidrListAliases": []
                }
            ]
        },
        "state": {
            "code": 16,
            "name": "running"
        },
        "username": "ubuntu",
        "sshKeyName": "win10",
        "metadataOptions": {
            "state": "applied",
            "httpTokens": "optional",
            "httpEndpoint": "enabled",
            "httpPutResponseHopLimit": 1,
            "httpProtocolIpv6": "disabled"
        }
    }
}
```

### start-instance命令

```bash
root@ip-172-31-13-87:~# aws lightsail start-instance --instance-name Ubuntu-1
{
    "operations": [
        {
            "id": "5d194a56-7ecf-409a-8b11-db870cd99d88",
            "resourceName": "Ubuntu-1",
            "resourceType": "Instance",
            "createdAt": "2022-12-01T07:48:54.536000+08:00",
            "location": {
                "availabilityZone": "ap-northeast-2a",
                "regionName": "ap-northeast-2"
            },
            "isTerminal": false,
            "operationDetails": "",
            "operationType": "StartInstance",
            "status": "Started",
            "statusChangedAt": "2022-12-01T07:48:54.536000+08:00"
        }
    ]
}
```

### stop-instance命令

```bash
root@ip-172-31-13-87:~# aws lightsail start-instance --instance-name Ubuntu-1
{
    "operations": [
        {
            "id": "f3be155e-2b7c-4471-a722-cc05b5da4429",
            "resourceName": "Ubuntu-1",
            "resourceType": "Instance",
            "createdAt": "2022-11-30T23:31:38.585000+08:00",
            "location": {
                "availabilityZone": "ap-northeast-2a",
                "regionName": "ap-northeast-2"
            },
            "isTerminal": false,
            "operationDetails": "",
            "operationType": "StartInstance",
            "status": "Started",
            "statusChangedAt": "2022-11-30T23:31:38.585000+08:00"
        }
    ]
}
```

## EBS卷命令

### 创建卷

```bash
aws ec2 create-volume --volume-type gp2 --size 80 --availability-zone ap-northeast-1a
```

![image-20230216083927999](AWS%E5%91%BD%E4%BB%A4/image-20230216083927999.png)

```bash
aws ec2 create-volume --volume-type gp2 --size 80 --availability-zone ap-northeast-1a | tee volume.txt

cat volume.txt | awk -F : '{print $2}' | grep vol | awk -F \" '{print $2}'

awk -F \" 'NR==8{print $4}' volume.txt
```



### 挂载卷

```bash
aws ec2 attach-volume --volume-id vol-0d264eddd9b9edfa5 --instance-id i-0b6d9cb9bd04a10f2 --device /dev/sdf
```

![image-20230216084310105](AWS%E5%91%BD%E4%BB%A4/image-20230216084310105.png)

### 分离卷

```bash
aws ec2 detach-volume --volume-id vol-0d264eddd9b9edfa5
```

![image-20230216084733635](AWS%E5%91%BD%E4%BB%A4/image-20230216084733635.png)

### 删除卷

```bash
aws ec2 delete-volume --volume-id vol-0d264eddd9b9edfa5
```

### 在linux系统挂载卷

```bash
sudo mkdir /mnt/data
sudo chmod 777 /mnt/data
sudo ln -snf /mnt/data /data

lsblk
sudo mkfs -t ext4 /dev/xvdf
sudo mount /dev/xvdf /mnt/data
```

![image-20230216085121725](AWS%E5%91%BD%E4%BB%A4/image-20230216085121725.png)

