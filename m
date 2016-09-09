From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 9 Sep 2016 16:37:06 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 2/2] e1000: bundle xdp
	xmit routines
In-Reply-To: <20160909212938.4001.40540.stgit@john-Precision-Tower-5810>
References: <20160909212915.4001.25504.stgit@john-Precision-Tower-5810>
 <20160909212938.4001.40540.stgit@john-Precision-Tower-5810>
Message-ID: <57D347A2.4060909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-09-09 02:29 PM, John Fastabend wrote:
> e1000 supports a single TX queue so it is being shared with the stack
> when XDP runs XDP_TX action. This requires taking the xmit lock to
> ensure we don't corrupt the tx ring. To avoid taking and dropping the
> lock per packet this patch adds a bundling implementation to submit
> a bundle of packets to the xmit routine.
> 
> I tested this patch running e1000 in a VM using KVM over a tap
> device using pktgen to generate traffic along with 'ping -f -l 100'.
> 
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---

This patch is a bit bogus in a few spots as well...


> -
> -	if (E1000_DESC_UNUSED(tx_ring) < 2) {
> -		HARD_TX_UNLOCK(netdev, txq);
> -		return;
> +	for (; i < E1000_XDP_XMIT_BUNDLE_MAX && buffer_info[i].buffer; i++) {
> +		e1000_xmit_raw_frame(buffer_info[i].buffer,
> +				     buffer_info[i].length,
> +				     adapter, tx_ring);
> +		buffer_info[i].buffer->rxbuf.page = NULL;
> +		buffer_info[i].buffer = NULL;
> +		buffer_info[i].length = 0;
> +		i++;
              ^^^^^^^^

