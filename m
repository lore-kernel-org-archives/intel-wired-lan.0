From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Mar 2018 18:57:19 +0000
Subject: [Intel-wired-lan] [PATCH v5 2/2] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <1521733352-25266-2-git-send-email-okaya@codeaurora.org>
References: <1521733352-25266-1-git-send-email-okaya@codeaurora.org>
 <1521733352-25266-2-git-send-email-okaya@codeaurora.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9579AB@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v5 2/2] ixgbevf: eliminate duplicate barriers
> on weakly-ordered archs
> 
> Code includes wmb() followed by writel() in multiple places. writel() already
> has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


