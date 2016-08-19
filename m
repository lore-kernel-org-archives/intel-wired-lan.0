From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 16:03:58 +0000
Subject: [Intel-wired-lan] [dev-queue PATCH v2 2/3] i40e: Enable VF
 specific	ethtool statistics via VF Port representor netdevs.
In-Reply-To: <1471542901-13405-3-git-send-email-sridhar.samudrala@intel.com>
References: <1471542901-13405-1-git-send-email-sridhar.samudrala@intel.com>
 <1471542901-13405-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9348@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, August 18, 2016 10:55 AM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> <anjali.singhai@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>; Nambiar, Amritha
> <amritha.nambiar@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] [dev-queue PATCH v2 2/3] i40e: Enable VF specific
> ethtool statistics via VF Port representor netdevs.
> 
> Sample script that shows ethtool stats on VF representor netdev
> PF: enp5s0f0, VF0: enp5s2  VF_REP0: enp5s0f0-vf0
> 
>    # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
>    # ip link set enp5s2 up
>    # ethtool -S enp5s0f0-vf0
>    NIC statistics:
>      rx_bytes: 0
>      rx_unicast: 0
>      rx_multicast: 0
>      rx_broadcast: 0
>      rx_discards: 0
>      rx_unknown_protocol: 0
>      tx_bytes: 140
>      tx_unicast: 0
>      tx_multicast: 2
>      tx_broadcast: 0
>      tx_discards: 0
>      tx_errors: 0
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 67
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  1 +
>  3 files changed, 69 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Statistics on VF port representor work as expected


