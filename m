From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 25 Jun 2019 15:07:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v6 2/8] etf: Don't use BIT() in
 UAPI headers.
In-Reply-To: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
References: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1561500439-30276-3-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The BIT() macro isn't exported as part of the UAPI interface. So, the
compile-test to ensure they are self contained fails. So, use _BITUL()
instead.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 8b2f993cbb77..f88c4e0bd9e5 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -988,8 +988,8 @@ struct tc_etf_qopt {
 	__s32 delta;
 	__s32 clockid;
 	__u32 flags;
-#define TC_ETF_DEADLINE_MODE_ON	BIT(0)
-#define TC_ETF_OFFLOAD_ON	BIT(1)
+#define TC_ETF_DEADLINE_MODE_ON	_BITUL(0)
+#define TC_ETF_OFFLOAD_ON	_BITUL(1)
 };
 
 enum {
-- 
2.7.3

