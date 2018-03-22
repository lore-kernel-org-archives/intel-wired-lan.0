From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Mar 2018 18:51:37 +0000
Subject: [Intel-wired-lan] [PATCH REPOST v4 2/7] ixgbe: eliminate
 duplicate barriers on weakly-ordered archs
In-Reply-To: <1521658572-26354-3-git-send-email-okaya@codeaurora.org>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-3-git-send-email-okaya@codeaurora.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9567AB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sinan Kaya
> Sent: Wednesday, March 21, 2018 11:56 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: sulrich at codeaurora.org; netdev at vger.kernel.org;
> timur at codeaurora.org; linux-kernel at vger.kernel.org; Sinan Kaya
> <okaya@codeaurora.org>; intel-wired-lan at lists.osuosl.org; linux-arm-
> msm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: [Intel-wired-lan] [PATCH REPOST v4 2/7] ixgbe: eliminate duplicate
> barriers on weakly-ordered archs
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
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


