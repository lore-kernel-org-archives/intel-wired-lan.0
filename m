Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3C8CC6B2D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 22:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CE3808AF;
	Wed, 14 Oct 2026 22:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yQXuj8APIno; Wed, 14 Oct 2026 22:22:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B6DD80BF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792016562;
	b=soxJ7uXE8vq6auXdxpgmxno1aBClInRm7eOz9EOiUVxUxRJ7KFAxjmVpeXDeG/jcSow9
	 65iKE5uMTU/5WWnZmkimXlL5F/bskBY5bo7eIcr0M30y7Z7YlRkooefSMZp+hJaq2MUfH
	 KF0RNT/icDeowIuuQIlwCyPB/9RtrNbJ30hr5gOg9PFQTdqCGuzwE2K3HqpfLiUaxqq1A
	 divoR6s8UsL2e3SIFQRgt1L68DiZX/cs/MTr8GEnYLi8dvMUKTPOMh7Acwl2gIPEOJXfR
	 JwtGRDhdc6+LXGDY5SYC9LP1KRDKUutVJ9vzMpngBTmr1so/n0e3zDKVa2chu1FplzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792016562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
	b=DXDIzRxURcOIfx9TwU8wmsvArbntBGgeEvB7IA/Cfg3KK5LZV6oku4gGLdjYEuCnkywM
	 u3t9sgVBsNPbsCc50mRn6zxtLPvnFO+m4UhHy+uzs47CJZmMCVMyypnAMktyJCeSM8yLB
	 4jdWMP6PQjga+HXtNvglq/5XMnzCB+33c1/I58mgh+DgoFGCsHEjuAiShrFBYCylAKSsR
	 vP6jyxruufipYUz2ed0PW66PVptP7np2hzuFtXiUXtVpz+9u9U1xo10nR1UvU0U3hG+ya
	 O3xlKKwCLSZoiEUbxl4usnfdAepYwrFs8E4DttPEma+k+lMMuMvvLkmcbyrTWuyGDdw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iaz5SkTS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792016562;
	bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ThP7/Dn3PDDK8l29eTWPrMwR9+QDimEkPiMqT6yWp4pHZtWjhBbhh4/b3/BDPFiKJ
	 HVQQMMzHilbmp0sOyltFqvrOK5f1iw5gnYjE/f7EOuQ/Lx2FumO6eQD9XEu9QFn3u9
	 7ivEvoV5varNKEqy8FeX/szICQ4PkuPPp2f0auM+QkLhg/gyVgfqMqxQWOY5mvIGHq
	 vHw8anaK9cEIgMLIoZbixY/FLahfIb/cbo+Df1koQq3CzEIxF0QzPk6a6VhzfHVblW
	 PcEgaIFlhK6tvuk+vBYy4CTyYStoiKcKaQRJLNlDDh3ANoEnRXnSz3HjqAMBzU5okZ
	 5wl3Z2c2Fa5WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B6DD80BF7;
	Wed, 14 Oct 2026 22:22:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83F5D769
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 758FB80E44
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZF5y9rrNcXx for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 16:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66E7880E43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::833"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791993788;
 b=MTxXQZSviZS4D/AdXTsSB7q/5CJrIK0oiMirSSgtEEhj2NZbZyPZPVDLeTAneFh6xti3
 fdhOX3CHrVgrVmJSGV3DI+dhk+Xpwl6gFs4gPKaW0+xhXKyjRieg9wxvZOwmCoLKhVPzm
 HPlqDbnGTY+nTNDNUBObqQkuARQ+3Z9csFsLDQTy/uIUw1Vq7INuRUkNbm6z1x0D2YA2o
 TM0aecvqIyr2GNTzs+NV+Y6HaB4UfeMJfGRQsxZ0ZMKldZcTWhDP+MP3b7F0aCWawDz+H
 Vsjfud1kZsS5ni6ii05wx7CeKHThmZtO/jt+i2em0/M/Wd7i5izqRm+vciL4YbXkjsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791993788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
 b=T6fIETmpBVXiyT2HJ6svqysAsZv3wfqnNh+kW+QVYb7mZRkktdzfk8nD6NqcgWQ1DQx7
 te+VOQYO5A1F7JFsdw9mLEyiy9EVKJEPTVBpECi64cgiDGmUuB0HJC7UW74Q6wn02wVux
 2OJq0LxOIVeY63ZtRA0Q31sEF1Tma3NKJfVjH+lp9YRe2zQRZS7IkATc8NTnnrsTNcohy
 QY5anAgWny1hzIhNOLpftmz66a/g8BVzCVyH6AV+k7YjxWjyigQOBDqK0NNQT6eB+RoHa
 qyGN6rv/+Njpe44qP6zZyrP1N5WvwBs/Jvx3tp651qpy2UvkpWvRtUPH0R4zoRAPAgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Iaz5SkTS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::833"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=zhangerfei@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Iaz5SkTS
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66E7880E43
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 16:03:07 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5350d9ea106so53351671cf.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 09:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791993786; cv=none;
 d=google.com; s=arc-20260327;
 b=c3nJicHGFZswn9c/YCv9kwssY7JI+78ytUsZcGdsT2rsPXKl2jkHo5DrS4VdOP7JjQ
 2FPfei+3P+x5B21zbhDf3Xs/nd7JJeDaI6WKfutqxw3WyYslpaB2upOwLQGUBQR+/z0/
 NlDXNzf6KnWsWMi41maq3IxlLpWGek83S/Am7PmuYtfVzpQwC+rnbktnnVbLaSy67wVd
 0Q/8rVIofVqa2KuK73D5MbfRmtsgN1F7PKTmnVvf5yvpNpxPrJywNmmuO78ZylM/doDp
 10b24WCcYTqdqKeQb1ZheelR2SdT9IGSOnWwqqyvE6dvdkF+wFvXdjRS+/vBDUulnY+T
 TUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
 fh=OV+FvphG9Gv01U4LLMUoeG8BPF8PErMQVey8EXSevNM=;
 b=bsBU/lvv8gW7e0lmMcXPYte2qiskfrDxw4x8BIgjDffJIIiEGS7I5SllLCqxGNIIUD
 quMoI7/wdhrONlxG6ZjNAE+SXF809XB/v/VxJcWe0ttIAIZdYYIc960yctdDqOr5SYwL
 vHpDtjfEG3NeElaltzyDU5AIQa168XTiVxU81bpWxFrGBGNN+7bg+Qp0Ej+ssuwSCWFS
 AUKNBiocVG+YyT4/mSycgj1XV4hrlQDBQimEMuuRsonZJY2iuXcpzIXOXc1ztb1D2q0Y
 O5V6jheOaZXYl4vIeSvTfRL3qT1BmYTz47T1tNerL/EbI8iUuD9kB8/8qkRnBTxmpf6n
 j+6A==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791993786; x=1792598586; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
 b=Iaz5SkTSg5eoppkVqWE2nNhzkY6Eo9y8XbIpztUIHpABxrhLfj++/RUMs2aly/Kz0T
 GifcXhYni2sirZTFQgdrCsBVs5y9NT4osUWmyTv93bQqxmTEaiHKTOuX9jnEJI4kBnTb
 wm9Cjx2IfWTe0yZW/vSLcbpf6jIecXraaR/QgxC9JQr4IFaWU2B52+Z/1vYCUacUgdhn
 7qYaL0y222d9etpRlsDqrRQEWw5O4cj/LOwMqqbc/00HEONhU+nSE2CEzfsQL50PKM+z
 GQE8CiOkbXjGdj+5JlMlzxxq6ql5Qh0fx1llRdtPE3hrs+tceqQkUaN9rBjUHhzaOVKt
 WI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791993786; x=1792598586;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jxlwun6amEazjuc+FQA9bN+TKYyUO6zzmtjfOw13olw=;
 b=HiF+aoNokiulRlfdRJgqhSVLp1P5pVHE0hiR2X28SHVP1RDoDjXUK4gyBw6jkhxDKa
 76Hzb3j/v1ekkAXxTvzIkLD/dqFRVpHS92pfrFRg1MnwiYSq1nlwbyux2I5pSnAUVZaS
 coKKkwlIgENWx3w8Pqpk5LWWzAOc7AEhtSSiavmyL48PQ0Sl0B5cdwuP8ogDqSGJEmOw
 j7143fCssvmZw3SvmZODWJvgpP4HHr+P2XXGvPR2Y5uVU/h2l6nNbOnMu2ngWsK1lsEU
 0QrRm/no/CzuClFDGTf6FhrrKXeL5lEm7pAwDRxHrfMrf8MG0PpPUYAuyKh68S9RQBf+
 rTWw==
