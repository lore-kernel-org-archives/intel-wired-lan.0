Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45614CC6B30
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 00:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C963660898;
	Thu, 15 Oct 2026 00:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a4cJuAXX3VzK; Thu, 15 Oct 2026 00:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C536F608BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792023230;
	b=Lzm3wSrRkaQ79mMcmfgdb0/WW/W/DqVrsaYsIOo/H2Azv4Yim83E970OYQsuhu03lidr
	 Xb5IVY9Sj7Ul4vCnDW/8uvzXKakMJ0fRjscIWnzIPheCNnJecj/jswCdFZpBXqGTvmd2v
	 2GquzkFyicnBUzrK5/tzqTdvsMnB+MKgaQLfGFAYOdWWokOiMP4mGg4tIHTpitCIOIXqs
	 1IfTzc72Tgpsxi+y9qzZuArK2i/CFm0d2UL+PwVehlhssoLimBblmUSjc6gcliBy2RPfm
	 tR7r3N5S3AMrxQrkSq73jxR4d6hUnblvSI4d1FFBUbvEB9ajedrSMcE2phPaSsWj5sA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792023230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
	b=Z0YRSNw8mcAFv8BElH1nT8L3SYymw1w6LyTybJu9Ddj21K2xvn4pQ9RY/6xmNoQ0+j+4
	 oZ2jtIE0iMp1+S2DJyTkthSpuTd76xgj2ADfWmVFEo5LHOEhopHXvC9CM2Cr3XXo7m4JA
	 ZnsluWqqR/GECJ3l5/NRmolu867Q6XIL9ZJWVgrGfuqRJce/PUIwFpkt6v2zd3tsfbgSY
	 y+ICM9b4mRKlMvquXifLqQFR7OXobm9RiS74+zaFG5tcI1PDT397JBHVQ6pfsSutxPHfG
	 JUTOi/XrWcH9lLlvEnvy/crWA78Z3lzdLVD+xApqqhUZqBBlSxwArvV8G1BjGQi2MIw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=F+jNow5T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792023230;
	bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=58NmDD8lDrewC3AqMaX31jB1YfedwbchIjiGkiwOBm9X/YCMtQwtxW9PE3+gEante
	 YxC83jWtGUV49Pr/YX+EVct/jhBMpUsLzKSmCr5tI+BRR5bnYh6ZEb8qwIX6TMNjq3
	 JWnUem4AQ0Gm/ThE+KUY01jOVZmVS5OB4tEZeGAcnI4YTF0WZlI2ZYwtAZSwvjL5WX
	 nnoiQOO6KM3fY3Rvy7XD9dPPrxjJFx+G6eao9HWQR6CtZXoEclyo0WEv1cKCvrhphI
	 HYgXuZ6rhxt6nVNnRm0PcIAN6PwWDr8h5Fm4/rOrfd8R4shlLZ0CSbgfgRT8RI+amQ
	 CMIs9D9W7tINw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C536F608BA;
	Thu, 15 Oct 2026 00:13:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C8A22AC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E62E608BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpxohveB3zyU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 00:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0710060898
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792023228;
 b=jCxmGzCTLnc6UB3BsP5m1OYnwPRHmXcU16niZBHJQMP2IvwiEa2Cq5W56jgqfZ0dlouT
 FUYbI9kpy1Tox25dYgKYKWqZeDjzU9sJYmPhzJKCJsR8DHnC65n0+G87tdy/PXcWeZYCj
 WmwbaDJLrjPV4o1nZPolsqLl5foel2NV7jn7hyXiMGh7iOjttthpDW4s/REj6fZbM3qeU
 HO8hbVhn0pmpyPg/I0LJGbTZNhxj1hMXy+2g/mzW6VsPQCOZwTIQjirjDRSNAAivw2DUq
 YN+B0zwFLmJwH/VmUbNkBNXW76B/H5djRD2gWN2LgYPhzjBiCsPs113GuLK51GUlEkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792023228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
 b=WyTlUyHeCwLBN8fD/wvT/FaDYLp0HP88ZRN+8Y4Ar7Amu55lR1prL+hs7YyY2stj7cfx
 7AVJPKpXn9ywcTX+slpgaeRJtAIxaGMm1er2kyBeMU5vCHmrYLv7bo4EPwb8/LL6FG9zd
 EDLQDYouZN6jf12Dn/wBMHiWgFdra7Xg4CR+YEwOQ7nWvGFifMzr0FUXV9xKjVVuo2nJK
 qcIvpAASXbmt6J9h+dL5AsEVeOufXFldAecJFJE94CezEQZzYzlynTBR9FrFAFaGEF8Q3
 pnOx9UTCPTvd7leUdrkML0j1gqAgd5qSiZaGXyn/DiJ4ZkV+nUht5QoxxYv2YfxMmNw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=F+jNow5T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=namangulati@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=F+jNow5T
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0710060898
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:13:47 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so7065e9.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792023225; cv=none;
 d=google.com; s=arc-20260327;
 b=EP3CGjuDmlrPCgtXLZ9dzr+dqPTPTt5j4LmGEeZm6dBMT2U2je1nA2QrWQcM9IC8gY
 eMJacQyHzaUWwvh9fcGbHvjtYoeqAKEvvwyi/eEpgYsl65QoLIDSFtaLKj3qTzgFruRt
 m01VIffhaIiBhKgJlew9tr/E4FyLqNVBAMbXextkhZhNoQsT5FjoHnncMARnAc8FnWrg
 2kpossj1nUU+oK/q7f7oo7wE8inMj8FN216kK5NFfddq0ZK8N+Zo/7WRxEWSZimlGyRy
 PnV+IHSkeAFl2xfMwGnXURio85u3ezbtstp6DqVwZPyQQ9PbBrDIkwDsQpFKfCo1mM/c
 6Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
 fh=ReKaLVSogeg5hKc6LikMTBCpEDc5Btgk9cZTw5EOgpo=;
 b=imvTceqGY01oLv+zRLXPriNj3FbYyy01jxguLHLoenryt2/vaZl1s7F0HVG/KJlZjL
 uMjxHQTnpMspfKqzcJYb3abtEDbiFohftToL1wzoRBhx+1Jb+4N/ufUMST9ASBjyQRSY
 H9Ncv+DAWo1svcWwwXum+uJGeQZgtOkk4lE9Um56nsFiqs69EbTxFrJKillTFHT/n3FC
 46HC/fFJzGm4h2YOZkg/MZn6e45hoedKPyGuiaEman6H8A8030PxrKNnvUaynIWQoi4I
 3+BmT6irgo8g5fshxztMP7g+CW81kqB2mqfwy7ri4FOdmwEQ3gIw4pfChhgTYUAB8m1n
 uk5g==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792023225; x=1792628025; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
 b=F+jNow5TrOQ1j8M5XxoH+Sl7tu1x4ASGdxxRU2YbYwjDRSkXBgBAmTXMWtRq2LaIRF
 AnRNBOTe9olv1xBVEohzUkZ62g3SBT94ScUOXhcdOROzVHz1MncxIH8YwCt0oW/HMYmU
 jIWx3xRIuOdIgHyF4dJAv0sINqviglvsjfQ7a4tdD5WGrcHmJf998ZgM9FK1XiVZ2VRb
 9nebBQ8szo+2o88o70vgZfWjhyU4infmu+Js7Hc4DGeyBqh0BdVLB9Y2fiZgdSG9i32B
 wewXrrmZFg1CKHIOBaIStdQmkOSfGdmduhp7GcuQhJF6qWCAQdhA4d7L/HdSQQiCXjpg
 Arcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792023225; x=1792628025;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ITyDJszE7bqIRA32dn6/eXhoySux/prBSJmNGfSqrUQ=;
 b=KEOSl9EW0zV0iADb73A6VMxad4MavwbmHM6gc2ID4rE40hAKtglCeNlM03AapFww0g
 wdsxoZfTbEFyHxT05+YOZRv9xtzoR/1LndkZImpe8PhmOFZl6z6qMnzdlmbYrEYXtMb5
 HYce+X8wu2t0sRPjWGt/475qLkfrClMhiXTAyaXx+6eYi29KMwzM1yrp1J2xKZcNLU6u
 8oV6Q4+9vyqtwZr4h2CLYfIHnh4YSc/z1/WS1bzuMLO6ECDfO7hzcaiPBrs0k23DQLsa
 N0Q/qs+7g8RLcoRawwidNMk93918Bx6MoFL4seaUlahH9ETt7n/PP6aLtsYOq8S4iRom
 eouw==
