From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 18:08:02 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 07/13] i40e/i40evf:
	avoid	dynamic ITR updates when polling or low packet rate
In-Reply-To: <20170714131019.52530-7-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB25CE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 07/13] i40e/i40evf: avoid
> dynamic ITR updates when polling or low packet rate
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The dynamic ITR algorithm depends on a calculation of usecs which assumes
> that the interrupts have been firing constantly at the interrupt throttle rate.
> This is not guaranteed because we could have a low packet rate, or have
> been polling in software.
> 
> We'll estimate whether this is the case by using jiffies to determine if we've
> been too long. If the time difference of jiffies is larger we are guaranteed to
> have an incorrect calculation. If the time difference of jiffies is smaller we
> might have been polling some but the difference shouldn't affect the
> calculation too much.
> 
> This ensures that we don't get stuck in BULK latency during certain rare
> situations where we receive bursts of packets that force us into napi polling.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 +++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 22 +++++++++++++++++----
> -  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 +
>  4 files changed, 36 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


