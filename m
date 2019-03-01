From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:58:42 +0000
Subject: [Intel-wired-lan] [next S2-v3 04/12] i40e: save PTP time before
 a device reset
In-Reply-To: <20190212215624.10049-1-jeffrey.t.kirsher@intel.com>
References: <20190212215624.10049-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36768B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, February 12, 2019 1:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S2-v3 04/12] i40e: save PTP time before a
> device reset
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In the case where PTP is running on the hardware clock, but the kernel
> system time is not being synced, a device reset can mess up the clock time.
> 
> This occurs because we reset the clock time based on the kernel time every
> reset. This causes us to potentially completely reset the PTP time, and can
> cause unexpected behavior in programs like ptp4l.
> 
> Avoid this by saving the PTP time prior to device reset, and then restoring
> using that time after the reset.
> 
> Directly restoring the PTP time we saved isn't perfect, because time should
> have continued running, but the clock will essentially be stopped during the
> reset. This is still better than the current solution of assuming that the PTP
> HW clock is synced to the CLOCK_REALTIME.
> 
> We can do even better, by saving the ktime and calculating a differential,
> using ktime_get(). This is based on CLOCK_MONOTONIC, and allows us to get
> a fairly precise measure of the time difference between saving and restoring
> the time.
> 
> Using this, we can update the saved PTP time, and use that as the value to
> write to the hardware clock registers. This, of course is not perfect.
> However, it does help ensure that the PTP time is restored as close as
> feasible to the time it should have been if the reset had not occurred.
> 
> During device initialization, continue using the system time as the source for
> the creation of the PTP clock, since this is the best known current time source
> at driver load.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> v3: added fix to check to see if the PTP flag is enabled
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  5 ++
> drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 58 +++++++++++++++++++--
>  3 files changed, 63 insertions(+), 4 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


