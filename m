Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FE6CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0BE580D1F;
	Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35inUPBeDWD2; Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D42CC80D21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791127748;
	b=S2yRhlmN3/oCW2yOc0G1FK7IBf3TCM60MlC5FLLX9oH+RuGyA2MY5eU9Y121ZtAMZmbZ
	 39YbtL2sDji0OUb5oxyp4IEgs46BZ0UTVDVbSwUxNU+qEuYXkytOEBDIUUyf1903Q+Kbn
	 PRiTgsROeGdCrRdt5Ibf6rjPvNXAHFfIVwNbmqEgju39MNbfRkeZZtvpzA7dJ8vLWZDOa
	 mALUWB0zfTLvenMxKf0ZkYbUBJCWn0mZu4YD7KrM7xclG1Daf54u9igDc9bZvZVnU/VrE
	 DhqU4cKtQrmBsJJXCccGCvlSDhlZVS/brYbl6w3iG8AFUFgJuqLoULv6o3SnczgYCUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791127748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
	b=R0Ad1ULfWUfxwfw8QSqORDD0w1W2bRtWPAwuDJQXbKINTDWUN/eCpzwwDf/bGETXtOkP
	 XK10SZ259JqwhgsUJNZ2uGnaLmXcbshK0QU3gthDfcOnMa1qBF5doDXDQEvGEjfCB0B9L
	 2OyCSUgibN4Hd0Fiu0L0+Cs/6IczU7ra+69I24uuwTwyGfIr6zy9xrcP5gECI2vgQ7Zd/
	 FbnPHnFV1SdkseKGSUo2ezUkbv/kU9Ukr2s29RA8TZKtoiv8wQsYNSEUS0iT2hVy1zHYJ
	 k/VeINbqg96Gra+sRmYQ0Mj0/POnpFGwe7apSglwpgNk3kB6+kivOeUWuRyzhIQClIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791127748;
	bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i5mZR4zpU1+Z4FTaTpNUmhyfwxc+3Fa3e3H2mfDvUfSKr8ae9fGQWlb97U91igNuM
	 FEdSObCVtUI0O0HiBSfx5VP4oydgWOReYm4azDfx89a4kmxItdErQ8Vbe+BZhtbe9i
	 ztIpwFh9qo5WHhZ6cXWs6KYHmL8xpwXYrYFLkSNKFrPprLYNx8HbYC+xpGcKIaqztg
	 mu4nvPw7jxqKO0EeEbgEKx6/sFjiAZI6q1M9WLSUOfQ+fEERYxhTFC/vSYDNF14cRu
	 Q/FnOOLnlDGf+u/sCe1IQN9MtmKgPYN+1eLHI+t6ybov+43p81+ZHZzF+a/vTdNGJ7
	 RUSQiG61p9G8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D42CC80D21;
	Sun,  4 Oct 2026 15:29:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1559D263
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFA1C40068
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jXQNwus82i5R for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 15:29:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C618940049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127746;
 b=sVOKYHEGHPBHoShDqMPGBE5H+cEVgdQe5I+Mcgz9UfWeg1Sp5xmoaAxFFS2dv+5eWGW/
 dJypt99kIt0oQycfaQTz1Cf1pca64RZ0EGD5WdtPMsXawJZQW1TAJBfa36fODnrxxJ/KJ
 CyXWl6snv4GyU7DzzfLuxLUNfZt8x2XmxZIMUgCTTZubaRNVEML4uEyoTmb4ogvUj3uMo
 92pPoJ6Z1ynfyrmvJdxluT49kEqNvOvTB4uDA4F2neidjz2B7pLskg5H/uc3ePkvxyKad
 I+M6v0hv2MgNdhiuldaRaSCkc5hWH0egRiC/cZaZRGCHcR5kZhabziwS/43GM2kf20w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127746;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
 b=N6BsTIhD/A4SYe8065U0aEza1qKa7xB0DF9afC0gf5CdrBY415noaOIgKI+Z79pWOLtF
 77SBnVfEX2RiSu1Xjlkh0Vy+1MPwbnI/eRldKWvjAeUJSjwm0qgh8PU45izi2iq1sNdAc
 L77jupUSUVaurazTii2hIXrypRUSMkH8npYx38gyol/lI2WcZvIgzsPFhl7xEtBKo+3dh
 ImOfwtBUIHvvSafVQ5va4sITCAzXoqyQ8YbHIXc4N+hAD/VqLVH0ayLTQaVkSVHQcvc6v
 k5eP8Jl+vuAE7eb70YTMC5jGcDpCq1DBY6ud/TveHm6H/Nu++HK/SUcRld/9K3xjRww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TUSYLBov; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=b2rancourt@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TUSYLBov
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C618940049
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:05 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so5658485e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 04 Oct 2026 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127743; x=1791732543; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
 b=TUSYLBovn/lGzLJVEAVuJ82JIQjMwQmVz1LqUm50ZdXH++rLUtFc5wjvjWJz4PVgVM
 sfIPnEVasXq/PAhT7FpeissVVRsKnHcLY7SwFbxPqTp4ge1i37yXHFXI02kKdC0GBhHF
 ohHDMFk+/KP/q86pPQQ8H7R3cACucIgj3/EqhVT7UeYGtgohJyYtH7dnOhexlXu3yML/
 9l5Ghu9u6EQSzZb/tTs01+dHPoQJ+zPpNkE0P1ip2Cwyta82byn2USUAtKMT/elv8jNo
 dUtlvQZOZjLe4ii+u6Ly6dj0knx7bWij6YDlLpEWqvDXTb4C0XFHUBurXn7H52niyzYo
 FGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127743; x=1791732543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=da8v9Ff4EAj7a0ycHgkCs+irzmjp0yJ76SMiIUMp9bU=;
 b=tkGjIBKHScnZ9J8lgSERpXwSmoH0EVk4ZeL9CfxbGyUgqLWWgGpNkEGvF9DRCoA+ci
 St/Sv5UGkJ7E3OrQINy+ijggZt0QZqfBa3zvPkdsLtC08N1Jdu/4KCWO3/+DPZ/H0sJZ
 dPW6Ylv2HswQFveL5PnOJvhVPYqU8Gj0a6BC9PYD3549mbDbSAsOeeb79yeYOJVKKvvI
 gm/3sU8EovwkYCSvSrOENg/9ox4T8CPcHmyAv0dthUxOq2QYRQlZetj9uS5HpnKfAZVz
 0uxQ85VJ+wtcK9gVIMY3B/biLQscqqPNCmhLUoV0rUY1+9UWb/gQjqJrPi9gLrDiWrnr
 4mdg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJafjvB3Ip09PVhhD+0X7ZYadse/fHHXME7tQ15q4MIwhUR+O4fFeNELQWFm+osErCvuVpX2ldofwfwWbuqE4=@lists.osuosl.org
