From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Mar 2018 18:56:48 +0000
Subject: [Intel-wired-lan] [PATCH v5 1/2] ixgbevf: keep writel() closer
 to wmb()
In-Reply-To: <1521733352-25266-1-git-send-email-okaya@codeaurora.org>
References: <1521733352-25266-1-git-send-email-okaya@codeaurora.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95799B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sinan Kaya
> Sent: Thursday, March 22, 2018 8:43 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: sulrich at codeaurora.org; netdev at vger.kernel.org;
> timur at codeaurora.org; linux-kernel at vger.kernel.org; Sinan Kaya
> <okaya@codeaurora.org>; intel-wired-lan at lists.osuosl.org; linux-arm-
> msm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: [Intel-wired-lan] [PATCH v5 1/2] ixgbevf: keep writel() closer to
> wmb()
> 
> Remove ixgbevf_write_tail() in favor of moving writel() close to wmb().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
>  2 files changed, 3 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


