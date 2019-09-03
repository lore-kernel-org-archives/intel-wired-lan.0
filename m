From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 3 Sep 2019 10:35:30 +0200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <0300439f389950a9f9baaaaf5e3ea697@mirality.co.nz>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
 <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
 <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
 <f6b7b539ece1ba352c60c6dc976a3ce2@mirality.co.nz>
 <0300439f389950a9f9baaaaf5e3ea697@mirality.co.nz>
Message-ID: <aafb4ac9-6825-300c-6dee-1b603c09e373@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Gavin,


Thank you for following up on this.

On 03.09.19 09:56, Gavin Lambert wrote:
> On 2019-08-20 14:15, I wrote:
>> Does anyone have any ideas about this?? Either towards further
>> investigation or to a possible resolution?
>>
>> This is at the point of hardware internals now, so I have no idea how
>> to proceed in either area.
> 
> To recap (plus some new info):
> 
> 1. I am using a kernel module which uses the code from the e1000e driver 
> to communicate with the hardware without actually registering it as a 
> Linux netdev.? (This is partly because it can get used in a Xenomai 
> context outside of Linux itself, although I'm not doing that myself.) 
> This historically works fine.
> 
> 2. On certain Linux versions, I encountered an issue where disconnecting 
> the network cable and reconnecting it almost always results in not being 
> able to send any packets.? (I cannot determine if receiving packets 
> works in this case, as the network design will not receive packets 
> unless some are sent first.)? Restarting the driver (rmmod+modprobe) 
> does recover from this case (until the next link loss), but simply 
> replugging the cable never does.
> 
> 3. The problem was observed with both I219-V and I219-LM (on 
> motherboard), but was *not* observed with 82571EB (PCIE).? The problem 
> was not observed with a motherboard igb-based I211.? I suspect the issue 
> is limited to motherboard-based e1000e adapters.? (Or perhaps there's 
> something different about how the IGBs are internally connected.)
> 
> 4. The problem does not occur when the e1000e driver is registered 
> "normally" as a Linux netdev.
> 
> 5. The problem was introduced by "mei: me: allow runtime pm for platform 
> with D0i3" (which has been backported to 4.4+, as far as I can tell). 
> Excluding this commit reliably resolves the issue and including it 
> reliably breaks it.

The commit hash in the master branch is 
cc365dcf0e56271bedf3de95f88922abe248e951 and is there since v4.16-rc1.

Strange, that it is in 4.4 and 4.9, as it was only tagged for v4.13+.

> 6. Applying the previously suggested patch 
> https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/e1000e?id=def4ec6dce393e2136b62a05712f35a7fa5f5e56 
> has no effect; the E1000_STATUS_PCIM_STATE bit is not set when the issue 
> occurs.
> 
> 7. Given the content of the change in #5, I assumed that the problem was 
> power-management related, perhaps a side effect of the e1000e driver not 
> being registered as a netdev.? (So perhaps something thinks that no 
> devices are in use and turns something off?)
> 
> 8. I've previously posted register dumps from an e1000e in both the 
> "normal" and "link up but not transmitting" states.? They seemed very 
> similar, but as I'm not familiar with the register meanings I may have 
> overlooked something significant.? (Note that the dumps were captured 
> inside the watchdog task, when it detects link up but before it sets 
> E1000_TCTL_EN.)
> 
> 9. I enabled debug logging in the mei driver; it logs a couple of 
> runtime_idles and then a runtime_suspend during system startup.? (I 
> added a log to runtime_resume that is missing in the driver source, but 
> it appears this does not get called in my scenario.)? Note that the 
> e1000e driver is still working ok after this.. at least at first.
> 
> 10. "cat /sys/bus/devices/pci0000:00/0000:00:16.0/power/runtime_status" 
> => "suspended"
>  ??? "cat 
> /sys/bus/devices/pci0000:00/0000:00:16.0/mei/mei0/power/runtime_status" 
> => "unsupported"
>  ??? "cat /sys/bus/devices/pci0000:00/0000:00:1f.0/power/runtime_status" 
> => "active"
>  ??? "cat /sys/bus/devices/pci0000:00/0000:00:1f.6/power/runtime_status" 
> => "active" (this is the actual NIC)
>  ??? These don't change between the working and non-working states. 
> (It's possible that some other device does, but I haven't found it yet.)
> 
> 11. I did try forcing the above to unsuspend, but this did not recover 
> from the e1000e issue.
> 
> 12. I also tried calling e1000e_reset on link-down.? This produces 
> different register output on link-up, but doesn't recover from the issue.
> 
> 13. I also tried recompiling the kernel with CONFIG_PM disabled (no 
> power management).? This *does* resolve the problem (but is a very big 
> hammer).
> 
> 14. Possibly also of interest is that if I do *both* #12 and #13, the 
> problem remains (suggesting #12 was counter-productive).
> 
> FYI the hardware on one of the test machines is as follows:
>  ??? 00:00.0 Host bridge: Intel Corporation Device 591f (rev 05)
>  ??? 00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 05)
>  ??? 00:02.0 VGA compatible controller: Intel Corporation Device 5912 (rev 04)
>  ??? 00:08.0 System peripheral: Intel Corporation Skylake Gaussian  Mixture Model
>  ??? 00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0  xHCI Controller (rev 31)
>  ??? 00:14.2 Signal processing controller: Intel Corporation Sunrise Point-H Thermal subsystem (rev 31)
>  ??? 00:15.0 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #0 (rev 31)
>  ??? 00:15.1 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #1 (rev 31)
>  ??? 00:16.0 Communication controller: Intel Corporation Sunrise Point-H CSME HECI #1 (rev 31)
>  ??? 00:17.0 SATA controller: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] (rev 31)
>  ??? 00:1b.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Root Port #19 (rev f1)
>  ??? 00:1b.3 PCI bridge: Intel Corporation Sunrise Point-H PCI Root Port #20 (rev f1)
>  ??? 00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #5 (rev f1)
>  ??? 00:1d.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #11 (rev f1)
>  ??? 00:1e.0 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO UART #0 (rev 31)
>  ??? 00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller (rev 31)
>  ??? 00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 31)
>  ??? 00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
>  ??? 00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-LM (rev 31)
>  ??? 02:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
>  ??? 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
>  ??? 05:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
> 
> I'm happy to add any code instrumentation or make any other changes 
> needed to locate and resolve the problem, and I can readily reproduce it 
> -- I'm just at a complete loss as to where to start looking, and am 
> still hoping for some suggestions in that regard.
> 
> If there's anywhere (or anyone) else better for me to talk to about this 
> issue, please let me know that too.

It is not clear to me, if this is still reproducible on Linux 5.3-rc7 
(or Linus? master branch).

If it is, this is a definitely regression, and the commits need to be 
reverted due to Linux? no regression policy.


Kind regards,

Paul
