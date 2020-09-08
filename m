From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 8 Sep 2020 11:45:13 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <20200907150217.30888-5-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
Message-ID: <6bbf1793-d2be-b724-eec4-65546d4cbc9c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 9/7/20 5:02 PM, Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
> zero-copy path.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 3771857cf887..f32c1ba0d237 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -239,7 +239,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>  	bool failure = false;
>  	struct sk_buff *skb;
>  
> -	while (likely(total_rx_packets < budget)) {
> +	while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {
>  		union ixgbe_adv_rx_desc *rx_desc;
>  		struct ixgbe_rx_buffer *bi;
>  		unsigned int size

This is a violation of NAPI API. IXGBE is already diverging a bit from best practices.

There are reasons we want to control the budget from callers,
if you want bigger budget just increase it instead of using your own ?

I would rather use a generic patch.

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7bd4fcdd0738a718d8b0f7134523cd87e4dcdb7b..33bcbdb6fef488983438c6584e3cbb0a44febb1a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2311,11 +2311,14 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)       ((net)->dev.type = (devtype))
 
-/* Default NAPI poll() weight
- * Device drivers are strongly advised to not use bigger value
- */
+/* Default NAPI poll() weight. Highly recommended. */
 #define NAPI_POLL_WEIGHT 64
 
+/* Device drivers are strongly advised to not use bigger value,
+ * as this might cause latencies in stress conditions.
+ */
+#define NAPI_POLL_WEIGHT_MAX 256
+
 /**
  *     netif_napi_add - initialize a NAPI context
  *     @dev:  network device
diff --git a/net/core/dev.c b/net/core/dev.c
index 4086d335978c1bf62bd3965bd2ea96a4ac06b13d..496713fb6075bd8e5e22725e7c817172858e1dd7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6608,7 +6608,7 @@ void netif_napi_add(struct net_device *dev, struct napi_struct *napi,
        INIT_LIST_HEAD(&napi->rx_list);
        napi->rx_count = 0;
        napi->poll = poll;
-       if (weight > NAPI_POLL_WEIGHT)
+       if (weight > NAPI_POLL_WEIGHT_MAX)
                netdev_err_once(dev, "%s() called with weight %d\n", __func__,
                                weight);
        napi->weight = weight;
