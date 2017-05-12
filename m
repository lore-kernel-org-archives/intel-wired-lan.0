From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 18:01:57 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 13/14] i40evf: Add support
 for	Adaptive Virtual Function
In-Reply-To: <20170511182321.147850-14-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-14-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA327F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, May 11, 2017 11:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 13/14] i40evf: Add support for
> Adaptive Virtual Function
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Add device ID define and mac_type assignment needed for Adaptive Virtual
> Function (VF Base Mode Support).
> 
> Also, update version to v3.0.0 in order to indicate clearly that this is the first
> driver supporting the AVF device ID.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> v2: added Kconfig
> ---
>  drivers/net/ethernet/intel/Kconfig              | 10 ++++++----
>  drivers/net/ethernet/intel/i40evf/i40e_common.c |  1 +
> drivers/net/ethernet/intel/i40evf/i40e_devids.h |  1 +
> drivers/net/ethernet/intel/i40evf/i40evf_main.c |  7 ++++---
>  4 files changed, 12 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


