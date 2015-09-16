From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Sep 2015 17:46:54 +0000
Subject: [Intel-wired-lan] [next PATCH S13 07/15] i40evf: detect reset
 more	reliably
In-Reply-To: <1440798961-17326-8-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6D21@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 07/15] i40evf: detect reset more
> reliably
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Using VFGEN_RSTAT to detect a VF reset is an endeavor that is fraught with
> peril. It's entirely too easy to miss a reset because none of the bits are sticky.
> By the time the VF driver reads the register, the reset may have been
> processed and cleaned up by the PF driver, leaving the register in the same
> state that it was before the reset.
> 
> Instead, detect a reset with the VF_ARQLEN register. When the VF is reset,
> the enable bit in this register is cleared, and it stays cleared until the VF driver
> processes the reset and re-enables the admin queue.
> 
> Because we now deal with multiple registers in the reset and watchdog
> tasks, rename the rstat_val variable to reg_val.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Id1df17045c0992e607da0162d31807f7fc20d199
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 36 +++++++++++----------
> ----
>  1 file changed, 16 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree.
