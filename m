From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 9 Jan 2016 03:00:40 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: Increase PHY PLL clock
 gate timing
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4BF4A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Raanan Avargil [raanan.avargil at intel.com]
> Sent: Tuesday, December 22, 2015 5:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: Increase PHY PLL clock gate      timing
> 
> Several packet loss issues were reported for which the root cause for
> them was an incorrect configuration of internal HW Phy clock gating
> mechanism by SW.
> This patch provides the correct mechanism.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 ++++++++++++
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
>  2 files changed, 15 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