X-Gm-Message-State: AFq9FYIz/YJOQJx3vKCk3XUlAJb6C7n2tfYyuM/lHCEotPBYLb4oubOp
 Y8RL6yyXEUGDNQf8565w3ywNIIgXfdmgAkDGrz5RYLoAyn8c6xdM54FX7SN67Brt5dNV31S7vLs
 vp53uym8hoAIBJZzkKP9muFaLR/JZzAo=
X-Gm-Gg: AYBFou2Q5Ym7G+ff4lYiPB1pgWrcvfylgd2qD9KKdJY0GeJrEP7Oc+gNViA+kV9aBbA
 y5164YaZw1JRv4sQosFPXGnNDk+qsmNi4c23iiOlFtIjKk1/Q0cHB2wJx9ODw3DVZWzBaSq/X8Q
 8Gdz3VOgzjGCVz7OC0uoE81KCAA0Ww3cHfajchqNc4eiZkvxoog42SrRVCKLRxtJlVLbd/OXXtO
 dtzz5yj4pg+GmBSGnvkIU+eUQ4edPkUO+bd+faVc4AWcSXAUZduCfY+kMFMFVTvDNadnmcfrfD0
 rEmW/XFENpmY+du1pDuSIARdFIOhNqsdUcTQ8c6p8HYdK2nXfAD9rF1R
