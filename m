From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 21:16:13 +0000
Subject: [Intel-wired-lan] [next PATCH S89 6/8] i40e: hold the RTNL lock
 while changing interrupt schemes
In-Reply-To: <20180316082637.49915-6-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
 <20180316082637.49915-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CCC6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 16, 2018 1:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S89 6/8] i40e: hold the RTNL lock while
> changing interrupt schemes
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When we suspend and resume, we need to clear and re-enable the interrupt
> scheme. This was previously not done while holding the RTNL lock, which
> could be problematic, because we are actually destroying and re-creating
> queues.
> 
> Hold the RTNL lock for the entire sequence of preparing for reset, and when
> resuming. This additionally protects the flags related to interrupt scheme
> under RTNL lock so that their modification is properly threaded.
> 
> This is part of a larger effort to remove the need for cmpxchg64 in
> i40e_set_priv_flags().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


