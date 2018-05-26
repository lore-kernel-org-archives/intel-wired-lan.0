From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 26 May 2018 01:22:46 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Wait 10ms just once after TX
 queues reset
In-Reply-To: <20180518095840.GA17330@gklab-81-211.igk.intel.com>
References: <20180518095840.GA17330@gklab-81-211.igk.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964E7BFC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sergey Nemov
> Sent: Friday, May 18, 2018 2:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: Wait 10ms just once after TX queues
> reset
> 
> Move 10ms sleep out of function resetting TX queue.
> Reset all the TX queues in one turn and
> wait for all of them just once.
> 
> Use usleep_range() instead of mdelay() in order not to
> affect transmission on other interfaces.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

