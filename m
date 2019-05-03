From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:31:31 +0000
Subject: [Intel-wired-lan] [next PATCH S5 01/10] i40e: let untrusted VF
 to create up to 16 VLANs
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C67F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 01/10] i40e: let untrusted VF to
> create up to 16 VLANs
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> This patch lets untrusted VF to create up to 16 VLANs.
> It was implemented by increasing I40E_VC_MAX_VLAN_PER_VF up to 16.
> Without this patch untrusted VF could create only up to 8 VLANs.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


