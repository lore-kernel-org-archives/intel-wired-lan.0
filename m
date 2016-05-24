From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 May 2016 16:23:11 +0000
Subject: [Intel-wired-lan] [PATCH] [v1,
 next-queue] net: ixgbe: Fix deleting link filters for cls_u32
 offloads
In-Reply-To: <5730E6C3.2070104@intel.com>
References: <20160507020951.3203.46579.stgit@terminator23.jf.intel.com>
 <5730E6C3.2070104@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D706A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Samudrala, Sridhar
> Sent: Monday, May 09, 2016 12:37 PM
> To: Nambiar, Amritha <amritha.nambiar@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH] [v1, next-queue] net: ixgbe: Fix
> deleting link filters for cls_u32 offloads
> 
> 
> On 5/6/2016 7:09 PM, Amritha Nambiar wrote:
> > On deleting filters which are links to a child hash table, the filters
> > in the child hash table must be cleared from the hardware if there is
> > no link between the parent and child hash table.
> >
> > Verified with the following filters:
> >
> > # tc qdisc add dev enp5s0f1 ingress
> > # ethtool -K enp5s0f1 hw-tc-offload on
> >
> > Create a child hash table:
> > # tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
> > 	handle 1: u32 divisor 1
> >
> > Link to the child hash table from parent hash table:
> > # tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
> > 	handle 800:0:10 u32 ht 800: link 1: \
> > 	offset at 0 mask 0f00 shift 6 plus 0 eat \
> > 	match ip protocol 6 ff match ip dst 15.0.0.1/32
> >
> > Add filters into child hash table:
> > # tc filter add dev enp5s0f1 parent ffff: protocol ip \
> > 	handle 1:0:2 u32 ht 1: \
> > 	match tcp src 22 ffff action drop
> > # tc filter add dev enp5s0f1 parent ffff: protocol ip \
> >          handle 1:0:3 u32 ht 1: \
> >          match tcp src 33 ffff action drop
> >
> > Delete link filter from parent hash table:
> > # tc filter del dev enp5s0f1 parent ffff: prio 99 \
> > 	handle 800:0:10 u32
> >
> > Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> 
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   75
> ++++++++++++++++++++++--
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_model.h |    4 +
> >   2 files changed, 72 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Deleting parent table also removes child filters
