From: kbuild test robot <lkp@intel.com>
Date: Tue, 18 Jun 2019 15:40:43 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] iavf:
 iavf_debug_d() can be static
In-Reply-To: <201906181502.baIuT9Wk%lkp@intel.com>
References: <201906181502.baIuT9Wk%lkp@intel.com>
Message-ID: <20190618074043.GA33787@lkp-kbuild11>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: d51cc48b07a8 ("iavf: Fix up debug print macro")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 iavf_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a833219..779bd59 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -148,7 +148,7 @@ enum iavf_status iavf_free_virt_mem_d(struct iavf_hw *hw,
  * @mask: debug level mask
  * @fmt_str: printf-type format description
  **/
-void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
+static void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
 {
 	char buf[512];
 	va_list argptr;
