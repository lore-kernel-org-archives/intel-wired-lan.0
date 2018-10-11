From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 11 Oct 2018 14:47:51 +0300
Subject: [Intel-wired-lan] [bug report] ixgbe: added Rx/Tx ring
 disable/enable functions
Message-ID: <20181011114751.GA21224@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Bj?rn T?pel,

This is a semi-automatic email about new static checker warnings.

The patch 024aa5800f32: "ixgbe: added Rx/Tx ring disable/enable 
functions" from Oct 2, 2018, leads to the following Smatch complaint:

    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10520 ixgbe_txrx_ring_enable()
    error: we previously assumed 'xdp_ring' could be null (see line 10515)

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
 10514		ixgbe_configure_tx_ring(adapter, tx_ring);
 10515		if (xdp_ring)
                    ^^^^^^^^
The patch adds a check for NULL.

 10516			ixgbe_configure_tx_ring(adapter, xdp_ring);
 10517		ixgbe_configure_rx_ring(adapter, rx_ring);
 10518	
 10519		clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 10520		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
                                                ^^^^^^^^^^^^^^^
but it also adds an unchecked dereference.

 10521	}
 10522	

regards,
dan carpenter
