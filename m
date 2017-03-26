From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat, 25 Mar 2017 17:58:56 -0700
Subject: [Intel-wired-lan] [PATCH v7 1/2] ixgbe: add XDP support for
 pass and drop actions
In-Reply-To: <58D6BF24.3070503@gmail.com>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <20170324043110.10293.50132.stgit@john-Precision-Tower-5810>
 <1490408627.5679.45.camel@intel.com> <58D6BF24.3070503@gmail.com>
Message-ID: <1490489936.5679.52.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2017-03-25 at 12:04 -0700, John Fastabend wrote:
> On 17-03-24 07:23 PM, Jeff Kirsher wrote:
> > On Thu, 2017-03-23 at 21:31 -0700, John Fastabend wrote:
> > > Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics
> > > on
> > > XDP
> > > programs instead of rcu primitives as suggested by Daniel
> > > Borkmann
> > > and
> > > Alex Duyck.
> > > 
> > > Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> > > Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > > ---
> > > ? drivers/net/ethernet/intel/ixgbe/ixgbe.h???????? |??? 4 -
> > > ? drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |??? 4 -
> > > ? drivers/net/ethernet/intel/ixgbe/ixgbe_main.c??? |? 163
> > > +++++++++++++++++++---
> > > ? 3 files changed, 144 insertions(+), 27 deletions(-)
> > 
> > Does not apply cleanly to my dev-queue branch, what tree did you
> > base
> > these changes on?
> > 
> 
> Did you pop off the v6 series? I see its still in your tree :/ Or do
> you
> just want fixes to the initial series?

Crap, you are right.  Let me try this again without v6 applied...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170325/de2bf7a0/attachment.asc>
