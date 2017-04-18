From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 18 Apr 2017 01:36:09 +0000
Subject: [Intel-wired-lan] [PATCH] net: igbvf: Use net_device_stats
	from	struct net_device
In-Reply-To: <20170406064522.13096-1-tklauser@distanz.ch>
References: <20170406064522.13096-1-tklauser@distanz.ch>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5EC952@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tobias Klauser
> Sent: Wednesday, April 5, 2017 11:45 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] net: igbvf: Use net_device_stats from
> struct net_device
> 
> Instead of using a private copy of struct net_device_stats in
> struct igbvf_adapter, use stats from struct net_device. Also remove the
> now unnecessary .ndo_get_stats function.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/net/ethernet/intel/igbvf/igbvf.h  |  1 -
>  drivers/net/ethernet/intel/igbvf/netdev.c | 26 +++++---------------------
>  2 files changed, 5 insertions(+), 22 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
