Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACC0C531CC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 18:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F9C260AC8;
	Thu, 23 Jul 2026 18:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bf1GKlxxDDnn; Thu, 23 Jul 2026 18:47:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA51160ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784832479;
	bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPOcI6SUGacdwE55UreyMu9W23Q+ESgNhrwFYfanU8QdWCy5zKbYKrDXRZUQh4R3G
	 18L1qI2/dHF9Uvb8ZcKL+kisUIeZkeOiBX8Zlx3VShRXCAGqkNF74XoQhEXfwFuB1V
	 lXfvhQLQKUpxMuxjd+v6dmR/tkmaIQrZar5xhB16d6r32Je73D7u5ACFoRnQx7D8sf
	 xOZGOlGHnf1sRtwNF0eMLW5vDV5XKMBocgUMeKqj+o1Vg6hlIwpscHsjq23aQ11Wdn
	 Y1wZ/qMRB0AHJp9VQRAGNkb6PBeDCZOZudGosHkJJ0Lawx2PoH1YsIGzl7c5FD+woR
	 XCT4P86Hnnq2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA51160ACE;
	Thu, 23 Jul 2026 18:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E0742A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 18:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9970560AC9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 18:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkjGmqWIPW2l for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 18:46:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=ekffu200098@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E8B4460AC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8B4460AC8
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8B4460AC8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 18:46:22 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3811f512167so961315a91.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 11:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832382; x=1785437182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
 b=HpAKKtdwSqmyWUU6Em2DcqLg7V65a8Vfb2JLdQAa7H3kbiKpFyBYOGN/wM2g32GAP9
 RfqOlPky9RB+B3gUs1/S3gaIXBsj8MNlWACY/RpUxIv6gijctKNB/V9CFdQpvM1s6pJb
 LlPh2LfdK0J4jlbjHG2n3+HCr2aOX7XwFSscCNqU+4xvC/yg09mdraWyxZB55FiG1Zk+
 N0ZobBOiCGWRVxj/r/723UCi/b/SdT6vFTlWA3UyMkzbH8h4R3ybhFw5B28u67q1yqBs
 WTdmbtv/p3RoTziqld/1OjI0vLFyWV05eTOXyg7yW3rNNW2jrQ1fvLGRFgAsMguwW3Te
 E74Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RouUD9iKpzxwPHcy+gLvG9By8WcV3mVag6rz8djM4j9WgAqSNIVqILL9UYkfBvNPQ48UxMZiL+sRZkW8DGlxyo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwnlPaQX52oY4FPGLqYo9WDVkFcJd7yHNyvlKoHOAJyQaZwV3ea
 JQWgLqNMeWzUK5SteGU81xu5Hoenvq9yHFGh4/vktp2WAkL0+6iT/aCW
X-Gm-Gg: AR+sD106oRV02qdqIDIpxChiFq7urrIscXinL93P2A5ItfZsu35+QC+kmLcihpY/hVv
 rN38MsE15fBa5VgsunEpZ1qDwu+TK4D4kuFb9rRZ7IhAc0jpEG/pe50Cn22r2OL5wRkwTA//HQF
 y/1DQXQC2rk1aNEOW7hF8fhly2JRhnlqlxMr48RaVEosWDbeAgahbxPOq2hDdMOoKqeBru+/5x7
 w+jWbqyV9B8to4Jvs4gLDNVJASS2wSeYYZUjEzDOWfOrd385cLRqpO/aA8KE42Nq4jFYImfgT4n
 z4QVeHDG2aeBt/xTaHKXAnde/rq7/Q0ifMKFpvb8Q0PfmIJZ6aNNzW3YIdpvmcjyE5VBmBDtChi
 lxuRHqveHp+w05VorAvA8ymPV4KG5wVGAcwok27DnW92z7XpIxU/5u0an4egcjem9e/ZZ8zUnKQ
 CeJ21VEVQ=
X-Received: by 2002:a17:90b:53c4:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-38ec64f3415mr4603537a91.14.1784832381937; 
 Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: cocci@inria.fr, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:11 +0900
Message-ID: <20260723184538.3888637-10-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 18:47:58 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832382; x=1785437182; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
 b=ssL95OWDMmLjQyGejGfdQmjKp60e99yJZsjtKNsUQj7iAqoV5IUP81DGuMUDPo/2ve
 TvsXrbfzswGqxt8QmgAjU824ZcLsk5sOhSvoZREmhZnll4lSDvOzrBI6Z0RTKIkuAnDn
 JH3/eY2tRcrlGvHvQZQ1Y8OCE2rR2jNwPfyrZ3ar6HGXnMAFVoFbt2T6guQGcOwRFQz2
 SpENRDvp7icSuLuJ0t6QP31rUfxnNHPUnZJyQYyd77YzuDUFZxGn/aFaUez0Ew69avX0
 /zCWQ8FFHI5wNoLUNZcqGi8Da0iDsbmwZDIGaRZTGNQSlhihIA7nO57zg3B2kaYagaz2
 CgkA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ssL95OWD
Subject: [Intel-wired-lan] [PATCH 09/36] net: intel: remove conditional
 return with no effect
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0cd0e5597c90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
  **/
 int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
-	int ret = 0;
-
 	i40e_control_rx_q(pf, pf_q, enable);
 
 	/* wait for the change to finish */
-	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
-	if (ret)
-		return ret;
-
-	return ret;
+	return i40e_pf_rxq_wait(pf, pf_q, enable);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9db29b231d6a..784f9a7bcbed 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 4cf737fb3b21..b758a7e0f013 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
 }
 
 /**
-- 
2.43.0

