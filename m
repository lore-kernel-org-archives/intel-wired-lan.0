From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:45:16 +0000
Subject: [Intel-wired-lan] [next PATCH S8 03/12] i40e:
 check_recovery_mode had wrong if statement
In-Reply-To: <20190723100144.57435-3-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CE78@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Podlawski, Adrian <adrian.podlawski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 03/12] i40e: check_recovery_mode
> had wrong if statement
> 
> From: Adrian Podlawski <adrian.podlawski@intel.com>
> 
> Function check_recovery_mode had wrong if statement.
> Now we check proper FWS1B register values, which are responsible for the
> recovery mode. Recovery mode has 4 values for FVL and 2 for FPK.
> That's why we need 6 different flags which are defined in shared code.
> Now in if statement we recognize type of mac address and register value.
> Without those changes driver could show wrong state.
> 
> Signed-off-by: Adrian Podlawski <adrian.podlawski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 17 ++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_register.h |  6 ++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


