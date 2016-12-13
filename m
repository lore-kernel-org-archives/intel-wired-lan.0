From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 13 Dec 2016 14:40:07 +0100
Subject: [Intel-wired-lan] [PATCH v3 4/4] i40e: Validate xdp_adjust_head
	support
In-Reply-To: <20161213134007.14707-1-bjorn.topel@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
Message-ID: <20161213134007.14707-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This patch will tell the user that bpf_xdp_adjust_head() is currently
not supported.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f7e627a540cc..f22cfa385b75 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9532,6 +9532,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
 	bool need_reset;
 	struct bpf_prog *old_prog;
 
+	if (prog && prog->xdp_adjust_head)
+		return -EOPNOTSUPP;
+
 	/* The Rx frame has to fit in 2k */
 	if (frame_size > I40E_RXBUFFER_2048)
 		return -EINVAL;
-- 
2.9.3

