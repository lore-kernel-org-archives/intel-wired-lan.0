From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 8 Dec 2016 01:32:47 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: fcoe: return value
	of	skb_linearize should be handled
In-Reply-To: <1481096614-25295-1-git-send-email-zhouzhouyi@gmail.com>
References: <1481096614-25295-1-git-send-email-zhouzhouyi@gmail.com>
Message-ID: <1C8B930C-8697-41FA-BFCF-22168963C252@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index fee1f29..4926d48 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2173,8 +2173,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector  
> *q_vector,
>  				total_rx_bytes += ddp_bytes;
>  				total_rx_packets += DIV_ROUND_UP(ddp_bytes,
>  								 mss);
> -			}
> -			if (!ddp_bytes) {
> +			} else {
>  				dev_kfree_skb_any(skb);
>  				continue;
>  			}

This is changing the logic by treating a negative ddp_bytes value (an error  
return) the same as a 0 value. This is probably wrong and inappropriate for  
this patch in any case.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161208/ff572904/attachment.asc>
