From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 16:39:35 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 14/15] i40e: replace PTP
 Rx	timestamp hang logic
In-Reply-To: <1475685046-16900-15-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-15-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC10@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 14/15] i40e: replace PTP Rx
> timestamp hang logic
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The current Rx timestamp hang logic is not very robust because it does not
> notice a register is hung until all four timestamps have been latched and we
> wait a full 5 seconds. Replace this logic with a newer Rx hang detection based
> on storing the jiffies when we first notice a receive timestamp event. We
> store each register's time separately, along with a flag indicating if it is
> currently latched. Upon first transitioning to latch, we will update the
> latch_events[i] jiffies value. This indicates the time we first noticed this
> event. The watchdog routine will simply check that the either the flag has
> been cleared, or we have passed at least one second. In this case, it is able to
> clear the Rx timestamp register under the assumption that it was for a
> dropped frame. The benefit if this strategy is that we should be able to
> detect and clear out stalled RXTIME_H registers before we exhaust the
> supply of 4, and avoid complete stall of Rx timestamp events.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Id55458c0cd7a5dd0c951ff2b8ac0b2509364131f
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 117 +++++++++++++++++++--
> -------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   2 -
>  4 files changed, 83 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


