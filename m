From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:32:52 +0000
Subject: [Intel-wired-lan] [next PATCH S70 11/12] i40e: properly
	spell	I40E_VF_STATE_* flags
In-Reply-To: <20170413084555.6962-11-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BF29@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 11/12] i40e: properly spell
> I40E_VF_STATE_* flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> These flags represent the state of the VF at various times. Do not spell them
> as _STAT_ which can be confusing to readers who may think these refer to
> statistics.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I6bc092cd472e8276896a1fd7498aced2084312df
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 98 +++++++++++--------
> ---  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 14 ++--
>  4 files changed, 58 insertions(+), 58 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


