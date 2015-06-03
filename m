From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 3 Jun 2015 16:16:43 +0000
Subject: [Intel-wired-lan] [PATCH V2 1/2] pci: Add dev_flags bit to
 access VPD through function 0
In-Reply-To: <556E6667.1020000@gmail.com>
References: <20150603000645.71269.26134.stgit@mdrustad-wks.jf.intel.com>
 <20150603001011.71269.79857.stgit@mdrustad-wks.jf.intel.com>
 <556E6667.1020000@gmail.com>
Message-ID: <4033DF50-0126-4F69-88FA-C6AABC0CADCE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 2, 2015, at 7:28 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> You can probably combine the dev->multifunction check with the dev_flags check.  After all you don't need this workaround if the device is not multifunction.  It might even make more sense to move the multifunction check to the quirk in patch 2/2.

Yes. I also realized that I really should check that tdev->vpd is not NULL. There is no point in referencing it if, for whatever reason, it has no VPD.

> I also believe this leaks a reference to the device.

Yes, and I was thinking that when I wrote the line, but forgot to do anything about it. Good catch!

> You should be calling pci_dev_put(tdev) if tdev is not NULL.  As such you probably need to split up the !tdev and the rest of the checks.

Yup. I will have a V3 coming. I still don't have anything to handle PFs assigned to guests, but I think that would be best in a separate patch set if there is need to fix that. It looks to me like that would involve trapping on all config space accesses to such devices and then emulating the behavior of the VPD Address/F and Data registers. It may be worth seeing if anyone cares before doing anything about it. I haven't seen any reports related to such a setup.

Again, thank you for your comments.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150603/257ffcfe/attachment.asc>
