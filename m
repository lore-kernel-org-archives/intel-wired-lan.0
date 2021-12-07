From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue,  7 Dec 2021 21:55:27 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 0/9] net: intel:
 napi_alloc_skb() vs metadata
Message-ID: <20211207205536.563550-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is an interpolation of [0] to other Intel Ethernet drivers
(and is (re)based on its code).
The main aim is to keep XDP metadata not only in case with
build_skb(), but also when we do napi_alloc_skb() + memcpy().

All Intel drivers suffers from the same here:
 - metadata gets lost on XDP_PASS in legacy-rx;
 - excessive headroom allocation on XSK Rx to skbs;
 - metadata gets lost on XSK Rx to skbs.

Those get especially actual in XDP Hints upcoming.
I couldn't have addressed the first one for all Intel drivers due to
that they don't reserve any headroom for now in legacy-rx mode even
with XDP enabled. This is hugely wrong, but requires quite a bunch
of work and a separate series. Luckily, ice doesn't suffer from
that.
igc has 1 and 3 already fixed in [0].

From v2 (unreleased upstream):
 - tweaked 007 to pass bi->xdp directly and simplify code (Maciej);
 - picked Michal's Reviewed-by.

From v1 (unreleased upstream):
 - drop "fixes" of legacy-rx for i40e, igb and ixgbe since they have
   another flaw regarding headroom (see above);
 - drop igc cosmetic fixes since they landed upstream incorporated
   into Jesper's commits;
 - picked one Acked-by from Maciej.

[0] https://lore.kernel.org/netdev/163700856423.565980.10162564921347693758.stgit at firesoul

Alexander Lobakin (9):
  i40e: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
  i40e: respect metadata on XSK Rx to skb
  ice: respect metadata in legacy-rx/ice_construct_skb()
  ice: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
  ice: respect metadata on XSK Rx to skb
  igc: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
  ixgbe: pass bi->xdp to ixgbe_construct_skb_zc() directly
  ixgbe: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
  i40e: respect metadata on XSK Rx to skb

 drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 16 +++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 15 ++++++++---
 drivers/net/ethernet/intel/ice/ice_xsk.c     | 16 +++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c    | 13 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 27 ++++++++++++--------
 5 files changed, 54 insertions(+), 33 deletions(-)

-- 
Testing hints:

Setup an XDP and AF_XDP program which will prepend metadata at the
front of the frames and return XDP_PASS, then check that metadata
is present after frames reach kernel network stack.
--
2.33.1

