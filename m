Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3084EEB1076
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDB11810F0;
	Tue, 10 Mar 2026 15:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FkZRajD4p96u; Tue, 10 Mar 2026 15:27:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D792810AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156440;
	bh=JeJj0T69WHUPLsIPvgVGO/TfjBqV2iFp2koKUN8LMcY=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIF09E1kndRKvhiYlmu+f9dW4Ryt2JnOdjOXZ7qvDz+BCJwIlM9/RQfHBRJ6u2U2+
	 Y6DEgxC2c1yehvOBbYccDoNuDVyMhZoOEyCZvnWIJIUY2vyjapMkE+sSCSwbo3zkpR
	 M49Mfs4429fMG5jydAtQSiNg5KSvWJj30st8rLxuTvAKrR3I4pEyoQUfFy/6ob/pgs
	 spmaYgtaSzAUJZIKCD/dWCau7zhM1Sdgwck4wet+puNeb4IJOsR9CskcFXtrQQpSuD
	 1mv8JlzHUTPDJMMoRBMYdb+EZX/Yca4sqgMY3KkakCrghUaMLQpOmioyjsN03a2sII
	 jwut4Ale0uYbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D792810AF;
	Tue, 10 Mar 2026 15:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B6F535C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 173EE41F70
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teY2NNzDbXzB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:bf0:244:244::119; helo=mail.avm.de;
 envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A36ED41F66
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A36ED41F66
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A36ED41F66
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ad-2367-7f0000032729-7f0000019da4-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
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
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY7O6x5f/jrEOlM2kM2YjYC7Xq22wW3Mikry
 9AY9ISieLCJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGOwAKCRA0LQZT0ays
 24W7CACaVIegavbFPh1+6gPSjqv5T1Ou5hQU0OcaZ20nx5fdOimad+jK3UuGfZrC9Vgv0QMm0ym
 3OSuSluEWbuIv6zcFp3UbdEj9aI7TM7en4Ha7pCkmDfNfPts09fhhi9VrPo390VGOMeNWeVMtD/
 CQde1U2q7DKI3QtGXyjY9I//uCPpAfeRw/e0X1QSKZ9eOdV+c4uWgQhNCPrPJZrHvycJx2lFn3Q
 ZNRGEplISNXY/bb/iuclRgqFYvGWnoUgBYQkpTrGJqDvFREwT8LcHN3+0nwKoz0xIqQbO7gBWgt
 +Dgbc3vk23keeP8aHFv6AZ7K16GCQyMm+zwDBr92eUq+pHvN
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-8A498E1F-7900509A/0/0
X-purgate-type: clean
X-purgate-size: 2553
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QeZmxS4Y9ZxzJ1P+c7PyBalRHGdguYBtzjQZ1WHuqnNfndJHBOWadzXneNpIO/Cpe
 WtbDE01JXbjsGwDZW/SJl+0F8SgXDtITpS9jrWOZKuA2MxhvXL4esHAjK0cxyNxT8g
 cX9nlCS2vI2XLhpV0lZEIvKvUcBSNRY+QxXEviZg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=QeZmxS4Y
Subject: [Intel-wired-lan] [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL
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

To: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
To: Olga Kornievskaia <okorniev@redhat.com>
To: Dai Ngo <Dai.Ngo@oracle.com>
To: Tom Talpey <tom@talpey.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2e79b1e325396517 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
  errout:
 	/* Take a reference in case the DTO handler runs */
 	svc_xprt_get(&newxprt->sc_xprt);
-	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
+	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
 	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
@@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	might_sleep();
 
 	/* This blocks until the Completion Queues are empty */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
 	flush_workqueue(svcrdma_wq);
 
@@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	svc_rdma_recv_ctxts_destroy(rdma);
 
 	/* Destroy the QP if present (not a listener) */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_destroy_qp(rdma->sc_qp);
 
-	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
 		ib_free_cq(rdma->sc_sq_cq);
 
-	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
 		ib_free_cq(rdma->sc_rq_cq);
 
-	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
+	if (!IS_ERR_OR_NULL(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
 	/* Destroy the CM ID */

-- 
2.43.0

