From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:10 +0000
Subject: [Intel-wired-lan] [PATCH S37 11/15] ice: Use ice_pf_to_dev
In-Reply-To: <20200122152041.41498-11-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-11-anthony.l.nguyen@intel.com>
Message-ID: <3168c6b525704343b84272b0bf0f54f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 11/15] ice: Use ice_pf_to_dev
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


