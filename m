Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD00CA5FEF
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 15:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DB5E40708;
	Sun,  4 Oct 2026 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8vB-xk0xDr4; Sun,  4 Oct 2026 15:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C4B6640709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791127749;
	b=AMoxwzHe69PkT6RMJfHW6dwI/RTiywTP5OXaAS+QRW3kHtCGKmxG2FDveeAwJch+8JtV
	 mIKmCzvdOmYmS7RaQja5Ef5iWu+gXCFlPh2RenqQnzdjBWHIj3s31ZadFJRxUqBC5QEGU
	 dGUZQTlwcaXFSo3/rWEDEIu80p7uI3B+edQiS/9Ea6elHouVZcaCK/3mvNh16+7jOG6RI
	 Oj0/38QoSJC5V1MSWtLUYFvERUZG65mWg4hErap4U9o/mgTfWN3YYH4WqZNgPdGVLN6Gm
	 Jb25lG7Fh6Ahas1s02VYNi1Vd/kzygOXBjq8Sy154kepRvlphARB3dKmnPzYV6s3Vpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791127749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
	b=lVI4XT8ZFur6mFJvMmFBhrL25HtdyB35/OYEWbY3bFDh/E7w2C9Hk4d7Wo0I7bz72cET
	 sM53rxKz4UytgJ0ooRn6AbvrFaIeThYDfCFW82peKh+DEI6hxI4RXNQeZhG8FlMkbx6jd
	 Ga2GSvsMTK55kaa/VyOatPE9gcalaEAzFbKTHLdxr/lAOXoyIy1P2m6ItrfjuQDjr1bxp
	 iXnBDH08sbbO7AYE4Ijrt8rZNa9Ld+jptec9caLaWEdTaxde4ES0BeGyIEqp5EbFUjYi6
	 JnzYbs9C2ilvbiNsSCHXp/k0lkmxbWixYjJoBu65ZOjsX2VJIWiliVTLru5CMqdkwAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791127749;
	bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R+nnNAi9hTKyOHKLaaesD9wI8oyLh7S/RSI8lw66hkBkO0pfd6jBVZnY4rPczuxpP
	 CTGJ8dT7fVnNmr0dZLfpayTzaOiRiv3rItqk9sqpXkt780/q4ZPhzmtgtsfMT1XtjU
	 7Sdmgf6HfwxRnbhmLoC0K+aUSHNr8VLdcX+u2wXKqa5IZDoqve4lWrwXIrCxIZvDh6
	 0cZ4uNbxMcVGRbDZbqIN44TkAXWi07pSQMs16Xi6mr2sV3V9qZyVd4xqJDbnFUMnja
	 cLkyiLE+6fN9EjWErH62Y68MDXkbSl5mU+6xPM9IIs7qG/IltBYNbdsHbaLGMe2f6M
	 mCePJEhyBmpqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4B6640709;
	Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 31DDD32F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 233726060C
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZs9RpkPCpLX for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 15:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1023B60607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127747;
 b=D3KGS46Gk9iZT9YpnnwJA0cITRMHjQdnuv9PZHywhM12nmO0Jhen14ffjFdGQ68nI+D2
 R3K3A4DGiaCBc7Fka2/zGlgzuqufynHtyjUcf7txNfFyqFXc4175hY01prLpb51Cm8NIs
 Pj+x4w3QS5U/eiiefNU6yIYn1lClRLcEkZqHn4/pa0uMS1eSx/xf6suU5+p5i6ezQLYLC
 F6m/Gz1JhGsEgnf5EZtolVI+WxT9KzN1xaDZ8xm0o4BLbBp8Hrk9hmpaP9pqDO+5+/bmR
 wnZ3TEM0P6OUbto5nF9xr/wn0bhToJ3wGoYYJqseEPFuiiBd3GfJg79CJ/S+I5DGvGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127747;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
 b=b+QMxgE29GCN09xupc2SrZNO+Pthmr0ELOZtfWQjqTQjc+g6zhKXTjmB9EauzIkB/ilD
 n6MNAHW3OMiLD/FRr51/4iRyRe1hFvkIQe9NO1ByR+MrsgcrDYqZVajK0H/fpRBbw2RFa
 rRaJLgX82kNi1r0Ga/1yR2wtdU4Fa23i08oNl3VE6QQPSrDZBNsY/H/kxA4bJB2jDEyeH
 uA5fkX5Qf28GKR6y9pNannPDP+yQ6k5gEjwhk6qZERMKHZuj7M/6WiF2MMKSE50iCUyCs
 eCyMBiqQf/5dB1MUVxRpAck6lGkSmQWeM9VnAmQYVxFrRG4sNIUT0Sqh6xNbTxDfsMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CKMY0jPo; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=b2rancourt@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CKMY0jPo
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1023B60607
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:06 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso9330355e9.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 04 Oct 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127744; x=1791732544; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
 b=CKMY0jPoHYqmimeEunPAd9RBwjspu0sarmNsha0BTUVL2pvQviDUUXpqnzYIuZhJVR
 bSLqMTM6vAYQTZMsROOjQXEVDLinWmfTzQ/UWTgQHH0k3W9bumyoS8KT6rfv2GRHBwe3
 WtqKajGOD7Rjt9PC7iY1fqsaEdPXpPBOZXC8Gu+5BnnuE96sO04pR8QlTBDgg5RfXM+s
 u7PkARJEe8hrEoDhcJyTP4FB01eLe47c07qIW4NAHexquCebyLZMw9FKnAkanQxQQEBJ
 m/ncK+CD+u2Eg0mGa8Um4ILWVEw3P00ZLOvCHkTaNCFgMrEanICbgBIVVmj6r6DFqHnO
 GweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127744; x=1791732544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
 b=wkBaqWhgX+ee32C++swYj0rHSVEnP6omk/JCcmUWkBF+cp5CZIIB8IV1ln8ECfcpnw
 6TvrtNuNSdmAsyfcUZfjEKZ8KrvMpyM75LuQjm4uVgzMnCAW8mgPZxuuvFhniflrdesA
 W9vn+7kQRMsFx0stPbmGKECdll1b1rIq8SN/gNeuaXk9Hl+26YtqfkHfS58OPe9CnX07
 uGXxbr/0fwKbgQ83iNVXnbQ91jyzXtvArzo7AnAtL2I5jNKVSG/hvO3wcMyorKNNMjlJ
 TQ86Gw8arO9DbAppDLk79BOImgAGokSogbn7ae62sd+tLsacwnuULk8W72BN2/u96r2s
 6UJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPaSvtzUC7fSmis31tHRYtHsSoAY0eNu4QRyIp3MR3+gL6EHTqbIP9kITV1QESnQ7FGSc8zlQUHyNlnBEmLZc=@lists.osuosl.org
