Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540E6C79FAF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BA3D40639;
	Tue,  8 Sep 2026 15:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7NS0PZQCk1qd; Tue,  8 Sep 2026 15:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D8B64063E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788880444;
	b=Z3QmSka0nMsuxBacC/iOQgcxzkywSGCl/5agIZAnYuiv7dxIPEb9ALlGxkl3yHQ4tIHs
	 SxpqDacnvkSYRYjkUM6jT6l6A0dlDDf/wFInsorKM0w3EKo8AoGeAIZe6p/fqHCXztUVj
	 it+agF7g2dySg4XqbBgvdbVJKw1W3qzppAEtcFkYPN6nMf5si5KgZtcoKdXY2gIDviYjU
	 9ww4lTiM8hZnSuJRTbOh4jb6DE4+Tjm0LsemMLaF8M5nzXGAG/RBs2uRB+DTl/Ypp9RW5
	 dDP/hRCthLQylGWGjAG79MwMQPpmtzok/nXWBbyRtLcQN5QH8Hoz0XvsI0qKNUjY0qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8r9SnL35HhiSLVJEbRnHKRUmG3f/HAJLdYLhcCv44DQ=;
	b=eWP2L7E3NeiCfMrlwu/fNGEUd0Be6ap82UhIq4/vhJcGEZEy88tXPeN9nImdxy/cO6iH
	 wQ7BIniZkh8KfTXXsUXUOuLBnvR2g2Bj+CHMvdHmnUkOF32jl2Sv7oBihCJ5ii1zdukYE
	 8qrKo3Pkrih7SaDoIoz2e4zJvlZa7fulwmk8m1cOgVkNmC7ABK56sZHyBqHgfTLXb6cfZ
	 V+6vp1Ag3xIjoC0we6PKyYDmblqJpkAndnQaD/gerVeWQzDpVeLukcXayhHteWnbu0kdL
	 Z47+wVrra4oZ4Czi53078BP0/OaGOMz9mvSU3zafC4exaM6f1taC7XxTD/QYwRpc7Xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=KBo4vUkA;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880444;
	bh=8r9SnL35HhiSLVJEbRnHKRUmG3f/HAJLdYLhcCv44DQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UTQpO9zcLQCfHtDtpAbgCP4lbx725ahjKn4WQeNT4ts2qd1L+rQQI/NDDy0J1Rz1K
	 BNBW6L52iAhoKoQNKLv6ULXcxTi5QmX18hUoy0EEB939fYNpA1itVuHOS1KIDzEV+S
	 zX2EiC7/jba1x26COed+d1wlue7iiTLH8yw+5w08MFZi4T12mAm5xLaOYG4X1qUecy
	 RDvADm7gahp4wC1F2LgUy0Mzq30D2nxL+fyKrOC673nQk/UfpCdPu62gBoFJRG47a8
	 PV+F14okv58VZTkpiJY2VMmxg6s5FN8mF4hV0qfFCoJd4Cpix+62YhCDE5cw/msj8n
	 GY3bUEKSe81Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D8B64063E;
	Tue,  8 Sep 2026 15:14:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44F25388
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3698440462
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xZlAQZqVqhg for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 17:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6222D40430
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788800700;
 b=fG+VG2VpYxM21Ts4QEXd8YtUJdW4EK9BcRL9FmpKagnhUVAWfmuYzgDmz896ARGDZcVV
 fjmThgYAFnWaDwqFO4ezNdwuFxxpXDVgEM1zyTjPQoopD+biqoTplekB8/TpngRwouIRl
 yhYikS3eTuCUpL2xLaiGPHv10WcI2V3utwmHAErVzcSUjIcoZXYmG8T0phVvYSUXKfDJw
 JMDFMjLCGDTJYkvw4Vr4xR8ZL84ZbtMuyf4fJ9jYukc6B7Qm3PboMBPXa5okMVrDFLMoD
 Zzr3e24Kfa76SHyQca/fOMd2KtoeDbc2a+ehWE3HVQcM4On2kWS3E+nWtzdoui6p5Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788800700;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8r9SnL35HhiSLVJEbRnHKRUmG3f/HAJLdYLhcCv44DQ=;
 b=nX6LF62/yRsW3UYvw5wM4pyQ1RL2E3YWIFPWpqg56+qjKb1n+SvA2Nl39FUk4RAbBZj3
 1D7ElV5SXSQ//qApRAUlr/IeUW2zZbzQ6PoVy3x1r1NNMguKZnVuMzcDuOHED+9c/AWjy
 Jh1/5vIq7uxRxQi/kkKbhMvhNtC1A0x/t9JCrLMzP5Yj2Hu4/fVylj0gum9pum+MPkZTs
 VpuXeoFARz2EhQPNu95IX+Hxvz/rRmpmlhclhIPsGN+39wi1ZQK45TldHmNNeHawxuuGI
 E1HwJsGN9n/DNfbEopdyftz4M15IcgGE+1WTdTf4vnRAW/xuY6Pwfn4zhYYzyzb56UA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=samba.org; 
 dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256
 header.s=42 header.b=KBo4vUkA; 
 arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
