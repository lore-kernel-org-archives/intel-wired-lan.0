Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0529EB1076
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68E8B403EE;
	Tue, 10 Mar 2026 15:27:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zk35HHcnaEoo; Tue, 10 Mar 2026 15:27:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1C5B403A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156428;
	bh=wXP6inC1ot/jec8Yz2mJDj/4GFF4TcysvA1pHXvsm5c=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULnB791rMbshriok2DNN0h0WVzNYfAssSnGxH+Fxos3gcO5eguWe/jj1VPDFFRq9X
	 oXkNqE+NgQTh9qrM0vFzg2lTtF49obuGsO/NwW16Q4MfAk8eodTDv0FMRTYpfZsSUR
	 qseQHSajYhkbrbk15FZZ8H013epp0Jdxqfzj8NTceV/lgyYqU2d4CHTQG9JkADo18M
	 43Dl0jXktoJykd/lfuEW1jUyMgWE7WdRv1tj5ItGYv+klGD3OLv0GFrh+wvtdgjDOg
	 vSINKWpvy7dFRmA4uG3zpf8H2itSFat6MIjM5yY4mmNlt0zqtkYJqtb/cn+zaPw0ut
	 2ylDtWEeoItVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C5B403A9;
	Tue, 10 Mar 2026 15:27:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F4B835C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 914C2406A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZJjogi1ONqG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.94;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B9AA3406A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9AA3406A7
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9AA3406A7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:21 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ab-e21d-7f0000032729-7f000001d976-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
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
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=FEizU4OZfQ9wQ3wvLqHfhAD95k5qump7I9MIi0BZQKk=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXdroDlhymGqsGkbn1SZv53cw4YuzOIIwtui
 bzXW6sBBQWJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF3QAKCRA0LQZT0ays
 2/1wB/sGTAYBPIahrXD3EXFQ9FcpHqqnw1r9sZLiba/u035gmw5LoaZhwTxHDBskl2iaWkVnIXz
 Iy7Anuu/HF1GBhMkP4ZE553CQedkoQLkwUxzFneqcFtg8dEj/bcSSJoqNhuTbcFTeYPFZ2FuuJR
 mi6wxSHOtk1jHNn9K4y3/ujXKX8zNKkMQCDkESe1H1kZKzWifi4aoEVftzahJtLslDJIa2qDL4i
 OSDOnojL7uRKrSwdvp+XJGBIrrn9XWylS2+dg5zaohBqwfc9ulGK+fMI3nM/n2Gqrv2OPrXEBM6
 17i7pbPmqS6afMN4bPYcsNPNwynB+aJ8jBm/4wPpjycn86fZ
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-7B60AF2F-D466ABAE/0/0
X-purgate-type: clean
X-purgate-size: 1467
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
Subject: [Intel-wired-lan] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over
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

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/ceph/dir.c  | 2 +-
 fs/ceph/snap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..934250748ae4fd4c148fd27bdf91175047c2877d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -889,7 +889,7 @@ int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
 {
 	struct dentry *result = ceph_lookup(dir, dentry, 0);
 
-	if (result && !IS_ERR(result)) {
+	if (!IS_ERR_OR_NULL(result)) {
 		/*
 		 * We created the item, then did a lookup, and found
 		 * it was already linked to another inode we already
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f922bfed39550311e793bfe3622cd26..528ad581be160713f91416115659e2dc6f259576 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -902,7 +902,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 bad:
 	err = -EIO;
 fail:
-	if (realm && !IS_ERR(realm))
+	if (!IS_ERR_OR_NULL(realm))
 		ceph_put_snap_realm(mdsc, realm);
 	if (first_realm)
 		ceph_put_snap_realm(mdsc, first_realm);

-- 
2.43.0

