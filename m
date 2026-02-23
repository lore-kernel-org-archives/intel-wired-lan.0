Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4C0F3C9AE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 16:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45324613C6;
	Tue, 24 Feb 2026 16:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4K_j0R-btJK; Tue, 24 Feb 2026 16:22:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2090D613BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771950150;
	bh=0bwm5Nf4dsIJ4dR/VdMoNSiuanpBP1kEATX+PGa6kPw=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PHkNSgIDvdrGi/IxB9CcwRfgmRViKHEwF3RaaGOO2r/wL5mV7skm/DUn/brNRaGY6
	 dlq9As7IO37G3AxMYF3EtxChFjiRbILZ6yeUxJKpoN4NImTm9DpJ7t2r2hCzTJuSll
	 0cZz4r8Ardl6K+Ff58zzM3UJpDE5B1Z8s6rl59JTyw8B+6LtYRuhIzcutw39cXBsDt
	 2wNth8kwgxAG7n4hHzNRDe/94g0Zh/4wcYF7SoSyRF/ulzxyrsnkRJNWuEu5N5YPBY
	 6X+nnsrAGUSQ5SYvxjUzihbI4DODKA9dhQitgjzQ6zpJgHmNifAFsV7rAlhFYlEaoY
	 IxTIcSyIrVhqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2090D613BB;
	Tue, 24 Feb 2026 16:22:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 801DF2EC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 705D982A72
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUY5NB0ZyfJw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 21:57:12 +0000 (UTC)
X-Greylist: delayed 400 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 23 Feb 2026 21:57:11 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AD6608293F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD6608293F
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=199.89.1.16;
 helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org;
 receiver=<UNKNOWN> 
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD6608293F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZNM1hPwzlh2fJ;
 Mon, 23 Feb 2026 21:53:07 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pCRkE4jR25AD; Mon, 23 Feb 2026 21:53:04 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZND0zL8zlh1Wk;
 Mon, 23 Feb 2026 21:52:59 +0000 (UTC)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Date: Mon, 23 Feb 2026 13:50:34 -0800
Message-ID: <20260223215118.2154194-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:22:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acm.org; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received; s=mr01; t=1771883584; x=1774475585; bh=0bwm5
 Nf4dsIJ4dR/VdMoNSiuanpBP1kEATX+PGa6kPw=; b=cxjk2LyseMoL5z2szKY4L
 hGVc4VK99SmQztNg27LRyprsrU5BvzVmk1//a+B+nescSu7X4EXdiTm4+J3uYsOB
 n5TG1AnudPGMZpQAZcVh8ls3UW2vuH3CJkZv7JMZNPBDI1RFDeE5Mbd5FzRKAvFm
 NxzG3kybQk8QF71NH3bZBHjdenD/Uyrp58aHNuL71vgSJItqMwTNxrY/uFO5/5tk
 PSHbtrHnMinV2ycI0LNVI7O2oNeYJVf2xyFf6bpILi7ASEt0GY3r6hyv0eyZI1Kl
 FsI977LPICRPPxNv060LIgZRS573msxtPnjz6c728woydG8jVlNWBL3wsWWH6zfV
 w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=acm.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256
 header.s=mr01 header.b=cxjk2Lys
Subject: [Intel-wired-lan] [PATCH 19/62] ice: Fix a locking bug in an error
 path
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
From: Bart Van Assche via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the ice_query_port_ets() call.

This patch fixes a bug in an error path. Without this patch pf->tc_mutex
may be unlocked in an error path without having been locked. This bug has
been detected by the clang thread-safety analyzer.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/e=
thernet/intel/ice/ice_dcb_lib.c
index bd77f1c001ee..78ded6876581 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
=20
+	mutex_lock(&pf->tc_mutex);
+
 	ret =3D ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
=20
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
=20
