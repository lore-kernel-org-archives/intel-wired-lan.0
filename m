From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:41:59 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 4/9] i40evf: Don't
 schedule reset_task when device is being removed
In-Reply-To: <20171218101643.75775-1-alice.michael@intel.com>
References: <20171218101643.75775-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB21@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S83-V5 4/9] i40evf: Don't schedule
> reset_task when device is being removed
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> When a host disables and enables a PF device, all the associated VFs are
> removed and added back in. It also generates a PFR which in turn resets all
> the connected VFs. This behaviour is different from that of Linux guest on
> Linux host. Hence we end up in a situation where there's a PFR and device
> removal at the same time. And watchdog doesn't have a clue about this and
> schedules a reset_task. This patch adds code to send signal to reset_task that
> the device is currently being removed.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


