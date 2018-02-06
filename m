From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:36:23 +0000
Subject: [Intel-wired-lan] [next PATCH S86 V3 6/8] i40e: i40e: Change
 ethtool check from MAC to HW flag
In-Reply-To: <20180205111121.59468-6-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
 <20180205111121.59468-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949961@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 5, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86 V3 6/8] i40e: i40e: Change ethtool
> check from MAC to HW flag
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The MAC, FW Version and NPAR check used to determine if shutting off the
> FW LLDP engine is supported is not using the usual feature check mechanism.
> 
> This patch fixes the problem by moving the feature check to i40e_sw_init in
> order to set a flag in pf->hw_features that ethtool will use for priv_flags
> disable operation.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++----------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++++++++
>  3 files changed, 13 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


