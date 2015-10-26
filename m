From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:38 -0400
Subject: [Intel-wired-lan] [next PATCH S20 12/15] i40evf: quoth the VF
	driver, Nevermore
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If, upon a midnight dreary, the PF returns ERR_PARAM when the VF is
requesting resources, that's fatal. Either the firmware or NVM is badly,
badly misconfigured, or this VF has been disabled due to a previous VF
driver sending a bunch of bogus messages.

Either way, there is no recovery from this. Don't ponder weak and weary,
just quit.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I09d9f16cc4ee7fec3b57646a289d33838c1c5bf5

---
Testing-hints: Ensure that the VF driver loads and initializes
correctly.
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 52a3286..f5d6932 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2435,6 +2435,14 @@ static void i40evf_init_task(struct work_struct *work)
 		if (err == I40E_ERR_ADMIN_QUEUE_NO_WORK) {
 			err = i40evf_send_vf_config_msg(adapter);
 			goto err;
+		} else if (err == I40E_ERR_PARAM) {
+			/* We only get ERR_PARAM if the device is in a very bad
+			 * state or if we've been disabled for previous bad
+			 * behavior. Either way, we're done now.
+			 */
+			i40evf_shutdown_adminq(hw);
+			dev_err(&pdev->dev, "Unable to get VF config due to PF error condition, not retrying\n");
+			return;
 		}
 		if (err) {
 			dev_err(&pdev->dev, "Unable to get VF config (%d)\n",
-- 
1.9.3

