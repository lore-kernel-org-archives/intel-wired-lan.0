From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Apr 2018 18:51:06 +0000
Subject: [Intel-wired-lan] [PATCH v8 6/7] ixgbevf: keep writel() closer
 to wmb()
In-Reply-To: <1522695990-31082-7-git-send-email-okaya@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
 <1522695990-31082-7-git-send-email-okaya@codeaurora.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95A803@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sinan Kaya
> Sent: Monday, April 2, 2018 12:06 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: sulrich at codeaurora.org; netdev at vger.kernel.org;
> timur at codeaurora.org; linux-kernel at vger.kernel.org; Sinan Kaya
> <okaya@codeaurora.org>; intel-wired-lan at lists.osuosl.org; linux-arm-
> msm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: [Intel-wired-lan] [PATCH v8 6/7] ixgbevf: keep writel() closer to
> wmb()
> 
> Remove ixgbevf_write_tail() in favor of moving writel() close to wmb().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
>  2 files changed, 3 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


