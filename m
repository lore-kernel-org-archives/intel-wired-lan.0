From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 24 Aug 2017 20:06:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next] e1000e: Be drop monitor
	friendly
In-Reply-To: <20170825013650.27463-1-f.fainelli@gmail.com>
References: <20170825013650.27463-1-f.fainelli@gmail.com>
Message-ID: <6475bbf2-9035-5630-e03e-66c2fdf1af0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 08/24/2017 06:36 PM, Florian Fainelli wrote:
> e1000_put_txbuf() cleans up the successfully transmitted TX packets,
> e1000e_tx_hwtstamp_work() also does the successfully completes the
> timestamped TX packets, e1000_clean_rx_ring() cleans up the RX ring and
> e1000_remove() cleans up the timestampted packets. None of these
> functions should be reporting dropped packets, so make them use
> dev_consume_skb*() to be drop monitor friendly.

This also won't compile, I marked it a Superseded in patchwork since
there is a v2 coming.

-- 
Florian
