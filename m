From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 12 Feb 2019 09:52:03 +0100
Subject: [Intel-wired-lan] [PATCH 0/2] i40e: fix regression that enables
 AF_XDP ZC unconditionally
Message-ID: <20190212085205.7848-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series addresses a recent AF_XDP zero-copy regression.

In commit f3fef2b6e1cc ("i40e: Remove umem from VSI") a regression was
introduced; When the VSI was reset, the setup code would try to enable
AF_XDP ZC unconditionally (as long as there was a umem placed in the
netdev._rx struct). Here, we add a bitmap to the VSI that tracks if a
certain queue pair has been "zero-copy enabled" via the ndo_bpf. The
bitmap is used in i40e_xsk_umem, and enables zero-copy if and only if
XDP is enabled, the corresponding qid in the bitmap is set and the
umem is non-NULL.

Thanks,
Bj?rn


Bj?rn T?pel (2):
  i40e: move i40e_xsk_umem function
  i40e: add tracking of AF_XDP ZC state for each queue pair

 drivers/net/ethernet/intel/i40e/i40e.h      | 16 ++----------
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  3 +++
 3 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.19.1

