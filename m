Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4DAC98318
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 00:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6940E8122C;
	Fri, 25 Sep 2026 00:34:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3y3bPXGPm3js; Fri, 25 Sep 2026 00:34:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C4F4981240
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790296489;
	b=tFlTFlPGsa6PNjlVfzcWWsJG+9qKn6or3nM37/oAYslonlYIM7WjaIydg0CLKvd2Q4oC
	 AaIg0XEY5WXtM0FQB3K3OuBxIKw2MmJMgeyfMLPVik1ayMthTnVXIHiJhrzcsIi8qBZYu
	 zEz8QV7lnDPBPmwtKjKxeBxhhBMrRJesbGDsjojEltWEc2IUecY2fheBq9qJ0z62fcYO3
	 pf/aua/VBDL0fIN2rGkATPAYJ/Gf91CyK0NVi2Zylvont1HGQJUXu2YHB4bOQjRLOTDja
	 QGRZOFoqC2kxeX7GXSjerlxIvBblceYc4R2Ly+ygTfKgEQ7IeLT15O2xzXyTG5FIatQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790296489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pEOSNKxeCJBNAGtkZyV1IkgJGtUbB5DBJZYMoFtteqg=;
	b=VlIYXkk6s3tZRjoQO80o/9Gb1NbsHceFQazkVfz3ONAz4jzkofrzqyRd0Ap86699yDDb
	 4Qg6W7ETa6DxIsLauAXtxwOyn65TMzdm7okGpX8P+wXdMU6pMirBK1PK6CxJ3N1pkTgo/
	 4DHZmNTFyMEi3+y3KleW8Q3KZly6WMnvEA3Q4HWHSiyio184DvH32FqgmGw4hTvOkF6u4
	 i9b+W8vVYxhjayzm4ETGDShrdTuCD1KclExUw5JwMJxNphLS8PwWu8O9F8S0A8B9zbKWj
	 270W6XF1gGqcU8eNrZtid+TzqvulqKitQ8ijwl7bOtK20SkCuLhqDJxh5CXOVWJ/WwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790296489;
	bh=pEOSNKxeCJBNAGtkZyV1IkgJGtUbB5DBJZYMoFtteqg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZSF+yyC4oXZZJs6v3J6EcLSVM3+2YhoiQqSfcaKdPLu9Vo3Vacft22nLTArzKOWOx
	 hlNoviyWCbVum49R+yXZQ9Na4fyOBfVm6YA1eAVVicJohR/82FWVgAzxYrXXHu91WN
	 /ypp729HpYhrAywZaaS406wueyahgqfEtwhfw2uBi8dvOW1G6qwADKBusev6U7vZLG
	 exJ0VLLCvJv/9ClmHFzy9BStB4zSf/hH0i2vvcJTCmZleTmsxUmnixy46cUv8WVs2i
	 Tmi/FVSdDo5aanWN8r2HmWIcytkajFY5zGaCT8dAiKGjFMbHeVu7BYOVBEwmxIkcph
	 z3K/HetelH8Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4F4981240;
	Fri, 25 Sep 2026 00:34:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28358194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 00:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E6F140C90
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 00:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4cFKtxoK679 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 00:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BD80E40C8C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::16"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790294608;
 b=nF70Ysk1ITnt7BFZDIAgTUVrQkBr9vOFDFa8SoDCN5yPkrlerXFX2bYA9nzrjcwYPs7U
 Q9EvkfRQsWTcJsyFa6klgLmaY/Y3FzvJgUdFNbqyvZ9sePYUatyKGz6r13Uj+ADCaoR2/
 GITx9r7y+8LJVA60J02MLsrhYHifC3kNyvZCKTFUzVAqGPtNYPJgPiToQrfXZ2P80RCpS
 qh+UD4DUeIHxH+/wWSuF5F9xVARlORHDACUYY5S5/ELOm7KQ2zuDWI04FkrZV3xs9BLmC
 ewyfNFJ5F9uQV2VKXlxzJdRxphYboTpGG2VuuC9ItDNYpUfCehXNFsFCpxqqjNHlEfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790294608;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=pEOSNKxeCJBNAGtkZyV1IkgJGtUbB5DBJZYMoFtteqg=;
 b=j/mU32vR8h6pJMt1jGTl8gpGsx4nIDWS3Eu/Bg2vECDYBJHvJncf0on/BPhSp0IEX9rw
 ln6Onbs8iDZCVVVu8r3IRUi1Z6NdVme4T4pGmy1bY4nC31L9FImowZQsBXqeMkE4pOEnt
 tRDBhz51U7MTjGa/2kZwSSXSxXCY9lfqwzs0ILqE79vbKKp5meuAhbE+XOBih+U4BOOws
 yRd8lboi/oWqsRpwGjjM4QOHMRj+06EG9e/NbnFhmbWtHnekwro3HGNr+Ah6i3QQNm1Wj
 qNdj3tbnS/4XK2jjOM5ekfmT+Ay8H1ssSclDWBzEeCK5eSRR0ESJtoJE7yDSNrEzRNA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nn0S2YSb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::16"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:36::16; helo=mail-dy2-x16.google.com;
 envelope-from=ayush37735@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nn0S2YSb