X-Gm-Message-State: AFq9FYIqjp7yDiMhaXIdeg6Ls3rhOyN21d0rNfmUIaoXzLlHaDtYcSlz
 5otshVol00NGsqf4zRV9COHUHCazCUuSkWijgx69dpr2viCxX0jheLK6UY/8g5qfVoCkx4NcINZ
 xZVQTxaRjcuAe1vDaorD8Ba9GhvKTHdZ7ctJhOKdm
X-Gm-Gg: AYBFou2dSFph72xB3Q5IOx7eCIdlgYn88te68qyFfZjoJVWb5wlzOvNcD7fixrPqLpo
 6ThG/ArwqIFp6Ylg0/oweYKJZNo9IyyTvntaN8QjxUZNDljJ6bMFOUVCyNTjEP2q9IwCrCLioHF
 0EZYezoiE+5a7WerJWqCk4dP1CnJz4OuMFa8293dgIbevKTFozptXnTFATLwxpDf9PDJ+qZmY00
 q0r8cejTvqdn7xAoJ0flLwb2aUDNojfyvgXi0Idd6tItYHnnJ8eFwjJSNT74TqXkUa0xwlOMYI8
 3ZlM/YN4RIHp6YNGvCU2+/oIyF/7sAsaBQEL/v6Ve1RYRpo1bKoIU9Sno02dKshXlGF72cKyuYB
 rBTxnxlbT0g==
