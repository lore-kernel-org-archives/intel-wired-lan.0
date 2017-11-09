From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 9 Nov 2017 09:04:01 +0200
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: Set HTHRESH when PTHRESH
 is used
In-Reply-To: <20171107221332.28283-1-mattst88@gmail.com>
References: <20171107221332.28283-1-mattst88@gmail.com>
Message-ID: <dc49eeda-eeb7-eeba-9341-ba2ccd78065d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/8/2017 00:13, Matt Turner wrote:
> From: Matt Turner <matt.turner@intel.com>
>
> According to section 12.0.3.4.13 "Receive Descriptor Control - RXDCTL"
> of the Intel? 82579 Gigabit Ethernet PHY Datasheet v2.1:
>
>      "HTHRESH should be given a non zero value when ever PTHRESH is
>       used."
>
> In RXDCTL(0), PTHRESH lives at bits 5:0, and HTHREST lives at bits 13:8.
> Set only bit 8 of HTHREST as is done in e1000_flush_rx_ring(). Found by
> inspection.
>
> Signed-off-by: Matt Turner <matt.turner@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 2dcb5463d9b8..286d0277284e 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3285,7 +3285,7 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
>   		if (adapter->flags & FLAG_IS_ICH) {
>   			u32 rxdctl = er32(RXDCTL(0));
>   
> -			ew32(RXDCTL(0), rxdctl | 0x3);
> +			ew32(RXDCTL(0), rxdctl | 0x3 | BIT(8));
>   		}
>   
>   		pm_qos_update_request(&adapter->pm_qos_req, lat);

Ack. Good point.

