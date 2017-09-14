From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Sep 2017 23:54:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] e1000e: Be drop
	monitor	friendly
In-Reply-To: <20170826011424.27251-1-f.fainelli@gmail.com>
References: <20170826011424.27251-1-f.fainelli@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6A057B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Florian Fainelli
> Sent: Friday, August 25, 2017 6:14 PM
> To: netdev at vger.kernel.org
> Cc: edumazet at gmail.com; Florian Fainelli <f.fainelli@gmail.com>; open list
> <linux-kernel@vger.kernel.org>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next v3] e1000e: Be drop monitor
> friendly
> 
> e1000e_put_txbuf() can be called from normal reclamation path as well as
> when a DMA mapping failure, so we need to differentiate these two cases
> when freeing SKBs to be drop monitor friendly. e1000e_tx_hwtstamp_work()
> and e1000_remove() are processing TX timestamped SKBs and those should
> not be accounted as drops either.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v3:
> 
> - differentiate normal reclamation from TX DMA fragment mapping errors
> - removed a few invalid dev_kfree_skb() replacements (those are already
>   drop monitor friendly)
> 
> Changes in v2:
> 
> - make it compile
> 
>  drivers/net/ethernet/intel/e1000e/netdev.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

