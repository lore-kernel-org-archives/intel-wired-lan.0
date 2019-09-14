From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Sep 2019 00:38:26 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: add rx drop enable attribute
In-Reply-To: <20190909142117.20186-1-bob.beckett@collabora.com>
References: <20190909142117.20186-1-bob.beckett@collabora.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971184AF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-09-09 at 15:21 +0100, Robert Beckett wrote:
> To allow userland to enable or disable dropping packets when descriptor
> ring is exhausted, add RX_DROP_EN private flag.
> 
> This can be used in conjunction with flow control to mitigate packet storms
> (e.g. due to network loop or DoS) by forcing the network adapter to send
> pause frames whenever the ring is close to exhaustion.
> 
> By default this will maintain previous behaviour of enabling dropping of
> packets during ring buffer exhaustion.
> Some use cases prefer to not drop packets upon exhaustion, but instead
> use flow control to limit ingress rates and ensure no dropped packets.
> This is useful when the host CPU cannot keep up with packet delivery,
> but data delivery is more important than throughput via multiple queues.
> 
> Userland can set this flag to 0 via ethtool to disable packet dropping.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
> 
> Notes:
>     Changes since v1: re-written to use ethtool priv flags instead of sysfs attribute
> 
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  8 ++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    | 11 +++++++++--
>  3 files changed, 18 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
