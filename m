Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A7DC433FE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Nov 2022 06:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF5C240338;
	Wed, 16 Nov 2022 06:35:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF5C240338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668580506;
	bh=xNtw+e+nq4Pexw++e8YTfnHQyg+JM2HjFY7FFQu96kQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ARCVtOeERxCK8SwPT4L9iIJPGP74QPBwiLAdKOfUX90OeBK1tGgD2GEsiz2uXPH2a
	 iurbziQMRaFjQW1XxleQPi1X0Z9tdPRWqSPulw2AWqDPhpsuDj447WRsdltRYxNHLz
	 guz5D4XV/aLBvA4i8DAKvesDT8THjfWw1K8SUDXgIG1vgGJXGIS3j6eQbs/IQccU6C
	 5nl5e+Tv27WlY69G1azxhK4UaChVXPKjEeogWfMqEOlac4GbhNsa+poKgnikPTr02V
	 P/W2UOvagqUmAMRBY8PPhRztWBQUWr7NtcjyK966V5kyx6vUYbOsrMudKF6oVJMgJv
	 qGGVDvh+0brdg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ASBzm6gsNBB; Wed, 16 Nov 2022 06:35:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A33CE4092B;
	Wed, 16 Nov 2022 06:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A33CE4092B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B23BC1BF2AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Nov 2022 06:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82BFB416E3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Nov 2022 06:35:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82BFB416E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i0ObXsXIrxpl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Nov 2022 06:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D0ED40338
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D0ED40338
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Nov 2022 06:35:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295831474"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="295831474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2022 22:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="617050553"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; d="scan'208";a="617050553"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by orsmga006.jf.intel.com with ESMTP; 15 Nov 2022 22:35:00 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 16 Nov 2022 07:21:20 +0100
Message-Id: <20221116062120.15025-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668580503; x=1700116503;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p8/tUa41IIsFPHLUjLNb8S8+7Jxd6FD+/dPFCWYQEeo=;
 b=EvflR1P1W/PUwOey+pJXRwdFgl8qv1zRIDUuRWkAbHUSw6OvJO0U7bre
 nFwVHmICrIZSb65S7ROAxiVLGstuBRMn7wJJ5tAXROD3Auom/w6EH+d6U
 mOnxn5vtXphf6QPSBtMgxe1+TZf2ZcwIPHGD5x5nyBqm1mthl6mVKwJrV
 c+bIpRQ18kloB+zEXc1a9eSM/SfNvG4b5RLIhIIEsd/L9TXMbGTZrk6JH
 2SHkg8yhcynsDcNtM9l4ib4yu4NCH2sjPTh0DGjlXEtSXpsszaoroNGLz
 SiRWgIGQ0p6EeGzmhm9OaFZ09LHSZRxUT/2y6TYp8OD+h+59BOCHw3nEl
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EvflR1P1
Subject: [Intel-wired-lan] [PATCH rdma v3] RDMA/irdma: change name of
 interrupts
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: mustafa.ismail@intel.com, shiraz.saleem@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add more information in interrupt names.

Before this patch it was:
irdma
CEQ
CEQ
...

Now:
irdma-0000:18:00.0-AEQ
irdma-0000:18:00.0-CEQ-0
irdma-0000:18:00.0-CEQ-1
...

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Suggested-by: Piotr Raczynski <piotr.raczynski@intel.com>
---
All based on Shiraz comments, thanks.
v2 --> v3:
 - move interrupt name len define to main.h
v1 --> v2:
 - rename interrupt names by adding dev_name
 - set interrupt name len to 64b
---
 drivers/infiniband/hw/irdma/hw.c   | 14 +++++++++++---
 drivers/infiniband/hw/irdma/main.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ab246447520b..d2a215ec531c 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1087,14 +1087,20 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	int status;
 
 	if (rf->msix_shared && !ceq_id) {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-AEQCEQ-%d",
+			 dev_name(&rf->pcidev->dev), ceq_id);
 		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
 		status = request_irq(msix_vec->irq, irdma_irq_handler, 0,
-				     "AEQCEQ", rf);
+				     msix_vec->name, rf);
 	} else {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-CEQ-%d",
+			 dev_name(&rf->pcidev->dev), ceq_id);
 		tasklet_setup(&iwceq->dpc_tasklet, irdma_ceq_dpc);
 
 		status = request_irq(msix_vec->irq, irdma_ceq_handler, 0,
-				     "CEQ", iwceq);
+				     msix_vec->name, iwceq);
 	}
 	cpumask_clear(&msix_vec->mask);
 	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
@@ -1123,9 +1129,11 @@ static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
 	u32 ret = 0;
 
 	if (!rf->msix_shared) {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-AEQ", dev_name(&rf->pcidev->dev));
 		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
 		ret = request_irq(msix_vec->irq, irdma_irq_handler, 0,
-				  "irdma", rf);
+				  msix_vec->name, rf);
 	}
 	if (ret) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: aeq irq config fail\n");
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 65e966ad3453..def6dd58dcd4 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -115,6 +115,8 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
 #define IRDMA_REFLUSH		BIT(2)
 #define IRDMA_FLUSH_WAIT	BIT(3)
 
+#define IRDMA_IRQ_NAME_STR_LEN (64)
+
 enum init_completion_state {
 	INVALID_STATE = 0,
 	INITIAL_STATE,
@@ -212,6 +214,7 @@ struct irdma_msix_vector {
 	u32 cpu_affinity;
 	u32 ceq_id;
 	cpumask_t mask;
+	char name[IRDMA_IRQ_NAME_STR_LEN];
 };
 
 struct irdma_mc_table_info {
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
