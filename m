From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 22:25:12 +0000
Subject: [Intel-wired-lan] [PATCH v4 5/5] igb: call igb_ptp_suspend
 during	suspend/resume cycle
In-Reply-To: <20160524205631.21225-5-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
 <20160524205631.21225-5-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F108C1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, May 24, 2016 1:57 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4 5/5] igb: call igb_ptp_suspend during
> suspend/resume cycle
> 
> Properly stop the extra workqueue items and ensure that we resume
> cleanly. This is better than using igb_ptp_init and igb_ptp_stop since
> these functions destroy the PHC device, which will cause other problems
> if we do so. Since igb_ptp_reset now re-schedules the work-queue item we
> don't need an equivalent igb_ptp_resume in the resume workflow.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
