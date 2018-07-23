From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 24 Jul 2018 05:04:13 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] i40e: len_ethhdr
 can be static
In-Reply-To: <201807240548.0XzJcSzH%fengguang.wu@intel.com>
References: <201807240548.0XzJcSzH%fengguang.wu@intel.com>
Message-ID: <20180723210413.GA7085@lkp-sbx04>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 58e0270bb7ac ("i40e: Initial support to add hw hints for xdp")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 i40e_txrx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 09536d7e7..ab8b97f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2296,9 +2296,9 @@ static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
 	writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
 };
 
-const size_t len_ethhdr = sizeof(struct ethhdr);
-const size_t len_ipv4hdr = sizeof(struct iphdr);
-const size_t len_ipv6hdr = sizeof(struct ipv6hdr);
+static const size_t len_ethhdr = sizeof(struct ethhdr);
+static const size_t len_ipv4hdr = sizeof(struct iphdr);
+static const size_t len_ipv6hdr = sizeof(struct ipv6hdr);
 
 enum XDP_META_PTYPE
 {
