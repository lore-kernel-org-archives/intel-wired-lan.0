Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6DAEB1072
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7F2D60B30;
	Tue, 10 Mar 2026 15:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwsI9ljRBtXA; Tue, 10 Mar 2026 15:27:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6CE3605DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156432;
	bh=gy402GJXbgyAJ+YKb8LodXTXPBtJ8ptnh7Eq9VEeyMQ=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qQIONtjkdcASixOrPD5czPH4BTVFOjFWJCei8d7d+VEh3hptOoWc7lAtghE00kSzA
	 mv64jfK7zaqUHJjUIS1DFyWxPRrguUYwLPnlOFrkpRGPrrJURo2pB13poKWXX4gUzX
	 VMboEajVo02WOopuusMZRTjmVtFWrKX+9gq3n9DReeOhXtJb8bV/9Y7ClEb/ocipBT
	 pEpi7aDnpkaleSSJzxbsqQmq+SRGNRKOBJeJf31Q23bAYe2DXopasGeWFdK1wJidWZ
	 2YtN3Y5jy4ymmyf1WoVBIaLehKYMThI2m0isDx4Eugvq8cTUFZtxwmWeDUXPb1jbQf
	 Dockp3+TLkTZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6CE3605DA;
	Tue, 10 Mar 2026 15:27:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 243CAB2C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95428420A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eK46ZWSxKUi6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:bf0:244:244::94;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7BBAD41F18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BBAD41F18
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BBAD41F18
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ad-e21d-7f0000032729-7f000001da1a-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-31-bd63b656022d@avm.de>
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
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=ObADPYZ6pJh7dF4ZtW/umhCREHwhUDWMyq9N6rBcVwQ=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY/UcXAwJovG6A4nB7YjchfS8dWMTKJR/2Zu
 MZwvRUzfSuJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGPwAKCRA0LQZT0ays
 2xl9CAC38JfIZK13/o0jdZIM8Gu3hUV57MgGCpPmPgAkgZQzEtBGs2FDO8Fx54b796heUI6C17z
 ZbGY2wRKWGjXSBCngfD+Y2a/1jCSzGEuQ4jVEtxbgFKGiVGPc8zPo3j7RIqGt+XkDfXhUJV/WGs
 +J2xRVA9B3RKAYgO58tDVBDDKVuZmX4cu+ETIaOpu3+o52epJyZqzezdrVwvwMz+c005iQpPVgY
 LKvEVu+vfw1C/S2Bm6+j0K7soEoH7Q1wM0z8TR821F0SvZ3KgnganCVQOD062Ix1eouKRv0CD2a
 gtvYCJFRo6JoTu9p/1jJVnIebiN1A5uUYXaP+Bibs/sNVbrI
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-2FBCCF2F-19F0E4AB/0/0
X-purgate-type: clean
X-purgate-size: 1123
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=ObADPYZ6pJh7dF4ZtW/umhCREHwhUDWMyq9N6rBcVwQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dw1nuFFWpVVdrKOfBC8Dj4wKZMjU9ddsg9cir5xT91Je3Qc4zdD9Tv9d84zEGU77U
 bneXu7o4d3sJr/YNLcP9VRF/8FE25ShEW6LPrPIHkFN36JlEXF0VOvnj++ND2duaOC
 CYWW988mCr9Su8D1d7S5dskAeFMN3TEqL7EVGhxg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=dw1nuFFW
Subject: [Intel-wired-lan] [PATCH 31/61] net/tipc: Prefer IS_ERR_OR_NULL
 over manual NULL check
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

To: Jon Maloy <jmaloy@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/tipc/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871db681e69f7aec8f660d6130a13346..0d9cb21ffbf1539b7740e76521e3aac5fde322e3 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2971,7 +2971,7 @@ void tipc_sk_reinit(struct net *net)
 	do {
 		rhashtable_walk_start(&iter);
 
-		while ((tsk = rhashtable_walk_next(&iter)) && !IS_ERR(tsk)) {
+		while (!IS_ERR_OR_NULL((tsk = rhashtable_walk_next(&iter)))) {
 			sock_hold(&tsk->sk);
 			rhashtable_walk_stop(&iter);
 			lock_sock(&tsk->sk);

-- 
2.43.0

