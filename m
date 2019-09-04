From: Gavin Lambert <intel@mirality.co.nz>
Date: Wed, 04 Sep 2019 23:08:27 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DCAF25E@hasmsx108.ger.corp.intel.com>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
 <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
 <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
 <f6b7b539ece1ba352c60c6dc976a3ce2@mirality.co.nz>
 <0300439f389950a9f9baaaaf5e3ea697@mirality.co.nz>
 <aafb4ac9-6825-300c-6dee-1b603c09e373@molgen.mpg.de>
 <20190903092046.GB12325@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DCAC1FF@hasmsx108.ger.corp.intel.com>
 <f5b988f9-25cf-db4a-53f5-9bb7edc8fb51@molgen.mpg.de>
 <0159f1cd031ce326447621f1a22f60fc@mirality.co.nz>
 <5B8DA87D05A7694D9FA63FD143655C1B9DCAF25E@hasmsx108.ger.corp.intel.com>
Message-ID: <53d81b8c69ddeba6f76128f308ff5275@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-09-04 22:06, Winkler, Tomas wrote:
>> 
>> On 2019-09-03 21:39, Paul Menzel wrote:
>> > Dear Tomas,
>> >
>> > On 2019-09-03 11:28, Winkler, Tomas wrote:
>> >
>> >>> On Tue, Sep 03, 2019 at 10:35:30AM +0200, Paul Menzel wrote:
>> >
>> >>>> On 03.09.19 09:56, Gavin Lambert wrote:
>> >>>>> On 2019-08-20 14:15, I wrote:
>> >>>>>> Does anyone have any ideas about this?? Either towards further
>> >>>>>> investigation or to a possible resolution?
>> >>>>>>
>> >>>>>> This is at the point of hardware internals now, so I have no idea
>> >>>>>> how to proceed in either area.
>> >>>>>
>> >>>>> To recap (plus some new info):
>> >>>>>
>> >>>>> 1. I am using a kernel module which uses the code from the e1000e
>> >>>>> driver to communicate with the hardware without actually
>> >>>>> registering it as a Linux netdev.? (This is partly because it can
>> >>>>> get used in a Xenomai context outside of Linux itself, although
>> >>>>> I'm not doing that
>> >>>>> myself.) This historically works fine.
>> >>>>>
>> >>>>> 2. On certain Linux versions, I encountered an issue where
>> >>>>> disconnecting the network cable and reconnecting it almost always
>> >>>>> results in not being able to send any packets.? (I cannot
>> >>>>> determine if receiving packets works in this case, as the network
>> >>>>> design will not receive packets unless some are sent first.)
>> >>>>> Restarting the driver (rmmod+modprobe) does recover from this case
>> >>>>> (until the next link loss), but simply replugging the cable never does.
>> >>>>>
>> >>>>> 3. The problem was observed with both I219-V and I219-LM (on
>> >>>>> motherboard), but was *not* observed with 82571EB (PCIE).? The
>> >>>>> problem was not observed with a motherboard igb-based I211.? I
>> >>>>> suspect the issue is limited to motherboard-based e1000e adapters.
>> >>>>> (Or perhaps there's something different about how the IGBs are
>> >>>>> internally connected.)
>> >>>>>
>> >>>>> 4. The problem does not occur when the e1000e driver is registered
>> >>>>> "normally" as a Linux netdev.
>> >>>>>
>> >>>>> 5. The problem was introduced by "mei: me: allow runtime pm for
>> >>>>> platform with D0i3" (which has been backported to 4.4+, as far as
>> >>>>> I can tell).
>> >>>>> Excluding this commit reliably resolves the issue and including it
>> >>>>> reliably breaks it.
>> >>>>
>> >>>> The commit hash in the master branch is
>> >>>> cc365dcf0e56271bedf3de95f88922abe248e951 and is there since
>> >>>> v4.16-rc1.
>> >>>>
>> >>>> Strange, that it is in 4.4 and 4.9, as it was only tagged for
>> >>>> v4.13+.
>> >>>>
>> >>>>> 6. Applying the previously suggested patch
>> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/e1000e?id=def4ec6dce393e2136b62a05712f35a7fa5f5e56
>> >>>>> has no effect; the E1000_STATUS_PCIM_STATE
>> >>>>> bit is not set when the issue occurs.
>> >>>>>
>> >>>>> 7. Given the content of the change in #5, I assumed that the
>> >>>>> problem was power-management related, perhaps a side effect of the
>> >>>>> e1000e driver not being registered as a netdev.? (So perhaps
>> >>>>> something thinks that no devices are in use and turns something
>> >>>>> off?)
>> >>>>>
>> >>>>> 8. I've previously posted register dumps from an e1000e in both
>> >>>>> the "normal" and "link up but not transmitting" states.? They
>> >>>>> seemed very similar, but as I'm not familiar with the register
>> >>>>> meanings I may have overlooked something significant.? (Note that
>> >>>>> the dumps were captured inside the watchdog task, when it detects
>> >>>>> link up but before it sets
>> >>>>> E1000_TCTL_EN.)
>> >>>>>
>> >>>>> 9. I enabled debug logging in the mei driver; it logs a couple of
>> >>>>> runtime_idles and then a runtime_suspend during system startup.
>> >>>>> (I added a log to runtime_resume that is missing in the driver
>> >>>>> source, but it appears this does not get called in my scenario.)
>> >>>>> Note that the e1000e driver is still working ok after this.. at
>> >>>>> least at first.
>> >>>>>
>> >>>>> 10. "cat
>> >>>>> /sys/bus/devices/pci0000:00/0000:00:16.0/power/runtime_status"
>> >>>>> => "suspended"
>> >>>>>  ??? "cat
>> >>>>>
>> >>>
>> /sys/bus/devices/pci0000:00/0000:00:16.0/mei/mei0/power/runtime_status"
>> >>>>> => "unsupported"
>> >>>>>  ??? "cat
>> >>>>> /sys/bus/devices/pci0000:00/0000:00:1f.0/power/runtime_status"
>> >>>>> => "active"
>> >>>>>  ??? "cat
>> >>>>> /sys/bus/devices/pci0000:00/0000:00:1f.6/power/runtime_status"
>> >>>>> => "active" (this is the actual NIC)
>> >>>>>  ??? These don't change between the working and non-working states.
>> >>>>> (It's possible that some other device does, but I haven't found it
>> >>>>> yet.)
>> >>>>>
>> >>>>> 11. I did try forcing the above to unsuspend, but this did not
>> >>>>> recover from the e1000e issue.
>> >>>>>
>> >>>>> 12. I also tried calling e1000e_reset on link-down.? This produces
>> >>>>> different register output on link-up, but doesn't recover from the
>> >>>>> issue.
>> >>>>>
>> >>>>> 13. I also tried recompiling the kernel with CONFIG_PM disabled
>> >>>>> (no power management).? This *does* resolve the problem (but is a
>> >>>>> very big hammer).
>> >>>>>
>> >>>>> 14. Possibly also of interest is that if I do *both* #12 and #13,
>> >>>>> the problem remains (suggesting #12 was counter-productive).
>> >>>>>
>> >>>>> FYI the hardware on one of the test machines is as follows:
>> >>>>>  ??? 00:00.0 Host bridge: Intel Corporation Device 591f (rev 05)
>> >>>>>  ??? 00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller
>> >>>>> (x16) (rev 05)
>> >>>>>  ??? 00:02.0 VGA compatible controller: Intel Corporation Device
>> >>>>> 5912 (rev 04)
>> >>>>>  ??? 00:08.0 System peripheral: Intel Corporation Skylake Gaussian
>> >>>>> Mixture Model
>> >>>>>  ??? 00:14.0 USB controller: Intel Corporation Sunrise Point-H USB
>> >>>>> 3.0  xHCI Controller (rev 31)
>> >>>>>  ??? 00:14.2 Signal processing controller: Intel Corporation
>> >>>>> Sunrise Point-H Thermal subsystem (rev 31)
>> >>>>>  ??? 00:15.0 Signal processing controller: Intel Corporation
>> >>>>> Sunrise Point-H Serial IO I2C Controller #0 (rev 31)
>> >>>>>  ??? 00:15.1 Signal processing controller: Intel Corporation
>> >>>>> Sunrise Point-H Serial IO I2C Controller #1 (rev 31)
>> >>>>>  ??? 00:16.0 Communication controller: Intel Corporation Sunrise
>> >>>>> Point-H CSME HECI #1 (rev 31)
>> >>>>>  ??? 00:17.0 SATA controller: Intel Corporation Sunrise Point-H
>> >>>>> SATA controller [AHCI mode] (rev 31)
>> >>>>>  ??? 00:1b.0 PCI bridge: Intel Corporation Sunrise Point-H PCI
>> >>>>> Root Port #19 (rev f1)
>> >>>>>  ??? 00:1b.3 PCI bridge: Intel Corporation Sunrise Point-H PCI
>> >>>>> Root Port #20 (rev f1)
>> >>>>>  ??? 00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI
>> >>>>> Express Root Port #5 (rev f1)
>> >>>>>  ??? 00:1d.0 PCI bridge: Intel Corporation Sunrise Point-H PCI
>> >>>>> Express Root Port #11 (rev f1)
>> >>>>>  ??? 00:1e.0 Signal processing controller: Intel Corporation
>> >>>>> Sunrise Point-H Serial IO UART #0 (rev 31)
>> >>>>>  ??? 00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC
>> >>>>> Controller (rev 31)
>> >>>>>  ??? 00:1f.2 Memory controller: Intel Corporation Sunrise Point-H
>> >>>>> PMC (rev 31)
>> >>>>>  ??? 00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev
>> >>>>> 31)
>> >>>>>  ??? 00:1f.6 Ethernet controller: Intel Corporation Ethernet
>> >>>>> Connection (2) I219-LM (rev 31)
>> >>>>>  ??? 02:00.0 Ethernet controller: Intel Corporation I211 Gigabit
>> >>>>> Network Connection (rev 03)
>> >>>>>  ??? 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit
>> >>>>> Network Connection (rev 03)
>> >>>>>  ??? 05:00.0 Ethernet controller: Intel Corporation I211 Gigabit
>> >>>>> Network Connection (rev 03)
>> >
>> > (Tomas, your MUA wrapped the lines messing up the formatting.)
> 
> 
> Sorry, it's outlook.
> 
>> >
>> >>>>> I'm happy to add any code instrumentation or make any other
>> >>>>> changes needed to locate and resolve the problem, and I can
>> >>>>> readily reproduce it
>> >>>>> -- I'm just at a complete loss as to where to start looking, and
>> >>>>> am still hoping for some suggestions in that regard.
>> >>>>>
>> >>>>> If there's anywhere (or anyone) else better for me to talk to
>> >>>>> about this issue, please let me know that too.
>> >>>>
>> >>>> It is not clear to me, if this is still reproducible on Linux
>> >>>> 5.3-rc7 (or Linus? master branch).
>> >>>>
>> >>>> If it is, this is a definitely regression, and the commits need to
>> >>>> be reverted due to Linux? no regression policy.
>> >>>
>> >>> So I should revert this from 4.4.y and 4.9.y?
>> >>
>> >> The issue is not in mei driver, it is in e1000 driver, I my best
>> >> knowledge there should be fix, please Vitaly can it be backported to
>> >> older kernels?
>> >
>> > Tomas, backporting the commit supposedly fixing this, does *not* help.
> 
> I hope that Vitaly can address that.
> 
>> > Also, it does not matter for the no regression policy.
> 
> There are power consumption implication if you revert this commit for
> everyone, while the issue is present only on some platforms.