X-Greylist: delayed 990 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 07 Sep 2026 17:04:59 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=samba.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (3072-bit key,
 unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256
 header.s=42 header.b=KBo4vUkA
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org;
 envelope-from=metze@samba.org; receiver=<UNKNOWN> 
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6222D40430
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org; 
 s=42; h=Message-ID:Date:Cc:To:From;
 bh=8r9SnL35HhiSLVJEbRnHKRUmG3f/HAJLdYLhcCv44DQ=; b=KBo4vUkAURwWxaGK5c61L2ZBD6
 HAaI50GF6FBzxK//MHyMxipG1loqo/2a9pYvo5iN1wtXgWeLyO4N00+r7OHZZtAh6j5iobJ4kkByS
 LNy0hZ2BotczspO/v92IX9fVD4Y7Y07i9eJSGQgn6hzNRdXIfwOd9tz0D3MBr+K9OnVFwCF1gS/t7
 +lfVkptVw21SZCQW1ZVFSYaeFZcxQ42swJjJK92BRw5JchysovU8VbS9wwQxUnB0zuhjHQR96GOq4
 c4uVQ70mCo2kaGMXS/UBgY7oZU9AN/DKFq70nWVXl+lxzhYME6UkJO6+e9nW1dHP1eEgSoY0iWmJj
 0CHQfmTsf6Y5gTAca9GJemMJaD1WHohg8CcT5gRhL+2qWvFHTHiZ13NlyT1AyHKHY6eD5voXkxD1o
 xy6mZCJvbsxzW390Lr7HeBSsPJu1YrI/KIaMQ5iOJ3MD8CkIFsAAtFbicwU5YVFhF7pSMlrgioHZO
 oM19YAm8lHu3+MIrnsink7tD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
 by hr2.samba.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
 (Exim) id 1x3cW5-00000000BzV-1gZ3; Mon, 07 Sep 2026 16:48:22 +0000
From: Stefan Metzmacher <metze@samba.org>
To: intel-wired-lan@lists.osuosl.org
Cc: metze@samba.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ice: fix double dereference in TP_printk problems in ice_{rx,
 tx}_dim_template
Date: Mon,  7 Sep 2026 18:48:10 +0200
Message-ID: <20260907164810.1048081-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

ice_tx_dim_work and ice_rx_dim_work generate the
following: "has double dereference in TP_printk" errors:

 REC->q_vector->tx.tx_ring->q_index
 REC->dim->state
 REC->dim->profile_ix
 REC->dim->tune_state
 REC->dim->steps_right
 REC->dim->steps_left
 REC->dim->tired

And the first one hits a WARN_ONCE()...

Fixes: 3089cf6d3caa ("ice: add tracepoints")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/net/ethernet/intel/ice/ice_trace.h | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..c641f8ce1aff 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -63,23 +63,23 @@
 DECLARE_EVENT_CLASS(ice_rx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field_struct(struct dim, dim)
 				     __string(devname, q_vector->rx.rx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->rx.rx_ring->q_index;
+				   memcpy(&__entry->dim, dim, sizeof(__entry->dim));
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Rx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->rx.rx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->dim.state,
+			      __entry->dim.profile_ix,
+			      __entry->dim.tune_state,
+			      __entry->dim.steps_right,
+			      __entry->dim.steps_left,
+			      __entry->dim.tired)
 );
 
 DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
@@ -90,23 +90,23 @@ DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
 DECLARE_EVENT_CLASS(ice_tx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field_struct(struct dim, dim)
 				     __string(devname, q_vector->tx.tx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->tx.tx_ring->q_index;
+				   memcpy(&__entry->dim, dim, sizeof(__entry->dim));
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->tx.tx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->dim.state,
+			      __entry->dim.profile_ix,
+			      __entry->dim.tune_state,
+			      __entry->dim.steps_right,
+			      __entry->dim.steps_left,
+			      __entry->dim.tired)
 );
 
 DEFINE_EVENT(ice_tx_dim_template, ice_tx_dim_work,
-- 
2.43.0

