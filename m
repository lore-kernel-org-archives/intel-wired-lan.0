From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:48 -0700
Subject: [Intel-wired-lan] [next PATCH S48 1/7] i40e: fix confusing dmesg
	info for ethtool -L option
In-Reply-To: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475000934-27335-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

Ethtool -L option with the combined parameter is for changing the number of
multi-purpose channels of the specified network device. The pre-set maximum
for the combined channels is cpu dependent. Currently, for an i40e device,
when the user sets a value between 64 and the maximum that the cpu can
support for the combined parameter, the i40e driver displays the confusing
info in dmesg to only show 64 as the RSS count regardless of what the
accepted user input is as long as it is larger than 64.

This patch fixes the message in the i40e driver when the user uses
ethtool -L to change the number of the combined channels to consistently
display the user requested value if it is valid and accepted by ethtool.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Change-ID: Ia80a68bc844b779a49e0f76e7d3dcc915032d9af
---
Testing Hints:
1. ethtool -l devname to show defaults
2. ethtool -L devname combined 72 to change the number of channels
3. ethtool -l devname to check settings
4. ethtool -S devname to verify 72 queues(tx/rx) got set up
5. run dmesg to check the i40e driver provided info to be consistent:
        i40e 0000:xx:00.x: User requested queue count/
                HW max RSS count:  72/64

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b4a4c0b..b2c9f9d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8361,8 +8361,8 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 
 		i40e_pf_config_rss(pf);
 	}
-	dev_info(&pf->pdev->dev, "RSS count/HW max RSS count:  %d/%d\n",
-		 pf->alloc_rss_size, pf->rss_size_max);
+	dev_info(&pf->pdev->dev, "User requested queue count/HW max RSS count:  %d/%d\n",
+		 vsi->req_queue_pairs, pf->rss_size_max);
 	return pf->alloc_rss_size;
 }
 
-- 
2.4.11

