From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 2 Nov 2020 19:26:59 +0100
Subject: [Intel-wired-lan] [PATCH v3 8/9] igc: Add support for XDP_TX
 action
In-Reply-To: <20201030210351.46482-9-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201030210351.46482-9-andre.guedes@intel.com>
Message-ID: <20201102182659.GK6427@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 30, 2020 at 02:03:50PM -0700, Andre Guedes wrote:
> This patch adds support for XDP_TX action which enables XDP programs to
> transmit back receiving frames.
> 
> I225 controller has only 4 tx hardware queues. Since XDP programs may
> not even issue an XDP_TX action, this patch doesn't reserve dedicated
> queues just for XDP like other Intel drivers do. Instead, the queues
> are shared between the network stack and XDP. The netdev queue lock is
> used to ensure mutual exclusion.
> 
> Since frames can now be transmitted via XDP_TX, the igc_tx_buffer
> structure is modified so we are able to save a reference to the xdp
> frame for later clean up once the packet is transmitted. The tx_buffer
> is mapped to either a skb or a xdpf so we use a union to save the skb
> or xdpf pointer and have a bit in tx_flags to indicate which field to
> use.
> 
> This patch has been tested with the sample app "xdp2" located in
> samples/bpf/ dir.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---

[...]

> +
> +static struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter,
> +					    int cpu)
> +{
> +	int index = cpu;
> +
> +	if (index >= adapter->num_tx_queues)
> +		index = index % adapter->num_tx_queues;

I'm not sure why you don't want to take the suggestion for getting rid of
modulo op. I won't insist anymore ;)

> +
> +	return adapter->tx_ring[index];
> +}

[...]
