From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 22:08:59 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 5/9] i40evf: Drop packet
 split	receive routine
In-Reply-To: <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2386@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 5/9] i40evf: Drop packet split
> receive routine
> 
> As part of preparation for the rx-refactor, remove the packet split receive
> routine and ancillary code.
> 
> Some of the split related context set up code stays in i40e_virtchnl_pf.c in
> case an older VF driver tries to load and still wants to use packet split.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 21 +---------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  7 ------
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  2 --
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 14 -----------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 28 +---------------------
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  4 ----
>  7 files changed, 3 insertions(+), 75 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tested with previous patch
