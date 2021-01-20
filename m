From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 20 Jan 2021 01:25:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: Log error for
 oversized MTU on device
In-Reply-To: <20210114161706.9224-1-eryk.roch.rybak@intel.com>
References: <20210114161706.9224-1-eryk.roch.rybak@intel.com>
Message-ID: <2d2bb2958990986810e419119649dbf6a6606446.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-01-14 at 16:17 +0000, Eryk Rybak wrote:
> When attempting to link XDP prog with MTU larger than supported,
> user is not informed why XDP linking fails. Adding proper
> error message: "MTU too large to enable XDP".
> Due to the lack of support for non-static variables in netlinks
> extended ACK feature, additional information has been added to dmesg
> to better inform about invalid MTU setting.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> ---
> v2: add dmesg trace, change commit message
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2a7e116..0ea04cb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12933,9 +12933,10 @@ static netdev_features_t
> i40e_features_check(struct sk_buff *skb,
>   * i40e_xdp_setup - add/remove an XDP program
>   * @vsi: VSI to changed
>   * @prog: XDP program
> + * @extack: netlink extended ack
>   **/
> -static int i40e_xdp_setup(struct i40e_vsi *vsi,
> -			  struct bpf_prog *prog)
> +static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog
> *prog,
> +			  struct netlink_ext_ack *extack)
>  {
>  	int frame_size = vsi->netdev->mtu + ETH_HLEN + ETH_FCS_LEN +
> VLAN_HLEN;
>  	struct i40e_pf *pf = vsi->back;
> @@ -12944,8 +12945,12 @@ static int i40e_xdp_setup(struct i40e_vsi
> *vsi,
>  	int i;
>  
>  	/* Don't allow frames that span over multiple buffers */
> -	if (frame_size > vsi->rx_buf_len)
> +	if (frame_size > vsi->rx_buf_len) {
> +		NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable
> XDP");
> +		dev_info(&pf->pdev->dev,
> +			 "MTU of %u bytes is too large to enable XDP
> (maximum: %u bytes)\n", vsi->netdev->mtu, vsi->rx_buf_len);

This is over 100 char, I've already fixed it up though so no need to
resend.
