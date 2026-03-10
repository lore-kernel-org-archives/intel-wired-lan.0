Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEE4EB1071
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B9C41C0C;
	Tue, 10 Mar 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkZtPq_9s1dz; Tue, 10 Mar 2026 15:27:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B083741C38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156451;
	bh=C3ysDg7oU3Ik8LJ7AkFJ4IpI0srzE03Ecj3qWGQ34tM=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=frdJ5IKcv6lfFzkyQvWQ63gmdrSx06txrBPjjryIgOnT1ESdk9d+PS++nKzGMJr4U
	 uju/6AMBbtaxgQSc7Ec/nQuSjfeiLob05EIo759jz5Hwjrg0JaRHExhijugxVy4kPO
	 y2sNSUwvBUh8JRgr+qCCZRc5AxKe0QaHk4wfZXfwXJFqFZfMujk5aK0yYm8wadjGTe
	 ESjDeNGZFfGyCJlvo5ETuMbX144Y3EY54+dbhE+31hw0ZkV3zI4Ac+SEw/D0lIX5gg
	 WpyRsy0CJNh75cGk9ftQlc0gOBqhkD0BkH6X2GEqkiMXjoVEllRKJQIgK8MmhMeqpd
	 0Jxfue6pKhStw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B083741C38;
	Tue, 10 Mar 2026 15:27:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 132A5201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04F7E403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WMZcFKK-R255 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.120;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38338403EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38338403EE
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38338403EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ac-b734-7f0000032729-7f000001c052-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-27-bd63b656022d@avm.de>
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
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=iG/6Gbypjz2OmWQb0dXEIiFm2wHO3xZ/QJrRffJjoq0=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYxKX27oPhhgjZ9L2aN+uf2Pkd/lJuV0FZGx
 7sT5NeXxfGJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGMQAKCRA0LQZT0ays
 2910CACA5AX3Aqq6mMRjUqWLJkwISGQ/SClIom7gyl5y4YdXmFh365btAW6CDMrujm4g2yYHKMn
 icMIaMalhr2gJPGai/SU/Cr5CZi3ZY+4gua5T+uq+HkP8vLsixdy6MzBKvC4YJ7SQ9u1y3suTJ2
 dXw3LfFbSDyXJK4eAmt3Q9xLN+IDoqMq7+VyONJtkwZmjMDy5iHAJpd4FamMBrqSwy4GaDMKKm7
 glgw85FRb142AMKifN1ghWcWZj4AIrKdQR8M3/bZ64Q5ElxSWaeaZ0coUuPBsdwn1welLaCtuOr
 MNnjMGoWnx945CHnVYBBpgGh+sR8NWsokX9o62B2ZLaEYpxG
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-DEDD0A3D-09A71CC5/0/0
X-purgate-type: clean
X-purgate-size: 1047
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=iG/6Gbypjz2OmWQb0dXEIiFm2wHO3xZ/QJrRffJjoq0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g+N0/sgSQ8SRQky5YcCPVvBqWjz0hDf6/mz5MXtIt5pp3nndKwnydeDBFFaGciw76
 fK8hCsX2XQfm37mz50EiEfGo9ClFJDaFX6LRzTWB5+xeibMvG/0El8aLjh4dU3qpIV
 pdtzYGFmANh8kH/hW7lr12MBHwTlKf1PiSqCWud4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=g+N0/sgS
Subject: [Intel-wired-lan] [PATCH 27/61] net/netlink: Prefer IS_ERR_OR_NULL
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

To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf40653e04de60f2d28ee26b8bdcdc2ed..58707b9da84adf1002ab9eff9401fa2083374189 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2667,7 +2667,7 @@ static void *netlink_seq_start(struct seq_file *seq, loff_t *posp)
 
 	netlink_walk_start(iter);
 
-	for (pos = *posp; pos && obj && !IS_ERR(obj); pos--)
+	for (pos = *posp; pos && !IS_ERR_OR_NULL(obj); pos--)
 		obj = __netlink_seq_next(seq);
 
 	return obj;

-- 
2.43.0