X-Gm-Message-State: AFuF++lMGkEw0t/ztfv0NKq1dHYdFYsYTW/ovc4SZ5yZn+ZiFcyilwy5
 Xq/kQ5WQmBmz4isCyFHtGEZ4J77W2d7VM4zi+Pt9OzEHurroL7rdkZyC
X-Gm-Gg: AYBFou3GjwFop5RmD3tOzdkE1+0yeyp6EXi+cbZinNnp3k6mlppX73mduLl2h8I2nfP
 gkKQzFkk1Q5Rmr0Rj6s8ePIPlIQdcl74AwF/2tJ+yeTPZUrGK0cauv80i51BViINfFknhF3Z4lC
 CXglHFE748fNBoshNSiQlcX1iLX+QGvXA3BOWx4aU6ehCd577oPfcHt8D/8CZFlHCHdHwqpFowy
 nlEq7BeGuQmjvryoHwF+VAhdvDRgsCm5U9wQy10+5XsOLH0r3c7Qc/K7HZxSwQvaXtZbkiyA4Tv
 9IyyGw6mdshmdg72wSpLCqAutVKjzmGAE5xPp34Wcartru4mH/AArHskZFYi2/UfokhHqNfA16S
 g338Fe7A7PfWZlFfOutTkjGBuAVFHxxiCoIwfdYZjx2gUMkg7ip32B+F3QWjF/fJijYhZKayx9z
 oHtvQHHc7B5MZFUYZIbV1Iph0paqG0cZZcsBYKv9g+OUISge/v6HeZU5V5WpOtpw9ZJStYxBDlr
 h6A5F6IN5W7Y1nKHE4Ze7EnHFca8dfLUJVJPFrAcPuIli0h7oqfmh9MLWisjgaNU6jJLCF+pSk=
