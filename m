From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 23:21:20 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 04/10] i40e: Fix a bug
 with	VMDq RSS queue allocation
In-Reply-To: <20170623082451.32671-4-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC06E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S74-V2 04/10] i40e: Fix a bug with
> VMDq RSS queue allocation
> 
> The X722 pf flag setup should happen before the VMDq RSS queue count is
> initialized for VMDq VSI to get the right number of queues for RSS in case of
> X722 devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 46 ++++++++++++++----------
> -----
>  1 file changed, 23 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


