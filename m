From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Aug 2018 19:17:46 +0000
Subject: [Intel-wired-lan] [next PATCH S95 03/12] i40e: move ethtool
 stats boiler plate code to i40e_ethtool_stats.h
In-Reply-To: <20180820151233.14629-3-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E966D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S95 03/12] i40e: move ethtool stats
> boiler plate code to i40e_ethtool_stats.h
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Move the boiler plate structures and helper functions we recently added into
> their own header file, so that the complete collection is located together.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 182 +----------------
>  .../net/ethernet/intel/i40e/i40e_ethtool_stats.h   | 221
> +++++++++++++++++++++
>  2 files changed, 222 insertions(+), 181 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


