Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EFEEB1075
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B831C6066D;
	Tue, 10 Mar 2026 15:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fhx9OliS8Uee; Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D875A60B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156455;
	bh=Xi8Rxb9N8gVUASmXPG2lAu3yO+J9YHYyyksDmdHBdxY=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SnhnNP5Y70DJAyxXOl2L5m35N9V0oLkjUjf12Qd/dMtM4fDfvvUqqlZr1AY4c/1gA
	 CsSJqZPxe/minJ9SSu+2G4Bg6S3wgfL8RuE5oK5zYY7cufYtyIIGvo2Q2G3UMOw8R1
	 GWwXJUcFY8EqAIDXiVRJPy8OFW328d8ZjP5kyMArYRD2CQgGSbwDfBg/NJoQJkBH74
	 8AzE1DLXftevJL5ouQ0qSW4Sm6oFGRX+x89ZYkoLziqcG2PwL6B3ZIdCe+RZAuFdyE
	 ZDYuoWYp9hAYLJwmMSjFdjRvg7CtnZ4+H6FcBFj/JO77qv638saM0DUHMMiLR/1WxV
	 u7RZfKwJzR0sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D875A60B33;
	Tue, 10 Mar 2026 15:27:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D615435C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7C8184129
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1B15by23jgt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.120;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0778B8410F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0778B8410F
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0778B8410F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ab-b734-7f0000032729-7f000001bff0-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
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
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=1PXfnuytcDxCJ5WvjcpjD44YA1sDO5ZH9mYGPwGsGfw=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYMDPZu3smBGrrjEDAZgewRd/vSzrMtCJxCU
 Ab0/aCneJOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGDAAKCRA0LQZT0ays
 2yYuCACBFSism0sJT51wNOH3mmVipRWFOp8Vg+RkYWteB8QGePJlSbJv9OJm09HMkW7tLjwUyWX
 VVHeC9B16w6ID+8gEcOTClH7t/fK4Dy8WecKHkh0F285AVZWcglgZ3SjIJUNbcIL4vnctyxVDTz
 UXRKVqYZS83Tz67A8a3xEjr7wme1UPPk+FME5Cb8slTwxHRkeibjPT1wP0LHzCbUOIo6nCgv8R7
 jLfvDCodAoO4aPJRzL3vfdPDFaqXegciQKVWThwHK6Iz+gXqJuudCNdAk8Oa0FFSpSor2eNbdWj
 hK6ZRlUo0db2BRvH/nraA1HapgaLEA9P2vfUY2mJwp9Lzm4g
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-E0DD4A3D-EB59D507/0/0
X-purgate-type: clean
X-purgate-size: 1400
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143724; bh=1PXfnuytcDxCJ5WvjcpjD44YA1sDO5ZH9mYGPwGsGfw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=J3wSWYAgTHffE/RASKBpQWq2ySnTd5MpW6YLASVrV89gusHRkOxfAkrwsTjGvFaNS
 hDxuWWXJL4XVOl+LI/t97dlq56rN6Kpzc7n2jHPxY+V+uUTEo8r5Ulk5M3qiRSRkq1
 dYJqASb6U15Y8KxN9uh8urreNs5K4N5plRC3Hf68=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=J3wSWYAg
Subject: [Intel-wired-lan] [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL over
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

To: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Ben Segall <bsegall@google.com>
To: Mel Gorman <mgorman@suse.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b09e586ae788b7f2e6336332d605a..cfa869bd7de5406a5ca094992ab04c62b0e92fd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3688,7 +3688,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	do {
 		rhashtable_walk_start(&rht_iter);
 
-		while ((dsq = rhashtable_walk_next(&rht_iter)) && !IS_ERR(dsq))
+		while (!IS_ERR_OR_NULL((dsq = rhashtable_walk_next(&rht_iter))))
 			destroy_dsq(sch, dsq->id);
 
 		rhashtable_walk_stop(&rht_iter);

-- 
2.43.0

