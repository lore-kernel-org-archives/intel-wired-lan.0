From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:11:59 +0000
Subject: [Intel-wired-lan] [next PATCH S91 06/11] i40e: Fix
 recalculation of MSI-X vectors for VMDq
In-Reply-To: <20180510125949.79823-6-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B7650FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 10, 2018 6:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S91 06/11] i40e: Fix recalculation of
> MSI-X vectors for VMDq
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> This patch adds a recalculation of number of MSI-X vectors for VMDq in the
> case where we have less vectors available than we would want to reserve for
> VMDq.
> 
> It fixes the issue where we recalculate vectors left and vectors wanted but
> we didn't take into account the reduced number of queue pairs per VSI.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


