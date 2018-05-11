From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 May 2018 18:09:56 +0000
Subject: [Intel-wired-lan] [next PATCH S91 02/11] i40evf: Fix client
 header define
In-Reply-To: <20180510125949.79823-2-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
 <20180510125949.79823-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B7650BA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S91 02/11] i40evf: Fix client header
> define
> 
> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Fix up the VF client header define, since it is the same as the PF client
> header.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_client.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