X-Gm-Message-State: AFuF++l4sFTWpjUxwydcTjk8P+IUiGXxCTZiOg1bzI5VMWlDnImpXwpy
 o/AEFPzEgxfVIBvp6JqZ+991jWt3Y5Sjpngaj/CHuUyioDUv44RU1DbD
X-Gm-Gg: AYBFou1hEI4ztzcrTH9exIzrjRbFPlum4opljU6q6lIGlZFGGpLXCHmP6QN6Q8C/tJB
 +L3zcMBnrHLlXcaYimjlrfVO84c2jke7pkUT2NKOalv4Y8aRDOhcdjzS0UhnX8wsQhX4fkoJ+4V
 pOKM+KbABOglroVlZ8fzdl8WrF/SAlxMlFDW66swONSlrdRanfzYyTobbiNcxQA6geQdJmu37jM
 9KnOwN9k7QDDv9kATCq3Tw3ZMETbE6BOQ4Gn3EgX8sDk19ck6DLOgUL1nmpaqw16m/y8ZPFJ1HB
 easDTwKtkkD9NTa54P1qYqvuiqS218/GeRfIjrb7sd7bNdQlYa8hmMM2ZXSvgQbO00tHWYnf/IF
 2JPutWMAVFnoXPxeN1uSEYNjFBmqlAlVYgP+Xg1i+P1EdaEN4DsBoBql5kzu8UEfph0A/d+ekuW
 N5K+PixtOciKlYr7/uJLzIR05G+T4bnWNijnmfwHmkl65U2cnIUHFWg+BF6RfI/5fv0TmlwDq1e
 xsUpouHpFFEjI+xbq7Nz+sHZGNbGwTju3kTPUwnOPh0nWTE60monoaAcxbljtNOrekmDxHY1xM=
X-Received: by 2002:a05:600c:1552:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-4a02755f84bmr145261655e9.11.1791127743178; 
 Sun, 04 Oct 2026 08:29:03 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 08:29:02 -0700 (PDT)
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
Subject: [PATCH iwl-net 0/2] igc: Fix Tx hangs after NETDEV_TX_BUSY with TSO
Date: Sun,  4 Oct 2026 17:28:38 +0200
Message-ID: <20261004152840.61222-1-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Since commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first
flag bit"), igc_xmit_frame_ring() requires count + 5 free descriptors,
while the queue is only stopped in advance below DESC_NEEDED =
MAX_SKB_FRAGS + 4. TSO skbs with 16 or 17 fragments then hit
NETDEV_TX_BUSY. That return skips the tail write deferred by
xmit_more, so the queue can stay stopped with descriptors the hardware
never saw, until the Tx watchdog resets the adapter.

