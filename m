From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 18 Apr 2017 18:32:55 +0200
Subject: [Intel-wired-lan] Improve error message *Hardware Error*
Message-ID: <fc469a9f-fab8-2df9-b3b3-219331ae390b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear e1000e Linux folks,


On the Lenovo X60t sometimes the e1000e driver logs the error *Hardware 
Error*.

```
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet 
Controller
```

This has been present since Linux 3.16 and is still present in Linux 
4.9. Note, I don?t know how to trigger it. It only happens very rarely.

Logs are available in the coreboot board status repository [1].

Here is the excerpt from Linux 4.9.16 [2].

```
[    1.654209] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.654211] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.654517] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.778284] e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 
00:16:d3:b8:e3:49
[    1.778287] e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network 
Connection
[    1.778427] e1000e 0000:01:00.0 eth0: MAC: 2, PHY: 2, PBA No: 005302-003
[   10.655460] e1000e 0000:01:00.0 eth8: renamed from eth0
[   12.137432] e1000e 0000:01:00.0 eth8: Hardware Error
[   15.077174] e1000e: eth8 NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: Rx/Tx
```

If I am not mistaken this is logged by `igb_reset()` [3].

```
  	if (hw->mac.ops.init_hw(hw))
  		dev_err(&pdev->dev, "Hardware Error\n");
```

Where can I find, what `init_hw` is doing, and under what conditions it 
fails?

Also, could the error message be improved?

Something like (made up):

 > Hardware error during device reset. An error occurred during init.
 > The device might still work.


Kind regards,

Paul


[1] https://review.coreboot.org/cgit/board-status.git/tree/lenovo/x60
[2] 
https://review.coreboot.org/cgit/board-status.git/tree/lenovo/x60/4.5-1365-g8e1c12f/2017-03-22T03_55_13Z/kernel_log.txt#n806
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/igb/igb_main.c#n1987
