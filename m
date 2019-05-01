From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 1 May 2019 23:56:28 +0000
Subject: [Intel-wired-lan] [PATCH][next] iavf: use struct_size() helper
In-Reply-To: <20190501171759.GA3494@embeddedor>
References: <20190501171759.GA3494@embeddedor>
Message-ID: <804857E1F29AAC47BF68C404FC60A18401094448A5@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, May 01, 2019 10:18 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH][next] iavf: use struct_size() helper
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace code of the following form:
> 
> sizeof(struct virtchnl_ether_addr_list) + (count * sizeof(struct
> virtchnl_ether_addr))
> 
> with:
> 
> struct_size(veal, list, count)
> 
> and so on...
> 
> This code was detected with the help of Coccinelle.

What is the Coccinelle script used to detect this issue?

> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 37 ++++++++-----------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index e64751da0921..9c80bf972b90 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -242,7 +242,8 @@ void iavf_configure_queues(struct iavf_adapter
> *adapter)
>  	struct virtchnl_vsi_queue_config_info *vqci;
>  	struct virtchnl_queue_pair_info *vqpi;
>  	int pairs = adapter->num_active_queues;
> -	int i, len, max_frame = IAVF_MAX_RXBUFFER;
> +	int i, max_frame = IAVF_MAX_RXBUFFER;
> +	size_t len;
> 
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */
> @@ -251,8 +252,7 @@ void iavf_configure_queues(struct iavf_adapter
> *adapter)
>  		return;
>  	}
>  	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
> -	len = sizeof(struct virtchnl_vsi_queue_config_info) +
> -		       (sizeof(struct virtchnl_queue_pair_info) * pairs);
> +	len = struct_size(vqci, qpair, pairs);
>  	vqci = kzalloc(len, GFP_KERNEL);
>  	if (!vqci)
>  		return;
> @@ -351,7 +351,8 @@ void iavf_map_queues(struct iavf_adapter
> *adapter)
>  {
>  	struct virtchnl_irq_map_info *vimi;
>  	struct virtchnl_vector_map *vecmap;
> -	int v_idx, q_vectors, len;
> +	int v_idx, q_vectors;
> +	size_t len;
>  	struct iavf_q_vector *q_vector;
> 
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
> @@ -364,9 +365,7 @@ void iavf_map_queues(struct iavf_adapter
> *adapter)
> 
>  	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
> 
> -	len = sizeof(struct virtchnl_irq_map_info) +
> -	      (adapter->num_msix_vectors *
> -		sizeof(struct virtchnl_vector_map));
> +	len = struct_size(vimi, vecmap, adapter->num_msix_vectors);
>  	vimi = kzalloc(len, GFP_KERNEL);
>  	if (!vimi)
>  		return;
> @@ -433,9 +432,10 @@ int iavf_request_queues(struct iavf_adapter
> *adapter, int num)
>  void iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_ether_addr_list *veal;
> -	int len, i = 0, count = 0;
> +	int i = 0, count = 0;
>  	struct iavf_mac_filter *f;
>  	bool more = false;
> +	size_t len;
> 
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */
> @@ -457,15 +457,13 @@ void iavf_add_ether_addrs(struct iavf_adapter
> *adapter)
>  	}
>  	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
> 
> -	len = sizeof(struct virtchnl_ether_addr_list) +
> -	      (count * sizeof(struct virtchnl_ether_addr));
> +	len = struct_size(veal, list, count);
>  	if (len > IAVF_MAX_AQ_BUF_SIZE) {
>  		dev_warn(&adapter->pdev->dev, "Too many add MAC
> changes in one request\n");
>  		count = (IAVF_MAX_AQ_BUF_SIZE -
>  			 sizeof(struct virtchnl_ether_addr_list)) /
>  			sizeof(struct virtchnl_ether_addr);
> -		len = sizeof(struct virtchnl_ether_addr_list) +
> -		      (count * sizeof(struct virtchnl_ether_addr));
> +		len = struct_size(veal, list, count);
>  		more = true;
>  	}
> 
> @@ -505,8 +503,9 @@ void iavf_del_ether_addrs(struct iavf_adapter
> *adapter)
>  {
>  	struct virtchnl_ether_addr_list *veal;
>  	struct iavf_mac_filter *f, *ftmp;
> -	int len, i = 0, count = 0;
> +	int i = 0, count = 0;
>  	bool more = false;
> +	size_t len;
> 
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */
> @@ -528,15 +527,13 @@ void iavf_del_ether_addrs(struct iavf_adapter
> *adapter)
>  	}
>  	adapter->current_op = VIRTCHNL_OP_DEL_ETH_ADDR;
> 
> -	len = sizeof(struct virtchnl_ether_addr_list) +
> -	      (count * sizeof(struct virtchnl_ether_addr));
> +	len = struct_size(veal, list, count);
>  	if (len > IAVF_MAX_AQ_BUF_SIZE) {
>  		dev_warn(&adapter->pdev->dev, "Too many delete MAC
> changes in one request\n");
>  		count = (IAVF_MAX_AQ_BUF_SIZE -
>  			 sizeof(struct virtchnl_ether_addr_list)) /
>  			sizeof(struct virtchnl_ether_addr);
> -		len = sizeof(struct virtchnl_ether_addr_list) +
> -		      (count * sizeof(struct virtchnl_ether_addr));
> +		len = struct_size(veal, list, count);
>  		more = true;
>  	}
>  	veal = kzalloc(len, GFP_ATOMIC);
> @@ -973,7 +970,7 @@ static void iavf_print_link_message(struct
> iavf_adapter *adapter)
>  void iavf_enable_channels(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_tc_info *vti = NULL;
> -	u16 len;
> +	size_t len;
>  	int i;
> 
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
> @@ -983,9 +980,7 @@ void iavf_enable_channels(struct iavf_adapter
> *adapter)
>  		return;
>  	}
> 
> -	len = (adapter->num_tc * sizeof(struct virtchnl_channel_info)) +
> -	       sizeof(struct virtchnl_tc_info);
> -
> +	len = struct_size(vti, list, adapter->num_tc);
>  	vti = kzalloc(len, GFP_KERNEL);
>  	if (!vti)
>  		return;
> --
> 2.21.0

