From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 23:42:09 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 05/10] i40e:
	separate	hw_features from runtime changing flags
In-Reply-To: <20170623082451.32671-5-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC08A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 05/10] i40e: separate
> hw_features from runtime changing flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The number of flags found in pf->flags has grown quite large, and there are a
> lot of different types of flags. Most of the flags are simply hardware features
> which are enabled on some firmware or some MAC types.
> Other flags are dynamic run-time flags which enable or disable certain
> features of the driver.
> 
> Separate these two types of flags into pf->hw_features and pf->flags.
> The hw_features list will contain a set of features which are enabled at init
> time. This will not contain toggles or otherwise dynamically changing
> features. These flags should not need atomic protections, as they will be set
> once during init and then be essentially read only.
> 
> Everything else will remain in the flags variable. These flags may be modified
> at any time during run time. A future patch may wish to convert these flags
> into set_bit/clear_bit/test_bit or similar approach to ensure atomic
> correctness.
> 
> The I40E_FLAG_MFP_ENABLED flag may be a good fit for hw_features but
> currently is used by ethtool in the private flags settings, and thus has been
> left as part of flags.
> 
> Additionally, I40E_FLAG_DCB_CAPABLE may be a good fit for the
> hw_features but this patch has not tried to untangle it yet.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             | 43 +++++++------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 34 +++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 72 +++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  6 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 +--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  4 --
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  2 -
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  2 +-
>  9 files changed, 85 insertions(+), 88 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


