From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 16 Dec 2015 11:31:17 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
Message-ID: <20151216193058.5383.11943.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It appears that when the i211 was introduced it was never actually enabling
RSS.  This change makes it so that we enable RSS by setting the appropriate
bit in the MRQC register.

Reported-by: Tal Abudi <talabudi@gmail.com>
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7afde455326d..c803da0aa883 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3464,8 +3464,7 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 		else
 			mrqc |= E1000_MRQC_ENABLE_VMDQ;
 	} else {
-		if (hw->mac.type != e1000_i211)
-			mrqc |= E1000_MRQC_ENABLE_RSS_4Q;
+		mrqc |= E1000_MRQC_ENABLE_RSS_4Q;
 	}
 	igb_vmm_control(adapter);
 

