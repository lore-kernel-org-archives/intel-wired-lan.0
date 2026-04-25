Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1B9FF8850
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Apr 2026 01:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B28681871;
	Sat, 25 Apr 2026 01:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3d7OZ896imG; Sat, 25 Apr 2026 01:48:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 031D48186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777081739;
	bh=81CODhtfCeY5gOXc4AcZuOqtvysUpw25zIQcp3J/FQg=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=w5lImyBaiD1q7bM/tF+w8OsAOqJvk60y66ZIngYOGhsysQ3s2Q0W9Sm4ot3MNDfxL
	 tddv8nbH4zdus/TK46u83gvHsjcRNgzSj93G/XYYJc4Hke4knKJ97u4maX1tjzVqER
	 faas8qJTikEVzY4nlLfP6lO5JaWL1VWNOoj2gyNrrzelg2NWQVeYNyY2lCAXZ8Vi64
	 HoCGt5qUX31ykako+2muNz7A6RhjwEpca2gFQolyqNK+jvo2MvgMDz2+zjOJEY2hlt
	 TRKtAs2G3qHoLZklxuL0fndWRfCwcFehuZJQyFw0CHP5u8PEg9//vEOMC4QPM6xOJ8
	 4SKhUVGS+bzZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 031D48186E;
	Sat, 25 Apr 2026 01:48:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 580CA194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Apr 2026 01:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E47C8186E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Apr 2026 01:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tf22Tyf__H6B for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Apr 2026 01:48:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com;
 envelope-from=3hx3saqykd8gp22zzwu22uzs.q20w17sz-aw5sr-zo1zw676.26826z.25u@flex--boolli.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 925028186A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 925028186A
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com
 [IPv6:2607:f8b0:4864:20::1249])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 925028186A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Apr 2026 01:48:56 +0000 (UTC)
Received: by mail-dl1-x1249.google.com with SMTP id
 a92af1059eb24-12dbf4f678eso15237934c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Apr 2026 18:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777081735; x=1777686535;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=81CODhtfCeY5gOXc4AcZuOqtvysUpw25zIQcp3J/FQg=;
 b=XHa6WdgkpOhaSPZagbdBopnHDkXPzhfHMIHo6L6dcjLG7Xp1XV61uvGzyptsi8mJCs
 uVkikozemhS+VtSOMPSTmOfTgR/nuG6CGD7EGFEizmDn6Znyh3krK71Xh3iRjHcUNzo0
 9Z5xsMVFtcdP318ydrYI5eKYwOSwn9mV1NO6odYaRfCK/PLoBM9zmO+8ncQj32FMaTqt
 HZXJH60SjATqcQoIvpCEjs2EqGh67GR28sir68osaFl3PGIam/zucCvEY35RTWdmzO0J
 SeWb5Jzz9BCgyXSzHvG5qJ2bHcEe5Szj+D1dGYKuIf8ex7DmRf6XQ9F7ytgM14UpIcqp
 0cmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ952LhmzdEAUpm9h9PZnumsK+je3WG74nyvDFwJK8m0zvOJYpsGTx/1usQXfWY7tEsncWmamLbZ/ohtwzEJLhk=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxUacytZe/Ioz+W1cgMZvmTyF6PbLdRnJw58IpDGEibpTnMbwjC
 zKRHAcA8DQy0HkdCTqWopTXEJrcpB3e6OKzOIw6eDC/401299RuLWZoK+U/llfrhchzftbcWw+B
 /v98Pjw==
X-Received: from dlea14-n1.prod.google.com
 ([2002:a05:701b:420e:10b0:12c:49a5:e4a4])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:60c:b0:12a:713b:8958
 with SMTP id a92af1059eb24-12c73f7596bmr17260924c88.10.1777081735213; Fri, 24
 Apr 2026 18:48:55 -0700 (PDT)
Date: Sat, 25 Apr 2026 01:48:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260425014842.1036981-1-boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777081735; x=1777686535; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=81CODhtfCeY5gOXc4AcZuOqtvysUpw25zIQcp3J/FQg=;
 b=AvJJeVshBsMlzxkY0OdCErk+W1EIbNn2I1aQyslE/4beHf+OJCpqjZwB5ZxAdkliFq
 2egzciVy8jJ4fN1MIjquyB8L/KusQOpTdMhxtgQqU0ay29tVq/2Xix91WT7po7E0Xs8/
 sP/wI7+zdF9ktcQTeFZ7kckyFjkDdE2Ycod/yKWVtEKRDb6Oah0TR30TashmX+2uPUmT
 FIAQBvifOWNP/TuRmXySM1IQK0hlZBN35xAdA87NoeFxAf6aqoA1fW/js4BuKBFIzIP3
 ACJMz+aC7eP+IEMGAVbrI8Y0Q0GQpJZNZjFc32tA6XkSt6EHFWTSQcqts37Iq2tf72Ci
 Cncg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=AvJJeVsh
Subject: [Intel-wired-lan] [PATCH iwl-next v2] libie: log more info when
 virtchnl fails
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
From: Li Li via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Li Li <boolli@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built and booted on a test machine.

Signed-off-by: Li Li <boolli@google.com>
---
v2:
 - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
   reviewer feedback.

 drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index ebc05355e39d..bf200fea1e12 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
 
 	xn = &xnm->ring[xn_index];
+
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
+			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
+			msg_cookie, ctlq_msg->data_len, xn->virtchnl_opcode,
+			xn->index, xn->cookie);
+	}
+
 	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
 	    msg_cookie != xn->cookie)
 		return false;
@@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
 		params->recv_mem = xn->recv_mem;
 		break;
 	default:
+		dev_warn_ratelimited(
+			params->ctlq->dev,
+			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

