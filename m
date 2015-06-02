From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 2 Jun 2015 18:15:14 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] pci: Add dev_flags bit to access
 VPD through function 0
In-Reply-To: <556DEC80.70206@redhat.com>
References: <20150602165706.6252.76253.stgit@mdrustad-wks.jf.intel.com>
 <20150602170414.6252.48036.stgit@mdrustad-wks.jf.intel.com>
 <556DEC80.70206@redhat.com>
Message-ID: <CCF4C06B-1029-4341-B5AE-846C834DD747@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 2, 2015, at 10:48 AM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> I'm pretty sure these could cause some serious errors if you direct assign the device into a VM since you then end up with multiple devices sharing a bus.  Also it would likely have side-effects on a LOM (Lan On Motherboard) as it also shares the bus with multiple non-Ethernet devices.
> 
> I believe you still need to add something like a check for !pci_is_root_bus(dev->bus) before you attempt to grab function 0.  It probably also wouldn't hurt to check the dev->multifunction bit before running this code since it wouldn't make sense to go chasing down the VPD on another function if the device doesn't have one.  You could probably do that either as a part of this code, or perhaps put it in the quirk.

I'll look into those. I think you are right about more checks being needed. Thanks for the comments.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150602/94886361/attachment-0001.asc>
