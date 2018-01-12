From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 12 Jan 2018 18:19:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40evf: use GFP_ATOMIC under
 spin lock
In-Reply-To: <1515724033-110604-1-git-send-email-weiyongjun1@huawei.com>
References: <1515724033-110604-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882B7F8F0@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wei Yongjun [mailto:weiyongjun1 at huawei.com]
> Sent: Thursday, January 11, 2018 6:27 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; kernel-janitors at vger.kernel.org
> Subject: [PATCH net-next] i40evf: use GFP_ATOMIC under spin lock
> 
> A spin lock is taken here so we should use GFP_ATOMIC.
> 

You are correct, good catch!

> Fixes: 504398f0a78e ("i40evf: use spinlock to protect (mac|vlan)_filter_list")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> index feb95b6..ca5b538 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> @@ -459,7 +459,7 @@ void i40evf_add_ether_addrs(struct i40evf_adapter
> *adapter)
>  		more = true;
>  	}
> 
> -	veal = kzalloc(len, GFP_KERNEL);
> +	veal = kzalloc(len, GFP_ATOMIC);
>  	if (!veal) {
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  		return;
> @@ -532,7 +532,7 @@ void i40evf_del_ether_addrs(struct i40evf_adapter
> *adapter)
>  		      (count * sizeof(struct virtchnl_ether_addr));
>  		more = true;
>  	}
> -	veal = kzalloc(len, GFP_KERNEL);
> +	veal = kzalloc(len, GFP_ATOMIC);
>  	if (!veal) {
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  		return;
> @@ -606,7 +606,7 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
>  		      (count * sizeof(u16));
>  		more = true;
>  	}
> -	vvfl = kzalloc(len, GFP_KERNEL);
> +	vvfl = kzalloc(len, GFP_ATOMIC);
>  	if (!vvfl) {
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  		return;
> @@ -678,7 +678,7 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
>  		      (count * sizeof(u16));
>  		more = true;
>  	}
> -	vvfl = kzalloc(len, GFP_KERNEL);
> +	vvfl = kzalloc(len, GFP_ATOMIC);
>  	if (!vvfl) {
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  		return;

