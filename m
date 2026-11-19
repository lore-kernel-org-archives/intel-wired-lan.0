Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50D606A324
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jD8yHgm5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXluyRq1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8990E8134D;
	Thu, 19 Nov 2026 16:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMmMvrsnMuNb; Thu, 19 Nov 2026 16:34:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F171681374
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795106040;
	b=JsctPVxOGJwZaeJZGPJz32cD8qZbXWXhMDvTvOedzh5lKRHX3VZtVusaVokX/VGT64pi
	 XFdzCaYCmFrllop35GoCqM2lKlxMqdxmBi00yTafV39begEVOink+cTqJvTbhViIcGtKh
	 3VwLm7W01LQ+SjE4zbEyW/DUJtjhJaXVayIFebs7EcA9Opi/hWzXQyphT90lzLov+ddYY
	 eRm+qE2uCGUjFCWdWOdQUPz/yHjqoJUXJMYpaq3AYRdzDLNJwC3kQG+S3RazbmxKXMDOF
	 dV83ISyCitklKdS6jASUrZ8YI/QtBg4YK0OBx0PRW6Fxqy79xwhEVSC8/xOTUZo+F7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795106040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
	b=Ppg607SicE7oh/T6sarKzoEtmtDrtUxIzail07vAlsveM8w4YR6v4theN7QVdIwtLmX3
	 WnoI5otTlmeqfloEYtYAtxT3i5/aLkbbKFGBuvS2/gfZue0pz+zg94JxvynFc8pq7NK05
	 QfYypW0wSxDM8xh4+xBfkA2YV99rY6a6GpUO/Mn42RCmMfEMmAsU0JVPGNNIsdypNfiu0
	 Wwi4w1XtXUZ8CoClcejD+s48AhHX38mCvEHXkaaqOAx4WkevzFYLRWv/c7vM1TPr8DVXJ
	 D3Jk5MfwjIO40nPTT06NX0H89fRQ/WdlRhgOUYJxaxUZxOgKgB/gw8krUjPpeM9OK1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795106040;
	bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jD8yHgm5mKOrMFVTorDwn96/SF6urhMJchLtZGrj+IVHKJr3zPnNPdG5nQkW5NRDj
	 1QVaioWrzluqXgJkEwfWkPmh8njcnf4qjktCzVxTAWtU6dHHH9fRpjVWwxF7A6X/1D
	 wP8axZvY77zevBokW4IfM3QpZuKjDgBWUICD94ryD/rKq5PRlzqaAUCpaos8XgC43m
	 4639k8YzbEd0WN4yIgUB2mp7HtvYwUzNHF/GUxlb1EuNqdqxLo5gczrLrZDKYUZcOY
	 0gEQadb9001R630wnkdI9AdJcu3R5AbmmzEtfKBuxXbeD7EOQt923XGnBSA4IacfzM
	 fMImxpo+qfZNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F171681374;
	Thu, 19 Nov 2026 16:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BF06E4D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 05:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B07260A52
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 05:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z2VoqE0JWpx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 05:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A149460896
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=izaiahsun@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IXluyRq1
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A149460896
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 05:57:39 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3b09a83d12aso1327940a91.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795067858; x=1795672658; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
 b=IXluyRq1AgeR8593uk4SLt8nKSEC/g4kKKKWmNnKboZy6K5QzCg0Lrhx5y7/OxcDgT
 6qZvJJAc9x3cYl1QlzgsGPel/EgTwDaKIx6VR2mOvw7V8amwaBitWDr587K+WPrH+E/4
 L/KcnSUEMQs+rXseCs0+zZmdQNNPdUgjp35tWJe/MXt7G9sBRQGWkYeGsyRku5Ee9KKT
 RSVyEEtxS042EhNMI+fbqZ3cOblchl0yLuwz/l+PabY9TgZyBOuvigSIaRas00WkGJJA
 Yiye92Jlmg3w/4AC/jEaFzjptqRm3T4kRG705VhOlhJ65CucrScZt/+Criik0X1m5fTv
 Xxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795067858; x=1795672658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FfJFOLv++WC9m0JyoYaS7BgHTNo/5XDIGUv7rymNFd8=;
 b=TJihUxe2kpaFG/vKYRWGg0EmMGjtKGUnHeAlNKUSZ6cmRb8Hc43uDxvsiQl+QKQR32
 +fX4RQMj11JzFAMI47CibziztvCGncyMfOUANU0nsfwoUnbOmlo2q06OoILPZDaSL3sW
 PuRru267Hq3a+M1x4ohJPVo8Cf90c2k94DXkD/ejXHsIDpl91TJ2YZLgzUpp1e9VBC7+
 Lx+Y96G7ZJRVAnK12SBzZGaDHYxCVNqRGmvkhuQvOqVweAwJk8CfLlOKsFpUzOFOtLio
 Oo33D4vQAYSAX5rs9oKvANSfv/gnrHRG18R8uqRDE7hlITKDRxV63DDhy8LEgRnyJy+z
 aI+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErExCD8dK+9JVX9eslPzTu4o74PGsOHNInEKUNTzfw8PEhVHZrmlThbXyskIs6OUlNDxxcVG8Bs6ZxAw3hb9sGM=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/6DCmVOKvGkcepwACfCo4QC8vw8JTWgywg3da4xX/R9TKUFtCc
 SWaqtnyCBMb2BW4ig2sHx5EJqWDpjIHkPpJuL4VfM28J1UhuHQwCbg6g
