Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0BFC25B78
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 May 2024 23:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AACD402DA;
	Wed, 22 May 2024 23:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXNHMSnvVTh0; Wed, 22 May 2024 23:13:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55DDC401F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716419617;
	bh=Rbo6pj7DzmYaxMPYk6l4aeo7Pj0pzJzyF80d2rCjlCc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=WPzrGT52elg66BydyoFjcK6/sGT+xKhkQP6bvmYUKbs0Jw7FKHG50RIzNPp36rUHD
	 brInMRtrKc/KSk3KA2VA4UHfABEHQrQvW+8vI1t1xxDO5I14a7fp+JVmg9oxQV8zrR
	 ncBVJsDOi1VhsHblfXJN1DNBxguFOtZ9eNJeNOKQY6bS73Q6wU7r643WGTjE8tMmN4
	 xYcHDxDe2BL/u5zvEoLOgDS2bOKyjtGjZp6Z2ebnOBQ3ufCOIkTp1Y3ATIA54VcGgB
	 Fm62v9xwEElmDw8Q5Dy0lzPaHi7mtAgMkp7lBUszhNZYtkKeIT/b7c2dgi13DNFpfe
	 TBs5h6AhOnPBA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55DDC401F2;
	Wed, 22 May 2024 23:13:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9958D1C60D4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 May 2024 23:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 820CF821B8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 May 2024 23:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymH5Dj1U5gGi for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 May 2024 23:13:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mschmidt@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F713821B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F713821B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F713821B7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 May 2024 23:13:31 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-tpyqX8J-P6a5gjJXbuF7dg-1; Wed, 22 May 2024 19:13:20 -0400
X-MC-Unique: tpyqX8J-P6a5gjJXbuF7dg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95C9985A58C;
 Wed, 22 May 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBE440004D;
 Wed, 22 May 2024 23:13:17 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Date: Thu, 23 May 2024 01:12:56 +0200
Message-ID: <20240522231256.587985-1-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1716419607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rbo6pj7DzmYaxMPYk6l4aeo7Pj0pzJzyF80d2rCjlCc=;
 b=XCEcHy6yTEKdjFKSw009uS0VfPMmJFxGd8bVX/NIzBGsyFlL2NXGV6QEKdgNZP82RvAuyU
 wqP/DqEVygD03Vbvup+dSLRjPpYQ0Nsn7eyzVZ+YRmAaMXcfFOjxrkOMWC5bhERDM6tA4f
 LwXf1P+ZezrpeF51LeDxMbBLmdEbUTU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XCEcHy6y
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: use
 irq_update_affinity_hint()
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
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Nitesh Narayan Lal <nitesh@redhat.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

irq_set_affinity_hint() is deprecated. Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that.
On the contrary, when the driver applies affinities by itself, it breaks
the users' expectations:
 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
    order to prevent IRQs from being moved to certain CPUs that run a
    real-time workload.
 2. ice reconfigures VSIs at runtime due to a MIB change
    (ice_dcb_process_lldp_set_mib_change). Reopening a VSI resets the
    affinity in ice_vsi_req_irq_msix().
 3. ice has no idea about irqbalance's config, so it may move an IRQ to
    a banned CPU. The real-time workload suffers unacceptable latency.

I am not sure if updating the affinity hints is at all useful, because
irqbalance ignores them since 2016 ([1]), but at least it's harmless.

This ice change is similar to i40e commit d34c54d1739c ("i40e: Use
irq_update_affinity_hint()").

[1] https://github.com/Irqbalance/irqbalance/commit/dcc411e7bfdd

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5371e91f6bbb..0f8b622db2b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2587,8 +2587,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
 
-		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(irq_num, NULL);
+		/* clear the affinity_hint in the IRQ descriptor */
+		irq_update_affinity_hint(irq_num, NULL);
 		synchronize_irq(irq_num);
 		devm_free_irq(ice_pf_to_dev(pf), irq_num, vsi->q_vectors[i]);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..a5d369b8fed5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2607,7 +2607,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		}
 
 		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
+		irq_update_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
 	err = ice_set_cpu_rx_rmap(vsi);
@@ -2625,7 +2625,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		irq_num = vsi->q_vectors[vector]->irq.virq;
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
-- 
2.44.0

