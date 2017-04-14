From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 14 Apr 2017 12:21:30 -0700
Subject: [Intel-wired-lan] [next PATCH S70 10/12] i40e: use
 i40e_stop_rings_no_wait to implement PORT_SUSPENDED state
In-Reply-To: <20170413084555.6962-10-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-10-alice.michael@intel.com>
Message-ID: <ae29bb81-9a83-47cb-8696-9feb6275109d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/13/2017 1:45 AM, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> This state bit was added as a way for DCB to avoid having to wait for
> the queues to disable when handling LLDP events. The logic for this was
> burried deep within stop Tx and stop Rx queue code. First, let's rename

s/burried/buried/

> it so that it does not appear to only affect Tx when infact it modifies

s/infact/in fact/

> both Tx and Rx flow. Second we can move it up into the i40e_stop_rings()
> function, and we can simply re-use the i40e_stop_rings_no_wait() so that
> we don't have to bury the implementation as deep into the call stack.
>
> An alternative might be to remove the state bit and instead attempt to
> shut down everything directly in DCP flow. This, however, is not ideal
> because it creates yet another separate shutdown routine that we'd have
> to maintain. In the current implementation any changes will be made to
> both flows.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I68e1ccb901af320862bca395e9c9746f08e8b17c
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++----------
>  2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index d35fec3..76bc404 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -149,7 +149,7 @@ enum i40e_state_t {
>  	__I40E_DOWN_REQUESTED,
>  	__I40E_FD_FLUSH_REQUESTED,
>  	__I40E_RESET_FAILED,
> -	__I40E_PORT_TX_SUSPENDED,
> +	__I40E_PORT_SUSPENDED,
>  	__I40E_VF_DISABLE,
>  };
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 7ceb256..b9d7798 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4008,10 +4008,6 @@ static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
>  	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
>  		i40e_control_tx_q(pf, pf_q, enable);
>
> -		/* Don't wait to disable when port Tx is suspended */
> -		if (!enable && test_bit(__I40E_PORT_TX_SUSPENDED, &pf->state))
> -			continue;
> -
>  		/* wait for the change to finish */
>  		ret = i40e_pf_txq_wait(pf, pf_q, enable);
>  		if (ret) {
> @@ -4105,10 +4101,6 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
>  	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
>  		i40e_control_rx_q(pf, pf_q, enable);
>
> -		/* Don't wait to disable when port Tx is suspended */
> -		if (!enable && test_bit(__I40E_PORT_TX_SUSPENDED, &pf->state))
> -			continue;
> -
>  		/* wait for the change to finish */
>  		ret = i40e_pf_rxq_wait(pf, pf_q, enable);
>  		if (ret) {
> @@ -4151,6 +4143,10 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
>   **/
>  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>  {
> +	/* When port TX is suspended, don't wait */
> +	if (test_bit(__I40E_PORT_SUSPENDED, &vsi->back->state))
> +		return i40e_vsi_stop_rings_no_wait(vsi);
> +
>  	/* do rx first for enable and last for disable
>  	 * Ignore return value, we need to shutdown whatever we can
>  	 */
> @@ -5986,7 +5982,7 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
>  	else
>  		pf->flags &= ~I40E_FLAG_DCB_ENABLED;
>
> -	set_bit(__I40E_PORT_TX_SUSPENDED, &pf->state);
> +	set_bit(__I40E_PORT_SUSPENDED, &pf->state);
>  	/* Reconfiguration needed quiesce all VSIs */
>  	i40e_pf_quiesce_all_vsi(pf);
>
> @@ -5995,7 +5991,7 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
>
>  	ret = i40e_resume_port_tx(pf);
>
> -	clear_bit(__I40E_PORT_TX_SUSPENDED, &pf->state);
> +	clear_bit(__I40E_PORT_SUSPENDED, &pf->state);
>  	/* In case of error no point in resuming VSIs */
>  	if (ret)
>  		goto exit;
>
