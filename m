From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:41:33 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Memory leak in
 i40e_config_iwarp_qvlist
In-Reply-To: <20190418203153.37605-1-alice.michael@intel.com>
References: <20190418203153.37605-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C71E@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 18, 2019 1:32 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Szapar, Martyna <martyna.szapar@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Memory leak in
> i40e_config_iwarp_qvlist
> 
> From: Martyna Szapar <martyna.szapar@intel.com>
> 
> Added freeing the old allocation of vf->qvlist_info in function
> i40e_config_iwarp_qvlist before overwriting it with the new allocation.
> 
> Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