X-Received: by 2002:a05:622a:608a:b0:536:d47:22e with SMTP id
 d75a77b69052e-5360d474d10mr18861081cf.40.1791993786160; Wed, 14 Oct 2026
 09:03:06 -0700 (PDT)
MIME-Version: 1.0
From: Frank Zhang <zhangerfei@gmail.com>
Date: Thu, 15 Oct 2026 00:02:54 +0800
X-Gm-Features: AclHuK-wEOPEK_W0vBMs-fOFtWZn5hNbfN8yB3ER_QaFb7AnnSgIJNCt4gZBUR0
Message-ID: <CAFnR4j-mCem16E7c46E-Ty_uN5-z5MmH_X0MBddY1V-Mi8KBXg@mail.gmail.com>
Subject: igc (i226-V): persistent RX-path cost regression after rx
 buffer-exhaustion storms
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: multipart/alternative; boundary="000000000000105b14065dcf11e6"
X-Mailman-Approved-At: Wed, 14 Oct 2026 22:22:41 +0000
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

--000000000000105b14065dcf11e6
Content-Type: text/plain; charset="UTF-8"

Hello,

We run a native-XDP forwarding datapath (an eBPF GTP-U user plane) on an
Intel N100 mini-PC with two i226-V NICs (in-tree igc, firmware 2023:889d,
2.5GBASE-T; Ubuntu 24.04, 7.0.0-38-generic, iommu=pt). Small-packet
capacity is ~2.6 Mpps/port here. We found that after the port is
over-offered for a few seconds, the RX path keeps a persistent per-packet
cost regression after the offered load is reduced back to a clean level.
It never recovers on its own. A comparable storm-and-return test on a
second box with an ixgbe NIC did not leave a persistent regression, so we
would appreciate a look from the igc side.

1) Observation

Same workload (82-byte frames), same coalescing (fixed EITR, 65 us), same
IRQ rate (~15.6k/queue), no frequency change:

  fresh after boot: 42.7% per-core softirq utilization at 2.4 Mpps/port
  after one storm:  50.8%  (+8 points; an earlier, less-tuned config
                    measured 55.2% -> 71.1%)
  then keeps creeping: +5 points over the following 40 min of traffic

