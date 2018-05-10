From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 10 May 2018 13:34:47 -0700
Subject: [Intel-wired-lan] [PATCH v6 5/5] PCI: Remove unused
 pcie_get_minimum_link()
In-Reply-To: <20180510163357.GB190385@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152537764322.62474.552711932384023140.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180510163357.GB190385@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ea4c716024a30ed834b1121adb8c2cb1deff2c97.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-05-10 at 11:33 -0500, Bjorn Helgaas wrote:
> On Thu, May 03, 2018 at 03:00:43PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > In some cases pcie_get_minimum_link() returned misleading
> > information
> > because it found the slowest link and the narrowest link without
> > considering the total bandwidth of the link.
> > 
> > For example, consider a path with these two links:
> > 
> >    - 16.0 GT/s  x1 link  (16.0 * 10^9 * 128 / 130) *  1 / 8 = 1969
> > MB/s
> >    -  2.5 GT/s x16 link  ( 2.5 * 10^9 *   8 /  10) * 16 / 8 = 4000
> > MB/s
> > 
> > The available bandwidth of the path is limited by the 16 GT/s link
> > to about
> > 1969 MB/s, but pcie_get_minimum_link() returned 2.5 GT/s x1, which
> > corresponds to only 250 MB/s.
> > 
> > Callers should use pcie_print_link_status() instead, or
> > pcie_bandwidth_available() if they need more detailed information.
> > 
> > Remove pcie_get_minimum_link() since there are no callers left.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Hi Jeff,
> 
> I got your note that you applied this to dev-queue.  I assume that
> means you also applied the preceding patches that removed all the
> users.  I got a note about ixgbe, but not the others, so I'm just
> double-checking.

I did initially apply it, but realized that I would have to apply the
earlier patches as well, which did not pertain to the Intel wired LAN
drivers.  So I have removed this patch from queue and will only be
testing the ixgbe patch of the series, which Andrew has already tested
and responded to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180510/c363ecfd/attachment.asc>
