From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Jul 2017 18:16:08 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 07/11] i40e: Use correct
 flag	to enable egress traffic for unicast promisc
In-Reply-To: <20170712094614.76501-7-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1E3E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S75-V3 07/11] i40e: Use correct flag to
> enable egress traffic for unicast promisc
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Albeit, we usually set true promiscuous mode for both multicast and unicast
> at the same time - however, it is possible to set it individually, so using
> allmulti flag which is only for allmulticast might caused unwanted behavior in
> mirroring egress traffic promiscuous for unicast in VF.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


