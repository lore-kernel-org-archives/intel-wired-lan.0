From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:53:27 +0000
Subject: [Intel-wired-lan] [next PATCH S8 10/12] i40e: allow reset in
 recovery mode
In-Reply-To: <20190723100144.57435-10-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CEE8@ORSMSX104.amr.corp.intel.com>
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
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 10/12] i40e: allow reset in recovery
> mode
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Driver waits after issuing a reset. When a reset takes too long a driver gives
> up. Implemented by invoking PF reset in a loop. After defined number of
> unsuccessful PF reset trials it returns error.
> Without this patch PF reset fails when NIC is in recovery mode.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 67 ++++++++++++++++++---
>  1 file changed, 60 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


