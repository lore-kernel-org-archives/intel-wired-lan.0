From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Aug 2018 19:19:41 +0000
Subject: [Intel-wired-lan] [next PATCH S95 04/12] i40evf: update ethtool
 stats code and use helper functions
In-Reply-To: <20180820151233.14629-4-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E967D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 04/12] i40evf: update ethtool
> stats code and use helper functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix a bug in the way we handled VF queues, by always showing stats for the
> maximum number of queues, even if they aren't allocated. It is not safe to
> change the number of strings reported to ethtool, as grabbing statistics
> occurs over multiple ethtool ops for which the rtnl_lock() cannot be held the
> entire time.
> 
> Avoid this by always reporting queue stats for the maximum number of
> queues in the netdevice. Share some of the helper functionality for adding
> stats with the PF code in i40e_ethtool_stats.h
> 
> This should reduce the chance of potential future bugs, and make adding
> new statistics easier.
> 
> Note for the queue stats, unlike the PF driver we do not keep an array of
> queue pointers, but an array of queues, so care must be taken to avoid
> accessing queue memory that hasn't yet been allocated.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/i40evf/i40e_ethtool_stats.h | 221
> +++++++++++++++++++++
> drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 137 +++++++------
>  2 files changed, 298 insertions(+), 60 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


