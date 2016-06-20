From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 20 Jun 2016 10:39:33 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: return smaller of actual work
	done or budget in fm10k_poll
In-Reply-To: <20160620173933.5638-1-jacob.e.keller@intel.com>
References: <20160620173933.5638-1-jacob.e.keller@intel.com>
Message-ID: <20160620173933.5638-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correct a slight issue with fm10k_poll returning the full budget even if
it didn't fully exhaust it. This occurs if a single ring exhausts its
per-ring portion of the budget but the other rings do not. Return the
actual amount we used capped at budget to avoid issues with napi core.

Change-Id: Ie84de029a62adcfa8af49ccb2dc0b4d9f378ee71
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 79d5093d83d1..c2c7f2ef2152 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1474,9 +1474,9 @@ static int fm10k_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 	}
 
-	/* If all work not completed, return budget and keep polling */
+	/* If all work not completed, return work done and keep polling */
 	if (!clean_complete)
-		return budget;
+		return min(work_done, budget);
 
 	/* all work done, exit the polling mode */
 	napi_complete_done(napi, work_done);
-- 
2.9.0.rc1.405.g81f467e