Received: from mail-dy2-x16.google.com (mail-dy2-x16.google.com
 [IPv6:2607:f8b0:4864:36::16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD80E40C8C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 00:03:28 +0000 (UTC)
Received: by mail-dy2-x16.google.com with SMTP id
 5a478bee46e88-33e6b4e33e4so321858eec.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790294607; x=1790899407; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEOSNKxeCJBNAGtkZyV1IkgJGtUbB5DBJZYMoFtteqg=;
 b=nn0S2YSbZBmlzVow+pH3hkheeKOrFOMaE8HomnNgagYSKVSRU7YAQLsNcLueVKdnnC
 DDP39n1KRxSF1qIJtmlc4ZGmutmiSGfY5buqd5jQzZ8ZC6VuQF7ti6s9OBb+AqG+KXoK
 6TX15ggIl4bEMkmJ7bMVU7um+CBheH/PHpgf6Cz+DaiUIhgE/UbKRCd7uVaUIl/DImAg
 6byLobklQT0uGDF/6a8OMZfYijFgJuvLUx4CB4v3OIOo5HkOTskiPiqWdv0IKKW19PeT
 hKahxFfuAjMfEBpvsyp/2feJv3ydouxw/y5hNJk2NmJWmQYIn2P1oI8277E7OUPnoAyu
 qHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790294607; x=1790899407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEOSNKxeCJBNAGtkZyV1IkgJGtUbB5DBJZYMoFtteqg=;
 b=pLpeH/x2j4uTsKwywKu/CdmDcodlbtSJKuvFG20vU+YeAdAm7z218giayJZKKiNUyU
 jtfPjTfup8cF6twEQn0slQFNqVXMA5HsGPc9qpUxC1eNItqFUW4ARSGMJgqKqF4pmZql
 0CjV8+TBQiiEAkFPnz8tvoT3iy8K6cyORl1nkUcMSv6fIC5TDSLxmJipBhdEbp6ouBtn
 xGtKUBGTTOLJeEoOaFqgjKlAM03TWuz2GC9vxXtb+5FlfPA+9OyA4kCk8qk8Jh8HuDZ9
 j//s5GKyQW3hV1q0yq6ds7AvhMuKgjDOLkUUNtvlxSzYNErYDsMgxBnWd6EGqjQuPYPC
 EOBw==
X-Gm-Message-State: AFuF++kSPEqLOH0qLknLZY2/3JxqVq+idqTIdVREpln4bxq2hisBEbAC
 Qs1BwS+qAqXkIcKel+66aTuETtZh855K3vjFOMhIN9WlUwKbzAYoX0ZQ
X-Gm-Gg: AYBFou3qYJCI7hRvNXJnkS42fqwdVtLoJ1xE9y3MxOeDDWfj70dSQIfPc6HPj2APqto
 qZ99JHQeE7WOlaI+9iarNx/3fvZCP2c9HnpefnX4TMlOI0ctm76juGzN2+fHwc5c4LY34USCQxr
 QpgoaKa19aVJxJmFmkr+psykh3zfWOJdg+qMVK1sAasNgw5IObYQsVrbCOUUMlaCF5vK6T9t+nA
 hweNdU0j7hb6MVmSvypLUNryK8zGCOlmbcr5advQsiOUqR+zl317FEtzdmn5va0oa6Phxnp6sUN
 ngDnBXPxhDigsSvduO9XSDHt+XyVcQ4XlgMVX7pxivvQUYZ7ea3snH81QSr4vGSaQJzngkpP87C
 Y0j93d1Fh7iB42IYK7QdCLWRnX94dRWBWx0Ml80BfM2wU7jOLdEgZOIckT14EHb5yn0fulLXjV/
 Nfz6L++A8CaiBWTKnfmd/csWsIe5FXAYkKz2fXRSkjzJfzhuvid8IHKOlWiZM=
X-Received: by 2002:a05:7300:3715:b0:341:67fc:98df with SMTP id
 5a478bee46e88-34167fca954mr845342eec.12.1790294607231; 
 Thu, 24 Sep 2026 17:03:27 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e1:11cd::1c6:c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757747sm1944409eec.13.2026.09.24.17.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 17:03:26 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Brigham Campbell <me@brighamcampbell.com>,
 linux-kernel-mentees@lists.linux.dev,
 Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
Date: Fri, 25 Sep 2026 05:32:44 +0530
Message-ID: <20260925000244.72480-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 00:34:48 +0000
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

Remove stale @vport parameter descriptions from

idpf_rx_desc_rel_all() and idpf_vport_queue_grp_rel_all().

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..6041c3faf7c4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -487,7 +487,6 @@ static void idpf_rx_desc_rel_bufq(struct idpf_buf_queue *bufq,
 
 /**
  * idpf_rx_desc_rel_all - Free Rx Resources for All Queues
- * @vport: virtual port structure
  * @rsrc: pointer to queue and vector resources
  *
  * Free all rx queues resources
@@ -1394,7 +1393,6 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 
 /**
  * idpf_vport_queue_grp_rel_all - Release all queue groups
- * @vport: vport to release queue groups for
  * @rsrc: pointer to queue and vector resources
  */
 static void idpf_vport_queue_grp_rel_all(struct idpf_q_vec_rsrc *rsrc)
-- 
2.53.0

