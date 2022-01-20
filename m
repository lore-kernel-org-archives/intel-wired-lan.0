From: Maurice Baijens (Ellips B.V.) <maurice.baijens@ellips.com>
Date: Thu, 20 Jan 2022 09:23:06 +0000
Subject: [Intel-wired-lan] ixgbe driver link down causes 100% load in
 ksoftirqd/x
Message-ID: <VI1PR02MB4142A638EC38107B262DB32F885A9@VI1PR02MB4142.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,


I have an issue with the ixgbe driver and X550Tx network adapter.
When I disconnect the network cable I end up with 100% load in ksoftirqd/x. I am running the adapter in
xdp mode (XDP_FLAGS_DRV_MODE). Problem seen in linux kernel 5.15.x and also 5.16.0+ (head).

I traced the problem down to function ixgbe_xmit_zc in ixgbe_xsk.c:

if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
    !netif_carrier_ok(xdp_ring->netdev)) {
            work_done = false;
            break;
}

This function is called from ixgbe_poll() function via ixgbe_clean_xdp_tx_irq(). It sets
work_done to false if netif_carrier_ok() returns false (so if link is down). Because work_done
is always false, ixgbe_poll keeps on polling forever.

I made a fix by checking link in ixgbe_poll() function and if no link exiting polling mode:

/* If all work not completed, return budget and keep polling */
if ((!clean_complete) && netif_carrier_ok(adapter->netdev))
            return budget;

This is probably fine for our application as we only run in xdpdrv mode, however I am not sure this
is the correct way to fix this issue and the behaviour of the normal skb mode operation is 
also affected by my fix.

So hopefully my observations are correct and someone here can fix the issue and push it upstream.


Best regards,
	Maurice Baijens
