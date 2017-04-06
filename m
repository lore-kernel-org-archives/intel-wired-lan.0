From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:39:40 +0000
Subject: [Intel-wired-lan] [next S66 v2 04/11] i40e:
	Simplify	i40e_detect_recover_hung_queue logic
In-Reply-To: <20170405115103.67374-4-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B13B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 04/11] i40e: Simplify
> i40e_detect_recover_hung_queue logic
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> This patch greatly reduces the unneeded complexity in the
> i40e_detect_recover_hung_queue code path.  The previous implementation
> set a 'hung bit' which would then get cleared while polling.  If the detection
> routine was called a second time with the bit already set, we would issue a
> software interrupt.  This patch makes it such that if interrupts are disabled
> and we have pending TX descriptors, we trigger a software interrupt since in,
> the worst case, queues are already clean and we have an extra interrupt.
> 
> Additionally this patch removes the workaround for lost interrupts as calling
> napi_reschedule in this context can cause software interrupts to fire on the
> wrong CPU.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Iae108582a3ceb6229ed1d22e4ed6e69cf97aad8d
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  4 --
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 59 +++++---------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 12 ++----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +-
>  5 files changed, 15 insertions(+), 64 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


