From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:44:14 +0000
Subject: [Intel-wired-lan] [PATCH v3 3/3] i40e: Add UDP segmentation
 offload support
In-Reply-To: <1570812820-20052-4-git-send-email-johunt@akamai.com>
References: <1570812820-20052-1-git-send-email-johunt@akamai.com>
 <1570812820-20052-4-git-send-email-johunt@akamai.com>
Message-ID: <5a780256fa3047c88f2ea9cb7c14c3eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Josh Hunt
> Sent: Friday, October 11, 2019 9:54 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>;
> willemb at google.com; Josh Hunt <johunt@akamai.com>;
> alexander.h.duyck at linux.intel.com
> Subject: [Intel-wired-lan] [PATCH v3 3/3] i40e: Add UDP segmentation
> offload support
> 
> Based on a series from Alexander Duyck this change adds UDP segmentation
> offload support to the i40e driver.
> 
> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> CC: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


