From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 25 Nov 2021 07:49:49 -0800
Subject: [Intel-wired-lan] [Bug 215129] New: Linux kernel hangs during
 power down
In-Reply-To: <1849b7a3-cdfe-f9dc-e4d1-172e8b1667d2@gmail.com>
References: <20211124144505.31e15716@hermes.local>
 <20211124164648.43c354f4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1849b7a3-cdfe-f9dc-e4d1-172e8b1667d2@gmail.com>
Message-ID: <20211125074949.5f897431@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 25 Nov 2021 08:32:18 +0100 Heiner Kallweit wrote:
> I think the reference to ath10k_pci is misleading, Kalle isn't needed here.
> The actual issue is a RTNL deadlock in igb_resume(). See log snippet:
> 
> Nov 24 18:56:19 MartinsPc kernel:  igb_resume+0xff/0x1e0 [igb 21bf6a00cb1f20e9b0e8434f7f8748a0504e93f8]
> Nov 24 18:56:19 MartinsPc kernel:  pci_pm_runtime_resume+0xa7/0xd0
> Nov 24 18:56:19 MartinsPc kernel:  ? pci_pm_freeze_noirq+0x110/0x110
> Nov 24 18:56:19 MartinsPc kernel:  __rpm_callback+0x41/0x120
> Nov 24 18:56:19 MartinsPc kernel:  ? pci_pm_freeze_noirq+0x110/0x110
> Nov 24 18:56:19 MartinsPc kernel:  rpm_callback+0x35/0x70
> Nov 24 18:56:19 MartinsPc kernel:  rpm_resume+0x567/0x810
> Nov 24 18:56:19 MartinsPc kernel:  __pm_runtime_resume+0x4a/0x80
> Nov 24 18:56:19 MartinsPc kernel:  dev_ethtool+0xd4/0x2d80
> 
> We have at least two places in net core where runtime_resume() is called
> under RTNL. This conflicts with the current structure in few Intel drivers
> that have something like the following in their resume path.
> 
> 	rtnl_lock();
> 	if (!err && netif_running(netdev))
> 		err = __igb_open(netdev, true);
> 
> 	if (!err)
> 		netif_device_attach(netdev);
> 	rtnl_unlock();
> 
> Other drivers don't do this, so it's the question whether it's actually
> needed here to take RTNL. Some discussion was started [0], but it ended
> w/o tangible result and since then it has been surprisingly quiet.
> 
> [0] https://www.spinics.net/lists/netdev/msg736880.html

Ah, that makes perfect sense, I didn't see that stack trace. 
Dropping Kalle from CC. Let's hear what Intel folks have to say..
