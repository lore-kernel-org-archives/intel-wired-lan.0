From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Feb 2018 18:20:41 +0000
Subject: [Intel-wired-lan] [PATCH] i40e/i40evf: use SW variables for
 hang detection
In-Reply-To: <20180212141659.38064-1-alice.michael@intel.com>
References: <20180212141659.38064-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949EF6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 12, 2018 6:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e/i40evf: use SW variables for hang
> detection
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> The i40e_detect_recover_hung function uses the i40e_get_tx_pending
> function to determine if there are packets stalled on the ring.
> i40e_get_tx_pending calculates the pending packets using the head
> writeback value and HW tail.  If the queue is stopped and we lose the
> interrupt to update our next_to_clean then we a) won't get another
> interrupt to clean because queue is stopped b) we won't catch the problem
> with i40e_detect_recover_hung because the HW values look like there's no
> packets waiting to be transmitted.  Using the SW values we can catch the
> issue because next_to_clean will be out of sync with head writeback.
> 
> This has the added benefit being less CPU intensive because we don't need
> to reach into the hardware to get the values.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 16 +++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  2 +-
>  3 files changed, 13 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


