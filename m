Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F451C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 16:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07DF880970;
	Thu, 17 Sep 2026 16:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gExDLQEM9Rzs; Thu, 17 Sep 2026 16:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7B38E808C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789661232;
	b=Uw0XHkUUJd2U7poIwXu4G5F+77oTxaLryIlThq9gZ5ToOxPD6sf/U+5nW9zMX3Q1xNSI
	 DT6xgGG32OzsRRMxk0kEuDwKAKFau3ZTI89V1i9QOQ4kOYwfew7YFBYy+f34JwtQ2MRbe
	 IbiIAXbHl4DanN4KxguRg0FnHw/hz/mSsHwvOHXcogW1y6UI733PufI5pJwYVI/8nsRZ4
	 +8ua2PGd8PpcQkaYEwoQ153hHKFZWFoHNluFLg7Bf4357vkX0lBZ1zP6KxZ5uQQh/8af7
	 pYegjGlJz2+aZ3tpkxckvTillBFDZKTAsWW5rXQEVVV4JavAC7H9QPG13kbLCpnsHzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789661232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
	b=jojp68o2Pa7h1jPtwSSiEAswf31n19hB4cQg0Jl8g0PLxC0Aez12qNe00pLdDJ9//R5m
	 T3ezUD1LejdiXpVdz4YI0u1FayWjkHsRsGuUM48Oz8xy4UbqbrzOeGATPHmYAdhXNHtAP
	 4NsjIbAWMyqHQYrjrW88eRbYjMrlH/PZalSS2w/OOzffuddVQBCH8t8ahHGsYSD4fCahe
	 DctWYeVoOcSjmWpsYQJ2CsmtBPwrThwxM7zeRxLSxF7hfHSFO3yZOE6/e9sER6+voqrol
	 mJcH77LCDCFI2KZb5uPT1SiHeZe4uJQU3uoKPAf34udz71qZkmVDkBZhJDVg1XbYEJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789661232;
	bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nn3U/7xvRgkfo+2KXr0n1X5tcaOOkGxH5LOlOtH4v9kW7zY1Db9TkIGDPkS59QpSq
	 1Lv0NR/3CjmCH3hd3n1Q0MVsYzBBmhZwV9+4SXCnaXzjt2I66kNUIU9LZRWAs196BK
	 1g9VVpACPjsQvLaNSLJue4y+m8jK+wmmB3vClpjkg6/HDC9jJdIzxxQStWmXzCORVW
	 +hVZx44iCEyDhydNmiE+21qOG6+iZOQ9xkiAHu2cl3+7f7iG+Qd4JJcSFnJ54HBaDE
	 mfoP5YqDOlRvJR+toudI7UtL+CttMbA1BGSoxEEKh4HScW0SGgw2woly994wFoXodF
	 RR9ZbB7tegx5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B38E808C0;
	Thu, 17 Sep 2026 16:07:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9129E42D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77134404EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZTVAl1DXJ5R for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 10:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D2BD7404DC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::14"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789642342;
 b=jJsmwkQwcGHmAZ1Dv6yKKgMMtvj+tQz8MkGDB2p/UfoK1//zNjhvmJ81KybzuA66z9FP
 36WWYv/Fnl8CXwbiR0Mx9H1tFOxz9AHv4BtyZ/bMMllb7DZFiZrUWe8cbGA1Q04PtK8Xk
 NLPsRaMi8qKjte09GRvZmDrDpReGYUlpa+x5p8v0x0uRGujsmR2tAaLGxNOQkz8osvmSX
 Nb1SLswzl4zU755+GE2jpmUPlA45pJ8Ahk1RMao8yQeqa2pw5KvrOILCl1ZcynE2mbCJ8
 c3cg75CVJtlqO9XYExM1LTcMhBFP3viLiIoLwLPce0SHRCVLCZiIsjzRPpXvha5Rh2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789642342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
 b=iIhycmvTRSXV5hPPH3MY2gpJNggNVscO5LDZGhUBdQjuV9GLq5xb1jAX+RHu8OoqdzFO
 OCh1MuRnKO2P7qOTAyP3z1yZ0/Ea91nW/miT661jVHEw/XdIaAD/GGXl4WShZvW2gFlOf
 QgCWRIaFOZ8BN3uFMr9t6/VXvXsSqmrjaAD2e3d4qs+2JRPww8PeEpk8cIZUzojcg9ecg
 cevHjw7hawGBT7ZcENGzkkj1GhTiZRgOe7uUBQoy2SqD/SyRtpk5r1XtlrjJb/C8FYmGU
 u16xX5E1yYJzMBjEGzd/o8nnL3eFMcBhGt7GBK7SvtMaSk4eBl+vUonpbVIxsEsP3JA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HXu9OErU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::14"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::14; helo=mail-pj2-x14.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HXu9OErU
