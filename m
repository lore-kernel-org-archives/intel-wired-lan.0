From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 9 Jan 2016 03:01:26 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: Set HW FIFO minimum
 pointer gap for non-gig speeds
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4BF5D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Raanan Avargil [raanan.avargil at intel.com]
> Sent: Tuesday, December 22, 2015 5:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: Set HW FIFO minimum pointer      gap for non-gig speeds
> 
> Based on feedback from HW team, the configured value of the internal Phy
> HW FIFO pointer gap was incorrect for non-gig speeds.
> This patch provides the correct configuration.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