X-Received: by 2002:a05:600c:3b01:b0:49c:ff18:79bd with SMTP id
 5b1f17b1804b1-4a1c200d58fmr71145e9.9.1792023224697; Wed, 14 Oct 2026 17:13:44
 -0700 (PDT)
MIME-Version: 1.0
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
 <20261009212537.3996-2-emil.s.tantilov@intel.com>
In-Reply-To: <20261009212537.3996-2-emil.s.tantilov@intel.com>
From: Naman Gulati <namangulati@google.com>
Date: Wed, 14 Oct 2026 17:13:32 -0700
X-Gm-Features: AclHuK-fTQ5wkSiyfBIasryyV3DUWPu81oE5aqd_s6c1xXZuDbURkARYnQe8sxg
Message-ID: <CAMP57yV3ZLnEcnJXvwh-7a5t21BKuLgQ6-gfxVKo+HznUPzGQw@mail.gmail.com>
Subject: Re: [PATCH iwl-net 1/2] idpf: fix use-after-free in the PTP auxiliary
 worker
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, milena.olech@intel.com, 
 konstantin.ilichev@intel.com, joshua.a.hay@intel.com, decot@google.com, 
 madhu.chittim@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks!

Reviewed-by: Naman Gulati <namangulati@google.com>

On Fri, Oct 9, 2026 at 2:43=E2=80=AFPM Emil Tantilov <emil.s.tantilov@intel=
.com> wrote:
>
> idpf_ptp_update_cached_phctime() runs from the PTP auxiliary worker and
> walks the Rx queues of every vport to refresh rxq->cached_phc_time. There
> is a small window on down that can result in use-after-free, detected by
> KASAN:
>
>   BUG: KASAN: slab-use-after-free in idpf_ptp_update_cached_phctime+0x367=
/0x4a0 [idpf]
>   Write of size 8 at addr ff11002146c2a4a0 by task ptp3/8084
>   ...
>   idpf_ptp_update_cached_phctime+0x367/0x4a0 [idpf]
>   idpf_ptp_do_aux_work+0x37/0x50 [idpf]
>   ptp_aux_kworker+0x64/0xd0
>   kthread_worker_fn+0x289/0xa20
>   ...
>   Allocated by task 8615 on cpu 5 at 812.655509s:
>   idpf_vport_queues_alloc+0x9e5/0x2580 [idpf]
>   idpf_vport_open.constprop.0+0x12c/0x10f0 [idpf]
>   idpf_open+0x1bb/0x230 [idpf]
>   __dev_open+0x2f5/0x7c0
>   ...
>   Freed by task 8628 on cpu 10 at 814.925757s:
>   idpf_rxq_group_rel.part.0+0xef/0x5a0 [idpf]
>   idpf_vport_queues_rel+0xaf/0x140 [idpf]
>   idpf_vport_stop+0x49e/0x850 [idpf]
>   idpf_stop+0x6d/0xc0 [idpf]
>   __dev_close_many+0x24c/0x650
>
> The existing rxq_grps test does not help. It is evaluated before the
> pointer is read again, so the worker can equally run past the kfree() and
> dereference a NULL rxq_grps with a stale num_rxq_grp.
>
> Add a per vport rxq_grps_lock and use it to serialize every transition of
> rsrc->rxq_grps against the worker:
>
>   - Teardown: idpf_rxq_group_rel() sets rsrc->rxq_grps to NULL under the
>     lock before anything reachable through it is freed. The worker
>     re-reads the pointer under the same lock, so it either sees a live
>     array while the release path is still blocked on the lock, or sees
>     NULL and skips that vport. The frees stay outside the lock.
>
>   - Allocation: Build the rxq_grps array privately and publish it to
>     rsrc->rxq_grps under the lock only once every group is complete. The
>     freeing of the group contents moves to idpf_rxq_grps_free(), which
>     takes the array explicitly so the allocation error path can unwind
>     safely.
>
>   - Soft reset: idpf_vport_stop() freed rxq_grps and cleared the live
>     vport's copy under rxq_grps_lock. Drop the stale pointer in the clone
>     so the memcpy() below does not republish the freed array to
>     the PTP aux worker before idpf_vport_open() reallocates it. The lock
>     sits past the offsetof(struct idpf_vport, link_up) boundary that
>     idpf_initiate_soft_reset() stops its memcpy() at, next to the wait
>     queues and mutexes that are already kept out of the copy, so a soft
>     reset never byte-copies it. The data it guards, dflt_qv_rsrc, is
>     inside that copied region, which is why the clone has to be cleared
>     rather than relying on the lock alone.
>
> Also, fix the NULL check in idpf_ptp_update_phctime_rxq_grp(). The split
> queue case took the address of a member before testing it, which can neve=
r
> be NULL, so test the rxq_sets[] entry itself.
>
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      |  5 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |  6 ++
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 16 ++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 65 +++++++++++++++------
>  4 files changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/etherne=
t/intel/idpf/idpf.h
> index 470bc23c844c..9d63feda1bc6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -373,6 +373,8 @@ struct idpf_q_vec_rsrc {
>   * @default_vport: Use this vport if one isn't specified
>   * @crc_enable: Enable CRC insertion offload
>   * @link_up: True if link is up
> + * @rxq_grps_lock: Serializes every transition of the @dflt_qv_rsrc.rxq_=
grps
> + *                pointer of a vport against the PTP auxiliary worker
>   * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
>   * @tstamp_config: The Tx tstamp config
>   * @tstamp_task: Tx timestamping task
> @@ -406,6 +408,9 @@ struct idpf_vport {
>         bool crc_enable;
>         bool link_up;
>
> +       /* Must be past the point idpf_initiate_soft_reset() memcpy()s */
> +       spinlock_t rxq_grps_lock;
> +
>         struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
>         struct kernel_hwtstamp_config tstamp_config;
>         struct work_struct tstamp_task;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 827c795afcb6..a1c739cdd540 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1276,6 +1276,7 @@ static struct idpf_vport *idpf_vport_alloc(struct i=
dpf_adapter *adapter,
>         vport->compln_clean_budget =3D IDPF_TX_COMPLQ_CLEAN_BUDGET;
>         vport->default_vport =3D adapter->num_alloc_vports <
>                                idpf_get_default_vports(adapter);
> +       spin_lock_init(&vport->rxq_grps_lock);
>
>         rsrc =3D &vport->dflt_qv_rsrc;
>         rsrc->dev =3D &adapter->pdev->dev;
> @@ -2075,6 +2076,11 @@ int idpf_initiate_soft_reset(struct idpf_vport *vp=
ort,
>         } else {
>                 set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
>                 idpf_vport_stop(vport, false);
> +
> +               /* Drop the stale pointer in the clone, as rxq_grps was f=
reed
> +                * by idpf_vport_stop().
> +                */
> +               new_rsrc->rxq_grps =3D NULL;
>         }
>
>         err =3D idpf_send_add_queues_msg(adapter, vport_config, new_rsrc,
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.c
> index 71fe8b2a8b4e..9b15973d2f7e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -348,9 +348,11 @@ idpf_ptp_update_phctime_rxq_grp(const struct idpf_rx=
q_group *grp, bool split,
>                 }
>         } else {
>                 for (i =3D 0; i < grp->splitq.num_rxq_sets; i++) {
> +                       if (!grp->splitq.rxq_sets[i])
> +                               continue;
> +
>                         rxq =3D &grp->splitq.rxq_sets[i]->rxq;
> -                       if (rxq)
> -                               WRITE_ONCE(rxq->cached_phc_time, systime)=
;
> +                       WRITE_ONCE(rxq->cached_phc_time, systime);
>                 }
>         }
>  }
> @@ -387,10 +389,17 @@ static int idpf_ptp_update_cached_phctime(struct id=
pf_adapter *adapter)
>                 struct idpf_q_vec_rsrc *rsrc;
>                 bool split;
>
> -               if (!vport || !vport->dflt_qv_rsrc.rxq_grps)
> +               if (!vport)
>                         continue;
>
>                 rsrc =3D &vport->dflt_qv_rsrc;
> +
> +               spin_lock(&vport->rxq_grps_lock);
> +               if (!rsrc->rxq_grps) {
> +                       spin_unlock(&vport->rxq_grps_lock);
> +                       continue;
> +               }
> +
>                 split =3D idpf_is_queue_model_split(rsrc->rxq_model);
>
>                 for (u16 i =3D 0; i < rsrc->num_rxq_grp; i++) {
> @@ -398,6 +407,7 @@ static int idpf_ptp_update_cached_phctime(struct idpf=
_adapter *adapter)
>
>                         idpf_ptp_update_phctime_rxq_grp(grp, split, systi=
me);
>                 }
> +               spin_unlock(&vport->rxq_grps_lock);
>         }
>
>         return 0;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/et=
hernet/intel/idpf/idpf_txrx.c
> index af3213eae393..96f79554a4d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1358,16 +1358,15 @@ static void idpf_rxq_sw_queue_rel(struct idpf_rxq=
_group *rx_qgrp)
>  }
>
>  /**
> - * idpf_rxq_group_rel - Release all resources for rxq groups
> + * idpf_rxq_grps_free - Free an Rx queue group array and everything in i=
t
>   * @rsrc: pointer to queue and vector resources
> + * @rxq_grps: group array to free, not reachable through @rsrc any more
>   */
> -static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
> +static void idpf_rxq_grps_free(struct idpf_q_vec_rsrc *rsrc,
> +                              struct idpf_rxq_group *rxq_grps)
>  {
> -       if (!rsrc->rxq_grps)
> -               return;
> -
>         for (unsigned int i =3D 0; i < rsrc->num_rxq_grp; i++) {
> -               struct idpf_rxq_group *rx_qgrp =3D &rsrc->rxq_grps[i];
> +               struct idpf_rxq_group *rx_qgrp =3D &rxq_grps[i];
>                 u16 num_rxq;
>
>                 if (idpf_is_queue_model_split(rsrc->rxq_model)) {
> @@ -1388,19 +1387,40 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_=
rsrc *rsrc)
>                         }
>                 }
>         }
> -       kfree(rsrc->rxq_grps);
> +       kfree(rxq_grps);
> +}
> +
> +/**
> + * idpf_rxq_group_rel - Release all resources for rxq groups
> + * @vport: vport the queue groups belong to
> + * @rsrc: pointer to queue and vector resources
> + */
> +static void idpf_rxq_group_rel(struct idpf_vport *vport,
> +                              struct idpf_q_vec_rsrc *rsrc)
> +{
> +       struct idpf_rxq_group *rxq_grps;
> +
> +       if (!rsrc->rxq_grps)
> +               return;
> +
> +       spin_lock(&vport->rxq_grps_lock);
> +       rxq_grps =3D rsrc->rxq_grps;
>         rsrc->rxq_grps =3D NULL;
> +       spin_unlock(&vport->rxq_grps_lock);
> +
> +       idpf_rxq_grps_free(rsrc, rxq_grps);
>  }
>
>  /**
>   * idpf_vport_queue_grp_rel_all - Release all queue groups
> - * @vport: vport to release queue groups for
> + * @vport: vport the queue groups belong to
>   * @rsrc: pointer to queue and vector resources
>   */
> -static void idpf_vport_queue_grp_rel_all(struct idpf_q_vec_rsrc *rsrc)
> +static void idpf_vport_queue_grp_rel_all(struct idpf_vport *vport,
> +                                        struct idpf_q_vec_rsrc *rsrc)
>  {
>         idpf_txq_group_rel(rsrc);
> -       idpf_rxq_group_rel(rsrc);
> +       idpf_rxq_group_rel(vport, rsrc);
>  }
>
>  /**
> @@ -1419,7 +1439,7 @@ void idpf_vport_queues_rel(struct idpf_vport *vport=
,
>         idpf_rx_desc_rel_all(rsrc);
>
>         idpf_xdpsqs_put(vport);
> -       idpf_vport_queue_grp_rel_all(rsrc);
> +       idpf_vport_queue_grp_rel_all(vport, rsrc);
>
>         kfree(vport->txqs);
>         vport->txqs =3D NULL;
> @@ -1803,18 +1823,19 @@ static int idpf_rxq_group_alloc(struct idpf_vport=
 *vport,
>                                 u16 num_rxq)
>  {
>         struct idpf_adapter *adapter =3D vport->adapter;
> +       struct idpf_rxq_group *rxq_grps;
>         bool hs, rsc;
> -       int err =3D 0;
> +       int err;
>
> -       rsrc->rxq_grps =3D kzalloc_objs(struct idpf_rxq_group, rsrc->num_=
rxq_grp);
> -       if (!rsrc->rxq_grps)
> +       rxq_grps =3D kzalloc_objs(struct idpf_rxq_group, rsrc->num_rxq_gr=
p);
> +       if (!rxq_grps)
>                 return -ENOMEM;
>
>         hs =3D idpf_vport_get_hsplit(vport) =3D=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED;
>         rsc =3D idpf_is_feature_ena(vport, NETIF_F_GRO_HW);
>
>         for (unsigned int i =3D 0; i < rsrc->num_rxq_grp; i++) {
> -               struct idpf_rxq_group *rx_qgrp =3D &rsrc->rxq_grps[i];
> +               struct idpf_rxq_group *rx_qgrp =3D &rxq_grps[i];
>
>                 rx_qgrp->vport =3D vport;
>                 if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
> @@ -1915,9 +1936,17 @@ static int idpf_rxq_group_alloc(struct idpf_vport =
*vport,
>                 }
>         }
>
> +       /* Publish only once every group is built, the PTP aux worker rea=
ds
> +        * the array as soon as it becomes visible.
> +        */
> +       spin_lock(&vport->rxq_grps_lock);
> +       rsrc->rxq_grps =3D rxq_grps;
> +       spin_unlock(&vport->rxq_grps_lock);
> +
> +       return 0;
> +
>  err_alloc:
> -       if (err)
> -               idpf_rxq_group_rel(rsrc);
> +       idpf_rxq_grps_free(rsrc, rxq_grps);
>
>         return err;
>  }
> @@ -1948,7 +1977,7 @@ static int idpf_vport_queue_grp_alloc_all(struct id=
pf_vport *vport,
>         return 0;
>
>  err_out:
> -       idpf_vport_queue_grp_rel_all(rsrc);
> +       idpf_vport_queue_grp_rel_all(vport, rsrc);
>
>         return err;
>  }
> --
> 2.37.3
>
