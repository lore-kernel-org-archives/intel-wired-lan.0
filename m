From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 17 Dec 2015 18:37:44 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
In-Reply-To: <20151216193058.5383.11943.stgit@localhost.localdomain>
References: <20151216193058.5383.11943.stgit@localhost.localdomain>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AAE7871@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I've spent too much time looking into this. I think this was added when someone looked for the register value and it was the same as E1000_MRQC_ENABLE_RSS_8Q and disabled i211 because it doesn't have 8 queues.

I've been asked if you could spin this to add a comment that the two values are the same (E1000_MRQC_ENABLE_RSS_8Q and E1000_MRQC_ENABLE_RSS_4Q).

Thanks.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Wednesday, December 16, 2015 11:31 AM
To: intel-wired-lan@lists.osuosl.org; alexander.duyck at gmail.com
Cc: Tal Abudi
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter

It appears that when the i211 was introduced it was never actually enabling RSS.  This change makes it so that we enable RSS by setting the appropriate bit in the MRQC register.

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
 

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
