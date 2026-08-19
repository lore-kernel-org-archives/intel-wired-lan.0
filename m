Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E12C5DF88
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 16:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C0BC405CD;
	Wed, 19 Aug 2026 16:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G0Z-oWA55eer; Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787155542;
	bh=e7rQxNaXNWqb2c9lwuccfrB1MuTuQX8j+1HrCiB3XiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qyw3XpZiNwULiTJKCjoBdQudsFa++p+JDBRWsIFm4WcFr6ATcuUIOSS1X1m67vWwR
	 Ux3gIrqVczQyRzMb5fkecFdslhjVq8z4b5LjAK52lxnZXpXHcNqP+nSAb/abqOLvGB
	 zMYyVN/D8gahP5WpO4d70A1Ptcg/APSHvFO1dOm8rc37ijdTGmeUKlMAz8y32oHKNl
	 YsAJel2gaUnLC1OQ0EbjtKaDwnikNIiT1tL+h7Qh3zOvbZaMw7fz8UApqXbeld63Yr
	 HjnkAC+58osBKlnxeK5C3SaYZ9Oy5b07lZDcJ1yh8QxKbvgmoWDNPsGwcHVfByb8Xh
	 2MdB3HOXPRJBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2827405D1;
	Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F5CE265
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D58C400A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIoC-OvICUzj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 16:05:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::8;
 helo=mail-pj2-x08.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hcZUDDtd
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDA1C4008B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:39 +0000 (UTC)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so402289a91.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787155539; x=1787760339; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e7rQxNaXNWqb2c9lwuccfrB1MuTuQX8j+1HrCiB3XiE=;
 b=hcZUDDtd3PI9fnXqXWXn5jkIEMBUZ9hIDnXR0ha9Qx3RGZUWUewPaGc0zTPUqiS9bq
 u9NlSHw+SMTCSYYZ3DKgIfQgiQJ1RBqQ5wOoyDiO3AesDT43HsL/gNrZvHKbgCpOW0k5
 aHaMv2qaKjc+APf9CEEFvfcQjdxO8fIwIhkdKNTO4KGVIZGizU7L7fL/07X/bVow0vMC
 7Cqc8H3aDjCHrCVDI1UFIyum21VcXBG/TC/hK9p+DoIrRTrlWYJgM8IovOav6hxBkpPG
 NtyKJq8sdNEJVaASImnXFX+0OsjAdvnKDe5W7crHuMfWEypT5u7687pnpyLd5l1IPdB2
 2M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787155539; x=1787760339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e7rQxNaXNWqb2c9lwuccfrB1MuTuQX8j+1HrCiB3XiE=;
 b=PRdeXzgKPI2VmIDXgODVSEFksgVa+B4VzhulIzbTe84BRveDI77xVs6OVnt1Etg5uZ
 9r/KSnR7dVO2jM3wR94vSrvXurcgmZO5JIhbzDFV8RCrtzOeN3m+mFLGdsLl4fHB0C/r
 KvfG31wdO6PBpuKWGmku/LlGVOYw+Ej9eLV6KnoxLmphSXHIl3gzhib1Dmxn+Z1srtbY
 NbYKW9kB/r3paK1892rTN6pZFnDS6Im7ugpDFPwxLN1iQN/7bjmD9Z4g/qbwr2uCmOyu
 m6e/weovn8zVDR6cJ8TDVk4e9bZuDfwWzl9r+Yhc8L7U9jMNoJipExKpT3PUaJmnt2dP
 6vwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgPheFvZpMdXTvxncwEcObCVyIuAoX0Tw3ulkr0q65r1w86JbfmJy3tt3J3SjdNZwHI+WNc7QRGHLQe/vZLo4=@lists.osuosl.org
X-Gm-Message-State: AFuF++kZzIg3oD3qrUmJUshirTywnFux72FduBV+x+QuqTBaJLnQ5g2g
 TlR5cn5BCaPVG3e0arRu+RKyYiCeQSu2cg7bz13CE0e9Q/Zm0XRSML2x
X-Gm-Gg: AR+sD1344+gw0K5AyxNGQGHtaYqGr3a4JuV9ni94R8SNh4BTjTwh7D5u8+W1gDgl3y7
 k9/8oJiICT/kIAuJozb52JBwIRDbUED4RMayDOT08KPW/ZRTtM5P/PAHUFhRHosYENJ50R60q6v
 mz5SnCPm5L3YZJ/z6Ct539U31YEKFzAg1me7mSF/HRkPopLsryMgjMFCXYTx9m641yYtvHfrc3a
 gy8mPRuPqO8GkWqFSC1Rwm9xjcj3Z+M1XAtoH/PxTuCwguDyzG0cri96Ot7rrwzmAMT+PwYI8SM
 UI4JA9I13jEP3OAKA6to/Qvu1ErZlk7vNNzswdGLsMeMnYwEZnD3HeqNk/tZOTKCfQog50aeqhk
 kgF6aFQXmLl7d+XvszAvTUMEfpOYpLNI6MhuUqIgBju65hIcs48PyhEpkL7LhamNhaUg4C4Qh4m
 4BQSpzGc/dlftcCXTrRJUTxGCxVHEl0E+DjEC0xXPGUihb+WX6zRZLYw==
X-Received: by 2002:a17:90b:4d0b:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3958127d8bdmr9857765a91.15.1787155538709; 
 Wed, 19 Aug 2026 09:05:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm3011405a91.10.2026.08.19.09.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:05:38 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: [PATCH net v3 1/3] xsk: align TX metadata layout across ABIs
Date: Wed, 19 Aug 2026 09:05:33 -0700
Message-ID: <20260819160535.1472459-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
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

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems.

On several architectures (csky, i386, nios2, m65k, openrisc, sh), the old
native 32-bit layout put launch_time at offset 12 and had a natural size of
20 bytes. Using sizeof(struct xsk_tx_metadata) as tx_metadata_len was already
rejected because the length must be a multiple of eight, so the
straightforward use of the interface was broken on those ABIs. Userspace
could still register a padded length of 24 bytes, though; mixing the old and
new layouts then silently reads launch_time from the wrong offset and
misprograms packet launch times. This intentionally replaces that
incompatible layout because the affected architectures are unlikely to
have any notable users. (x86_64 and arm64 have the most users and are _not_
affected)

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/uapi/linux/if_xdp.h       | 1 +
 tools/include/uapi/linux/if_xdp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
-- 
2.53.0-Meta