X-Gm-Gg: AZFdTZfDe3p7KebxD0UumgYwAP9NPN6RaN0dtHMV6OOKdcf8l7eJb4I5y24XLpbWa44
 5I7UH0z2eGJofTII9L4KgKG5LH2h6xrgkOP+3rd0UQG8lWXdmrdhN1k2r+e3j/qJ//mdnJ0s0sN
 rTZUr/H6t/IKU6QnOWVrYHcAQEq4ss+xduJGTKrl9nGhghXJHqzezAtE/kvjctsNS/8FU0uo35m
 zWcYHTtXvPP/OSiNYjtKURRQL33gwwTt4936NfF4Yx+Ba+oTa+6S2kcEZSBFRvHTdmVcpRmV3D0
 VUtZ9Cr/9JsCB2RbHzr9p50MoekXKqkY/40xV/7iC+o+LJ24yETLtSffxpfFG49zIV7vfH1Vayf
 66S/XW4F8Y/FLxkUxKAidMQ0fsCv8JZy4F9mnK7QKRjEdRM52dd21rT4tCSLQz28mIIttMSQwVR
 cqJAIetS41rII+xk8zv4MXVTANLGufHTuyatmajt1Js2gbA+XftVemRrry+Z0FFBFv1TxrTD+Pz
 jCBPxAwWDJa4MECWfyyd75oOL0CfSH+clAjZaz7O+4SSjbi44/zyz5YKO+G9zP+C9ekjNXBAxJI
 nQhsnnAddiGAgpvBIueYkhcpUYU76vJkhY+LHqt8tLzMIS/krgCNqeW1rtrI4mPbQl0djzk=
X-Received: by 2002:a17:90b:3c04:b0:3b3:adea:4b04 with SMTP id
 98e67ed59e1d1-3b3d07bf9c0mr4206369a91.36.1795067858445; 
 Wed, 18 Nov 2026 21:57:38 -0800 (PST)
Received: from localhost.localdomain ([155.69.167.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff5ec9cd0sm24469175ad.11.2026.11.18.21.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Nov 2026 21:57:37 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: m.wilczynski@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH iwl-net] ice: Do not free a preallocated node in
 ice_sched_add_node()
Date: Thu, 19 Nov 2026 13:57:31 +0800
Message-ID: <20261119055731.55798-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 16:33:58 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_devlink_rate_node_new() allocates a scheduler node and stores it in
the devlink rate as priv. When the parent is set, ice_devlink_set_parent()
passes it to ice_sched_add_node() as prealloc_node. If allocating
node->children fails, ice_sched_add_node() frees the node with
devm_kfree(), but priv still points to it, and later rate operations
(setting tx_max or tx_share, or setting the parent again) use the freed
node.

Only free the node when ice_sched_add_node() allocated it.

Fixes: bdf96d965a20 ("ice: Add an option to pre-allocate memory for ice_sched_node")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    Bug was found by kbound, an internal static analysis prototype.
    The fix was written with the help of Claude Opus 5.5.
    
    Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
    not have E800 hardware.

 drivers/net/ethernet/intel/ice/ice_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a5c7a4e1ceba..dba6cc912b7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -210,7 +210,8 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 						   *node->children,
 						   hw->max_children[layer]);
 		if (!node->children) {
-			devm_kfree(ice_hw_to_dev(hw), node);
+			if (!prealloc_node)
+				devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
 		}
 	}

base-commit: 6055ab4d82e42de89871db03045b568ed706ef50
-- 
2.53.0

