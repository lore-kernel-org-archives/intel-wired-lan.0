Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55566C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Nov 2022 23:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C618E60A71;
	Tue, 22 Nov 2022 23:48:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C618E60A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669160920;
	bh=tZxpuSwm1OKEtkLJ9s3OYlENcjppt8IXEkXm3Tkf5JY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=khNfl1Hek+Z97Zh00HldOoFcJbHnJEQjYstUU1fCj9BR1K1itKjAkpWzzY92gMxr0
	 bvLsQe/UloPVaZ5l1fiJ7ChjjUw3YJX4U8b2rL8hwZRiryRTfYGTy4qe1ulMNI+syg
	 ukPrjiM1mRoBs00s6WA12+Ah/VPrjtOkoHIY9FIafeMaFCBq/HzA/5ZdO14Lq8+jh5
	 CO3rwfRIjea42Og9vWiBeyGJcW1PrB6Gobc5xJCXEbQurDYO509NDVIXklKA3CM7/w
	 U0P5V4pI5UpBsMXaG5ycOb7vGClQvht1U8OsIwE7cFXpOH4sv3dR9AAubg1u9ygyqF
	 PIZilJkasfupQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KM2bIZrpoqPq; Tue, 22 Nov 2022 23:48:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7E2660AB7;
	Tue, 22 Nov 2022 23:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7E2660AB7
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 32EEF1BF2B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 23:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D4DF81361
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 23:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D4DF81361
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UVcUduZIkEWH for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Nov 2022 23:48:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37AF780DCB
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37AF780DCB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 23:48:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301496593"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; d="scan'208";a="301496593"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2022 15:48:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970654798"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; d="scan'208";a="970654798"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2022 15:48:35 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 22 Nov 2022 15:48:25 -0800
Message-Id: <20221122234825.3360663-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669160917; x=1700696917;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Scbz7bpST9DNs8l1oOtF/J8oFT/dXn3HQpKWXxkcn70=;
 b=RE4dVzOcODFUiky7Sk8vcfbS2BJ/e2ZRLAgv4i88nhHYIpr4tDWOuTod
 +J1XFil6c+tgBBHw+gD9pbDcBWK5669+mUTbkBbnCmiNbD8xUfUz3K3GV
 bxHcXAkYx7+AliIADb1FNt7DGuB+nuMTp+Sgyis9AFBIvMKTitPSLPBT3
 ZLUcZACjHdmP4xA8Ov6pmlCSXmw2rs4ixxiYX1BKT/icTXwamDJvozNXB
 Zgc3cV1W3Vv7R408HvLyvCc+GZL8e+y25iEheGbSMqx1VA9ZNJaSgV52q
 i89a6Ogq2mqf4eyioNU9sPsabREl8i6QKe+YP/DiZtOzGv/CSjwIril5a
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RE4dVzOc
Subject: [Intel-wired-lan] [PATCH net-next v2] ixgbe: XDP: fix checker
 warning from rcu pointer
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
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ixgbe driver uses an older style failure mode when initializing the
XDP program and the queues. It causes some warnings when running C=2
checking builds (and it's the last one in the ethernet/intel tree).

$ make W=1 C=2 M=`pwd`/drivers/net/ethernet/intel modules
.../ixgbe_main.c:10301:25: error: incompatible types in comparison expression (different address spaces):
.../ixgbe_main.c:10301:25:    struct bpf_prog [noderef] __rcu *
.../ixgbe_main.c:10301:25:    struct bpf_prog *

Fix the problem by removing the line that tried to re-xchg "the old_prog
pointer" if there was an error, to make this driver act like the other
drivers which return the error code without "pointer restoration."

Also, update the "copy the pointer" logic to use WRITE_ONCE as many/all
the other drivers do, which required making a change in two separate
functions that write the xdp_prog variable in the ring.

The code here was modeled after the code in i40e/i40e_xdp_setup().

NOTE: Compile-tested only.

CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ab8370c413f3..93699d2ae051 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6647,7 +6647,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     rx_ring->queue_index, ixgbe_rx_napi_id(rx_ring)) < 0)
 		goto err;
 
-	rx_ring->xdp_prog = adapter->xdp_prog;
+	WRITE_ONCE(rx_ring->xdp_prog, adapter->xdp_prog);
 
 	return 0;
 err:
@@ -10297,14 +10297,13 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			synchronize_rcu();
 		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
-		if (err) {
-			rcu_assign_pointer(adapter->xdp_prog, old_prog);
+		if (err)
 			return -EINVAL;
-		}
 	} else {
-		for (i = 0; i < adapter->num_rx_queues; i++)
-			(void)xchg(&adapter->rx_ring[i]->xdp_prog,
-			    adapter->xdp_prog);
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			WRITE_ONCE(adapter->rx_ring[i]->xdp_prog,
+				   adapter->xdp_prog);
+		}
 	}
 
 	if (old_prog)

base-commit: 50ae3afd446667c6fe540f41b84ff83172c38b27
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
