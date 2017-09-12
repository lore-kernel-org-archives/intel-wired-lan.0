From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 22:15:35 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 10/11] i40e: Retry
	AQC	GetPhyAbilities to overcome I2CRead hangs
In-Reply-To: <20170907120556.45699-10-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA141@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 10/11] i40e: Retry AQC
> GetPhyAbilities to overcome I2CRead hangs
> 
> From: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
> 
> - When the I2C is busy, the PHY reads are delayed.  The firmware will
>   return EGAIN in these cases with an expectation that the SW will
>   trigger the reads again
> - This patch retries the operation for a maximum period of 500ms
> 
> Signed-off-by: Jayaprakash Shanmugam
> <jayaprakash.shanmugam@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 42
> ++++++++++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  3 ++
>  3 files changed, 35 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


