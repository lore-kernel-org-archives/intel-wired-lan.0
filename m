From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 18 May 2015 16:45:27 -0700
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect	VPD operations
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418AE66237@fmsmsx115.amr.corp.intel.com>
References: <20150516001407.98487.1056.stgit@mdrustad-wks.jf.intel.com>
 <FC41C24E35F18A40888AACA1A36F3E418AE66237@fmsmsx115.amr.corp.intel.com>
Message-ID: <1431992727.3921.2.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-05-18 at 23:31 +0000, Nelson, Shannon wrote:
> > -----Original Message-----
> > From: Intel-wired-lan
> [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> > On Behalf Of Mark D Rustad
> > Sent: Friday, May 15, 2015 5:14 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
> > protect VPD operations
> > 
> > Some devices have a problem with concurrent VPD access to different
> > functions of the same physical device, so move the protecting mutex
> > from the pci_vpd structure to the pci_bus structure. There are a
> > number of reports on support sites for a variety of devices from
> > various vendors getting the "vpd r/w failed" message. This is likely
> > to at least fix some of them. Thanks to Shannon Nelson for helping
> > to come up with this approach.
> > 
> > Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> 
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> 
> 
> > ---
> >  drivers/pci/access.c |   10 ++++------
> >  drivers/pci/probe.c  |    1 +
> >  include/linux/pci.h  |    1 +
> >  3 files changed, 6 insertions(+), 6 deletions(-)

Since this patch really needs to be sent to linux-pci & netdev, I have
let Mark know to re-send this to Bjorn and the linux-pci mailing list.

Dropping this patch so that Mark can resend to the more appropriate
mailing lists.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150518/8ee31a78/attachment-0001.asc>
