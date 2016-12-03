From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 02 Dec 2016 23:59:17 -0800
Subject: [Intel-wired-lan] [PATCH v2] ethernet: intel: Replace
 pci_pool_alloc by pci_pool_zalloc
In-Reply-To: <CAFqt6zbAVxVu-bsH2P+km2tX_4RsdqD0aCS6a9RLJ-bm9kzX7g@mail.gmail.com>
References: <20161201190427.GA3357@jordon-HP-15-Notebook-PC>
 <1480707894.2415.16.camel@intel.com>
 <CAFqt6zbAVxVu-bsH2P+km2tX_4RsdqD0aCS6a9RLJ-bm9kzX7g@mail.gmail.com>
Message-ID: <1480751957.2410.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2016-12-03 at 12:58 +0530, Souptick Joarder wrote:
> On Sat, Dec 3, 2016 at 1:14 AM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
> > On Fri, 2016-12-02 at 00:34 +0530, Souptick Joarder wrote:
> > > In e100_alloc_cbs(), pci_pool_alloc() followed by memset will be
> > > replaced by pci_pool_zalloc()
> > > 
> > > Signed-off-by: Souptick joarder <jrdr.linux@gmail.com>
> > 
> > Why the change?? Is pci_pool_alloc() being deprecated?? I ask because
> > this
> > is a very old driver and changes will cause a huge regression, where
> > many
> > of the parts/NICs may not be available to test with.
> 
> pci_pool_alloc is not deprecated. As pci_pool_zalloc can do the same as
> pci_pool_alloc/memset, hence this change.
> 
> Do we need to go through complete regression to validate this patch?

Well, I do not think it is good idea to make changes and not test them,
even the "simple" patches need to be tested and verified.

Since pci_pool_zalloc() does the same thing as pci_pool_alloc/memset, then
what is the benefit of the change?  If there is no benefit and just causes
a bunch of regression testing, then I am not seeing the gain.

Currently e100 and e1000 drivers are in bug fix only mode (and have been so
for some time now) so if you looking to kick the dust off these older
drivers for no real good reason other than you see a possible optimization,
which you are not wanting to regression test to verify there are no issues.
 Then I am not going to take your requested change seriously.

Since we are not actively working on the driver, it makes even more sense
that we should thoroughly test any changes to ensure there are no issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161202/c5f6c799/attachment.asc>
