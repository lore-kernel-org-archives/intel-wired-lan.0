Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24467CD98E4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Jun 2026 10:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D830285D52;
	Wed, 17 Jun 2026 10:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRdRxTsFSOzb; Wed, 17 Jun 2026 10:06:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF9F585D4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781690763;
	bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mvLP/0gegEw7TJO5qfDYkNSTI5QVnkWLu+IzjBneO9028+vswtmMZXsIvuWGWY2ZN
	 KifT1YZHgWlgyAV7oM3kaReY+1UWgQL3YZuoGQ9nGZZMzMSuGaKeMxaTacGBKEPfOF
	 40qHQDpQW+t+PVR/Wy6y5rjxa6qWG0m+h9R7NslE3eBon5zB8Sce660e3lKXTwlxvJ
	 DTEtmEUGjcBG2xka3cVErISxNvHToyU4zmppfmOBKFzLwrQGH7EVvTc4SND+paQ8Zr
	 iZ7+90zNQGyjFis+4bn0IABpVzF0E9cXrWEAXt0Hgf6nkho+LuJW1+JCSTShZmrLZU
	 XLQbp/ocH19ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF9F585D4A;
	Wed, 17 Jun 2026 10:06:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 643BCD8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 10:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41DF94063E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 10:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HkJg-RI67Z-M for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Jun 2026 10:06:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=doruk@0sec.ai; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E3BAE40480
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3BAE40480
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3BAE40480
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 10:06:00 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso1138069f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 03:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690759; x=1782295559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
 b=eBn5hXtsDKi/farWKvSjVFVlq4gQ6+pixr4+iQBzpeHhwaZevxfAYHJYL+iRg1kJ7L
 KxYcpnzVfmVLG7yqlBy1QyyiACiP1TDGvPYCZY2C+UAbUxYWbwWUEUUZNwbKnKF7pwP4
 SXBizp3e+U54Cvf9jrK7lSV02zAugzs3vbtenF/bpuFYqyCzS9fPnP5hMb/J7GboVyf5
 NHHDaxbyVj+RWAfqxj4d07hgnB4H8DkImke9XgDstEUgmWucV5S8PLpxPihTupOPRHBp
 3bAY4tCWHBW1v3quAL78iIrtnFsCROMpZTH1krs33/u3RzrAfxhuYStzx/CXVBv8+dpo
 bWeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7IlsM+lYBtq720x92Acv4x53tIGJnq0mS8gYanUt+5H7w2rWSJt0SxhYsztRpLx/rMp/qv2H04HEbaSfRXEw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyELvfAUqBGS9t8mPoc0WZV/At/keo73nKMMyQObiyu49lznGPV
 qS8D9JWTjJLcXN2TCVgxUx5XEGaEq5Gkr+NjamYimc9FhS9AuLn76lWXs9Jjx0ctxRNn
X-Gm-Gg: AfdE7cmK6lJxkjChxTDkMtLIyVicschC4q2nqKP5m9W1PTFKGc0tOpGyQLNYvUHMHWZ
 +dkDNh2+bkhw5SpisltKXiwT0HltcTZDQ2+fHw184ITOqOWCpWpRS62fwBkQzhVvhG8djv1+Ms8
 iwe7Y8ve5H87ci8fI+krKlecfYbZF2zN0IaFezExqP7a2uE+fMYbOYw0k1RGkZ6YTq3WRZqf9Iv
 rrqoURLMHxohEuyYPgll+gtL66+kUUaJs9xofn4ByzOSUr+UOtYVFrNJuOMK1F/mbh+XiaYarQK
 BxASGBE6FTaw7y+lyyjqP7RJ7SfXpNvFEQaJIxCgzzP/gE8+n7iqYqYagP8Hwpa4U8ONffSUX2R
 QclHZxVbYVZ+GNJubtWdZd+L88++QHpUynk0plZfgyE8IOMxf2w3YcVJrUn6lOskywAI1XT7EMz
 EuKfM+20hxYLsVtuSru3gps6QD0rX60VwuHP9/WKVxVeeg75OAjX1d1b9IaNRXY9hyFC19iTsBB
 f5Uazg4ZTWxl6/Z5MFJuo2tQqSUsSLR3mo=
X-Received: by 2002:a05:6000:2302:b0:461:a159:98c6 with SMTP id
 ffacd0b85a97d-46235e9ac51mr5885239f8f.6.1781690758585; 
 Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm55033847f8f.11.2026.06.17.03.05.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Doruk Tan Ozturk <doruk@0sec.ai>,
 stable@vger.kernel.org
Date: Wed, 17 Jun 2026 12:05:56 +0200
Message-ID: <20260617100556.83620-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0sec.ai; s=google; t=1781690759; x=1782295559; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
 b=d2bOpnTUASevYdPkcfYRvBXCFMjY8P9+YTJhvjGZTGey8VF/A2DaC9SpuSOEiTm8R9
 c13IFE6F9OmUjXejsTXTsr2trhrrmFuFo5sahXVO93dz9287V6lcNNBfXoj+jApCgXZZ
 2fjNcAX6fEx9QRITin0+T3z+v3JEYOYovVg8cgT879y2icllBuAWKZpxBgmgCnyKhi8T
 bVsdvgfTWSVPZgUMFZqMbCTlTn/5msXub/AQcvwto+SuD9T9GoZTUFXElXQu6IAxUX/3
 NKPJRvMvJHQ01q/rexhd3HQVjZ/eQG2/iWYwtKlNeE/45nuEL+xfVlgh7L0iYCcJ8W4h
 mqMA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=0sec.ai
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=temperror header.d=0sec.ai header.i=@0sec.ai header.a=rsa-sha256
 header.s=google header.b=d2bOpnTU
Subject: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix use-after-free
 of metadata_dst in repr release
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

ice_eswitch_release_repr() frees the port representor metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The eswitch slow-path TX routine
ice_eswitch_port_start_xmit() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight (e.g. queued in a qdisc) when the representor is torn
down, the metadata_dst is freed while the skb still points at it. When
the skb is later freed, dst_release() operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 v2:
  - Correct the Fixes: tag to the commit that introduced the switchdev
    teardown (Simon Horman); add his Reviewed-by. No functional change.
 v1: https://lore.kernel.org/netdev/20260615140532.52676-1-doruk@0sec.ai/

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..41b30a7ca4a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;
 
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);
-- 
2.43.0

