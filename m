From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Sep 2017 17:42:33 +0000
Subject: [Intel-wired-lan] [net-next PATCH V2] ixgbe: add counter for
 times rx pages gets allocated, not recycled
In-Reply-To: <150455042211.455.6804897285651927718.stgit@firesoul>
References: <150455042211.455.6804897285651927718.stgit@firesoul>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9ACE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesper Dangaard Brouer
> Sent: Monday, September 4, 2017 11:40 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Jesper Dangaard Brouer <brouer@redhat.com>
> Subject: [Intel-wired-lan] [net-next PATCH V2] ixgbe: add counter for times
> rx pages gets allocated, not recycled
> 
> The ixgbe driver have page recycle scheme based around the RX-ring queue,
> where a RX page is shared between two packets. Based on the refcnt, the
> driver can determine if the RX-page is currently only used by a single packet,
> if so it can then directly refill/recycle the RX-slot by with the opposite "side"
> of the page.
> 
> While this is a clever trick, it is hard to determine when this recycling is
> successful and when it fails.  Adding a counter, which is available via ethtool --
> statistics as 'alloc_rx_page'.  Which counts the number of times the recycle
> fails and the real page allocator is invoked.  When interpreting the stats, do
> remember that every alloc will serve two packets.
> 
> The counter is collected per rx_ring, but is summed and ethtool exported as
> 'alloc_rx_page'.  It would be relevant to know what rx_ring that cannot keep
> up, but that can be exported later if someone experience a need for this.
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |    4 ++++
>  3 files changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