X-Received: by 2002:a05:600c:3545:b0:4a1:242:1353 with SMTP id
 5b1f17b1804b1-4a102421468mr124163015e9.5.1791127744379; 
 Sun, 04 Oct 2026 08:29:04 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 08:29:03 -0700 (PDT)
From: Benoit DE RANCOURT <b2rancourt@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>, linux-kernel@vger.kernel.org,
 Benoit DE RANCOURT <b2rancourt@gmail.com>
Subject: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty frame
 descriptors
Date: Sun,  4 Oct 2026 17:28:39 +0200
Message-ID: <20261004152840.61222-2-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004152840.61222-1-b2rancourt@gmail.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
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

Commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
bit") raised the number of free descriptors that igc_xmit_frame_ring()
requires before mapping a packet from count + 3 to count + 5, to leave
room for the empty frame (one context and one data descriptor) that may
be inserted ahead of a launch time packet. DESC_NEEDED was left at
MAX_SKB_FRAGS + 4. igc_tx_map() uses it to stop the queue in advance,
and TX_WAKE_THRESHOLD is derived from it.

A queue left running after a transmit therefore only guarantees
MAX_SKB_FRAGS + 4 free descriptors, while the next skb with a linear
part and MAX_SKB_FRAGS fragments, each fitting in one data descriptor,
requires MAX_SKB_FRAGS + 6. igc_xmit_frame_ring() then returns
NETDEV_TX_BUSY, which the queue stop logic is meant to prevent.

With TSO this happens routinely. On an I226-V (8086:125c) running 7.2.8
with MAX_SKB_FRAGS = 17, routed and locally generated TCP traffic on a
CPU-saturated router produced 10890 NETDEV_TX_BUSY returns in three
runs of 180 seconds, all for TSO skbs with 16 or 17 fragments, with
21 or 22 free descriptors in all but 5 cases. Together with deferred
tail writes (xmit_more), these returns led to 25 Tx timeouts and
adapter resets in the same runs:

  igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2 timed out 5353 ms
  igc 0000:08:00.0 terra: Reset adapter

The following patch addresses the lost tail write itself.

Raise DESC_NEEDED to MAX_SKB_FRAGS + 6 to match the admission check.
The additional reservation is currently unconditional, including when
launch time is disabled; match that existing admission policy in the
proactive stop threshold. With MAX_SKB_FRAGS = 17, the queue is now
stopped below 23 free descriptors instead of 21. This also raises the
completion-based wake threshold from 42 to 46 free descriptors,
preserving the existing two-times-stop-threshold policy. Throughput
and latency effects were not measured.

With this change alone, three runs of the same test on 7.2.8 produced
no NETDEV_TX_BUSY and no Tx timeout over 8.8M NETDEV_TX_OK returns,
including 613k TSO skbs with 17 fragments.

As before commit db0b124f02ba, an skb whose linear part or fragments
exceed IGC_MAX_DATA_PER_TXD may still need more descriptors than
DESC_NEEDED accounts for.

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Cc: stable@vger.kernel.org
Assisted-by: LLM bpftrace
Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 17f213cc93e4..f1efadbd9f74 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -575,9 +575,13 @@ enum igc_boards {
 #define IGC_MAX_TXD_PWR		15
 #define IGC_MAX_DATA_PER_TXD	BIT(IGC_MAX_TXD_PWR)
 
-/* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
-#define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
+
+/* Tx descriptor budget for a head and MAX_SKB_FRAGS fragments,
+ * each fitting in one data descriptor: one context descriptor,
+ * two descriptors for an optional empty frame, and two spare entries.
+ */
+#define DESC_NEEDED	(MAX_SKB_FRAGS + 6)
 
 struct igc_rx_buffer {
 	union {

base-commit: a83267db14681b3be481e02a4d5a38177507006c
-- 
2.55.0

