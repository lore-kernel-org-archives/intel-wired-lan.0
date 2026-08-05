Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98456C55822
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52B4F4072B;
	Wed,  5 Aug 2026 06:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDxL5m6-fsYp; Wed,  5 Aug 2026 06:52:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CEEC40741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785912770;
	bh=/O7EIpvPJh0KavpSXy2BJiApWgFpKpIfXSkU1S5aVq4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHVtiwtHq+XIDJOJZkm8leZwmDnQAHxq2t/Z+I6KmXgcYz+/1yfl6Xygbhdm0S/8x
	 LLuVgnxPU9Tp+8VGarsgJsHYJepSSg18LyR7v2tfSbkdVXMrla0Ax4aqSliJ/lV6M+
	 hBUySRUJV3q9BFLEKK54LjNyqX+N4X9uBCsV0s457XAfVmJfRoc5hgLOrtUDstvgZP
	 ZrGEOqoIZMHAt4dhihv5e5fHjFxjAQ14nNvl0za1p9fMiPCt8fRhcdS79QfcO5EKHu
	 53fYq9fPbKIeEE4E8oecQ5OHyH7576nDfuNQWVJTg9I4D3sdjBIvXaWZCYxlxIbpdX
	 /69qWvIiU+VOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CEEC40741;
	Wed,  5 Aug 2026 06:52:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CD2E218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EFC540748
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fp8ZWyc6FxzZ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:52:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.179;
 helo=out-179.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 436FE40741
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 436FE40741
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 436FE40741
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed,  5 Aug 2026 14:51:30 +0800
Message-ID: <20260805065132.148625-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/O7EIpvPJh0KavpSXy2BJiApWgFpKpIfXSkU1S5aVq4=;
 b=uU/cwCdx9Yab375Iv3gcCcSxFyQnreSlGIGzoAOGcnTiekw1A5KzucgEjcIhYh0LhShauW
 nn/wmUmBrZFBYwcBn5WGsx65W4cJL9wWiivSy2mfjRErqQJvHHseSgMlxM21zv8OPjI+WW
 ehASGRdb7rQDKIjS9qQftPhcFoazQQE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=uU/cwCdx
Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/5] i40e: synchronize reset
 recovery with device removal
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

i40e_remove() currently tears down PTP and device resources before
claiming RESET_RECOVERY_PENDING. A service task can pass its initial state
check before removal starts and continue into reset recovery after the
remove path has begun teardown. This can make i40e_reset_and_rebuild()
access or recreate resources that are being released.

Stop the service timer and disable the service work before claiming reset
ownership. disable_work_sync() drains the current service task and rejects
later queue_work() attempts, including those from interrupts. Claim the
reset bit before starting teardown so an existing reset owner completes
first.

Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8c28788ac634f..5922f83f324ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16159,6 +16159,20 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	i40e_devlink_unregister(pf);
 
+	/* Interrupts can queue the service task until __I40E_DOWN is set.
+	 * Disable it so no service work can outlive the PF.
+	 */
+	set_bit(__I40E_SUSPENDED, pf->state);
+	if (pf->service_timer.function)
+		timer_shutdown_sync(&pf->service_timer);
+	if (pf->service_task.func)
+		disable_work_sync(&pf->service_task);
+
+	/* Wait for any reset owner before tearing down device resources. */
+	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
+		usleep_range(1000, 2000);
+	set_bit(__I40E_IN_REMOVE, pf->state);
+
 	i40e_dbg_pf_exit(pf);
 
 	i40e_ptp_stop(pf);
@@ -16167,26 +16181,12 @@ static void i40e_remove(struct pci_dev *pdev)
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
 
-	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
-	 * flags, once they are set, i40e_rebuild should not be called as
-	 * i40e_prep_for_reset always returns early.
-	 */
-	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
-		usleep_range(1000, 2000);
-	set_bit(__I40E_IN_REMOVE, pf->state);
-
 	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
 		i40e_free_vfs(pf);
 		clear_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
 	}
-	/* no more scheduling of any task */
-	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
-	if (pf->service_timer.function)
-		timer_shutdown_sync(&pf->service_timer);
-	if (pf->service_task.func)
-		cancel_work_sync(&pf->service_task);
 
 	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
 		struct i40e_vsi *vsi = pf->vsi[0];
-- 
2.43.0

