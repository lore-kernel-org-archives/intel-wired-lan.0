Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C6C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5DF540C95;
	Thu, 13 Aug 2026 19:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXt1NaCLfQZ7; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF9BC40C85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648085;
	bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FdYYJWNNCDXfcJjpnxhOi3yxycEseRfXNI/+Uvbsh7LH2eOPZYMKuYDBeAOJBXqTP
	 VyBVdGxocEr0nKSn+axt64c/vSCc/D5jA8qc9kdMFvrP0PQ171LwIIEOY1Y4jM/3KI
	 Jo9o/P2dsmOC59Lj5x0EKtTfGkcpGPKVVanPKQpap3J7+pPekV7CexghGXPN6DCYQ5
	 DeGfJtAImfcHIudKRWQkjICad1qevL7E/FszuYoXOiwbRAyd6NQ9JJNwnoGe4eujfq
	 v09AarUI1R2zJoTd7bDoXOyQC5aIzEQ9qN9kP3hh/SMTcOAayq8DZIouPZPZOarOaU
	 YFizi20A5xc3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF9BC40C85;
	Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E58723DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9D9981370
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeBOhzUtsczW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:08:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::1;
 helo=mail-pj2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8200C81396
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8200C81396
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BX/0c931
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8200C81396
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:03 +0000 (UTC)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so159522a91.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786648083; x=1787252883; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
 b=BX/0c931aHH8P/Q/PDRtGhxSmiDMZCzqyFrbW8ZOfrLk+8m0wDqdWLD0oFu47LR9lY
 UN1wooLKWQnlPd9/xfNmeN9zD5to2ebigcsCG1Rh2szWyJCz2WWLDoyYZ+YjTaguNsRR
 p3nS6hbfe9dUCz1yCoMwqtmc0Gb8SAhdFfOFkrgOWmRL1h+aW6PV9iLoAbNrUxZe8sk4
 blcE82wkoMc5S+//e1P6CHdbf4OWSN7MbVtLNuLvDtyYN6eXbB7xAbAk/Bhy2Vzf3rSr
 yw+g9Wy5gH8VLhqyViePIj4NF8LBpdreguzlo2+2obhPSsdzudMgrkyLXM7WSeZYU2ts
 ++pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648083; x=1787252883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
 b=lfO6/jwE8mpOvPOAd8iFIwIhIVnHta5XQAjSqgoL+8MnTrxsEuVvt/nJhISLVB2wgf
 YktxGPmGMZNzTCPuLulzkGHKJ3VZ2tgkZOLDvLVb31r0ZISnWm8JK1sSxaGkFtt5XUtT
 DjUaw8XnkII6Wt//epPPgmgebJ+rbqjJ8zblFxl5cTYv+YK0T9/CZiQ53fW2GFZEXujS
 ErpzsKatTjzHpFnHMAmP0x5ejAaFhX1nyrm6y4xKML2sHxO7LKOVorMl3lIvq6QeJ8aJ
 rRWfDQNxRjkaq71QeX1rrmj/Pcy/NneNgro5TjrbOnjTqMKOz6KELr0ALhT6NA9d3F6a
 pnxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrX8l7KijBZyNjBwZMRadNjtM25I5PiuV3BJLVOmKDPxkCA0MrhdIWfBMvTT3mYtn1rI6Rw8k8mQKZhuRTEHWA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzJFjHH0SE85na9J48zNX+bccA0QImYQbvLrSpbW7im1uZiDTgz
 QcRkAOrP5d84OTPSeUO5+dZqCXUJ3XjnzvlMS+77s13Oxu6E9n6t0whT
X-Gm-Gg: AR+sD12/mTbcR8lZ/6CW5iRYOOUbT7F//x95HZtK/vQ98SPkWbvPu07rluZlT1TCNQW
 YbsKbPFo35srnGJWThc73e6hlPo8a554/U3bZVRlPElV5fXPhOT6Q2OzHa2YA6A+JUvvRM1yz8s
 T1WAyDRqZhC3C7S6fve3FE6Jq3PpbdcW0d9nYW3VSzafL+0sYslkqgzR0M2BelawAcitwxxmAF1
 6NR5nljTutVQKEgmRkJyeUSV+leQLT2bXkIEXsbbvugVGpuOGvsALJD33PsKb5QAoEkajvJ5X6B
 VGtb5yCQCpQC/i46v+JrBX8s5UJ8plR0AvWMpfff5mMXQ+1suA0CGyHbTzyBMw4g4RxlWENI2+U
 0xuvn7mlawKiNeJEOzTAz1kpqhk2Gn6iaz8mJShK2MZyF5yw6R2fd2z/46xLCJQoHHxYoAjMQ2D
 +1BEn9EOqiioihrdrfCiOWaVNh0ZniIg3VpIX6skVf8OcBEqKmMiMB/Q==
X-Received: by 2002:a17:90b:2b8e:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3933b8aa611mr183995a91.15.1786648082609; 
 Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3933a009f35sm492119a91.15.2026.08.13.12.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
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
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Thu, 13 Aug 2026 12:07:58 -0700
Message-ID: <20260813190800.222527-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH net v2 1/3] xsk: align TX metadata layout
 across ABIs
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

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems.

On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
tx_metadata_len was already rejected because the length must be a multiple
of eight, so the straightforward use of the interface was broken on those
ABIs. Userspace could still register a padded length of 24 bytes, though;
mixing the old and new layouts then silently reads launch_time from the
wrong offset and misprograms packet launch times. This intentionally
replaces that incompatible layout while the interface is still new.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
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

