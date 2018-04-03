From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Apr 2018 18:52:13 +0000
Subject: [Intel-wired-lan] [PATCH v8 1/7] i40e/i40evf: Eliminate
 duplicate barriers on weakly-ordered archs
In-Reply-To: <1522695990-31082-2-git-send-email-okaya@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
 <1522695990-31082-2-git-send-email-okaya@codeaurora.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95A822@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v8 1/7] i40e/i40evf: Eliminate duplicate
> barriers on weakly-ordered archs
> 
> memory-barriers.txt has been updated as follows:
> 
> "When using writel(), a prior wmb() is not needed to guarantee that the
> cache coherent memory writes have completed before writing to the MMIO
> region."
> 
> Remove old IA-64 comments in the code along with unneeded wmb() in
> front of writel().
> 
> There are places in the code where wmb() has been used as a double barrier
> for CPU and IO in place of smp_wmb() and wmb() as an optimization. For
> such places, keep the wmb() but replace the following writel() with
> writel_relaxed() to have a sequence as
> 
> wmb()
> writel_relaxed()
> mmio_wb()
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 +++++++++-------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  8 +-------
>  2 files changed, 10 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


