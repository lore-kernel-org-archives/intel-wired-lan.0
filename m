From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 15 Mar 2017 03:07:22 +0000
Subject: [Intel-wired-lan] [next PATCH] igb/ixgbe: Fix typo in
 igb_build_skb and/or ixgbe_build_skb code comment
In-Reply-To: <20170215171559.4456.38581.stgit@localhost.localdomain>
References: <20170215171559.4456.38581.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5B485E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, February 15, 2017 9:16 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH] igb/ixgbe: Fix typo in igb_build_skb
> and/or ixgbe_build_skb code comment
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> There was a typo that I had left in the code comments for the igb and ixgbe
> functions that enabled build_skb support.  This patch is meant to clean
> that up since it didn't seem like something worth respinning both series
> for.  If I end up having to respin the series I will pull this change into
> the patch and at that time we can drop this one.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c     |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
