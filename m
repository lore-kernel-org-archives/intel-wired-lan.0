From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Thu, 25 Nov 2021 22:11:16 +0100
Subject: [Intel-wired-lan] [Bug 215129] New: Linux kernel hangs during
 power down
In-Reply-To: <1849b7a3-cdfe-f9dc-e4d1-172e8b1667d2@gmail.com>
References: <20211124144505.31e15716@hermes.local>
 <20211124164648.43c354f4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1849b7a3-cdfe-f9dc-e4d1-172e8b1667d2@gmail.com>
Message-ID: <4a28ad86-1b1e-ab51-2351-efdd6caf8e1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 25.11.2021 08:32, Heiner Kallweit wrote:
> On 25.11.2021 01:46, Jakub Kicinski wrote:
>> Adding Kalle and Hainer.
>>
>> On Wed, 24 Nov 2021 14:45:05 -0800 Stephen Hemminger wrote:
>>> Begin forwarded message:
>>>
>>> Date: Wed, 24 Nov 2021 21:14:53 +0000
>>> From: bugzilla-daemon at bugzilla.kernel.org
>>> To: stephen at networkplumber.org
>>> Subject: [Bug 215129] New: Linux kernel hangs during power down
>>>
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=215129
>>>
>>>             Bug ID: 215129
>>>            Summary: Linux kernel hangs during power down
>>>            Product: Networking
>>>            Version: 2.5
>>>     Kernel Version: 5.15
>>>           Hardware: All
>>>                 OS: Linux
>>>               Tree: Mainline
>>>             Status: NEW
>>>           Severity: normal
>>>           Priority: P1
>>>          Component: Other
>>>           Assignee: stephen at networkplumber.org
>>>           Reporter: martin.stolpe at gmail.com
>>>         Regression: No
>>>
>>> Created attachment 299703
>>>   --> https://bugzilla.kernel.org/attachment.cgi?id=299703&action=edit    
>>> Kernel log after timeout occured
>>>
>>> On my system the kernel is waiting for a task during shutdown which doesn't
>>> complete.
>>>
>>> The commit which causes this behavior is:
>>> [f32a213765739f2a1db319346799f130a3d08820] ethtool: runtime-resume netdev
>>> parent before ethtool ioctl ops
>>>
>>> This bug causes also that the system gets unresponsive after starting Steam:
>>> https://steamcommunity.com/app/221410/discussions/2/3194736442566303600/
>>>
>>
> 
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
> 

I think the problem with runtime_resume() taking RTNL could also hit
the driver internally. See following call chain: If this would ever
be called when the device is runtime-suspended, then a similar
deadlock would occur.

__dev_open()    - called with RTNL held
  igb_open()
    __igb_open()   - arg resuming is false
      if (!resuming)
        pm_runtime_get_sync(&pdev->dev);
          igb_resume()
            rtnl_lock()
