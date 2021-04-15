From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Thu, 15 Apr 2021 14:04:38 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210415092145.27322-1-kurt@linutronix.de>
References: <20210415092145.27322-1-kurt@linutronix.de>
Message-ID: <20210415140438.60221f21@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 15 Apr 2021 11:21:45 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> When using native XDP with the igb driver, the XDP frame data doesn't point to
> the beginning of the packet. It's off by 16 bytes. Everything works as expected
> with XDP skb mode.
> 
> Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
> the timestamp before executing any XDP operations and adjust all other code
> accordingly. The igc driver does it like that as well.
> 
> Tested with Intel i210 card and AF_XDP sockets.

Doesn't the i210 card use the igc driver?
This change is for igb driver.


> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
[...]
> 
> drivers/net/ethernet/intel/igb/igb.h      |  3 +-
>  drivers/net/ethernet/intel/igb/igb_main.c | 46 ++++++++++++-----------
>  drivers/net/ethernet/intel/igb/igb_ptp.c  | 21 ++++-------
>  3 files changed, 33 insertions(+), 37 deletions(-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

