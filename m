From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 06 Jun 2017 13:43:36 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
In-Reply-To: <59370DDD.5050008@gmail.com>
References: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
 <1496780043.5522.5.camel@intel.com> <59370DDD.5050008@gmail.com>
Message-ID: <1496781816.86439.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-06-06 at 13:17 -0700, John Fastabend wrote:
> On 06/06/2017 01:14 PM, Jeff Kirsher wrote:
> > On Mon, 2017-05-01 at 22:06 -0700, John Fastabend wrote:
> > > XDP checks to ensure the MTU is valid and LRO is disabled when it
> > > is
> > > loaded. But user configuration after XDP is loaded could change
> > > these
> > > and cause a misconfiguration.
> > > 
> > > This patch adds checks to ensure config changes are valid.
> > > 
> > > Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17
> > > +++++++++++++++++
> > >   1 file changed, 17 insertions(+)
> > 
> > I know you have moved onto a new job, which is probably taking up
> > most
> > of your time.  I just need to know if you will be re-spinning this
> > patch based on the feedback from Alex.
> > 
> 
> I planned to get the xdp_redirect patches updated and sent out
> in the next few weeks. When I get around to that I'll also push
> an update to this assuming no one beats me to it.

Ok thanks for the update, I will drop the current patch and will await
an updated version.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170606/1d7b3c21/attachment.asc>
