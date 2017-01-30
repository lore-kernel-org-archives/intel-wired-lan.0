From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Jan 2017 21:39:16 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Invoke softirqs
	after	napi_reschedule
In-Reply-To: <20170113010414.22708-1-bpoirier@suse.com>
References: <20170113010414.22708-1-bpoirier@suse.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D522@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Thursday, January 12, 2017 5:04 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Invoke softirqs after
> napi_reschedule
> 
> The following message is logged from time to time when using i40e:
> NOHZ: local_softirq_pending 08
> 
> i40e may schedule napi from a workqueue. Afterwards, softirqs are not run
> in a deterministic time frame. The problem is the same as what was
> described in commit ec13ee80145c ("virtio_net: invoke softirqs after
> __napi_schedule") and this patch applies the same fix to i40e.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


