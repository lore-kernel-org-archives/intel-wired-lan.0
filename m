From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jan 2018 19:04:13 +0000
Subject: [Intel-wired-lan] [PATCH v2 next-queue 12/12] i40e: Add and
 delete cloud filter
In-Reply-To: <20180117161607.49344-13-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
 <20180117161607.49344-13-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A935BD7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, January 17, 2018 8:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 next-queue 12/12] i40e: Add and delete
> cloud filter
> 
> This patch provides support to add or delete cloud filter for queue channels
> created for ADq on VF.
> We are using the HW's cloud filter feature and programming it to act as a TC
> filter applied to a group of queues.
> 
> There are two possible modes for a VF when applying a cloud filter
> 1. Basic Mode:	Intended to apply filters that don't need a VF to be
> 		Trusted. This would include the following
> 		  Dest MAC + L4 port
> 		  Dest MAC + VLAN + L4 port
> 2. Advanced Mode: This mode is only for filters with combination that
> 		  requires VF to be Trusted.
> 		  Dest IP + L4 port
> 
> When cloud filters are applied on a Trusted VF and for some reason the same
> VF is later made as unTrusted then all cloud filters will be deleted. All cloud
> filters has to be re-applied in such a case.
> Cloud filters are also deleted when queue channel is deleted.
> 
> Testing-Hints:
> =============
> 1. Adding Basic Mode filter should be possible on a VF in
> 	Non-Trusted mode.
> 2. In Advanced mode all filters should be able to be created.
> 
> Steps:
> ======
> 1. Enable ADq and create TCs using TC mqprio command 2. Apply cloud filter.
> 3. Turn-off the spoof check.
> 4. Pass traffic.
> 
> Example:
> ========
> 1. tc qdisc add dev enp4s2 root mqprio num_tc 4 map 0 0 0 0 1 2 2 3\
> 	queues 2 at 0 2 at 2 1 at 4 1 at 5 hw 1 mode channel 2. tc qdisc add dev
> enp4s2 ingress 3. ethtool -K enp4s2 hw-tc-offload on 4. ip link set ens261f0 vf
> 0 spoofchk off 5. tc filter add dev enp4s2 protocol ip parent ffff: prio 1
> flower\
> 	dst_ip 192.168.3.5/32 ip_proto udp dst_port 25 skip_sw hw_tc 2
> 
> v2: made i40e_find_vsi_from_seid and i40e_del_all_cloud_filters functions
>     as static.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   6 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  16 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 458
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   2 +
>  4 files changed, 470 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


