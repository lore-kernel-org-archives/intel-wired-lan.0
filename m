From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 12 Oct 2018 10:41:02 +0200
Subject: [Intel-wired-lan] [bug report] ixgbe: added Rx/Tx ring
 disable/enable functions
In-Reply-To: <20181011114751.GA21224@mwanda>
References: <20181011114751.GA21224@mwanda>
Message-ID: <CAJ+HfNikU3iHCXkDJ86B29oXKSRKV_8gBP4CBT4GkCWZGEBzsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Den tors 11 okt. 2018 kl 13:48 skrev Dan Carpenter <dan.carpenter@oracle.com>:
>
> Hello Bj?rn T?pel,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 024aa5800f32: "ixgbe: added Rx/Tx ring disable/enable
> functions" from Oct 2, 2018, leads to the following Smatch complaint:
>
>     drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10520 ixgbe_txrx_ring_enable()
>     error: we previously assumed 'xdp_ring' could be null (see line 10515)
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>  10514          ixgbe_configure_tx_ring(adapter, tx_ring);
>  10515          if (xdp_ring)
>                     ^^^^^^^^
> The patch adds a check for NULL.
>
>  10516                  ixgbe_configure_tx_ring(adapter, xdp_ring);
>  10517          ixgbe_configure_rx_ring(adapter, rx_ring);
>  10518
>  10519          clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
>  10520          clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
>                                                 ^^^^^^^^^^^^^^^
> but it also adds an unchecked dereference.
>
>  10521  }
>  10522
>
> regards,
> dan carpenter

Thank you. I'll have a look and get back with a patch.


Bj?rn


> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
