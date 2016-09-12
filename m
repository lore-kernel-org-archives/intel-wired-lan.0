From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 12 Sep 2016 15:13:01 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 0/3] e1000 XDP implementation
Message-ID: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch implements XDP on e1000 a few comments below:

The XDP_TX path does not violate BQL in this series so we have to increment
and decrement the bql counters correctly. When a TX queue can have both stack
traffic and XDP traffic I believe user configured BQL should be correct. If
users do not want BQL they can always disable it or raise the limits.


I left the xdp program attached to the adapter structure because in the e1000
case the program is global because we only run on a single queue. Pushing the
program into the rx_ring just creates a bunch of ring[0] references in the code
and adds little in my opinion. This is really just a style issue though. Notice
I did push the bundle logic onto the queue but I view the bundling and rx
ring buffers to be so closely linked it was worth it and only caused a couple
extra ring[0] lines.


XDP_TX will drop packets if any errors occur while attempting to push onto the
TX descriptor ring. This seems to me at least to be the most sensible thing to
do and keeps e1000 inline with existing mlx XDP drivers. This can always be
extended if some consensus is made later.

Thanks for all the comments in v{1|2}. As always any comments/feedback
appreciated.

Also initial patch was based on a patch I took from Alexei so I left his
signed-off there even though I mangled the code a fair amount since then and
did not give him any chance to review off-list.

---

Alexei Starovoitov (1):
      e1000: add initial XDP support

John Fastabend (2):
      e1000: track BQL bytes regardless of skb or not
      e1000: bundle xdp xmit routines


 drivers/net/ethernet/intel/e1000/e1000.h      |   12 +
 drivers/net/ethernet/intel/e1000/e1000_main.c |  227 ++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 10 deletions(-)

--
Signature
