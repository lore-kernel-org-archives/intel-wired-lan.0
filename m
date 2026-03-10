Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E32AEB1070
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA0C18132F;
	Tue, 10 Mar 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVJJ41D6SBJB; Tue, 10 Mar 2026 15:27:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26C6C81329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156451;
	bh=FfSzQd7kv4UrwUhbLdoRlPs9cYP9/YWD1INFReBo/3M=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rjxpNgq3aPvQxuCYdii1DI9LHYIoiEtISdndS4QaBxX62eN0KA6VYtLvZgX9q3rdH
	 15PTdvIPAR1zm7sIuruMV7q6fw5l1fL1233O80e01GR0U81DYVB2EIf4/QwsGOwJ6J
	 cvk4fqnw3KWMvrfX8ur/PdRB2NQ6IX+o6LR1dGLLCkeZ4BDYlu9zjlXo/1ClZfBKa4
	 Hx95+1PhLDObq5cGJmHtAa4rjFkIom43Oq4B5hptFF3ji1Ye/ewgMWI6o1k3JfRHvT
	 R27V99uFq6pXPYiT9bAyRyccApUcm5tv2ocLQJXkhN03DMwlC4rHf7bDk5cCbd15GK
	 88ppDfyf7crsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26C6C81329;
	Tue, 10 Mar 2026 15:27:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC06935C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D588404F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4kE-ozBdstyw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:bf0:244:244::120; helo=mail.avm.de;
 envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DE99F403A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE99F403A1
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE99F403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:04 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ae-b734-7f0000032729-7f000001c0a2-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-43-bd63b656022d@avm.de>
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
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=7kdqP+tYIFKXEbW/CcutoIH+BaTJGO9lG8xGd+KBKlA=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZn1sZXeMLIPVJuPMvtIFyA6+Lb/ZSleHAPf
 T0qLrc6EciJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGZwAKCRA0LQZT0ays
 20K6B/45z034OMVnc7IW5eSlZRm22idjp9lRSYx7bSAgasz9Q69aq8L0v4zLmsPUTUANCklIZV3
 Ky9LpL/JQ27BKEBlPFUkZv7HOQgdozWfUf51X/x0BdMhEpEPDFIJUTovRoUphEHN8rw1r9KUQDQ
 dRKeWS5ua07ZtP69du+2qOW1Bjj55fWBu+uxvI7fohNlQeSwssQzt0rpy3r+7xRxxg0LdKDF+Eo
 Y+QuFzLHRhLpEtgPju+jKGgQPeWyFuaSnteU1ZzTdDhjn5fvjXBJ7IuXzcVk6epAYwi3YolC11O
 rwheclTeEca9nqJY9eYYhG9OXtZeHQ7d173Po939eVnoDlQn
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-E3DCEA3D-4F569189/0/0
X-purgate-type: clean
X-purgate-size: 1170
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=7kdqP+tYIFKXEbW/CcutoIH+BaTJGO9lG8xGd+KBKlA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=nh38mtwHyUV9SKw+BNpXSRFMzfO8/FcrsieQzDWw9oji2O+z7Psbni6v7KAffehjx
 qmid8HatIGHMRnktoTMo9XRdUV6Ztkx3lRZel+NdFrmuz3TY6gos5gVQP+DoaQPsNi
 ndWgzemtoyfAka1Tah5hiKpjxy0BL5dDr2HvKeZc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=nh38mtwH
Subject: [Intel-wired-lan] [PATCH 43/61] s390: Prefer IS_ERR_OR_NULL over
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

To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/s390/char/tape_class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index b69430220a813e764ec1514c27ad486ac9e95575..aad4fff1faea69ae055b517910ec6467b14cb6e8 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(register_tape_dev);
 
 void unregister_tape_dev(struct device *device, struct tape_class_device *tcd)
 {
-	if (tcd != NULL && !IS_ERR(tcd)) {
+	if (!IS_ERR_OR_NULL(tcd)) {
 		sysfs_remove_link(&device->kobj, tcd->mode_name);
 		device_destroy(&tape_class, tcd->char_device->dev);
 		cdev_del(tcd->char_device);

-- 
2.43.0

