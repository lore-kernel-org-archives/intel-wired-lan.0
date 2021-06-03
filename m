From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 3 Jun 2021 11:30:44 +0000
Subject: [Intel-wired-lan] [PATCH net v4] igb: Fix XDP with PTP enabled
In-Reply-To: <20210503072800.79936-1-kurt@linutronix.de>
References: <20210503072800.79936-1-kurt@linutronix.de>
Message-ID: <MW3PR11MB4554208E081D4DD08EADD7669C3C9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Kurt Kanzenbach <kurt@linutronix.de>
>Sent: Monday, May 3, 2021 12:58 PM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
>Jakub Kicinski <kuba@kernel.org>
>Cc: Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
><daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
>Fastabend <john.fastabend@gmail.com>; Sven Auhagen
><sven.auhagen@voleatech.de>; intel-wired-lan at lists.osuosl.org;
>netdev at vger.kernel.org; bpf at vger.kernel.org; Ilias Apalodimas
><ilias.apalodimas@linaro.org>; Lorenzo Bianconi <lorenzo@kernel.org>;
>Sebastian Andrzej Siewior <bigeasy@linutronix.de>; Richard Cochran
><richardcochran@gmail.com>; Alexander Duyck
><alexander.duyck@gmail.com>; Tyler S <tylerjstachecki@gmail.com>;
>Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Kurt Kanzenbach
><kurt@linutronix.de>
>Subject: [PATCH net v4] igb: Fix XDP with PTP enabled
>
>When using native XDP with the igb driver, the XDP frame data doesn't point
>to the beginning of the packet. It's off by 16 bytes. Everything works as
>expected with XDP skb mode.
>
>Actually these 16 bytes are used to store the packet timestamps. Therefore,
>pull the timestamp before executing any XDP operations and adjust all other
>code accordingly. The igc driver does it like that as well.
>
>Tested with Intel i210 card and AF_XDP sockets.
>
>Fixes: 9cbc948b5a20 ("igb: add XDP support")
>Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>---
>
>Changes since v3:
>
> * Get rid of timestamp check in hot path (Maciej Fijalkowski)
>
>Changes since v2:
>
> * Check timestamp for validity (Nguyen, Anthony L)
>
>Changes since v1:
>
> * Use xdp_prepare_buff() (Lorenzo Bianconi)
>
>Changes since RFC:
>
> * Removed unused return value definitions (Alexander Duyck)
>
>Previous versions:
>
> * https://lkml.kernel.org/netdev/20210422052617.17267-1-
>kurt at linutronix.de/
> * https://lkml.kernel.org/netdev/20210419072332.7246-1-
>kurt at linutronix.de/
> * https://lkml.kernel.org/netdev/20210415092145.27322-1-
>kurt at linutronix.de/
> * https://lkml.kernel.org/netdev/20210412101713.15161-1-
>kurt at linutronix.de/
>
> drivers/net/ethernet/intel/igb/igb.h      |  2 +-
> drivers/net/ethernet/intel/igb/igb_main.c | 45 +++++++++++++----------
>drivers/net/ethernet/intel/igb/igb_ptp.c  | 23 +++++-------
> 3 files changed, 37 insertions(+), 33 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
