From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 27 Sep 2019 19:01:56 +0000
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Make use of
 cpumask_local_spread to improve RSS locality
In-Reply-To: <20190921001818.3431.45376.stgit@localhost.localdomain>
References: <20190921001818.3431.45376.stgit@localhost.localdomain>
Message-ID: <1dc5ab14370c4105be3ffe0eac951998@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, September 20, 2019 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] ixgbe: Make use of
> cpumask_local_spread to improve RSS locality
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> This patch is meant to address locality issues present in the ixgbe driver when
> it is loaded on a system supporting multiple NUMA nodes and more CPUs
> then the device can map in a 1:1 fashion. Instead of just arbitrarily mapping
> itself to CPUs 0-62 it would make much more sense to map itself to the local
> CPUs first, and then map itself to any remaining CPUs that might be used.
> 
> The first effect of this is that queue 0 should always be allocated on the local
> CPU/NUMA node. This is important as it is the default destination if a packet
> doesn't match any existing flow director filter or RSS rule and as such having it
> local should help to reduce QPI cross-talk in the event of an unrecognized
> traffic type.
> 
> In addition this should increase the likelihood of the RSS queues being
> allocated and used on CPUs local to the device while the ATR/Flow Director
> queues would be able to route traffic directly to the CPU that is likely to be
> processing it.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


