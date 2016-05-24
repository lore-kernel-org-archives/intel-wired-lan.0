From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 May 2016 16:05:34 +0000
Subject: [Intel-wired-lan] [PATCH] [v1,
 next-queue] net: ixgbe: Error handler for duplicate filter
 locations in hardware for cls_u32 offloads
In-Reply-To: <20160517013320.2902.71585.stgit@terminator23.jf.intel.com>
References: <20160517013320.2902.71585.stgit@terminator23.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D703E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Monday, May 16, 2016 6:33 PM
> To: Fastabend, John R <john.r.fastabend@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>; Nambiar, Amritha
> <amritha.nambiar@intel.com>
> Subject: [Intel-wired-lan] [PATCH] [v1, next-queue] net: ixgbe: Error handler
> for duplicate filter locations in hardware for cls_u32 offloads
> 
> For u32 classifier filters, avoid overwriting existing filter in a hardware location
> without removing it first, to clean up inconsistencies due to duplicate values
> for filter location.
> 
> Verified with the following filters:
> 
> # tc qdisc add dev enp5s0f1 ingress
> # ethtool -K enp5s0f1 hw-tc-offload on
> 
> Create child hash tables:
> # tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
> 	handle 1: u32 divisor 1
> # tc filter add dev enp5s0f1 parent ffff: protocol ip prio 99 \
> 	handle 2: u32 divisor 1
> 
> Link to the child hash table from parent hash table:
> # tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
> 	handle 800:0:11 u32 ht 800: link 1: \
> 	offset at 0 mask 0f00 shift 6 plus 0 eat \
> 	match ip protocol 6 ff match ip dst 15.0.0.1/32
> 
> # tc filter add dev enp5s0f1 protocol ip parent ffff: prio 99 \
> 	handle 800:0:12 u32 ht 800: link 2: \
> 	offset at 0 mask 0f00 shift 6 plus 0 eat \
> 	match ip protocol 17 ff match ip dst 16.0.0.1/32
> 
> Add filter into child hash table:
> # tc filter add dev enp5s0f1 parent ffff: protocol ip \
> 	handle 1:0:3 u32 ht 1: \
> 	match tcp src 22 ffff action drop
> 
> Add another filter to the same location:
> # tc filter add dev enp5s0f1 parent ffff: protocol ip \
> 	handle 2:0:3 u32 ht 2: \
> 	match tcp src 33 ffff action drop
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   41 +++++++++++++++----
> ------
>  1 file changed, 25 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Unable to add filter in duplicate location without removing first, get error as expected.
