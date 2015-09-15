From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 15 Sep 2015 18:39:35 +0000
Subject: [Intel-wired-lan] [PATCH V4 1/2] pci: Add dev_flags bit to
 access VPD through function 0
In-Reply-To: <1442341152.23936.122.camel@redhat.com>
References: <20150713183821.19985.52157.stgit@mdrustad-wks.jf.intel.com>
 <20150713184001.19985.64867.stgit@mdrustad-wks.jf.intel.com>
 <1442341152.23936.122.camel@redhat.com>
Message-ID: <F17F8A11-FB09-4131-A404-DE106F3944BB@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 15, 2015, at 11:19 AM, Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> In addition to the (PCI_SLOT() != devfn) issue, I'm concerned about
> topologies like we see on Skylake.  IIRC, the integrated NIC appears at
> something like 00:1f.6.  I don't know if that specific NIC has VPD, nor
> am I sure it really matter because another example or some future
> version might.  So we'll set the PCI_DEV_FLAGS_VPD_REF_F0 because we do
> so for all (PCI_FUNC() != 0) Intel NICs, we'll call
> pci_vpd_f0_dev_check(), which will error because function 0 has a
> different class code and device ID, so we return error and if VPD exists
> on the device, it's now inaccessible.

Yes, that is exactly what would happen.

> I thought there was talk about whitelisting anything on the root bus to
> avoid strange root complex integrated devices (and perhaps avoid the
> general case for assigned devices within a VM), but I don't see anything
> like that here.

I hadn't heard that talk, but I'm not on the PCI list and I guess I wasn't copied.

> Perhaps instead of failing and hiding VPD we should fail, clear the
> flag, and allow normal access.  Thanks,

Because the purpose of VPD is to hold information about the device, I would suggest that VPD should never be provided for an embedded network device, but rather for the device as a whole. So while there may well be VPD for an SOC, that VPD should not be associated with one of its embedded devices, but rather something more appropriate for the device as a whole. And attaching VPD to a whole bunch of internal devices would just be madness.

So I understand the concern, but I don't think that it should really happen in real systems. I did think about this case when I was working on the patches. A networking device should really only have VPD when it is its own physical device, such as a NIC.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150915/fea2b91e/attachment.asc>
