From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 17 May 2018 23:31:15 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 12/12] i40e: implement Tx
 zero-copy
In-Reply-To: <20180515190615.23099-13-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
 <20180515190615.23099-13-bjorn.topel@gmail.com>
Message-ID: <20180517233115.44c00dee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Tue, 15 May 2018 21:06:15 +0200 Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Here, the zero-copy ndo is implemented. As a shortcut, the existing
> XDP Tx rings are used for zero-copy. This means that and XDP program
> cannot redirect to an AF_XDP enabled XDP Tx ring.

This "shortcut" is not acceptable, and completely broken.  The
XDP_REDIRECT queue_index is based on smp_processor_id(), and can easily
clash with the configured XSK queue_index.  Provided a bit more code
context below...

On Tue, 15 May 2018 21:06:15 +0200
Bj?rn T?pel <bjorn.topel@gmail.com> wrote:

int i40e_xdp_xmit(struct net_device *dev, struct xdp_frame *xdpf)
{
	struct i40e_netdev_priv *np = netdev_priv(dev);
	unsigned int queue_index = smp_processor_id();
	struct i40e_vsi *vsi = np->vsi;
	int err;

	if (test_bit(__I40E_VSI_DOWN, vsi->state))
		return -ENETDOWN;

> @@ -4025,6 +4158,9 @@ int i40e_xdp_xmit(struct net_device *dev, struct xdp_frame *xdpf)
>  	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>  		return -ENXIO;
>  
> +	if (vsi->xdp_rings[queue_index]->xsk_umem)
> +		return -ENXIO;
> +

Using the sane errno makes this impossible to debug (via the tracepoints).

>  	err = i40e_xmit_xdp_ring(xdpf, vsi->xdp_rings[queue_index]);
>  	if (err != I40E_XDP_TX)
>  		return -ENOSPC;
> @@ -4048,5 +4184,34 @@ void i40e_xdp_flush(struct net_device *dev)
>  	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>  		return;
>  
> +	if (vsi->xdp_rings[queue_index]->xsk_umem)
> +		return;
> +
>  	i40e_xdp_ring_update_tail(vsi->xdp_rings[queue_index]);
>  }

	

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
