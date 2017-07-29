From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 29 Jul 2017 00:01:48 +0000
Subject: [Intel-wired-lan] [PATCH] igbvf: convert msleep to mdelay in
 atomic	context
In-Reply-To: <20170720161514.9729-1-gedwards@ddn.com>
References: <20170720161514.9729-1-gedwards@ddn.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C664721@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Greg Edwards
> Sent: Thursday, July 20, 2017 9:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Greg Edwards <gedwards@ddn.com>
> Subject: [Intel-wired-lan] [PATCH] igbvf: convert msleep to mdelay in atomic
> context
> 
> This fixes a "scheduling while atomic" splat seen with
> CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
>  drivers/net/ethernet/intel/igbvf/vf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

This could be considered a 3 of 3 for the 2 mbox related igbvf patches I just replied to as those introduce a call trace on driver load which this resolves.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

