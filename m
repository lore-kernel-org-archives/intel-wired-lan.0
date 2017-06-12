From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 18:18:44 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 13/13] i40e: don't hold
 RTNL	lock for the entire reset
In-Reply-To: <20170607094313.32060-13-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-13-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAB8A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S72-V3 13/13] i40e: don't hold RTNL
> lock for the entire reset
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We recently refactored i40e_do_reset() and its friends to be able to hold the
> RTNL lock only for the portions that actually need to be protected. However,
> a separate refactoring added several new callers of these functions during
> the PCIe error recovery and suspend/resume cycles.
> 
> When merging the changes together, it was not noticed that we could
> reduce the RTNL scope by letting the reset function handle the lock itself, as
> previously it was not possible.
> 
> Fix this by replacing these call sites to indicate that the reset function should
> handle its own lock. This enables multiple PFs to reset or resume
> simultaneously without serializing the resets via the RTNL lock. The end result
> is that on systems with lots of PFs and VFs the resets don't stall waiting for
> each other to finish.
> 
> It is probable that we can also do the same for i40e_do_reset_safe, but this
> author did not research that change carefully enough to be confident.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


