From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 23 Dec 2015 15:17:29 +0300
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: force to synchronize
 reporting "link on" and getting speed and duplex
In-Reply-To: <1450853205-27133-1-git-send-email-zyjzyj2000@gmail.com>
References: <1450853205-27133-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <567A90D9.9040204@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On 12/23/2015 9:46 AM, zyjzyj2000 at gmail.com wrote:

> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> In X540 NIC, there is a time span between reporting "link on" and
> getting the speed and duplex. To a bonding driver in 802.3ad mode,
> this time span will make it not work well if the time span is big
> enough. The big time span will make bonding driver change the state of
> the slave device to up while the speed and duplex of the slave device
> can not be gotten. Later the bonding driver will not have change to
> get the speed and duplex of the slave device. The speed and duplex of
> the slave device are important to a bonding driver in 802.3ad mode.
>
> To 82599_SFP NIC and other kinds of NICs, this problem does
> not exist. As such, it is necessary for X540 to report"link on" when
> the link speed is not IXGBE_LINK_SPEED_UNKNOWN.
>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index aed8d02..cb9d310 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6479,7 +6479,21 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
>   	       (flow_rx ? "RX" :
>   	       (flow_tx ? "TX" : "None"))));
>
> -	netif_carrier_on(netdev);
> +	/*
> +	 * In X540 NIC, there is a time span between reporting "link on"
> +	 * and getting the speed and duplex. To a bonding driver in 802.3ad
> +	 * mode, this time span will make it not work well if the time span
> +	 * is big enough. To 82599_SFP NIC and other kinds of NICs, this
> +	 * problem does not exist. As such, it is better for X540 to report
> +	 * "link on" when the link speed is not IXGBE_LINK_SPEED_UNKNOWN.
> +	 */
> +	if ((hw->mac.type == ixgbe_mac_X540) &&
> +	    (link_speed != IXGBE_LINK_SPEED_UNKNOWN)) {
> +		netif_carrier_on(netdev);
> +	} else {
> +		netif_carrier_on(netdev);
> +	}
> +

    {} not needed here. And you do the same thing regardless of whether your 
check succeeds or not, this doesn't make sense.

[...]

MBR, Sergei

