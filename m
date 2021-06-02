From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 2 Jun 2021 10:49:15 +0000
Subject: [Intel-wired-lan] [PATCH RFC net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210412101713.15161-1-kurt@linutronix.de>
References: <20210412101713.15161-1-kurt@linutronix.de>
Message-ID: <MW3PR11MB45542D3E8343264F0160BF6F9C3D9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Kurt Kanzenbach
>Sent: Monday, April 12, 2021 3:47 PM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
>Jakub Kicinski <kuba@kernel.org>
>Cc: Kurt Kanzenbach <kurt@linutronix.de>; Jesper Dangaard Brouer
><hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
>netdev at vger.kernel.org; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
>Ilias Apalodimas <ilias.apalodimas@linaro.org>; Alexei Starovoitov
><ast@kernel.org>; intel-wired-lan at lists.osuosl.org; bpf at vger.kernel.org;
>Lorenzo Bianconi <lorenzo@kernel.org>
>Subject: [Intel-wired-lan] [PATCH RFC net] igb: Fix XDP with PTP enabled
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
> drivers/net/ethernet/intel/igb/igb.h      |  3 +-
> drivers/net/ethernet/intel/igb/igb_main.c | 45 ++++++++++++-----------
>drivers/net/ethernet/intel/igb/igb_ptp.c  | 18 ++++-----
> 3 files changed, 32 insertions(+), 34 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
