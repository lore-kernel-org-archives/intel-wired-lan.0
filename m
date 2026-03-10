Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DC0EB1073
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24D94811A1;
	Tue, 10 Mar 2026 15:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NPhNmSYZqMh; Tue, 10 Mar 2026 15:27:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 933F4807B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156438;
	bh=zS/lt7IufKQt9b00w4tg0H1pDBP8jbAdIjOpgPRguTw=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N5Gj7Da3hmkEMjz9C5CWf9vvfbLyQcZClI4fMnXXlNQ7XPl5YYAXcQw+ByN2jMP8M
	 4komEOO+2jjx4Mk4hz/Zv2MUk45ertR7zdwE4wg4nqIJxS4T7hAuBvqF6k64m0Cug9
	 cc0ZBqTz9anel9udGcSs8PhiiD5jH0RKJFsNEsnhWBT1+13hzUOFISBRK2QygZKhBn
	 ZuVlAPsNOvNWt3wZmRB873zuUAB0zpUeYsfIDWDaJTl5ugjrkBneP2MHN7QfggdpiQ
	 2qkrjbPf0a+cA50fBAy+KAV4vsssLTHcXtIMHq9UPxLGejFPI4zvMeb/9eUkT5xlpS
	 yJ3vjaSviAK/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 933F4807B4;
	Tue, 10 Mar 2026 15:27:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15D6C201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B5FA60F2E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhz53oORUwL1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.94;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9259861545
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9259861545
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9259861545
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:20 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ac-e21d-7f0000032729-7f000001d9ae-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-9-bd63b656022d@avm.de>
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
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=0D7JqCvM2HduGB7jcCjsvL2MgPxSPSMnqWoOW6gFXPg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAX0gr7ZqouZ6B9Y6l873KDZh87VRkMxmLSVt
 AItcTzXYr2JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF9AAKCRA0LQZT0ays
 2/XgCACwqNRVP1ceb2sCHMTvH8vznLrrwbRdBid2VGiRwlIoIqclnUBeLwwGZ/n/hBxtkijY1s3
 NziYVgznq0k9VYxacmvzAvuKhhv5805K9y/+itK+PFXmzL3ZRzqmfWP6ng28fVSUYAufwVEc7CR
 9llIbOBq8N4aCpqTBELhb7mwymU8hNLZpMBK934i79wnmNx9OySShuCrTBL+FEQ9g/aUtfHcqTV
 4JM/tu/NHEvIwEfZrC8rjS3HwU+8fz/vbF4We+/TjORw4iEGT1m6VfBdB71QF+Wi1viRKTPIkVW
 Nxf+o86GuJolrkUsNGy4WHdCFW95aUilkAjXyF+7XIpdZkLT
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-80E01F2F-4A43AD77/0/0
X-purgate-type: clean
X-purgate-size: 1619
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
Subject: [Intel-wired-lan] [PATCH 09/61] ntfs3: Prefer IS_ERR_OR_NULL over
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

To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/ntfs3/fsntfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0df2aa81d8845f21bfb571c408bd65b9e1fb8128..3ced4f95c2e95bac1fe5b334f976b8c8a15cf19d 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -237,7 +237,7 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 
 	/* Try to find $ObjId */
 	inode2 = dir_search_u(inode, &NAME_OBJID, NULL);
-	if (inode2 && !IS_ERR(inode2)) {
+	if (!IS_ERR_OR_NULL(inode2)) {
 		if (is_bad_inode(inode2)) {
 			iput(inode2);
 		} else {
@@ -248,21 +248,21 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 
 	/* Try to find $Quota */
 	inode2 = dir_search_u(inode, &NAME_QUOTA, NULL);
-	if (inode2 && !IS_ERR(inode2)) {
+	if (!IS_ERR_OR_NULL(inode2)) {
 		sbi->quota_no = inode2->i_ino;
 		iput(inode2);
 	}
 
 	/* Try to find $Reparse */
 	inode2 = dir_search_u(inode, &NAME_REPARSE, NULL);
-	if (inode2 && !IS_ERR(inode2)) {
+	if (!IS_ERR_OR_NULL(inode2)) {
 		sbi->reparse.ni = ntfs_i(inode2);
 		sbi->reparse_no = inode2->i_ino;
 	}
 
 	/* Try to find $UsnJrnl */
 	inode2 = dir_search_u(inode, &NAME_USNJRNL, NULL);
-	if (inode2 && !IS_ERR(inode2)) {
+	if (!IS_ERR_OR_NULL(inode2)) {
 		sbi->usn_jrnl_no = inode2->i_ino;
 		iput(inode2);
 	}

-- 
2.43.0

