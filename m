From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 9 Jan 2016 03:02:19 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: Clear ULP
	configuration	register on ULP exit
In-Reply-To: <1450791305-11285-4-git-send-email-raanan.avargil@intel.com>
References: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>,
 <1450791305-11285-4-git-send-email-raanan.avargil@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4BF6C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Raanan Avargil [raanan.avargil at intel.com]
> Sent: Tuesday, December 22, 2015 5:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: Clear ULP configuration  register on ULP exit
> 
> There have been bugs caused by HW ULP configuration settings not being
> properly cleared after cable connect in V-Pro capable systems.
> This caused HW to get out of sync occasionally.
> The fix ensures that ULP settings are cleared in HW after
> LAN cable re-connect.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
>  drivers/net/ethernet/intel/e1000e/ich8lan.h | 4 ++++
>  2 files changed, 6 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
