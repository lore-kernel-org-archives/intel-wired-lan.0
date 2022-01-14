From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 13 Jan 2022 16:37:01 -0800
Subject: [Intel-wired-lan] [PATCH net-next] igc: avoid kernel warning
 when changing RX ring parameters
In-Reply-To: <20220113160021.1027704-1-vinschen@redhat.com>
References: <20220113160021.1027704-1-vinschen@redhat.com>
Message-ID: <87sftr6tle.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Corinna Vinschen <vinschen@redhat.com> writes:

> Calling ethtool changing the RX ring parameters like this:
>
>   $ ethtool -G eth0 rx 1024
>
> triggers the "Missing unregister, handled but fix driver" warning in
> xdp_rxq_info_reg().
>
> igc_ethtool_set_ringparam() copies the igc_ring structure but neglects to
> reset the xdp_rxq_info member before calling igc_setup_rx_resources().
> This in turn calls xdp_rxq_info_reg() with an already registered xdp_rxq_info.
>
> This fix initializes the xdp_rxq_info member prior to calling
> igc_setup_rx_resources(), exactly like igb.
>
> Fixes: 73f1071c1d29 ("igc: Add support for XDP_TX action")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 8cc077b712ad..93839106504d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -671,6 +671,10 @@ igc_ethtool_set_ringparam(struct net_device *netdev,
>  			memcpy(&temp_ring[i], adapter->rx_ring[i],
>  			       sizeof(struct igc_ring));
>  
> +			/* Clear copied XDP RX-queue info */
> +			memset(&temp_ring[i].xdp_rxq, 0,
> +			       sizeof(temp_ring[i].xdp_rxq));
> +

Reaching "inside" xdp_rxq to reset it doesn't feel right in this
context, even if it's going to work fine (for now).

I think that the suggestion that Alexander gave in that other thread is
the best approach. And thanks for noticing that igb '_set_ringparam()'
has the same underlying problem and also needs to be fixed.


Cheers,
-- 
Vinicius
