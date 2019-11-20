From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 20 Nov 2019 02:49:50 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: dont drop packets if rx flow
 control is enabled
In-Reply-To: <20191022153155.9008-1-bob.beckett@collabora.com>
References: <20191022153155.9008-1-bob.beckett@collabora.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97179755@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Robert Beckett
> Sent: Tuesday, October 22, 2019 8:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Robert Beckett <bob.beckett@collabora.com>; netdev at vger.kernel.org;
> David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v2] igb: dont drop packets if rx flow control
> is enabled
> 
> If rx flow control has been enabled (via autoneg or forced), packets
> should not be dropped due to rx descriptor ring exhaustion. Instead
> pause frames should be used to apply back pressure. This only applies
> if VFs are not in use.
> 
> Move SRRCTL setup to its own function for easy reuse and only set drop
> enable bit if rx flow control is not enabled.
> 
> Since v1: always enable dropping of packets if VFs in use.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  8 ++++
>  drivers/net/ethernet/intel/igb/igb_main.c    | 47 ++++++++++++++------
>  3 files changed, 42 insertions(+), 14 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
