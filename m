From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 25 Oct 2019 03:26:50 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/3] igb: Add UDP segmentation
 offload support
In-Reply-To: <1570812820-20052-2-git-send-email-johunt@akamai.com>
References: <1570812820-20052-1-git-send-email-johunt@akamai.com>
 <1570812820-20052-2-git-send-email-johunt@akamai.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971565B0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Josh Hunt <johunt@akamai.com>
> Sent: Friday, October 11, 2019 9:54 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: willemb at google.com; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Brown, Aaron F
> <aaron.f.brown@intel.com>; alexander.h.duyck at linux.intel.com; Josh Hunt
> <johunt@akamai.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Subject: [PATCH v3 1/3] igb: Add UDP segmentation offload support
> 
> Based on a series from Alexander Duyck this change adds UDP segmentation
> offload support to the igb driver.
> 
> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> CC: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.h |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c    | 23 +++++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

