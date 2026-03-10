Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAB7EB1072
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C481441C93;
	Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9CyDhDH4mZoJ; Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39DC641C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156455;
	bh=UZ1R+4oZb1OFARHwN3kW6NWT/McIyfCGe+74kGs96GA=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4vxiu77CabWlHfCXnPniWaeb39eEYpD3OjUeKxHkOmd3nJiEGoyqjalP5i2a9PZll
	 crIs9A8ASOl5HwR2+yXeYZgTNdpjC1yAr1iChdI5Ci3jTYKI8zjngPGrIgIuuKa4jf
	 JJzfF/lC/ChdSfp9D05i5CXhF1Ak8x0cyGdSgK9Mes+orXsMOvfZSx0WGXih+V8tw+
	 0t8cIiII1Am3fDqP1/mMgqh18udt35BtUcK4Aynx3n9nSyRSd42kcV9b7neOymeJ5B
	 SVSPU+7p1opRKHYhnl/69/cIhyYNb34WnEaohjk+hjn8IpRAixgBghyyB5rPyNkyV4
	 yftbi74ZYeINg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39DC641C68;
	Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7CA335C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E3BC60B56
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IM19wmEbPoCF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.120;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8FED260B1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FED260B1C
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FED260B1C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006b0-b734-7f0000032729-7f0000019cb0-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-59-bd63b656022d@avm.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=ljsuTOpGREUyGER98xbD6/ci86SD8pohlonTQBpqGIg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAafUF4Co3bKHEJh1nSPEbGPanpbmXqLGBVTE
 nsli8aGTIqJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGnwAKCRA0LQZT0ays
 2/eqCACfKEiwIm4grjaffCaqYK9UtMC/I42k93h5L5QQzw4cYMYd8FGhvLp+Ug9Jk9iQltpydL0
 M021kU+8e5LuC9HNGAP+FvXfKicTrLe4WOGLghTKJxJD0Qnwt87qFBwN4C5TgDS7lK8yPptqdRT
 xavsstUunap8iVxwbzeUWdgcTpG4nsY9KAjliWo7xLgVYhCSEWYrkYbks39zWe9p1rptJWM2IT/
 +/O3p9icHSV3twwgGTFQhBYPys+tvE7XNArxXHhB+XYW7AEdqLgSeLiL6ig5y++9xZFwEIcnWi0
 5dJklCZYTethhL0MgTuOAEkoSCl0Bk6MDrD8akTrSRkzdCkv
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-7AAFCA3D-1B7F7E41/0/0
X-purgate-type: clean
X-purgate-size: 1118
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143728; bh=ljsuTOpGREUyGER98xbD6/ci86SD8pohlonTQBpqGIg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PqCygKH8TUTFzdsVoltpS6V+urh3nKuUaWPGyQ9+G5dBBIMLMlSqFUF2pQu2ztCks
 nKjygDeUmN//qOptE9nqaXpkixC5XmuX8GEDJn5HpI8613PWAZldzQgtG5ilRHjEDe
 PPv3OqXdqRSmvRO/4sRCoDxU/Kdn2GWugjDbKUbA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=PqCygKH8
Subject: [Intel-wired-lan] [PATCH 59/61] debugobjects: Drop likely() around
 !IS_ERR_OR_NULL()
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

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Change generated with coccinelle.

To: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12f50de85b621a743a5b6f2638a308f6162c6fcc..12e2e42e6a31aa8706e859aca41b81c03889cffe 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1024,7 +1024,7 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (likely(!IS_ERR_OR_NULL(obj)))
+	if (!IS_ERR_OR_NULL(obj))
 		return;
 
 	/* If NULL the allocation has hit OOM */

-- 
2.43.0

