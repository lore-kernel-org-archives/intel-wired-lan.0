From: trix@redhat.com <trix@redhat.com>
Date: Thu, 17 Jun 2021 14:54:19 -0700
Subject: [Intel-wired-lan] [PATCH] ice: change return type of
 ice_ptp_request_ts() to s8
Message-ID: <20210617215419.3502075-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tom Rix <trix@redhat.com>

A gcc 10.3.1 compile error
ice_ptp.h:149:1: error: return type defaults to
  'int' [-Werror=return-type]
  149 | ice_ptp_request_ts(struct ice_ptp_tx *tx, ...
      | ^~~~~~~~~~~~~~~~~~

This stub's return needs to match the decl for
CONFIG_PTP_I588_CLOCK, which matches its use in
ice_txrt.c

Change the implicit int return to s8.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 41e14f98f0e66..d01507eba0364 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -145,7 +145,7 @@ static inline int ice_get_ptp_clock_index(struct ice_pf *pf)
 	return -1;
 }
 
-static inline
+static inline s8
 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 {
 	return -1;
-- 
2.26.3

