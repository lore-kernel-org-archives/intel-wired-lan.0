From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 8 Jun 2021 09:27:05 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: add tracepoints
In-Reply-To: <20210528014943.3036054-1-jesse.brandeburg@intel.com>
References: <20210528014943.3036054-1-jesse.brandeburg@intel.com>
Message-ID: <20210608092705.00005761@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg wrote:

> This patch is modeled after one by Scott Peterson for i40e.

I found a little bug in the code, Tony do you want to correct it or
have me send a v3?

> +DECLARE_EVENT_CLASS(ice_tx_dim_template,
> +		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
> +		    TP_ARGS(q_vector, dim),
> +		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
> +				     __field(struct dim *, dim)
> +				     __string(devname, q_vector->tx.ring->netdev->name)),
> +
> +		    TP_fast_assign(__entry->q_vector = q_vector;
> +				   __entry->dim = dim;
> +				   __assign_str(devname, q_vector->tx.ring->netdev->name);),
> +
> +		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
> +			      __get_str(devname),
> +			      __entry->q_vector->rx.ring->q_index,

should be:                                       tx.ring

