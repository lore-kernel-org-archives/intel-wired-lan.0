Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC1BCCF2D5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5070D605F3;
	Mon, 19 Oct 2026 10:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mATcUnmHhQD8; Mon, 19 Oct 2026 10:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE1A96073D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407167;
	b=RPAZRj8gq/4VDxglJr1Imh2pvtiR23RgJCsWw5/QL4Pq35K7RikWS3sdVVqC0FQupyeM
	 l1IrdQpSpU1GVcWMuTw/l3AtBETu5wF0vkMBRlXyiVKfqav2fmaR4FQXiWd4nQgiWLTND
	 H26FzPEwOyEhP1aPs7tNNiNbsPQjD0olmVclm9/IaGK7gT8mGglEhzJp4+8p7/Bs5QNod
	 Hg5e/BAqoE9Yw3wGET6DQVBQ2eDrd49QxIskjZjjLOSS09NY3SHTBcqG5X29yw6ZOnIP4
	 zvYqC7SfnPbv4vyHZ8hq+KPwdUJgO+EIRe+mJEmC0+J1XgEyBVvd4X40v2dP7jGpxxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FCCK4lukVu46UX8q/+nvsePnhoGpz0IH4czbYBTEba0=;
	b=VBZcKCo0EtXbMRnVS2HfgCJ+SrW0nRAtAFUl0cxxGI6UTvdKG3EN06/qP95Ju9VImSis
	 Go708zcel+pZbY6HYPbG9bDaRDPWfRco5hRqZtJkH4UimOKNb+r6AcLigyNKnW7bG4Cco
	 qO/BwsAAb3uUWTgPeNug5QKPuRVKMT9KadsOaYdOgVAjqtFaN3cITSnGiVuZ4U3Ncg5H3
	 Ppxl2b93fPGja5kv4qTbkhe3Y8ppoZNNjDFk08QcXDxg6iTgMrcrPBmb5y6hdZ0TxTcf3
	 HvQHhNV0whC0HiuwISVFYY82mVDx9zkM9+7BK33wysPU454bNrfSwA0cOfCV3gt5FFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407167;
	bh=FCCK4lukVu46UX8q/+nvsePnhoGpz0IH4czbYBTEba0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6PJz3qQ0HE6hswueVqi9w2X92Mn/6ZP8Y3R3XD05ScBLjVOUHRvobo1qHYBkECn7
	 pTVh7uVS9ldryP9lhvMZ93Va3lQKjkha21LVvSwMZre3lvNnKAC1dKzDc3H2PwX6ei
	 0qIv6gPWuMFacC+aPBYNswhyoju/zbQTYMJSJ1kDUiCNLm8hhnllY5NcFlvyBL/ndY
	 nOUeviI7NdZ6zNIt6cuSsWoyN8yXJQK4huIQUeSY0Ec85QZTCWun87lXRa5WzfFsJq
	 nxEz5zrse1CjRESRFKDOu55xH8InczqNq9teNqL8ZGTl7QB2kpp0ydr8nYVMtNof54
	 YxDOa8WKPORGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE1A96073D;
	Mon, 19 Oct 2026 10:52:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCC41E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02A6180D9F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzSKfc6xuY3u for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2A2880D1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407165;
 b=Q3rkNYKhxDqvVOuQOAa1JNSzRDwhAAvQNJbwbbLSrSZub8Jq+/tOW0QEUKMkDHoPMbB4
 nw1jzUf4GTcDbb/6wt8La471MMbS2HYUoazgBv7x/MyG3ujhAPaNHeSEHTaBj7MQCh/F0
 5TAM6SEvVslj+umHhNLZzCDtj3zITs8/Fv17wjVX/6cN5LQMDcaSZzcqBGhWRnIXUFSF3
 sdmxQ3aI7mJ8rpf/Mj5+xzQWb/5B9Gk2qTG+aPv7LE84XVNsi5hGCrn/vhx2jUTZr2sdp
 +NmursQICSlD2Yp7Udk6Y9vmaWcyN70OHgNldEJ+gEnATfWcrpoxZ54w2uam1HIS7GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407165;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FCCK4lukVu46UX8q/+nvsePnhoGpz0IH4czbYBTEba0=;
 b=f5UZPRDhwosYgg7ruqG4evfTjORPcI+XM2i+HmHU1VZ/bN6F/OefLyv4M/643V9aLCS4
 SnXqjMYvriIT0NKp2Xcy5Q3k6h7N9GS89C8YNNGeW8mxJHrbyzA9nhY55jnLOd5yDJEeQ
 P74/NP09pHxf9ytsnbseu7Ft6WCodRXlf5qN280etMKRCI02yWFwdFh8dW8r5OAZrtk0Y
 sqmBcXVrAIGupa5fhTw0L7XXJzUWvGzyh2mp1RIHKc9TtK1Z4BB/0qZJ+cKyW1Rw3mgQo
 c6ChTRptgNYpwxXJibBTDW3beL8sKo14vQxhem7HoxMDQaB4S5HFp67zhAyarRRMXlw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=LjiEw6VQ; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LjiEw6VQ
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2A2880D1B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:44 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67FE83F442
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407162;
 bh=FCCK4lukVu46UX8q/+nvsePnhoGpz0IH4czbYBTEba0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LjiEw6VQ38GVAI1qWjT4BFpQcwsd3O4jiuaGVgp5/ZgFqG38qQoiLKb1Dnmz+myCH
 7dtIekLq3JlmdT69m3yVG+/qCK3vcf6qp7zVuPZeroLQ7qrWBCzGlQkQ3vMa0YCMg/
 lPCyYX3T1JKoW0Bl4hbmlojTgAwTyycL33OivJHpfQ6uBFtAtFnOyCPBFxN/Q9lof3
 cfa3KieV8sfklpOSdoHYxRCfxmiCmhrIpYFYBmhs3yhSjjrnuERqnbWB3DRWC5JllP
 Z4CJCspHJVpnVSZ4AW0WIwZXHPXUfl5kmrQgdWW3xi4RrlP89ZW8dZe2bNVJiSpx2s
 YMKn28lBu+5nf8Qc2gKL9hXWG/z5hJzJGrfTU1aEPJSx1v2a6LVc7oHbws0XVckh2C
 HyRtLlslQLaCUNGUqLo60ACk9wUHWKTCGsJxehIlEcvILtNZ2ImkGTne2dcK2VUBIq
 s5WpTC+h6wmZMTL5/u5nzTVtWkbUcjmbqCLrukGfmQLDDrl9wMU+FtHnQSJtwLE6yx
 nP7ReKLom7JvKV4eQI/LoRvh1WZk9QQVGTERjd9XCJNXjpDqE9VDv4S5ViLMjoYy1s
 5Mj+uXx7OfWZWH8KgyG3+orriTnSejWtSHEgghkG1OXZfLXtIOC3xGO1OyHW36dF4E
 8ZtLFKfzKOYlqs5j0j3qAkh8=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16faefac0so11857015e9.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407162; x=1793011962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FCCK4lukVu46UX8q/+nvsePnhoGpz0IH4czbYBTEba0=;
 b=Su1p5spkusaiCSx68I+NdDX2GQ9vflquUnWYbrznVPB4KYlBWehVc/pOuflSpefXoJ
 3OG2PYfqQYJ7NRpWKhIYRz+YMzdw94tlMJhmvFXPH+BT8/JY0Y/KHPsW/60NP5wTxrlC
 6Zryn/LX9TXIBVqlqkcq9l0vHMD2D2Hte+Mda/fU5Hru0QWrBXzPZPYE6IMfKxeK8R1F
 IWZ2i88uXUiUfqflMZ7EZwrCIYzWimTv9dHFC/dQZDBOvN4PqtuyxRjWfaKkbjF6i3gV
 gXFkwi2fspliwFF+QO6/qlTmQUz904bCQ6t6u57HBfwDg3injsuHDs4aKZSIejzfQ51r
 w1lw==
