From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 21 Jul 2018 13:53:27 +0800
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe: ixgbe_get_completion_timeout()
 can be static
In-Reply-To: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
References: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180721055327.GA30259@lkp-wsm-ep1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 23f3effc3f69 ("ixgbe: Refactor queue disable logic to take completion time into account")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d4395f1..e3fac6a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5605,7 +5605,7 @@ void ixgbe_up(struct ixgbe_adapter *adapter)
 	ixgbe_up_complete(adapter);
 }
 
-unsigned long ixgbe_get_completion_timeout(struct ixgbe_adapter *adapter)
+static unsigned long ixgbe_get_completion_timeout(struct ixgbe_adapter *adapter)
 {
 	u16 devctl2;
 
