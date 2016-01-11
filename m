From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Mon, 11 Jan 2016 09:34:50 -0800
Subject: [Intel-wired-lan] [PATCH] igb: rename igb define to be more generic
Message-ID: <20160111173450.19024.84504.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

E1000_MRQC_ENABLE_RSS_4Q enables 4 and 8 queues depending on the part
so rename to be generic.

Similarly, E1000_MRQC_ENABLE_VMDQ_RSS_2Q has no numeric meaning so
rename to be more generic.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.h |    4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 2154aea..de8805a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -56,10 +56,10 @@ s32 igb_write_i2c_byte(struct e1000_hw *hw, u8 byte_offset, u8 dev_addr,
 #define E1000_SRRCTL_TIMESTAMP                          0x40000000
 
 
-#define E1000_MRQC_ENABLE_RSS_4Q            0x00000002
+#define E1000_MRQC_ENABLE_RSS_MQ            0x00000002
 #define E1000_MRQC_ENABLE_VMDQ              0x00000003
 #define E1000_MRQC_RSS_FIELD_IPV4_UDP       0x00400000
-#define E1000_MRQC_ENABLE_VMDQ_RSS_2Q       0x00000005
+#define E1000_MRQC_ENABLE_VMDQ_RSS_MQ       0x00000005
 #define E1000_MRQC_RSS_FIELD_IPV6_UDP       0x00800000
 #define E1000_MRQC_RSS_FIELD_IPV6_UDP_EX    0x01000000
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 31e5f39..24dbd59 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3460,12 +3460,12 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 			wr32(E1000_VT_CTL, vtctl);
 		}
 		if (adapter->rss_queues > 1)
-			mrqc |= E1000_MRQC_ENABLE_VMDQ_RSS_2Q;
+			mrqc |= E1000_MRQC_ENABLE_VMDQ_RSS_MQ;
 		else
 			mrqc |= E1000_MRQC_ENABLE_VMDQ;
 	} else {
 		if (hw->mac.type != e1000_i211)
-			mrqc |= E1000_MRQC_ENABLE_RSS_4Q;
+			mrqc |= E1000_MRQC_ENABLE_RSS_MQ;
 	}
 	igb_vmm_control(adapter);
 

