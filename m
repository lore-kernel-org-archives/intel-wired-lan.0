Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC9FEB1076
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2B6240412;
	Tue, 10 Mar 2026 15:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQjgCm2MMIYe; Tue, 10 Mar 2026 15:27:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E55F8403AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156433;
	bh=fjJobOr1hAQHKATPAuWIHrWpFe9f0JfxfPXIwwWzS6A=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQlxxlRtILVWGXG8ODvPugI6yNVdDQ/xBNega7jURW+KZprPLTsc1SOrbRMLbIvOf
	 t9IB6O9+V1XYHkeI9UG+KK6b5fYz6IusIf26HyWqflZuFrqIcwMiZC6TDXUlCrey02
	 sAsMXlP1bIVui9Egw7ka80xwWLemNuGJCl6B+fPau+4XZHtAgdHejlAxIvjnROCm+0
	 YHAxMfyhZAABkBuD7wLCes9H1iRZgRNafGC3dGWL3pftzsxNBzhNd+t414UJCIKIXi
	 YgndsbywneEXL4bbWvbttbk3E8RSQr27rt/T6NJxfiAWp+fQSvIM8P8X8exNHwe6U4
	 XDQxXkf7H7Gcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E55F8403AA;
	Tue, 10 Mar 2026 15:27:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2727F201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F102284247
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7kuPpLy1yrO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:bf0:244:244::119; helo=mail.avm.de;
 envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7538A840FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7538A840FD
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7538A840FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006af-2367-7f0000032729-7f000001c9aa-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
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
Cc: Linus Walleij <linusw@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=7QEjQvc53kHdYvJikGIe0XIqNo63J0gbffxhQyvvDmc=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZht0v/gzetsO7BqEut/SimpAgjLSUxejqDN
 jYPITjd+qeJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGYQAKCRA0LQZT0ays
 2w/2B/4pX609pdZXvqHfb+Vqmmi/TuKtxSLe3zgXgKoCJW/gh17vsp/T22wIBqf6SXS4OIznDwc
 CqIbsgeOEAAlNDyBRYAY6KPNdElI/rv3fa2ORfx9RdjhIHa4x5wKb3P01gEbIVxJDT7L+eaQBY5
 W5yNdsizunhdj+FuJcUWkiWweG/sakXiGLIkqX5NlLESVIppvEGGOaxwjbsMisZ9PSaDKihHXQV
 LTJsTcuZgnx6Ly3LMJ0SQkiMEfMsx1Sbu6dG9rRM3ckN2uFTC5HrsnBNmmT4sZqY9FpULICBCkq
 q7sHGVDOpWpuw1oJ3VO2Y9YZsG2cD9KHQpB9olXNSESNKBcu
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-86C91E1F-25F0153A/0/0
X-purgate-type: clean
X-purgate-size: 976
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143727; bh=7QEjQvc53kHdYvJikGIe0XIqNo63J0gbffxhQyvvDmc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=xkT1xwtnaKnF5zwky80U90tVBtgjXUcX+GeykmrAvdmpppC5+8VK/cr2uIrG8dU1M
 7wm2m1OyU4JV6u1islMHTFtIiUXXXY5n/w/md+c+5C+f1bhtmzGNVLxiuCLq3+FykP
 yZ+BZpZfQ6y4Yx2gZPgoiPOharwFnkzMOEjjrW34=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=xkT1xwtn
Subject: [Intel-wired-lan] [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL over
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

To: Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index b5e97689589fbf1b6750620fc193bc820012be2b..97a80989601abbe969d4b64cb0f3926fd4f291f5 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1991,7 +1991,7 @@ static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
 	device_root = debugfs_create_dir(debugfs_name, debugfs_root);
 	pctldev->device_root = device_root;
 
-	if (IS_ERR(device_root) || !device_root) {
+	if (IS_ERR_OR_NULL(device_root)) {
 		pr_warn("failed to create debugfs directory for %s\n",
 			dev_name(pctldev->dev));
 		return;

-- 
2.43.0