"Storm" = ~2.7 Mpps/port offered for ~15 s: rx_no_buffer_count +~0.2M/port,
rx_fifo_errors +0.06-0.6M, no adapter reset, dmesg silent.

perf stat, same offered rate before vs after (equal event set):

  instructions: unchanged (216.5G vs 217.3G)
  cycles: +17-23%
  LLC-loads: +116%
  DRAM-hit loads: x2.5 (37.8M -> 96.0M)
  load-bound stalls: x2.5 (12.1G -> 30.1G)
  igc_clean_rx_irq self-time ~8.5% -> 16.9%

PEBS (perf mem) attributes the delta to the two dependent per-packet
loads of struct page (+0x8 compound_head, +0x34 refcount), moving from
L1/L2 hits to DRAM hits.

2) RX ring page layout

Physical addresses of RX buffer pages, sampled via bpftrace
(igc_clean_rx_irq -> ring -> rx_buffer_info -> page):

  fresh:   97-100% of adjacent slots within 128 KiB (median step 8 KiB)
  stormed: 0-2% (median neighbour distance 115-150 MB); ~2/3 of the page
           set replaced (intersection vs pre-storm snapshot: 23-37%)

During the storm __page_frag_cache_drain runs 0.45-0.73M times per 15 s;
storms that do not trigger this recycling leave layout and performance
unchanged. Our reading: storm -> buffer recycling churn -> refill from
fragmented blocks -> scattered ring pages -> per-packet page-metadata
misses.

We are not claiming this is igc-exclusive -- ixgbe shares a similar
RX-buffer lifetime shape; the X520 result above just means we cannot say
the effect is universal either.

3) Recovery (measured)

  ip link down/up, ethtool -r, FLR, compact_memory: no effect
  rmmod/modprobe x1: partial
  rmmod/modprobe x2-3: near baseline, stable
  reboot: full
  (local workaround: force fresh ring allocations at refill: full)

4) Related observation (happy to split out or drop)

The default RSS indirection table is block-interleaved
(igc_setup_mrqc(): tbl[j] = (j * queues) / IGC_RETA_SIZE). With
correlated tunnel flows (GTP-U flows differing only in low tuple bits)
and a per-boot random RSS key, we saw the whole workload collapse into
one 32-bucket block -> a single RX queue (2 cores saturated, capacity
~halved). ethtool -X equal N restores the spread; we apply that as a
workaround. ixgbe initialises this table interleaved. Flagging because it
materially lowers this box's small-packet ceiling and makes the storm
above easier to reach. (Also: RSS key get/set was merged in July 2026 --
thanks; our distro kernel predates it.)

5) Ask

- Is this persistent post-storm state known for igc/I226? Any recommended
  mitigation?
- Would keeping the RX ring pages collectively fresh (allocation
  strategy, higher-order pages, a local reserve) at refill time be
  feasible in the driver, or is this considered allocator-side?
- Happy to test patches, run mainline, or minimise the reproducer
  (trivial XDP program).

Raw data available on request: perf reports, counter dumps, ring-page
dumps, recovery logs, reproducer notes (two-day study).

Thanks,
Frank

--000000000000105b14065dcf11e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div style=3D"font-size:inherit"><pre style=3D"font-style:normal;font-weigh=
t:400;letter-spacing:normal;text-indent:0px;text-transform:none;word-spacin=
g:0px;margin:0px;white-space:pre-wrap;text-align:justify;line-height:1.6;fo=
nt-size:inherit;color:rgb(0,0,0)">Hello,

We run a native-XDP forwarding datapath (an eBPF GTP-U user plane) on an
Intel N100 mini-PC with two i226-V NICs (in-tree igc, firmware 2023:889d,
2.5GBASE-T; Ubuntu 24.04, 7.0.0-38-generic, iommu=3Dpt). Small-packet
capacity is ~2.6 Mpps/port here. We found that after the port is
over-offered for a few seconds, the RX path keeps a persistent per-packet
cost regression after the offered load is reduced back to a clean level.
It never recovers on its own. A comparable storm-and-return test on a
second box with an ixgbe NIC did not leave a persistent regression, so we
would appreciate a look from the igc side.

