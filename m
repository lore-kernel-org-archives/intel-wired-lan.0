Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1C8EB1073
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E1A581282;
	Tue, 10 Mar 2026 15:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ph_aYPKIdVWn; Tue, 10 Mar 2026 15:27:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB547812B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156445;
	bh=YHzgGZovp5R3ovSImQbhUGUsyfpkJhLDogat/KIjBPE=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bd1rero+YdAjOArjAKsencbQqGkGmxDTTHcddBj4X+FJR9SpiTcE3hr/E705MZlnU
	 oEI6khiB+vuT8M39GgMquVPbnQyHZAYu11dNuYhWTswUC82J+riIQueanvfHVzcGEP
	 11yseLwa9rjz4QjfRythgrNZa5rk/p66LHnDxNqxXevNUtfWKJWPVEa3W2QbsCep6K
	 EvCCRGtu3DTVJXcS9dYQFw8D3WsnkBU3QafChu9YNSjM/D3Xs36rBP+f+C+0XJRu9/
	 KLp/cyKunE+N/j0C623GLzo6zMRmXofcXd/mDaBJmgljl8iS6jKsxInPXoesCuULgk
	 LR2JSUEjiPOQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB547812B5;
	Tue, 10 Mar 2026 15:27:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E1BCB2A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4870741FAF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id be4bY5TSsb9K for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:bf0:244:244::94;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C15E4201F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C15E4201F
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C15E4201F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:21 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ae-e21d-7f0000032729-7f000001da20-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=pDm3lCNTlSjUg9te/2qYAZpsW6tvI+d2q74vAk/3XKc=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZQlhc7PU7tZE01ILV/cgCsTY0g2y915SWo2
 WOp3PFfMVuJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGUAAKCRA0LQZT0ays
 25iRB/4+DNoMMW2koOlN/DfR0crLtH1nZDxAJOmf/8RHXFfdriIuA3iATU5mx4bxDWjpvaGsmVF
 sScQl/IREquLsn2WvMNqP8VTO6O5b6dTKbFCMkwD4BQk0G2mg/TcyproVTFFc53eOopbKdhzKTm
 Isr1LIuVwpZ0FQ6SRPCDxxmnQfxV1v9dSs1qwmVTacxHLQeT5J39Og4hMR9wi3vpAJ5eehJCv9n
 lR3Su7JxXXqg12+uTsE16DABRCYs7reggRC+HE7/WglPKMOyMs6b/M6GTKoEx8jwE+9yNdG13UM
 RWdxOZdqo69T8hgV/W9OJAR9jWWipbKE58eiOeRYxFyI6r6y
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-35BF0F2F-C3FAD55E/0/0
X-purgate-type: clean
X-purgate-size: 1016
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=pDm3lCNTlSjUg9te/2qYAZpsW6tvI+d2q74vAk/3XKc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fVELfbwvQoehRpaJFY7JhfI6hh7CeBxkQsPfYq55sQ0vUjWp9z+lIlt95Xk2AyEJh
 PbXsF1cpAtdhOegTLvrb0S9nq62cukWwwyYrxLjCI0wmTbF+WNMrGuES99sNVPjj/b
 EsWE3JQi9cza2Xm4SWbcDWKe4CCvCMWDAHq2lZUk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=fVELfbwv
Subject: [Intel-wired-lan] [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over
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

To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 arch/sh/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 5bbde53fb32d785607f8281f9e9cee16d16fc551..06c3bfe2511fd0d5e67e28a8882aa9159991c30a 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -97,7 +97,7 @@ void __iomem __ref *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	 */
 	mapped = pmb_remap_caller(phys_addr, size, pgprot,
 			__builtin_return_address(0));
-	if (mapped && !IS_ERR(mapped))
+	if (!IS_ERR_OR_NULL(mapped))
 		return mapped;
 
 	return generic_ioremap_prot(phys_addr, size, pgprot);

-- 
2.43.0

