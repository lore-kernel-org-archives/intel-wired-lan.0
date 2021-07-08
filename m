From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Jul 2021 14:35:50 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 2/5] igc: Integrate flex
 filter into ethtool ops
In-Reply-To: <20210629044332.3491232-3-vinicius.gomes@intel.com>
References: <20210629044332.3491232-1-vinicius.gomes@intel.com>
 <20210629044332.3491232-3-vinicius.gomes@intel.com>
Message-ID: <6b3974a3-f9c4-222e-4b46-53a9c40d456d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 07:43, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Use the flex filter mechanism to extend the current ethtool filter
> operations by intercoperating the user data. This allows to match
> eight more bytes within a Ethernet frame in addition to macs, ether
> types and vlan.
> 
> The matching pattern looks like this:
> 
>   * dest_mac [6]
>   * src_mac [6]
>   * tpid [2]
>   * vlan tci [2]
>   * ether type [2]
>   * user data [8]
> 
> This can be used to match Profinet traffic classes by FrameID range.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  24 ++-
>   drivers/net/ethernet/intel/igc/igc_defines.h |   4 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  20 ++
>   drivers/net/ethernet/intel/igc/igc_main.c    | 190 ++++++++++++++++++-
>   4 files changed, 228 insertions(+), 10 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
