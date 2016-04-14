From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 13 Apr 2016 23:42:37 -0700
Subject: [Intel-wired-lan] [PATCH] [v2,
 next-queue] net: ixgbe: Match on multiple headers for cls_u32
 offloads
In-Reply-To: <20160414011206.25187.30613.stgit@sdncamp.jf.intel.com>
References: <20160414011206.25187.30613.stgit@sdncamp.jf.intel.com>
Message-ID: <1460616157.2960.54.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-13 at 21:12 -0400, Amritha Nambiar wrote:
> Adds support to set filters with multiple header fields (L3,L4)to
> match on.
> This is achieved in the following order:
> 1. Create a leaf hash table for the next header.
> 2. Create a link to the leaf hash table from the base hash table with
> ?? matches on next header type and current header fields.
> 3. Add filter in leaf hash table with match on next header fields and
> ?? action.
> 
> Verified with the following filters :
> 
> Match TCP and DIP:
> # tc qdisc add dev enp9s0f0 ingress
> # tc filter add dev enp9s0f0 parent ffff: protocol ip prio 99 \
> ????????handle 1: u32 divisor 1
> # tc filter add dev enp9s0f0 protocol ip parent ffff: prio 99 \
> ????????u32 ht 800: order 1 link 1: \
> ????????offset at 0 mask 0f00 shift 6 plus 0 eat \
> ????????match ip protocol 6 ff match ip dst 10.0.0.1/32
> # tc filter add dev enp9s0f0 parent ffff: protocol ip u32 ht 1: order
> 1 \
> ????????match tcp src 28 ffff action drop
> 
> Delete the filter:
> # tc filter del dev enp9s0f0 parent ffff: prio 99 handle 1:0:1 u32
> 
> Match on DIP, SIP, UDP (SPort, DPort):
> # tc filter add dev enp9s0f0 parent ffff: protocol ip prio 99 \
> ????????handle 2: u32 divisor 1
> # tc filter add dev enp9s0f0 protocol ip parent ffff: prio 99 \
> ????????u32 ht 800: order 2 link 2: \
> ????????offset at 0 mask 0f00 shift 6 plus 0 eat \
> ????????match ip dst 15.0.0.2/32 match ip protocol 17 ff \
> ????????match ip src 15.0.0.1/32
> # tc filter add dev enp9s0f0 parent ffff: protocol ip u32 ht 2: order
> 2 \
> ????????match udp src 30 ffff match udp dst 32 ffff action drop
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> v2: Rename a loop variable to fix build error
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe.h?????? |??? 2?
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c? |? 216
> +++++++++++++++++-------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_model.h |??? 6 +
> ?3 files changed, 156 insertions(+), 68 deletions(-)

Dropping because patch does not apply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160413/c060ba16/attachment.asc>
