From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 21 Dec 2017 10:40:54 +0100
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <20171210083949.GA3872@amd>
References: <20171210083949.GA3872@amd>
Message-ID: <4259bb94-5820-1349-8335-cfebd8fb3ed4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Pavel,


On 12/10/17 09:39, Pavel Machek wrote:

> In v4.15-rc2+, network manager can not see my ethernet card, and 
> manual attempts to ifconfig it up did not really help, either.
> 
> Card is:
> 
> 02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit
> Ethernet Controller
> 
> Dmesg says:
> 
>    dmesg | grep eth
> [    0.648931] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:16:d3:25:19:04
> [    0.648934] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network Connection
> [    0.649012] e1000e 0000:02:00.0 eth0: MAC: 2, PHY: 2, PBA No: 005302-003
> [    0.706510] usbcore: registered new interface driver cdc_ether
> [    6.557022] e1000e 0000:02:00.0 eth1: renamed from eth0
> [    6.577554] systemd-udevd[2363]: renamed network interface eth0 to eth1
> 
> Any ideas?

I am sorry for jumping in on this so late.

Since using a Lenovo X60t more ofter since a year or so, I experience 
the issue, that the link doesn?t come up during that period occasionally 
[1]. I haven?t tried the latest patches yet, but it might be unrelated.

Did you test, that removing and loading the e1000e module fixes the issue?

Additionally, I was asked privately to test the out of tree driver, but 
haven?t had time yet.

> You might give the out-of-tree driver a try, you can download it here
> https://downloadcenter.intel.com/download/26549/Intel-Network-Adapter-Driver-for-PCIe-Intel-Gigabit-Ethernet-Network-Connections-Under-Linux-?product=19297
>  It's version is 3.3.5, dated 8/2016

Kind regards,

Paul


[1] 
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20170410/008590.html
-------------- next part --------------
An embedded message was scrubbed...
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [Intel-wired-lan] e1000e: Link down after startup on Lenovo X60
Date: Wed, 12 Apr 2017 16:31:45 +0200
Size: 6867
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171221/0804f19a/attachment-0001.mht>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171221/0804f19a/attachment-0001.p7s>
