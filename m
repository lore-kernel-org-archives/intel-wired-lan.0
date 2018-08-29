From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 20:53:46 +0000
Subject: [Intel-wired-lan] [next PATCH S95 07/12] i40e: Unset
 promiscuous settings on VF reset
In-Reply-To: <20180820151233.14629-7-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB306@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 07/12] i40e: Unset promiscuous
> settings on VF reset
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch cleans up promiscuous configuration when a VF reset occurs.
> Previously the promiscuous mode settings were still there after the VF driver
> removal.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 267 ++++++++++++-----
> ----
>  1 file changed, 157 insertions(+), 110 deletions(-)> 

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


