From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 23:34:39 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V3 5/5] i40e: lock service
 task	correctly
In-Reply-To: <1479762231-27559-5-git-send-email-bimmy.pujari@intel.com>
References: <1479762231-27559-1-git-send-email-bimmy.pujari@intel.com>
 <1479762231-27559-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA385CD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 21, 2016 1:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S53-V3 5/5] i40e: lock service task
> correctly
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The service task lock was being set in the scheduling function, not the actual
> service task. This would potentially leave the bit set for a long time before
> the task actually ran. Furthermore, if the service task takes too long, it calls
> the schedule function to reschedule itself - which would fail to take the lock
> and do nothing.
> 
> Instead, set and clear the lock bit in the service task itself. In the process, get
> rid of the i40e_service_event_complete() function, which is really just two
> lines of code that can be put right in the service task itself.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I83155e682b686121e2897f4429eb7d3f7c669168
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


