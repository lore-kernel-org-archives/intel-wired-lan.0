From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 16 Dec 2016 10:07:32 -0800
Subject: [Intel-wired-lan] [PATCH v3 2/4] i40e: Initial support for XDP
In-Reply-To: <20161213134007.14707-3-bjorn.topel@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
 <20161213134007.14707-3-bjorn.topel@gmail.com>
Message-ID: <58542D64.2070801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-12-13 05:40 AM, Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This commit adds basic XDP support for i40e derived NICs. All XDP
> actions will end up in XDP_DROP.
> 
> Only the default/main VSI has support for enabling XDP.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---

[...]

>  
>  /**
> + * i40e_run_xdp - Runs an XDP program for an Rx ring
> + * @rx_ring: Rx ring used for XDP
> + * @rx_buffer: current Rx buffer
> + * @rx_desc: current Rx descriptor
> + * @size: buffer size
> + * @xdp_prog: the XDP program to run
> + *
> + * Returns true if the XDP program consumed the incoming frame. False
> + * means pass the frame to the good old stack.
> + **/
> +static bool i40e_run_xdp(struct i40e_ring *rx_ring,
> +			 struct i40e_rx_buffer *rx_buffer,
> +			 union i40e_rx_desc *rx_desc,
> +			 unsigned int size,
> +			 struct bpf_prog *xdp_prog)
> +{
> +	struct xdp_buff xdp;
> +	u32 xdp_action;
> +
> +	if (unlikely(!i40e_test_staterr(rx_desc,
> +					BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)))) {
> +		dev_warn_once(&rx_ring->vsi->back->pdev->dev,
> +			      "Received unexpected RXD_EOF!\n");
> +		goto do_drop;
> +	}
> +
> +	xdp.data = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +	xdp.data_end = xdp.data + size;

We need to set the xdp.data_hard_start as well here.

	xdp.data_hard_start = xdp.data

should be good enough for now.

> +	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp);
> +
> +	switch (xdp_action) {
> +	case XDP_PASS:
> +		return false;
> +	default:
> +		bpf_warn_invalid_xdp_action(xdp_action);
> +	case XDP_ABORTED:
> +	case XDP_TX:
> +	case XDP_DROP:
> +do_drop:
> +		if (likely(i40e_page_is_reusable(rx_buffer->page))) {
> +			i40e_reuse_rx_page(rx_ring, rx_buffer);
> +			rx_ring->rx_stats.page_reuse_count++;
> +			break;
> +		}
> +
> +		/* we are not reusing the buffer so unmap it */
> +		dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
> +			       DMA_FROM_DEVICE);
> +		__free_pages(rx_buffer->page, 0);
> +	}
> +
> +	/* clear contents of buffer_info */
> +	rx_buffer->page = NULL;
> +	return true; /* Swallowed by XDP */
> +}
> +
> +/**
>   * i40e_fetch_rx_buffer - Allocate skb and populate it

Thanks,
John

