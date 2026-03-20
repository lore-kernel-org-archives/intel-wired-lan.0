Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F3109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 880DA8452D;
	Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGJYLq9jMf6n; Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 400E28452A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773969919;
	bh=/QYC4SzEuyGRG+kJyCDzSpHDYzTJ7+UZHrEymifymEA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yxFDuCexyrd7FD3ApylG2+Ljw7N7I7CcGUEwKMm+1SR2oZ2KtgKAWLpW6MQghwhbX
	 CQqtB0mdws+movAsXWOB8Arfgs3z78l+hNQLfiDlW/bCLp/dBOrPBmtTKNDmzrVSFp
	 cTzT0PT4WZZ19UO0VnFuCApYLMe+lEjVZWgMel3R4EG6kRxlffcslaMbaui8EewPW4
	 +LsYq8k7m0kCdTxB8nrnoIdyUX/tloKffTA0ktDChSbZviWu2X34WQU670rdUhSGeY
	 5qpl6w7FpQL8D4+ts9mKbs08I8rNNHAuK5Fwvd5Xmys+R7TDg0/emwve2k7zypxDyT
	 zVGzyRMi2ylLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 400E28452A;
	Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1230E298
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F20541BC0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id esSIyDbzlgTi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 01:25:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.82.175;
 helo=mail-dy1-f175.google.com; envelope-from=stfomichev@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4963841BBB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4963841BBB
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4963841BBB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 01:25:14 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c0c955a481so802062eec.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 18:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773969913; x=1774574713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/QYC4SzEuyGRG+kJyCDzSpHDYzTJ7+UZHrEymifymEA=;
 b=fWQygyqb/OEBthgQt10WZfbT5r+f3fC9cPpcQoH68eGJfMAM+5mcdFS8vKPo5luS89
 jmmNHX9p006a8rU6y0ku3/CIYh8wpjMu+N2DDkBBDRhuEDFC/gdIe6NVuXmsC+wyTWyp
 8Rhw0+kJ3dLxyuzH7DIvVPajUXwruXfWCMR1IrJCbNw9i8F8/cyoELdUW5tR1goC++0u
 lni4D8hywn0T6dsK8J6U2Lqa0f7HQ0hcbVHkABCt4AKa0DqGkISzIW5MwHR6SKJrOUQn
 8vVA8VdUrSYn0BCzVgMuB6+eIAc0Fw2dNxgr4wDGBa/y89qAZhhVHcI3Izi4+mXtdN69
 OTjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf1PhJKTwFO6ia2lXN9CvM1E7RvsEp14brGo6cdELWTm2QxAmMapq39US8FEV4wM9QqoZDEQ+slkTa5jJo/60=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzTLxvZ642JoMZ38DC3Q4TYV3CifkpNkrqc5S9QG6/kt+U7Yhy6
 1g4etHN5sqSEpqTH7/Th5PTqX/1bitc1ZD63R4DvaPibuTigW96klIM=
X-Gm-Gg: ATEYQzzjjYf+OInz/FXI8HBh4/KvBX1iTPJPGTsj21XIxon5TO7yxG/t5hjxTpKzvyT
 3+q8sytGPMuN4nHZ3KyjfV9k8C/l8150FAVp3ZSG8wTQ2ZmlXbIVd8OB66kwIxEko3VNhyYi+/r
 uT2gCwLtr+QX0knVpUgBjX676aDyNnlcuHOkw2yTORpanC8206tQHil3zcOQzNKSaYsH5kZRlD2
 fhyL2mvOTYoFGX0k1/00BHmcEQyVkT6CgYAVXCA93e78HOFDr73oic43LNj+mthfWbBUCjUxXzC
 +a5RTZB9DxPQKHVhtWRclzzBha/MfLc3EetgogGtzvd6aqBkKV1aIgy27eG+4PUuxHeHXKHBMBz
 ccGlx1iOt0a3yE1he8BTUUsCMVhU3Ap4XZLbTDwV1Vd2b3R4CKFlGVe7wD9BEXSkvNox45qKt8n
 H0w0/RR/jACm72xoe3uPaHs7IdbwrbxPwhqpOQN+39LufkiMGk5U3qmqP3aoaF2TD301RnXgSbj
 hadO3K14OogXm0K9a7bvww7gYQs
X-Received: by 2002:a05:7022:6893:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-12a726dd982mr607975c88.40.1773969912989; 
 Thu, 19 Mar 2026 18:25:12 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733e794esm803266c88.6.2026.03.19.18.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:25:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Date: Thu, 19 Mar 2026 18:24:56 -0700
Message-ID: <20260320012501.2033548-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=fomichev.me
Subject: [Intel-wired-lan] [PATCH net-next v3 08/13] bnxt: use snapshot in
 bnxt_cfg_rx_mode
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

With the introduction of ndo_set_rx_mode_async (as discussed in [0])
we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
use uc/mc snapshots and move its call in bnxt_sp_task to the
section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
bnxt_set_rx_mode.

0: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 225217b32e4b..12265bd7fda4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *);
+static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
+			    struct netdev_hw_addr_list *);
 static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
 				 const struct netdev_hw_addr_list *);
 
@@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnxt_cfg_rx_mode(bp);
+	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
 	if (rc)
 		goto err_out;
 
@@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct net_device *dev,
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
+		bnxt_cfg_rx_mode(bp, uc, mc);
 	}
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *bp)
+static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
 {
 	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
@@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
+	uc_update = bnxt_uc_list_updated(bp, uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -13639,10 +13641,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	vnic->uc_filter_count = 1;
 
 	netif_addr_lock_bh(dev);
-	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
+	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
-		netdev_for_each_uc_addr(ha, dev) {
+		netdev_hw_addr_list_for_each(ha, uc) {
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
@@ -14600,6 +14602,7 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
+	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14613,9 +14616,6 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_reenable_sriov(bp);
 	}
 
-	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
-		bnxt_cfg_rx_mode(bp);
-
 	if (test_and_clear_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
@@ -14680,6 +14680,12 @@ static void bnxt_sp_task(struct work_struct *work)
 	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
 	 * must be the last functions to be called before exiting.
 	 */
+	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
+		bnxt_lock_sp(bp);
+		bnxt_cfg_rx_mode(bp, &dev->uc, &dev->mc);
+		bnxt_unlock_sp(bp);
+	}
+
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event))
 		bnxt_reset(bp, false);
 
-- 
2.53.0

