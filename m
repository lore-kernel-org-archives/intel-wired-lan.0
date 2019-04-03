From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:59:38 +0000
Subject: [Intel-wired-lan] [next PATCH S4 10/11] i40e: missing input
 validation on VF message handling by the PF
In-Reply-To: <20190329220840.51187-10-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D37881F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Szapar, Martyna <martyna.szapar@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 10/11] i40e: missing input validation
> on VF message handling by the PF
> 
> From: Martyna Szapar <martyna.szapar@intel.com>
> 
> Patch is adding missing input validation on VF message handling by the PF to
> the functions with opcodes:
> 	VIRTCHNL_OP_CONFIG_VSI_QUEUES = 6
> 	VIRTCHNL_OP_CONFIG_IRQ_MAP = 7,
> 	VIRTCHNL_OP_DISABLE_QUEUES = 9,
> 	VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE = 14,
> 
> Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 58 ++++++++++++++-----
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
>  2 files changed, 46 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