Received: from mail-pj2-x14.google.com (mail-pj2-x14.google.com
 [IPv6:2607:f8b0:4864:39::14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2BD7404DC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 10:52:22 +0000 (UTC)
Received: by mail-pj2-x14.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso215640a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642341; x=1790247141; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
 b=HXu9OErUrzJGwkXw3To/ukRsF8X5WhO3I4f4PM3C5oG4N2AsA8lBwVrwt8HF9uHlHQ
 q7aOdHoP6zpuWQy7fGDrPkWRXs5VU4YsOV367rBaOb0FR6m421m/E7ZT6N637VFMnC77
 Vg6xcG2HX32wvNujy+3QzCyCNTA6C4rGxIQPU5S3iBOzB/RZeDTAnUzOlKFXYlhDX6yF
 rurg8oSF49aKtu/Wm699iLJ7pIhohyYz2hIggegkf1dJbbc3fPIqTGuITNQC4dO8bJbM
 km/p9jZ6ekJy+Y8rXOHJmgFI3B6v6UdjRSqFa/quWPDb7XCp+rBXXXu4+nW7JHT6Fbkk
 ojVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642341; x=1790247141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7u6svTs4k5fVDk0RxXve6EP4/L0851Qdz0RFWFIyYB8=;
 b=wfwaaZGJGu/PpLqzN2fbF55dOA84MY+KfxUwMV3xAtCXLKgsDRQa7zzNaJwenGPKxo
 Bgi6O+YHm5pPB/miAFCootnIsj9TPLBPcx1fEHy639ddV3Fzrb8bKvkcOHROXKt7vkTN
 ENzNGOUBWfMWMi6n39dNLY/H8ibcAXM+mrBa8e9epaOwFWE11s/szB8X1AuPA1V6uoxM
 woXRHTaAfGEd/QkRMu8CspOmA/LFEO7RQyt/YlyGQr7naEjhZ2dVvluKxA9MnbxB1Cec
 m7b6dZopBxy04rxKqtnOEqurXNVBxipuMxYWCBOXXfbg3tmXWNNHd1qLkz+iXnRxL/LE
 0Adw==
X-Gm-Message-State: AFuF++k8IJWYlYvAjgVCVsuYdU7bdv7GYypMpCvmPxoggEdnbQyrFXwh
 l5IplfyOn2KxE2Rsdz2lM/CZ5D7NnPAa4Md8xmFttZYKa6KkBU0YGW6C+gh5jb0Yj6Y=
X-Gm-Gg: AYBFou1pwWKDIHs5xiqH8zfiIH/0TMShVg+/RnYdC9c2uwWBFJW5xREVGKFpNTdX6qz
 g+ZXqXlMrFrWfJwt73/KzbnTe4IdNzfUdj6msvJ9hGOpypn0jL0vZk75ygnQVL//9v1YgQWDw+j
 kC+XLM4nBTN7yfPL1xWQL1ybUHcu/DlEol56ZtXLSO2DFuwjsDYosI/NgIhAPsXissgqx2PhznW
 8Q/TDgWE/uKoBDI5uOSC3/xqO1+dV1YmT//f6fOqUxSTYtIO/lK008aQFQII/pyyrVVpdbs6ig5
 DjBp7lQJtVIaGLUNoYWD/HQogxTq/noE4nXuajEML62vq2YIha9n+13Mw5mVME63cyksQkTrTrH
 Y5aR8e3A/7FM8ELwIW/wRYfZXx4bSDepa6KcWRM57wh4CO08tzjv9FCn49xPOsLGvcAqT2MO/lU
 xPugctAMpCahqTbYrVkCD8yXN3sAdIMorOQE0rQsAGU5owBx6pRoIvw9XWCuOEvTIDhD5pOvdR5
 p2y1gHKKVUr5OuBcwU+6VcZfntXvCpTop1Ub8JTBZ2HHLNe3EuMB6y0GF2f2TNX2GNpfOAIuQQt
 IOM=
X-Received: by 2002:a17:90b:1b06:b0:39e:429b:1e2c with SMTP id
 98e67ed59e1d1-39e429b2135mr1226720a91.15.1789642341417; 
 Thu, 17 Sep 2026 03:52:21 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Sep 2026 03:52:21 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 emil.s.tantilov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Date: Thu, 17 Sep 2026 18:52:05 +0800
Message-ID: <20260917105205.37561-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917105205.37561-1-luckilystar08@gmail.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 16:07:09 +0000
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

idpf_remove() ends with a function reset to leave the device clean for
whoever binds it next. Commit 4c9106f4906a ("idpf: fix adapter NULL
pointer dereference on reboot") replaced the idpf_remove() call in
idpf_shutdown() with idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(),
and the reset was lost along the way.

Restore it, so that the kernel started by a warm reboot or kexec finds
the device in the same state as after a module unload.

The reset alone does not stop the stray completion writes fixed by the
previous patch: the next kernel's load-time reset already performs a
reset and stale queue state was observed to survive it. It complements
the previous patch, which makes the device tear its queues down first.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..d7cd449fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -197,6 +197,9 @@ static void idpf_shutdown(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 	idpf_vc_core_deinit(adapter);
+
+	/* Leave the device clean for the next kernel, as idpf_remove() does */
+	adapter->dev_ops.reg_ops.trigger_reset(adapter, IDPF_HR_FUNC_RESET);
 	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
-- 
2.50.1 (Apple Git-155)

