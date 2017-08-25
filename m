From: David Miller <davem@davemloft.net>
Date: Thu, 24 Aug 2017 21:29:59 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v2] e1000e: Be drop monitor
	friendly
In-Reply-To: <20170825035824.26935-1-f.fainelli@gmail.com>
References: <20170825035824.26935-1-f.fainelli@gmail.com>
Message-ID: <20170824.212959.70798260439682691.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 24 Aug 2017 20:58:24 -0700

> e1000_put_txbuf() cleans up the successfully transmitted TX packets,
> e1000e_tx_hwtstamp_work() also does the successfully completes the
> timestamped TX packets, e1000_clean_rx_ring() cleans up the RX ring and
> e1000_remove() cleans up the timestampted packets. None of these
> functions should be reporting dropped packets, so make them use
> dev_consume_skb_any() to be drop monitor friendly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I'll let the Intel folks pick this up.
