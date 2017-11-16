From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:18:40 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 1/9] i40evf: Do not clear
 MSI-X PBA manually
In-Reply-To: <20171114120052.86665-1-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEE96@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S82-V4 1/9] i40evf: Do not clear MSI-X
> PBA manually
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We should not be clearing the pending bit array for each vector manually.
> The documentation for the hardware states that when in MSI-X mode the
> pending bit array wil be cleared automatically. Us clearing it ourselves just
> results in multiple opportunities for us to drop an interrupt.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


