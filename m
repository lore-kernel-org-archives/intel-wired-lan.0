From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:18:08 +0000
Subject: [Intel-wired-lan] [PATCH S20 14/15] ice: Add a helper to
 trigger software interrupt
In-Reply-To: <20190416173052.28928-15-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AD08@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 14/15] ice: Add a helper to trigger
> software interrupt
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add a new function ice_trigger_sw_intr to trigger interrupts.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 24 +++++++++++++++++------
> drivers/net/ethernet/intel/ice/ice_lib.h  |  2 ++
> drivers/net/ethernet/intel/ice/ice_main.c | 14 +++++--------
>  3 files changed, 25 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


