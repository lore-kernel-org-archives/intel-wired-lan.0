From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:14:15 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Increase timeout of polling
 bit	RSPCIPHY
In-Reply-To: <1444913989-10607-1-git-send-email-raanan.avargil@intel.com>
References: <1444913989-10607-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F0C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Raanan Avargil [raanan.avargil at intel.com]
> Sent: Thursday, October 15, 2015 5:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: Increase timeout of polling bit      RSPCIPHY
> 
> Due to timing changes to the ME firmware in Skylake, this timer
> needs to be increased to 300ms.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