I wouldn't suggest reverting that change, at least not solely on my 
account (unless it's affecting more people).  It's not only me using 
this code but it's still a very niche case, and outside of "normal" 
Linux usage.

Although it seems a little odd that it ended up in 4.4 and 4.9 when the 
commit said it was intended for 4.13+.  But I don't know how those 
things work.

(Though in a way this was good for me -- it would have been a lot harder 
to run into this issue when switching from 4.9 to 4.19 [which would have 
been the next step] rather than from 4.9.110 to 4.9.168 [which is what 
actually happened].)

> You can still disable runtime power management via sysfs and
> permanently using udev rule on your particular system.
> e.g. ATTR{../../power/control}="on"

I'll do some more testing on this tomorrow, but I do recall trying 
setting power/control to "on" (via sysfs) for the device:

   00:16.0 Communication controller: Intel Corporation Sunrise Point-H 
CSME HECI #1 (rev 31)

which was the one that I noticed was suspended.  Is this the mei device?

In any case when I tried it before it didn't seem to help, but I think 
this was after link-down and things had already failed.  I'll try 
testing a few more cases, including doing it pre-emptively.

>> > Let?s wait until Gavin can confirm if it is happening with Linux
>> > 5.3-rc7.
>> 
>> As noted above (and in a prior email), the problem doesn't occur when 
>> using
>> the driver "normally" within Linux.  The triggering environment is 
>> where the
>> driver init/send/receive code is being executed directly
>> *without* being registered as a Linux netdev.
>> 
>> It is likely that the "real problem" is some side effect of this, such 
>> as
>> something checking if a child device is in use or powered down but 
>> it's not
>> registered.
>> 
>> My environment is currently based on this tree:
>> 
>> > Using this kernel tree:
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/?h=v4.9-rt&ofs=3120
>> >
>> > I've identified that the code at tag v4.9.126 is "good" and the code
>> > at tag v4.9.127 is "bad".
>> (I then narrowed it down to that specific commit.)
>> 
>> To reiterate, there is probably no problem with standard usage of the
>> drivers as part of Linux.
>> 
>> But in this particular non-standard-edge-case-usage, there seems to be 
>> some
>> unfortunate interaction between the mei driver power management change
>> and link-loss in onboard e1000e, and I'm trying to figure out the 
>> cause and
>> hopefully a fix/workaround (or at least one less serious than 
>> disabling power
>> management entirely).
> This is some underlying issue, I'm don't think you can be able to
> resolve it yourself,  e1000 guys should provide the fix.
> Unfortunately I cannot really fix this issue form the mei side.
> 
>> 
>> Some more context from my original email:
>> > I'm using a system with an e1000e network driver which has been
>> > patched to bypass the regular Linux network stack (because it can get
>> > called from a Xenomai RT context, among other reasons -- although in
>> > my case I'm not doing that).  The complete source for the patched
>> > version of the code can be found here:
>> >
>> > https://github.com/ribalda/ethercat/blob/master/devices/e1000e/netdev-4.9-ethercat.c
>> > (There are some minor changes to other files, but the
>> > majority of changes are only to this file.  You can see just the
>> > changes at
>> > https://gist.github.com/uecasm/5e36a15bda6ffd53079344fc443dcc5f/revisions .)
>> >
>> > It was originally based on the in-kernel e1000e driver as of Linux
>> > 4.9.65.  (I'm not the person who originally made the patches, but I am
>> > the person who rebased them to kernel 4.9 and I'm the one trying to
>> > maintain them for newer kernel versions.  Though I'm also not the
>> > person who made that github repo.)
> 
> You will need to eventually incorporate the e1000 fix when resolved
> also to your code base.
> For now the easiest workaround is to disable power management on mei
> from outside on effected platforms.

Yeah, I'm hoping that the eventual solution will be a code change to the 
e1000e driver.  The way the distribution is structured it's very easy to 
apply a fix there and much much harder to apply one at any other point.  
Though userspace rule changes are also feasible.
