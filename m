From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:37:30 +0000
Subject: [Intel-wired-lan] [next PATCH S7 2/9] i40e: make visible
 changed vf mac on host
In-Reply-To: <20190702122259.79070-2-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD223@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S7 2/9] i40e: make visible changed vf
> mac on host
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This patch makes changed vm mac address visible on host via ip link show
> command. This problem is fixed by copying last unicast mac filter to vf-
> >default_lan_addr.addr. Without this patch if vf mac was not set from host
> side and if you run ip link show $pf, on host side you'd always see a zero mac,
> not the real vf mac that vf assigned to itself.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

