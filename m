From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 15 Sep 2015 21:47:35 +0000
Subject: [Intel-wired-lan] [PATCH V4 1/2] pci: Add dev_flags bit to
 access VPD through function 0
In-Reply-To: <1442351847.23936.155.camel@redhat.com>
References: <20150713183821.19985.52157.stgit@mdrustad-wks.jf.intel.com>
 <20150713184001.19985.64867.stgit@mdrustad-wks.jf.intel.com>
 <1442341152.23936.122.camel@redhat.com>
 <F17F8A11-FB09-4131-A404-DE106F3944BB@intel.com>
 <1442343860.23936.141.camel@redhat.com>
 <5E6FC98D-C2B9-4F69-ABB9-84A39AE6D271@intel.com>
 <1442351847.23936.155.camel@redhat.com>
Message-ID: <4BC72D19-784E-4320-9323-825D7D00DA67@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 15, 2015, at 2:17 PM, Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> Also, rather than clearing the flag, can we move the tests done by
> pci_vpd_f0_dev_check() into the
> quirk setup function?  It seems like function 0 should be sufficiently
> configured by the time we're probing non-zero functions that we can be
> more selective in setting the flag rather than unsetting it later.

I guess I was being very conservative in not assuming anything about the state of other devices at that point. Things seem to be increasingly parallel all the time and I am not deeply involved in the evolution of the PCI subsystem. If you want to make that assumption, I would suggest that pci_vpd_f0_dev_check remain a separate function called by the quirk setup so that it can be used by other quirk setup functions as well.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150915/48f8ee00/attachment.asc>
