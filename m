Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BD9C5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDFB4407C7;
	Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twY7nJ4K8vqp; Mon, 17 Aug 2026 15:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8347407B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980442;
	bh=uClaKJD4Ir9tR/GTyjo/ABX39e0TSK4z5x2QoXKCFyM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=EBowIlJtu6T6DPiLs9umdFKHfA6iBRGK+qDP6RlVDQem74okkV4rnK+fyBBQ4RRnq
	 HZXdcg/93UGExw4Actg2PDOTEDiTYVy0QOYLbvFafObBZ6VGeGWx+N6EcKF3vXHjby
	 S/lnH4Qayjs27qllxp9HFVv9nplKIAL7sUn+Rw3gvMUrEd+SAcdAQ1qMy1aT/eN2VG
	 80rveeucZZj14DeGxhxnsWiqUVy2HjAxo4qgE8awD6a5DBoGJGvVbqLppSDoG1gTaG
	 3wkZL8gTXIrM8PuPn499pzY6qrUROgn1NJOU818vo/64bWjWCQCBsrXoaEBf7yVMij
	 rrrzpWZxYzTHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8347407B7;
	Mon, 17 Aug 2026 15:27:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A014194
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 13:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0767E406DA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 13:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfS2vp3pj6li for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 13:55:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=tristmd@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2380F406D8
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2380F406D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=csn404bY
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2380F406D8
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 13:55:13 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso28864235e9.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786888512; x=1787493312; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uClaKJD4Ir9tR/GTyjo/ABX39e0TSK4z5x2QoXKCFyM=;
 b=csn404bYz9oJ+UEmgM6lzxbH7npJfbV96zl218mH17gaJzE4WRXgM1Ig6yGg4PjrTf
 cl3seDRjEcBCihIcysAfbogySmIMNg4kUo6bmRpxhD6aL+rox7UG4+5tFRZxqOwC7bUN
 n+aFWOz25wJul/0xJV0pR9xTd3r+qb7dZkTx3U13Oc/jo1KbL4ACJqvsgO0dCgJZEmXl
 +vMvygK9XkYu4BuYHJLyXQBYHv7QavNlR7F/KvHmlZPHHCeksqEz2R39gKpeEeUZOvxo
 X+Yy3IE8zPDXVEJk14jwdgkdUgB/xTHggdJyurc6vFiYvEWFYM0Rce4Fw6kApKOU+ROy
 f/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786888512; x=1787493312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uClaKJD4Ir9tR/GTyjo/ABX39e0TSK4z5x2QoXKCFyM=;
 b=JDek41jCLFU0E8XzsPIdmjKgiQ8TjjLbCiXtWo2UgfdrTVFCPPnGG3YmMf9f4ii9fm
 Pe7aEdQKeVzjIcRNIv2Uxo8OkWBvx5icGGisOkLZiiiqwYGIQ4QhOymIlRNg1E83OOoo
 EI9U18r8qVO7YGgLQi115JUQftAgSuV2vSMMPAVsSraXrkOz5BYq8P6bUuAE8lOrUABw
 8XZI2K313QKS6ZduU7M0pPN9NAizsJ1xhroRdLr3KwFXc0P3yOewQH5YQXZW95cKZhCX
 bZtEuxqsxN08v2MgX1EGK1o4kjl6lwG4Oav5RL2K7cP5FGjdD1e5DddBq1UJAEyo65nz
 bgTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3iGYDQOoI5HBagIvDixbzeCPIytOne/EDa/TwEdAvIAEUdrCSb2px+3LGHghCEQOfvV+TevwprL16J+HQADI=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzxpJWKqG1zcHlLtRlyS132sXtEBuJcueHjOiBSbS5qbxi0hlw4
 5VerjnKUIwxfW8Kjra8G6AMXPIIBJAEvTg7BGszbnpDnWbKegZa//PI=
X-Gm-Gg: AR+sD11J6gebePBgMwiE8tOEwLJMtWrB4lVJ729z40ZtphTsCgjzU135C6RdsTJRsRS
 /BnrLbY7op5azt3+O+QyEnDEFigSNTO2w+jSt65ItBH5A9a60ny1BolFVUes7Zvgkbwd06jOyRB
 /Uk2IcmUFN2TbNgfOPg+TPIUsLCLcq0zoNWfKe5/vYqd8pKNjHyasBGNdo/YIisMjUbTbLKmvfQ
 mA57i3YWmbyUqYRwkoFHzDAqCr6Qgwv50GAhxmoA2Ws1WvO3rGB66/MbOl9vLsapL0WScueKzgp
 puoY4WkgrHLf+ruwyaQvGPeYUsyNAJYyVtl/6+2RzOtbLDYuZ0qYEUErUWUAG3YzndzNW9KiRCE
 2Nfc8AKffaCrauGu7W3kPOSg4wNWHNpkyzNrmdDdxNxVLQrZccK9HWxpP0B3rHX2yve9AKtlT6l
 ntl0FmHpInXqvts8uGBQcBYXKZQ5ikeA==
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-49987938e19mr302694185e9.1.1786888511685; 
 Sun, 16 Aug 2026 06:55:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c0a75sm24312488f8f.25.2026.08.16.06.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 06:55:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Sun, 16 Aug 2026 13:55:10 +0000
Message-ID: <20260816135510.1015041-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 15:27:18 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix metadata_dst refcount
 handling on representor teardown
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
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Tristan Madani <tristan@talencesecurity.com>

ice_eswitch_release_repr() uses metadata_dst_free() to release the
representor's metadata_dst.  metadata_dst_free() directly frees the
underlying memory without checking the dst_entry refcount.

When ice_eswitch_port_start_xmit() processes a packet, it takes a
reference via dst_hold() and attaches the metadata_dst to the skb.
If the representor is torn down while packets are still queued on
the lower device (e.g. in a qdisc), the metadata_dst is freed while
references are still held.

Use dst_release() instead, which correctly decrements the refcount
and only frees the object when all references are dropped.  The dst
subsystem already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Other drivers sharing this pattern (nfp, airoha, bnxt) already use
dst_release() for their metadata_dst lifecycle.

Fixes: f5396b8a663f7 ("ice: switchdev slow path")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c30e27bbfe6e2..96174fca3984a 100644
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
2.47.3

