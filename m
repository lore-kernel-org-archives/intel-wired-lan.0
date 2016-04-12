From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 18:16:26 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbevf: refactor ethtool
	stats	handling
In-Reply-To: <20160407225839.28139.26733.stgit@localhost6.localdomain6>
References: <20160407225839.28139.26733.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF400@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 07, 2016 3:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbevf: refactor ethtool stats handling
> 
> This brings the logic closer to how we handle the stats in ixgbe and it sets us
> up for introducing per-queue stats.
> 
> Use IXGBEVF_STAT and IXGBEVF_NETDEV_STAT for accessing the driver and
> netdev stats respectively. This way we don't have to calculate the stats based
> on register values which could lead to the counters not being initialized
> properly when the interface is down.
> 
> IXGBEVF_QUEUE_STATS_LEN is set to include the number of queues.
> 
> Also some defines were renamed to use the IXGBEVF prefix.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c |  126 +++++++++++++---------
> ----
>  1 file changed, 64 insertions(+), 62 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool stats on VF work properly