Patch 1 aligns DESC_NEEDED with the admission check. Patch 2 writes the
tail before returning NETDEV_TX_BUSY, which remains reachable for skbs
with buffers larger than IGC_MAX_DATA_PER_TXD. Each patch was tested
alone; together they keep the queue stop logic consistent and the
remaining busy path safe.

Setup: CWWK router, Pentium Gold 8505, six I226-V (8086:125c rev 04,
NVM 2017:888d), 7.2.8, default MAX_SKB_FRAGS = 17. Load: CPU saturated
with busy loops, a remote build routed through the port, two SSH bulk
streams in each direction and short TCP bursts, 180 seconds of load
per run observed during a 195-second probe window, TSO enabled on the
egress port. bpftrace probes on igc_xmit_frame, __igc_maybe_stop_tx
and igc_poll recorded NETDEV_TX_BUSY returns, the inferred last tail
write and next_to_clean stalls.

                       runs  Tx timeouts  NETDEV_TX_BUSY  TX_OK returns
  unpatched 7.2.8         3           25           10890       7.3M
  patch 2 only            3            0           10751       9.5M
  patch 1 only            3            0               0       8.8M
  both patches            3            0               0       9.4M
  unpatched, TSO off      1            0               0      21.5M

In all 25 timeout episodes, the stalled queue had pending descriptors
after a NETDEV_TX_BUSY return. The probes inferred at least 214
descriptors beyond the last tail write. For that queue, the hardware
register dump showed TDH = TDT = the next_to_clean value recorded by
the probe.

With both patches applied, no NETDEV_TX_BUSY occurred, so the flush
path of patch 2 was not exercised in that run; its effect is shown by
the patch 2 only runs.

TX_OK returns count igc_xmit_frame() calls returning NETDEV_TX_OK,
excluding NETDEV_TX_BUSY retries. These are software call counts,
not hardware packet counters; with TSO disabled, segmentation occurs
before the driver.

Related code, not addressed in this series and not tested:

- bnxt: commit e8d8c5d80f5e ("bnxt: make sure xmit_more + errors does
  not miss doorbells") rings a pending doorbell on the drop paths. It
  leaves the busy path alone, reasoning that busy can only happen if
  start_xmit races with completions that both enable the queue, in
  which case no kick can be pending; the current code warns "ring busy
  w/ flush pending!" if that assumption breaks. In igc, patch 1
  restores that property for skbs whose buffers each fit in one
  descriptor, and patch 2 covers the remaining case.

- igc drop paths (skb_put_padto() failure in igc_xmit_frame(), out_drop
  in igc_xmit_frame_ring(), the DMA mapping error path of igc_tx_map())
  also return without writing a pending tail, the case bnxt fixed in
  e8d8c5d80f5e and 00eeab0c644a ("bnxt_en: Write doorbell when
  linearizing skb fails"). The queue is not stopped there, so pending
  descriptors are delayed until the next transmit on that queue rather
  than stranded.

- igb, ixgbe, fm10k, i40e, iavf, ice, e1000e and e1000 also defer the
  tail write with xmit_more and return NETDEV_TX_BUSY from their
  admission check without writing it. Their stop thresholds match
  their admission checks, so this should only be reachable for skbs
  needing more descriptors than the stop threshold assumes.

Not done:
- runtime test on a kernel built from this tree; the patches were
  tested on 7.2.8, where the affected code is identical, and apply
  cleanly here;
- launch time (ETF/taprio) and XDP/AF_XDP traffic, which share the
  ring and the wake threshold;
- longer runs and other I226/I225 boards;
- only the igc objects were built with W=1 under allmodconfig, not
  the full tree.

The analysis and the patches were prepared with an LLM-based coding
assistant, which also wrote the bpftrace probes; the results above come
from those probes and the kernel log on real hardware.

Benoit DE RANCOURT (2):
  igc: Fix Tx stop threshold to cover empty frame descriptors
  igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY

 drivers/net/ethernet/intel/igc/igc.h      | 8 ++++++--
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)


base-commit: a83267db14681b3be481e02a4d5a38177507006c
-- 
2.55.0