1) Observation

Same workload (82-byte frames), same coalescing (fixed EITR, 65 us), same
IRQ rate (~15.6k/queue), no frequency change:

  fresh after boot: 42.7% per-core softirq utilization at 2.4 Mpps/port
  after one storm:  50.8%  (+8 points; an earlier, less-tuned config
                    measured 55.2% -&gt; 71.1%)
  then keeps creeping: +5 points over the following 40 min of traffic

&quot;Storm&quot; =3D ~2.7 Mpps/port offered for ~15 s: rx_no_buffer_count =
+~0.2M/port,
rx_fifo_errors +0.06-0.6M, no adapter reset, dmesg silent.

perf stat, same offered rate before vs after (equal event set):

  instructions: unchanged (216.5G vs 217.3G)
  cycles: +17-23%
  LLC-loads: +116%
  DRAM-hit loads: x2.5 (37.8M -&gt; 96.0M)
  load-bound stalls: x2.5 (12.1G -&gt; 30.1G)
  igc_clean_rx_irq self-time ~8.5% -&gt; 16.9%

PEBS (perf mem) attributes the delta to the two dependent per-packet
loads of struct page (+0x8 compound_head, +0x34 refcount), moving from
L1/L2 hits to DRAM hits.

2) RX ring page layout

Physical addresses of RX buffer pages, sampled via bpftrace
(igc_clean_rx_irq -&gt; ring -&gt; rx_buffer_info -&gt; page):

  fresh:   97-100% of adjacent slots within 128 KiB (median step 8 KiB)
  stormed: 0-2% (median neighbour distance 115-150 MB); ~2/3 of the page
           set replaced (intersection vs pre-storm snapshot: 23-37%)

During the storm __page_frag_cache_drain runs 0.45-0.73M times per 15 s;
storms that do not trigger this recycling leave layout and performance
unchanged. Our reading: storm -&gt; buffer recycling churn -&gt; refill fro=
m
fragmented blocks -&gt; scattered ring pages -&gt; per-packet page-metadata
misses.

We are not claiming this is igc-exclusive -- ixgbe shares a similar
RX-buffer lifetime shape; the X520 result above just means we cannot say
the effect is universal either.

3) Recovery (measured)

  ip link down/up, ethtool -r, FLR, compact_memory: no effect
  rmmod/modprobe x1: partial
  rmmod/modprobe x2-3: near baseline, stable
  reboot: full
  (local workaround: force fresh ring allocations at refill: full)

4) Related observation (happy to split out or drop)

The default RSS indirection table is block-interleaved
(igc_setup_mrqc(): tbl[j] =3D (j * queues) / IGC_RETA_SIZE). With
correlated tunnel flows (GTP-U flows differing only in low tuple bits)
and a per-boot random RSS key, we saw the whole workload collapse into
one 32-bucket block -&gt; a single RX queue (2 cores saturated, capacity
~halved). ethtool -X equal N restores the spread; we apply that as a
workaround. ixgbe initialises this table interleaved. Flagging because it
materially lowers this box&#39;s small-packet ceiling and makes the storm
above easier to reach. (Also: RSS key get/set was merged in July 2026 --
thanks; our distro kernel predates it.)

5) Ask

- Is this persistent post-storm state known for igc/I226? Any recommended
  mitigation?
- Would keeping the RX ring pages collectively fresh (allocation
  strategy, higher-order pages, a local reserve) at refill time be
  feasible in the driver, or is this considered allocator-side?
- Happy to test patches, run mainline, or minimise the reproducer
  (trivial XDP program).

Raw data available on request: perf reports, counter dumps, ring-page
dumps, recovery logs, reproducer notes (two-day study).

Thanks,
Frank</pre></div>

--000000000000105b14065dcf11e6--
