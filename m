From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Feb 2019 23:51:24 +0000
Subject: [Intel-wired-lan] [PATCH S12 07/14] ice: use ice_for_each_vsi
 macro when possible
In-Reply-To: <20190208205101.12078-8-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366AF4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 07/14] ice: use ice_for_each_vsi macro
> when possible
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Replace all instances of:
> 	for (i = 0; i < pf->num_alloc_vsi; i++)
> 
> with the following macro:
> 	ice_for_each_vsi(pf, i)
> 
> This will allow the code to be consistent since there are currently cases of
> using both.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     |  3 +--
>  drivers/net/ethernet/intel/ice/ice_main.c        | 12 ++++++------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


