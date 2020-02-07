From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:34:43 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 11/15] ice: Use ice_pf_to_dev
In-Reply-To: <20200206092013.23388-11-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-11-anthony.l.nguyen@intel.com>
Message-ID: <30676660a9f747029e0d482132dcf256@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 11/15] ice: Use ice_pf_to_dev
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Use ice_pf_to_dev(pf) instead of &pf->pdev->dev Use ice_pf_to_dev(vsi-
> >back) instead of &vsi->back->pdev->dev When a pointer to the pf instance
> is available, use ice_pf_to_dev instead of ice_hw_to_dev
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c        | 12 ++++++------
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 14 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_main.c        | 16 ++++++++--------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  8 ++++----
>  6 files changed, 27 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


