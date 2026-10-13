Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11162CA9ED2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 12:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8496605D7;
	Tue, 13 Oct 2026 12:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vD8CcLsYCLR; Tue, 13 Oct 2026 12:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08A29605D8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893571;
	b=GSkm4U6TZ0YugJLFyzISZxU5xsUkgI4tql+zs88GhzkxL09wvudoL+nWdeZSXMJlUUx1
	 K9+JVDaI2XSy3RRPRbzn+Qpz1rkUQ7rlhDFP09aXJjxsufAk3XyJk3OWibKCGkhEhQKA9
	 UlcYAGQ/HC3y1HED3mhsjfAaF9nnu2O6+09vqK+Tybfr1XCGanAyboQvJLPgQSrlnioIX
	 +SuPN3WmgbsyuZTbb8sklW0iUqtxS03w5poZlOjcpOYdF5bef0iKFpUNAIPkspiYw6KIX
	 KQ/bnRlHwezZfPhhSRyzPyEQh0vve29Q6MtgNjwah6mg6HeGEKvjZi62h4VOx6hPAUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
	b=l07HGrJkeqhLWwxpjd3dJlfgQSz6tzIvH+oo6khPnghS8dQlu28YPHjiHuud8kon5jAu
	 twGRzgwCPlX9A15vV9P7AzHq3lwa0M+fPKktqb/lpBCVsKb1HN5G3ecq+kuNvDrr44BRI
	 ztr6JMNutl0QmeHHcgo1/0L6Hs4pDmyggrys9Dr2aaLmeyp7CVoXUQSPwZTnYlvn9fRm6
	 DBmAehYV16i3uUwJWaCV7Qdzk21u5oh7VFgC7KWA34T1pFZMgwmlE8R9XA9wpWxovUGV4
	 7beEVHHd9BC7MuxlLVcDVTsrha3+UAcilCW1nkInDfmi7XWjwxhr6Bs0OcUUROZqxUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791893571;
	bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jr+K03M6t+Ppg1hQ1wxfCVXByY+zgn9AWlzmiBgf7zUEnyWKD/byLlx4cxJnYkRgS
	 lyVEanPhgUpDGkNWNNG6H/4Vy65Vp0SjJkfBYTeo8RziFrVX5qVu5iaVIlhW3YUOkB
	 HT0D7VSkzkKWVlC23hp5BnQrYaiNvivCNtYxefFVjg5TB1aVbB0ezr/pcAyweTD/WC
	 6MtODJb47GsCpyl35oDYqY6Ovzf1SmhXmSitiMAWIVrJ5WXmRC9hGPxrycmxIiJyWE
	 VrVbYauThvg07jcQTLTe4Z2EM2csOPW6y5Xlzjd7zOrJHsTVJXaT3/qNjc+zlt6JnV
	 SBtpesC8Bve1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08A29605D8;
	Tue, 13 Oct 2026 12:12:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CA9A235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C349400C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3nLZkDCzn4iY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 12:12:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 67D5F40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893568;
 b=RnYfVTlokFR3HFTOxciU1gYyIg9IZ2RF7Y7Hya9RTA8eK+UUkGrGFAtqll8RtMsdFmBU
 4bxxrkWIwRW18CGSu8wkDXLLaUv0v7h2c5/g4ivVotO8tUARTgR5lWU17eD779UidNQWd
 Xht4ZBc3Y+J/tSpx/JaTkl+BAqn33hBm90ht4jn4RfBb3bUOsm5fmWD1seRw7Jg+FCGLJ
 0ISRLE8b+fnWvdGjX6XN/R1Xle1aEctRP+HTRJTpL9/faDVcTBi8O4LqMnMXCNQG10SbK
 7UZtQL+pFF6R7dEnkj6jBE9LnMj2ltw+tbN2GBvrLq7A4kwTU2FNyErgpHwYep8nEnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
 b=gHCv7q9Q05A3mqmDFiLzQNrIi9gL9POADzpuVGe54gLDNkwrDzh7vHFnXhi848L3u7Cl
 czUhqPf5cRvMVyNixPUgQQbgOz17DJ8DIu/JT1fd1iaUgiI4fPatn3DxbgaNWCwwgBGRz
 ljWM6a6HN7eb9IYVJc7yBw4V+ED5S4UOe0tztozZTHqxZAxrfwB4+ywklBY6BWuot6hxc
 q1qqcYT1+C+70EZWDCqJOOauUh5ydxWjAW7ro1Qo6jU2KZk/Wlzf791HU058mz1ocAyKS
 mMFcKEqYHjW/ujSy+yRBe3FRFnygTJcrQApPi3OadRPKs9ctzHrDJhGApnZGwuTFqUQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lSBnUBkG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lSBnUBkG
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67D5F40070
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:48 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso757866eec.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893567; x=1792498367; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
 b=lSBnUBkGzcKgTbcoA5lZkKYDKGKTuzfgX2drhiE4rdTC5YZx55SMbdWqgY4LqH/3c9
 o918FA+JtZcURI05bXhtbv0/+0k8A0k48AtHNB+qdwebdCdynLWpmUZj4PgVLVafIk6U
 LZxIfZpWLkPM45uOfbFQ86gq4MZOutxZgZ++oyaA8BEaO39g5Y2+JDFwivAExFe3ZASv
 6TXWynPhY6kbyjP5GDla5MVCZYlBLdheniT51P/4rHTFWF/uVsfYEWjVh72yd98UoFNj
 9dxNjSZXI4Rg39Kf/M6hcjEVbbdi1Z0MvxOZNbD/iyvLubAbD75C0/nfKITEiGVtwbHG
 LAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893567; x=1792498367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VeXZNjBoqnw5XD9CEHjqXm9+b0DsQCCT5Oh6fOsHRj4=;
 b=Xrj2nnx2dninNQbyIilemXzqgP2+891p6ilEHrOQI2ZQyosGMyq8g8xmHbV8Z4T/16
 sDsr0jZUP+Y1s4W9OARFnG3cLXPMC/UuxcVJFYWTKDa8grfbeSAkH/MgDb4MUmdMm8UP
 FV46iI7Xj5F2kmhmaVF409kZJEvicgkjQKCKE+XGRcNo4/iYZyLJkU3jf0EI02SEHxSp
 rUZEjH/L34DUZtGRltQZ+wUR28J8K7iQ5Rchgv5AHyuLbRHeLObHsaGkhw57b3rqzM/5
 qXv9ykeA/jLE0mfIRWzWRkUt55+MOwJ0R7bQ0Q5LW2SFNzSeyALTNxtzFMQY2j44gcFw
 wWqA==
