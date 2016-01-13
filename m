From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 13 Jan 2016 01:58:53 +0000
Subject: [Intel-wired-lan] [PATCH] igb: When GbE link up,
 wait for Remote receiver status condition.
In-Reply-To: <1451541494-64693-1-git-send-email-t.ueba11@gmail.com>
References: <1451541494-64693-1-git-send-email-t.ueba11@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4DBB9@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Takuma Ueba [t.ueba11 at gmail.com]
> Sent: Wednesday, December 30, 2015 9:58 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Takuma Ueba
> Subject: [Intel-wired-lan] [PATCH] igb: When GbE link up,       wait for Remote receiver status condition.
> 
> I210 device IPv6 autoconf test sometimes fails,
> because DAD NS for link-local is not transmitted.
> This packet is silently dropped.
> This problem is seen only GbE environment.
> 
> igb_watchdog_task link up detection continues to the following process.
> The following cases are observed:
> 1.PHY 1000BASE-T Status Register Remote receiver status bit is NG.
> (NG status becomes OK after about 200 - 700ms)
> 2.In this case, the transfer packet is silently dropped.
> 
> 1000BASE-T Status register
> [Expected]: 0x3800 or 0x7800
> [problem occurred]: 0x2800 or 0x6800
> Frequency of occurrence: approx 1/10 - 1/40 observed
> 
> In order to avoid this problem,
> wait until 1000BASE-T Status register "Remote receiver status OK"
> 
> After applying this patch, at least 400 runs succeed with no problems.
> 
> Signed-off-by: Takuma Ueba <t.ueba11@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
