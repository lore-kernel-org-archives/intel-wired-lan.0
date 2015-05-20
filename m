From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 20 May 2015 00:34:33 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect VPD operations
In-Reply-To: <555BD029.7050803@redhat.com>
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
 <555B78F7.60908@redhat.com> <20150519160158.00002cd6@unknown>
 <555BD029.7050803@redhat.com>
Message-ID: <F47DC49C-CCC5-4693-8905-20ABCE6F5993@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 5:07 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> 
> 
> On 05/19/2015 04:01 PM, Jesse Brandeburg wrote:

>> But Alex if you do this you're violating the principle of least
>> surprise, not to mention changing a user-space interface which should
>> not be done.
> 
> I'm willing to back off on dropping the VPD info for those functions entirely, but the lock should not be pushed to the bus.

Yeah, I think suddenly dropping the VPD from non-0 functions would be disruptive.

>> Mark's solution is pretty graceful and solves the issue at heart, which
>> is that
>> 1) several Intel chips have this issue
>> 2) it appears that several other vendor's chips have this issue (or
>> similar) as well, but even if they don't Mark's fix will not change
>> their general operation, only make a small serializing effect when
>> multiple simultaneous reads are made.
> 
> 2 is based on a false premise.  The "vpd r/w failed" error is about as common as dev_watchdog().  Just because it presents with a similar symptom doesn't mean it is the same issue.

I don't know if it is false, but it is possible that other devices could have the same behavior. I didn't expect that it would fix them all by any means, but I figured there would be some fellow travelers.

> If the bug is in Intel Ethernet with VPD then I would suggest tweaking the VPD logic and adding a Intel Ethernet PCI quirk.  It doesn't make sense to assume based on one common error message that all of creation has the same issue.

> If anything I believe Mark's patches have revealed a bigger issue. That is the fact that the sysfs file is reading outside of the VPD area which the PCI spec doesn't have a defined behavior for.  I suspect this is the cause of a number of the issues being reported as Broadcom had to specifically quirk to prevent it, and I found one discussion that indicated something similar might be needed for Realtek.

It turns out that I missed something very important here - the state of the F bit. Because of how that works, and how the kernel knows what the last access was, it is vital to know which address/data registers are shared and which ones aren't. This is going to result in a much bigger fix. It will be necessary to positively know when this register sharing is happening. This will result in significant changes to the VPD code in order to model the behavior right. Essentially, devices with this issue will need to have the vpd pointer point to the same structure. That automatically fixes the locking issue. I will look into what can be done for KVM while I am at it. It will be a big device table, but that is unavoidable.

Doggone it. It seemed too good to be true yesterday and now I know that is because it is. So close. If only it weren't for VPD writes... I'm going to start over now.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150520/3fb80d78/attachment.asc>
