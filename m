From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 27 Apr 2022 08:59:15 -0700
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix error when changing
 ring parameters on ice PF
In-Reply-To: <20220427115220.163736-1-michal.maloszewski@intel.com>
References: <20220427115220.163736-1-michal.maloszewski@intel.com>
Message-ID: <0a59ba51-e87a-9e90-6ef7-710cb6e9e623@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/27/2022 4:52 AM, Michal Maloszewski wrote:
> Reset is triggered when ring parameters are being changed through
> ethtool and queues are reconfigured for VF's VSI. If ring is changed
> again immediately, then the next reset could be executed before
> queues could be properly reinitialized on VF's VSI. It caused ice PF
> to mess up the VSI resource tree.
>
> Add a check in iavf_set_ringparam for adapter and VF's queue
> state. If VF is currently resetting or queues are disabled for the VF
> return with EAGAIN error.
>
> Fixes: d732a1844507 ("i40evf: fix crash when changing ring sizes")
> Signed-off-by: Sylwester Dziedziuch<sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Michal Maloszewski<michal.maloszewski@intel.com>
> ---
> v3: Correct patch to be send on right tree
> v2: Changed unnecessary parentheses

As I mentioned in v2, this still does not address any of the comments 
from netdev[1]

- Tony

[1] https://lore.kernel.org/netdev/20220422154752.1fab6496 at kernel.org/

> ---
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 3bb56714beb0..a27df8af5cff 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -631,6 +631,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
>   	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>   		return -EINVAL;
>   
> +	if (adapter->state == __IAVF_RESETTING ||
> +	    adapter->state == __IAVF_RUNNING &&
> +	     (adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> +		return -EAGAIN;
> +
>   	if (ring->tx_pending > IAVF_MAX_TXD ||
>   	    ring->tx_pending < IAVF_MIN_TXD ||
>   	    ring->rx_pending > IAVF_MAX_RXD ||
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220427/43d324ec/attachment-0001.html>
