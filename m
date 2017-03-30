From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 29 Mar 2017 17:31:30 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Check for skb->queue_mapping
In-Reply-To: <1490831874-6396-1-git-send-email-tushar.n.dave@oracle.com>
References: <1490831874-6396-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <1490833890.24891.53.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-03-29 at 16:57 -0700, Tushar Dave wrote:
> There are events seen where skb->queue_mapping value is greater than
> vsi->num_queue_pairs. In such cases, vsi->tx_ring becomes invalid
> (null) and xmit results in kernel panic.
> 
> One such event is running netconsole and enabling VF on the same
> device. Or running netconsole and changing number of tx queues via
> ethtool on same device.

Something is wrong then, and must be fixed on these producers.



