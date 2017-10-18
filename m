From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Oct 2017 23:23:18 +0000
Subject: [Intel-wired-lan] [PATCH 51/58] ethernet/intel: Convert timers
 to	use timer_setup()
In-Reply-To: <1508200182-104605-52-git-send-email-keescook@chromium.org>
References: <1508200182-104605-1-git-send-email-keescook@chromium.org>
 <1508200182-104605-52-git-send-email-keescook@chromium.org>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EACF7E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kees Cook
> Sent: Monday, October 16, 2017 5:30 PM
> To: David S. Miller <davem@davemloft.net>
> Cc: Kees Cook <keescook@chromium.org>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Thomas Gleixner
> <tglx@linutronix.de>
> Subject: [Intel-wired-lan] [PATCH 51/58] ethernet/intel: Convert timers to
> use timer_setup()
> 
> In preparation for unconditionally passing the struct timer_list pointer to all
> timer callbacks, switch to using the new timer_setup() and from_timer() to
> pass the timer pointer explicitly. Switches test of .data field to .function,
> since .data will be going away.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/intel/e100.c                 |  6 +++---
>  drivers/net/ethernet/intel/e1000e/netdev.c        | 14 ++++++--------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c      |  8 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c       |  8 ++++----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c   |  8 ++++----
>  drivers/net/ethernet/intel/igb/igb_main.c         | 18 ++++++++----------
>  drivers/net/ethernet/intel/igbvf/netdev.c         |  7 +++----
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c       |  9 ++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  7 +++----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  8 ++++----
>  10 files changed, 43 insertions(+), 50 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


