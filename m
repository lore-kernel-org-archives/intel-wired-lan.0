From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 15 Mar 2018 16:52:47 -0700
Subject: [Intel-wired-lan] [PATCH v2 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180315234802.31336-13-anirudh.venkataramanan@intel.com>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-13-anirudh.venkataramanan@intel.com>
Message-ID: <20180315165247.165ac10e@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 15 Mar 2018 16:47:59 -0700
Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> wrote:

> +
> +static const struct ice_stats ice_gstrings_vsi_stats[] = {
> +	ICE_VSI_STAT("tx_unicast", eth_stats.tx_unicast),
> +	ICE_VSI_STAT("rx_unicast", eth_stats.rx_unicast),
> +	ICE_VSI_STAT("tx_multicast", eth_stats.tx_multicast),
> +	ICE_VSI_STAT("rx_multicast", eth_stats.rx_multicast),
> +	ICE_VSI_STAT("tx_broadcast", eth_stats.tx_broadcast),
> +	ICE_VSI_STAT("rx_broadcast", eth_stats.rx_broadcast),
> +	ICE_VSI_STAT("tx_bytes", eth_stats.tx_bytes),
> +	ICE_VSI_STAT("rx_bytes", eth_stats.rx_bytes),
> +	ICE_VSI_STAT("rx_discards", eth_stats.rx_discards),
> +	ICE_VSI_STAT("tx_errors", eth_stats.tx_errors),
> +	ICE_VSI_STAT("tx_linearize", tx_linearize),
> +	ICE_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
> +	ICE_VSI_STAT("rx_alloc_fail", rx_buf_failed),
> +	ICE_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
> +};
> +

Ignoring feedback from maintainers is unlikely to help get your driver adopted.
