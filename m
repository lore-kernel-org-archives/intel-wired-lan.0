Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB1CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4413260B5C;
	Fri,  2 Oct 2026 13:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XxCQEdbiKX6D; Fri,  2 Oct 2026 13:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9167D6080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946550;
	b=NBr53isA7noOI68qMPxpHxtEVpYJhRy+YhUyJ/NfR/8ImdYGjlRB2j7TKd+6qe2U05oa
	 dDv8yXuYW9DBhKfhu1KZiJcntMVh0Pl7ATaE0PBibPr/MRDcV7gjfJLpGo+TjG9VBjURf
	 ualUe8DVf6Oqsla8D+iWcuClvaPbmb0uihknBZ2q/84c6HQOWgDPGpuJHLOCp19Soxelh
	 FlWsqLTrXY5vqzG662HfAsh2+pp6aXs+34vcDOgL4QJi0VuAbDj/W/0y+AsVLnx+/1s9d
	 nI0wGT12p3Nbq8mwPX498WCNE1GTiTlUgO9PDRHRf9a7MMMISXMJYd0BypeNgNdx2OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nQSqLz5OriNDY7xfFl5J4UkpqFctIlNQ7RGwSyJ7FGY=;
	b=GP+YH7lSAJtKqCPpWd2NxE4jFuD0cVs1JC1q9FFDBE0zkoWwtLY5v8GouPdfq9gmlI3B
	 TE00p7jSFwxfsR99HY3N0ZrYBl3F5opXXJ0C3DePCsk78cZj0KbMqozwRiMnv04I9cFdc
	 ltpS4t46zlkREJbIBjjwlFQPqfJepzzlkJ25kNYX8w/1R6n4rENZF9mloM3AQSKAymeK8
	 3q0KwV45A+G8+yYXXUzf07//cfoppirUjNGl3cfqb10iXJwk6iW3mCJ2cx7r5wKYYjt5C
	 NeYO+UsHM+AdA09JWJzNy3t8+bZVfqHMW6fZU+MKHAT4+rC0dig4fr1QhRicvLPR73w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946550;
	bh=nQSqLz5OriNDY7xfFl5J4UkpqFctIlNQ7RGwSyJ7FGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1SO/Nz+wz8HLRMqd9A2EnjKV1r1FJRU+GF25TghJDQZ0cDZH1NdSuprAyXONjkg3
	 MRos1vxNWKRE58a24C6tPG596dH7eiQzfntzMoI7HtntpDTqoz+xN5vXdRhJDbc3yy
	 vBkc2EbmFC0FCOqlKJc/2qPwc2vVjgnAo764nnxGTlVdygN9gG58mzDXUeeJFsyCTv
	 N1KrYKEFaaJKOE/CTfqKJT7Q3quCBl2nWxwqyO1cq9PQTENuJI2QneHumUIRqxkrjI
	 o5qW+PiV2mRPiE2bjfpqN8PSH7ITTnbXuoy7kRZ2Zd4NV6CI5jXhTMjm4eh0DN76UY
	 RuA2AI+TTFgGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9167D6080A;
	Fri,  2 Oct 2026 13:09:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91A49282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8334D8125E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdpE6FIjpLrA for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B65A98124F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946549;
 b=ZEUDGR0iJnw97eYrwhLwf60Osq8RTN5HLziNCXUNHgrDzeRec+Ap6yBn+0MM4On6qIyJ
 etUaztP6fRWTzcZPHb7iUSzQDRy1unJVwkkpGrj4K6Iqzd/PzSxz5z7GGNqqOGPeEXa21
 yRMYbxQR1gxNxd/eEkDPV4mmSh6WbjL1Z4QqRfjCCsOo9ZSUwOS8/c14xEZHEnywKTFNe
 woPD2t97Tqoqo24XexLVAD61XFFgmUsu+24DXmDsizqERxnU/QbxdqN/22tlbPr8dFEu9
 cJ/WO0vWAOMZ4fJPNS+UFkgUemXTUJYi/DGTKV+em2SxODY36PVCJ6Cgxe6gOOtjXyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946549;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=nQSqLz5OriNDY7xfFl5J4UkpqFctIlNQ7RGwSyJ7FGY=;
 b=puhvxYl0A1ZrRWwFju7sEv4ZjO9lsmo/1+nbvLNVXFiNNN8Nz//NaS186VBVAL94ZBdu
 R5Ufh0vKZ+AWh+O2KqFaz/XK0wd8CroG5Qq4qBKnhVM5lUgXpxykA7z4ESFHxxpoQv0P9
 dn6b8PquE1U91jSnIVgBp2NynchYV0BGzlzGQMhBOLtTEiSejlz+9PHjZ2kAqr/AErPly
 tAoL5pFBo5mJeBRl2RMemnET03AyJ32sza08K1NXJyIZ0mkpWUrhEcRlN13Yhtdbg3EHV
 xg0gXf+9YBt1Fc8kMyMYiRpgwHx92fFvQI2QAm/rfk+GnmmV47bkFX6P87+T6Ftn3rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aIn9mCfq; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIn9mCfq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id B65A98124F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQSqLz5OriNDY7xfFl5J4UkpqFctIlNQ7RGwSyJ7FGY=;
 b=aIn9mCfqy7W9Y83xJyfeVjtFO52W5wbwGFValWJyne5g0Ap+osDM7t7RXoapnCnAvbonOZ
 7N94mRWGd3qMfLUomG4jdx/O/JMHb28V7lTjctBy0xdh0ZIuUWpXlbRqBnoEAYZg+rAnIc
 /+KcekxLSqN8pn+0H2ovet85DIlPPNM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-dQ1eSqRdP66QrJr-KhpdFQ-1; Fri,
 02 Oct 2026 09:09:00 -0400
X-MC-Unique: dQ1eSqRdP66QrJr-KhpdFQ-1
X-Mimecast-MFC-AGG-ID: dQ1eSqRdP66QrJr-KhpdFQ_1790946537
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 728C7195F149; Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9561D214; Fri,  2 Oct 2026 13:08:51 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 08/10] ice: detect a PF reset that does not complete
Date: Fri,  2 Oct 2026 15:07:50 +0200
Message-ID: <20261002130752.2597259-9-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: azepJLTs4Yj92kjRP-QnydfDugap2EiAVSW4d7KHyN4_1790946537
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to
ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
the timeout check after the loop still compares the counter with
ICE_PF_RESET_WAIT_COUNT alone. When the reset never completes the loop
ends with cnt == 5300, the check does not match and the function
returns success with PFSWR still set. A reset that completes just when
the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
instead.

Check the PFSWR bit read last instead of the loop counter, the same
way i40e_pf_reset() does after its poll loop.

Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 04633103e3e610..0ffd6b5b81239e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
 		mdelay(1);
 	}
 
-	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
+	if (reg & PFGEN_CTRL_PFSWR_M) {
 		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
 		return -EIO;
 	}
-- 
2.55.0

