From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Oct 2017 19:05:38 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 5/9] i40evf: hold the
 critical	task bit lock while opening
In-Reply-To: <20171027150656.68250-5-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADD50@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 5/9] i40evf: hold the critical
> task bit lock while opening
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> If i40evf_open() is called quickly at the same time as a reset occurs (such as
> via ethtool) it is possible for the device to attempt to open while a reset is in
> progress. This occurs because the driver was not holding the critical task bit
> lock during i40evf_open, nor was it holding it around the call to
> i40evf_up_complete() in i40evf_reset_task().
> 
> We didn't hold the lock previously because calls to i40evf_down() would take
> the bit lock directly, and this would have caused a deadlock.
> 
> To avoid this, we'll move the bit lock handling out of i40evf_down() and into
> the callers of this function. Additionally, we'll now hold the bit lock over the
> entire set of steps when going up or down, to ensure that we remain
> consistent.
> 
> Ultimately this causes us to serialize the transitions between down and up
> properly, and avoid changing status while we're resetting.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 40
> +++++++++++++++++++------
>  1 file changed, 31 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


