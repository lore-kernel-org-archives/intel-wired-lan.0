Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AD4EB1070
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06B9980BB2;
	Tue, 10 Mar 2026 15:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kE14J02V6mQ; Tue, 10 Mar 2026 15:27:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF3F281380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156454;
	bh=oVRlrvP2vbgXglr+z2zhizXrLgYYAnk6ZwkJlTNfyBA=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S/ZSBrNVvjxy8WMHDaT4pfMEQM2c0Y6ZdMjPx4N0e7Sa9vI/j9SG1BqqDn5Nngxro
	 AprJsSEQ9SFb7g7pnCLneZImbAHULP1fgKlHNYLtJHL3NUAYtFPFWHUqv573+qLWfl
	 2jXDa8O3ahdFbZU1MAqcKmJxSQ/O67nKCTUmGl0JJJLRtiRUB+9MADbHFRXJkU4THQ
	 6iOjlKWLRwR48g7BBHcLdXrX59p92opfR3feG8CdaKF+2RisfdY8S2bYekmUahBHtM
	 01k85PLgYxFIvv2CqNnHgXXDHUxMNj7FAy68gG0Rh/cYEj+lovu2hiFbt/OXBXvDxg
	 ZrMvAJ+thmlhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF3F281380;
	Tue, 10 Mar 2026 15:27:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1997C201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BD0B41EAF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bl-RmVMg3Yac for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:bf0:244:244::120; helo=mail.avm.de;
 envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41B5841EC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41B5841EC0
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41B5841EC0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:07 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ab-b734-7f0000032729-7f000001bfb4-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
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
Cc: Miklos Szeredi <miklos@szeredi.hu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Z5CcgUmxb8TIHuxVENT8+Rdbeolb2IW3uV9KbiLoZl0=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXxKvlvqCH0DwJSbq+UNs0LTyfOD3vzlRqtT
 2TRtqiRMXSJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF8QAKCRA0LQZT0ays
 2xgMCACJUN2JSxzamJUFQvwc92wfvAAIT82LlFBC4CNAPLjUwClhfMFmMBmKAZA8HDz81VrcG/p
 fo2P5eS+rFs83E9iVI/bW+OpSphb7hd9/Pa3DNpSkaQcLQUMHw39s5ltgUYmcwhQdUpEa+pWYW+
 gg+34EAVtKnYkmIuH1aWQKSSPRHXFEEIj8Mu1YI3EnTGvDB+NleQt1zN6UaIksTNUf5+3I2W33b
 Z+hxOEmA2AEpaox3bemtlkSQbWv4qtVtcFYcWHKzhKpkUH0i5WAZ0lUSrDgtHsTI7KM+223fQQ9
 V7CmYp8rYAFlP8Yb8uQbtjIbd9Kw5z3oAZRh0mglz23o1NU6
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-035C7A3D-B44CD0B6/0/0
X-purgate-type: clean
X-purgate-size: 892
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143724; bh=Z5CcgUmxb8TIHuxVENT8+Rdbeolb2IW3uV9KbiLoZl0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HvCb/8oi+QjPTMN2Yg58hVQgISqDho2KSemsYUZ+vy5VD2bnZIm5jRkx5UuokMrry
 Cd/bADEMvLj4WpFiDDooSYtHMuljYAEx/RujmrWNzucIvLCjqd0TnsL6u3xLqdwjKn
 SoUF7kcbAi1lGgdxzJJB8ERoQMMzj0TR7iF4FK9M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=HvCb/8oi
Subject: [Intel-wired-lan] [PATCH 08/61] fuse: Prefer IS_ERR_OR_NULL over
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

To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12323e3afb97b98301f623bce917a4..7b39c013027bd9c4ba6f080bfc9b3ec22bc2dd4a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1599,7 +1599,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 		goto put_parent;
 	while (!entry) {
 		struct dentry *child = try_lookup_noperm(name, dir);
-		if (!child || IS_ERR(child))
+		if (IS_ERR_OR_NULL(child))
 			goto put_parent;
 		entry = start_removing_dentry(dir, child);
 		dput(child);

-- 
2.43.0

