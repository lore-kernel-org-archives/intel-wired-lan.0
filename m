From: Zhou Furong <furong.zhou@linux.intel.com>
Date: Fri, 27 May 2022 17:08:18 +0800
Subject: [Intel-wired-lan] [PATCH net-next v5 09/11] igc: Add support
 for Frame Preemption verification
In-Reply-To: <20220520011538.1098888-10-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-10-vinicius.gomes@intel.com>
Message-ID: <e6cb8b03-4d3d-b64b-0aca-642fe53ecb90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> +
> +	struct delayed_work fp_verification_work;
> +	unsigned long fp_start;
> +	bool fp_received_smd_v;
> +	bool fp_received_smd_r;
> +	unsigned int fp_verify_cnt;
> +	enum frame_preemption_state fp_tx_state;
> +	bool fp_disable_verify;

struct size would be smaller if add member to right place


> +	if (!netif_running(adapter->netdev))
> +		return -ENOTCONN;
> +
> +	/* FIXME: rename this function to something less specific, as
> +	 * it can be used outside XDP.
> +	 */
> +	ring = igc_xdp_get_tx_ring(adapter, cpu);
> +	nq = txring_txq(ring);
> +
> +	skb = alloc_skb(IGC_FP_SMD_FRAME_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
if there is chance of NOMEM, move this before
ring = igc_xdp_get_tx_ring(adapter, cpu);


> +static void igc_fp_verification_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct igc_adapter *adapter;
> +	int err;
> +
> +	adapter = container_of(dwork, struct igc_adapter, fp_verification_work);
> +
please remove blank

> +	if (adapter->fp_disable_verify)
> +		goto done;
> +
> +	switch (adapter->fp_tx_state) {
> +	case FRAME_PREEMPTION_STATE_START:
> +		adapter->fp_received_smd_r = false;
> +		err = igc_xmit_smd_frame(adapter, IGC_SMD_TYPE_SMD_V);
> +		if (err < 0)
> +			netdev_err(adapter->netdev, "Error sending SMD-V frame\n");
> +
> +		adapter->fp_tx_state = FRAME_PREEMPTION_STATE_SENT;
state is SENT when send error?

> +		adapter->fp_start = jiffies;
> +		schedule_delayed_work(&adapter->fp_verification_work, IGC_FP_TIMEOUT);
> +		break;
> +





> +
> +			if (adapter->fp_verify_cnt > IGC_MAX_VERIFY_CNT) {
> +				adapter->fp_verify_cnt = 0;
> +				adapter->fp_tx_state = FRAME_PREEMPTION_STATE_FAILED;
> +				netdev_err(adapter->netdev,
> +					   "Exceeded number of attempts for frame preemption verification\n");
> +			} else {
> +				adapter->fp_tx_state = FRAME_PREEMPTION_STATE_START;
> +			}
> +			schedule_delayed_work(&adapter->fp_verification_work, IGC_FP_TIMEOUT);
> +		}
> +
> +		break;
> +
> +	case FRAME_PREEMPTION_STATE_FAILED:
> +	case FRAME_PREEMPTION_STATE_DONE:
miss default?

> +		break;
> +	}
> +
