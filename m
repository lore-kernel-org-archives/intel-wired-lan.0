Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A670EB1072
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14AB980FA7;
	Tue, 10 Mar 2026 15:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMSqeFNYom8g; Tue, 10 Mar 2026 15:27:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F28778116B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156444;
	bh=lrRXsh0QP3uQBo+fRrmRSbxajRBSUkQFtB6HeorUnAU=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKrPlVp64F++T/jR3QQA64nAVwmd86IDU8nUbU+xlVHVL8Aw65XDdA4D76opn6BvA
	 hJ+7YxF8gheGjPX7TJK+kTK3cW/wMytj3/BjjbYCniLTlO7Wm3+NUsu3Tt5U3lOYEQ
	 5aSk7KPVf9SGqOIB0lJ0gl27vrd54vjnHZkfS9j2S1lu9WF3QOEThK5IQAycvoO24D
	 JGJOqU2EHJRLHak5tDL3W6cp0qcUNfrlrdanPD6w3K6BMitRLKWmakEpshC6rCbQBp
	 nfwqhjQV8rsJGS68ZV1vtE7JiRnFJALLN4WycZEm28YPcANBTFIYXV/XN5bXOHJpet
	 3NfRugmfRRQOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F28778116B;
	Tue, 10 Mar 2026 15:27:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F97C201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBCF54209C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLd2rAMnM_nL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:bf0:244:244::94;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3CD7941FB6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CD7941FB6
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CD7941FB6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:20 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ae-e21d-7f0000032729-7f000001da46-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-40-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=OG5VAiuGyzJgANNFmhgEdiJnvt9YJlG2KvCxr7UGm4k=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZdX7BuYNUIT5gp+HdcH5WlcPs/igfKSrsAT
 PQS+sW6TAKJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGXQAKCRA0LQZT0ays
 2/NeB/9cvi9goE8RWfPmZWHWl3KHJ0IK1niSHPDuRHNTDiNM+uFP9eXaUfJVBsSlG1Wrvh2+TJe
 E9N4PWX9zPPmgAp5c7pkgWQbvcINWsfQ1xzs1yuBHGsqvNtAKAsQzgwmgDGwuWvubUvPlUOVRcp
 yVNORqT1RMYwWcOYu1sgBDKncm/OAEpn290nhfRgs1yTJZoXMdM3Qo3tnRyHHZBM6KJSQfrTcAN
 m09EN+RMlpdZuT4NVV6TCBCJKyPJuHYu9on1qpX149qmJ5tp+DIgif8s3ztCwKsBs1+MXzsdDLr
 s9Zz5Ncp+UQA6p8+C4T8PIAGabbdKYRKG/eLYl2cB6wt3ozJ
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-8EE65F2F-4D55CEAD/0/0
X-purgate-type: clean
X-purgate-size: 835
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143727; bh=OG5VAiuGyzJgANNFmhgEdiJnvt9YJlG2KvCxr7UGm4k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JAdZI+FehAdfAN09twwfZHH6jDfh071cQKzCXwtIuoVqEEpOJJcnao39LQt63y4t/
 7qNOwbcUlaXsU8odvsi+CNxHeM67JZXi3Ip3hqOsWbsrOWQmqT6Wf8Y7+vMqlEol/o
 yXX6+U61Z17F5K3SatxnKB4/2w/h4/gfhRTup+tE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=JAdZI+Fe
Subject: [Intel-wired-lan] [PATCH 40/61] phy: Prefer IS_ERR_OR_NULL over
 manual NULL check
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

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53eb1c63f1ffd2217f767c2dab5c3a..6416e9097caab56f7ba663777eba2c06291dffc5 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -699,7 +699,7 @@ EXPORT_SYMBOL_GPL(of_phy_get);
  */
 void of_phy_put(struct phy *phy)
 {
-	if (!phy || IS_ERR(phy))
+	if (IS_ERR_OR_NULL(phy))
 		return;
 
 	mutex_lock(&phy->mutex);

-- 
2.43.0

