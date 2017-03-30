From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 29 Mar 2017 17:29:47 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Check for skb->queue_mapping
In-Reply-To: <1490831714-6184-1-git-send-email-tushar.n.dave@oracle.com>
References: <1490831714-6184-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <1490833787.24891.52.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-03-29 at 16:55 -0700, Tushar Dave wrote:
> There are events seen where skb->queue_mapping value is greater than
> adapter->num_tx_queue. In such cases, adapter->tx_ring becomes invalid
> (null) and xmit results in kernel panic.
> 
> One such event is running netconsole and enabling VF on the same device.
> Or running netconsole and changing number of tx queues via ethtool on
> same device.
> 
> This patch adds check for skb->queue_mapping and uses simple arithmetic
> to select available tx queue from driver.

We are not going to fix all multi queue drivers, for something that
seems to be a generic issue higher in the stack.


