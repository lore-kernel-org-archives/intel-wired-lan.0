From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:18 -0700
Subject: [Intel-wired-lan] [PATCH S50 15/15] ice: fix unused parameter
 warning
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Depending on PAGE_SIZE, the following unused parameter warning can be
reported:

drivers/net/ethernet/intel/ice/ice_txrx.c: In function ?ice_rx_frame_truesize?:
drivers/net/ethernet/intel/ice/ice_txrx.c:513:21: warning: unused parameter ?size? [-Wunused-parameter]
        unsigned int size)

The 'size' variable is used only when PAGE_SIZE >= 8192. Add __maybe_unused to
to remove the warning.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 0aaed92f807f..909d56b28358 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -509,8 +509,8 @@ static unsigned int ice_rx_offset(struct ice_ring *rx_ring)
 	return 0;
 }
 
-static unsigned int ice_rx_frame_truesize(struct ice_ring *rx_ring,
-					  unsigned int size)
+static unsigned int
+ice_rx_frame_truesize(struct ice_ring *rx_ring, unsigned int __maybe_unused size)
 {
 	unsigned int truesize;
 
-- 
2.20.1