X-Forwarded-Encrypted: i=1;
 AKwUvByw9E84a+l3zZWRuN6nqrEpQMm1TA7cTIZSCGHNHCtnLRD1bODxhR8j1sDy1LKI8ac2FiP5VpcB4fzst9bTbv8=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJANycZT4SqxMvdTA58rT/iycaCkrwl2BNTX5p+9JCD8Lo8wgcr
 ERELa2sQkrcpWtGHl9bRirkig7UyV00qh12Skg90o2g1EK9+oGO+SsZb3vhaQOfn/GMkNYfa8dq
 J/KneQTbOuh4WGfsSDiqOPPcm6+SzfYsKeN7yi2pYkYVP05GgkfebVJ4wVmOUFa75m7w2wRTSc8
 j6efpKQ7jX4lE=
X-Gm-Gg: AYBFou1rEsvrWY0d5LA6X+q8DPeQfKvLwf5KVYWDU2mZPRa4mo0MWs4vlfbOUu/Te/f
 IuhOktKdUM2RbDuIaKzprO/EBE2NY0kdQOLEFg0CTczmaJr1PqQCXBwqmd6jcmuUivaSgQtE4M1
 HM2z8gDmAQCjaSLLpzfOURUj5aouUugVnFa1ZDqYFcnhc1MQJyaomD6xJigAAYKiZsmm9udFYqB
 c55gokWuXwvQNk5C7qN/e39Az9mP3Fy0AA08LlFgPTXoZKVbcoWHIJk8h3r62VPPv6nlKFImCVD
 whMJUqDcapQDV0bEQTN4ZyinPhgX1bKBYerDOZ7L3oDalq7lMKRiC5MGu5HNtUEk5FcoP7+Lcgl
 xum5D5/wWSKGW72m99RhVDH9bM0QDuq8NVpRBbA7ovrm7LlQzmKAdL5T4jsHCTF8kb3REpKke7R
 8VceMxiywASSWVawQnEzyrIu+AyZDqN6HKs82gn6uM9C9l/JwTNXhbDpfL2t4GdeyMmAxri69RC
 HTrLlcMsfQqblYBioKQab/FnZ8iXNuUQJqRnSrs
X-Received: by 2002:a05:600c:b99:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-4a1d75a9828mr140136065e9.1.1792407161994; 
 Mon, 19 Oct 2026 03:52:41 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-4a1d75a9828mr140135825e9.1.1792407161618; 
 Mon, 19 Oct 2026 03:52:41 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:52:40 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley <brett.creeley@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 1/5] ice: check the full PF reset polling limit
Date: Mon, 19 Oct 2026 18:51:51 +0800
Message-ID: <20261019105155.3793063-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
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

The PF reset polling loop includes the Global Configuration Lock timeout
in addition to the normal PF reset wait. Its timeout check still compares
the iteration count against only the normal PF reset wait.

Consequently, exhausting the extended loop reports success while PFSWR
is still set. A reset completing exactly at the old limit can instead
report a false failure. Subsequent initialization must not proceed on
the assumption that an unfinished reset succeeded.

Compare the count against the same bound used by the polling loop.

Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 04633103e3e61..82b803e74aac0 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
 		mdelay(1);
 	}
 
-	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
+	if (cnt == ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT) {
 		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
 		return -EIO;
 	}
-- 
2.53.0

