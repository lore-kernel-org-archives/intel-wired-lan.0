From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 9 Feb 2017 13:49:30 +0300
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: add the external ixgbe
 fiber transceiver status
In-Reply-To: <1486609408-6770-1-git-send-email-yanjun.zhu@oracle.com>
References: <1486609408-6770-1-git-send-email-yanjun.zhu@oracle.com>
Message-ID: <27479fa3-47e7-5f01-1410-876a21e01523@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello!

On 2/9/2017 6:03 AM, Zhu Yanjun wrote:

> When the ixgbe fiber transceiver is external, it is necessary to get
> the present/absent status of this external ixgbe fiber transceiver.
>
> The steps to get the present/absent status:
> The enp1s0f0 is an external ixgbe fiber NIC.
>
> ethtool enp1s0f0
>
> ...
>         Port: FIBRE
>         PHYAD: 0
>         Transceiver: external(present) <---The transceiver is present.
>         Auto-negotiation: on
>         Supports Wake-on: d
> ...
>
> Or
> ...
>         Port: FIBRE
>         PHYAD: 0
>         Transceiver: external(absent) <---The transceiver is absent
>         Auto-negotiation: on
>         Supports Wake-on: d
> ...
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 15 +++++++++++++++
>  include/uapi/linux/ethtool.h                     |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index fd192bf..b3f86f4 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -313,6 +313,21 @@ static int ixgbe_get_settings(struct net_device *netdev,
>  		break;
>  	}
>
> +	/* When the tranceiver is external, the following is meaningful.
> +	 * ecmd->reserved[0] has 3 values:
> +	 * 0x0: tranceiver absent
> +	 * 0x4: tranceiver present
> +	 * others: not support
> +	 */
> +	if (ecmd->port == PORT_FIBRE) {
> +		u32 status = IXGBE_READ_REG(hw, IXGBE_ESDP) & IXGBE_ESDP_SDP2;
> +
> +		if (status == 0x4)
> +			ecmd->transceiver = XCVR_EXTERNAL_PRESENT;
> +		if (status == 0x0)

    *else* *if*. Although *switch* would match better instead...

> +			ecmd->transceiver = XCVR_EXTERNAL_ABSENT;
> +	}
> +
>  	/* Indicate pause support */
>  	ecmd->supported |= SUPPORTED_Pause;
>
[...]

MBR, Sergei