X-Gm-Message-State: AFq9FYIgtZvxqkXhG/DpekBb/98jetdjbDOFs9LH4krObtXjnpoSC0Yd
 ETAAgjrjsAS8Bx5WsJsWy6NBpQyMxcbXYEfHpW+Y2PuADfMeGMVmNBDo0pC1dujuEhsLrg==
X-Gm-Gg: AYBFou0PJGn7H1m7hJh7ATkXaYnm4O8dbYNbkv+XamPw6bfkT6FLUD1M71qScEC6e9h
 kqjcGI8SWv76NaYlVo/KjnrfdsS0iY3/L4e+uRdAEzLMCOpx7YZhssjKfIRCfQKOloasSrXY6TR
 7jbRxgA3nmSoQIsUS03c57llqiw+woX08x545w6uOpVhh47g+CystoB7eoFmi5nTCInE1krw8rM
 D2wkEg4mnX5LFr9dItI6lYjE3UKneLQmAZuiifxvXzer4oN3r791iX/+Xt+jpmpSs+xo0uRBxLB
 8OagvWCi+G5+5uCgmogspqJmqdvpFYkcioTnuIN7I5wwCKrEFaAb7n2CmFW5Z3H3HAHE29H6nLQ
 8Dj1X5FJNTLfk2ovuaBlD4+NtrDYv3ESBEGAaHkouAo+sZXDn088es15mxct4FGnVkvQQqyveVN
 xRdc+SrWylLGMi5HIWlfD0ZtGKsIjIKfGWClYxJMvyHHvOIZuWm1gyPlwetS8EQ0NumcWwCDMA6
 AgpypRUpA+93VRTx31sdx0udzW/zcxX58jZZCl2dDOZfzshDBiG4VRDkBE/uH94seisOJcwXXPe
 JQ==
X-Received: by 2002:a05:7300:de02:b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-35ccd357b71mr1293310eec.41.1791893567003; 
 Tue, 13 Oct 2026 05:12:47 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 05:12:46 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 2/3] idpf: ignore link events once removal has
 started
Date: Tue, 13 Oct 2026 20:12:23 +0800
Message-ID: <20261013121224.84482-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

mbx_task keeps handling mailbox events while idpf_deinit_task() releases
the vports: it requeues itself, or is queued from the mailbox interrupt,
until idpf_vc_core_deinit() cancels it once the vports are gone. A
VIRTCHNL2_EVENT_LINK_CHANGE event handled in that window looks its vport
up in adapter->vports[] without a lock, and idpf_vport_dealloc()
releases the netdev and frees the vport before it clears that slot, so
idpf_handle_event_link() can follow a NULL netdev pointer or use the
freed vport.

Make idpf_handle_event_link() return once IDPF_REMOVE_IN_PROG is set.
The previous patch waits for a running mbx_task after the bit is set and
before anything is released, so on remove a link event is either handled
before the vports are torn down or ignored. Shutdown has the same window
today; the last patch of this series sets the bit there as well. The
window also remains on a hard reset, which tears the vports down without
setting the bit; that path is not changed here.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0db60647..2cfd216ae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -40,6 +40,10 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 	struct idpf_netdev_priv *np;
 	struct idpf_vport *vport;
 
+	/* The vports are released on remove and shutdown */
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return;
+
 	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
 	if (!vport) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to find vport_id %d for link event\n",
-- 
2.50.1 (Apple Git-155)

