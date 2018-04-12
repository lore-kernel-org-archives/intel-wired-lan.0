From: Jacek Kalwas <jacek.kalwas@intel.com>
Date: Thu, 12 Apr 2018 12:03:14 -0700
Subject: [Intel-wired-lan] [net] xfrm: allow to release xfrm_state with flush
In-Reply-To: <20180412190315.3102-1-jacek.kalwas@intel.com>
References: <20180412190315.3102-1-jacek.kalwas@intel.com>
Message-ID: <20180412190315.3102-2-jacek.kalwas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Call to flush SAs doesn't release xfrm_state in case there was a
traffic associated with that state and state was already deleted.

Given patch calls xfrm_policy_cache_flush despite of actual states
deleted in xfrm_state_flush function.

Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>
---
 net/xfrm/xfrm_state.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f9d2f2233f09..7d3d6a12a14f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -734,10 +734,10 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	}
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
-	if (cnt) {
+	if (cnt)
 		err = 0;
-		xfrm_policy_cache_flush();
-	}
+
+	xfrm_policy_cache_flush();
 	return err;
 }
 EXPORT_SYMBOL(xfrm_state_flush);
-- 
2.14.3

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

