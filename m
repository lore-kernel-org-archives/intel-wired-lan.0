Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7E7CC6B33
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E5FB407BC;
	Thu, 15 Oct 2026 15:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxQ5CyFUlFaW; Thu, 15 Oct 2026 15:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD60C407E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792079711;
	b=ZKCJXTxVY0Hc8qNnUdBcNODRqRsw6Lv2UjmEhl0ejf4hBVAq0Ne/GDCyTCFaaH1R3WjD
	 kp/YYtUXSrATY9C3Q/iBRQTrNgjUCaWOdFS3TYi+r8A0cUJCJkVkZw6Krx4+WBhLpKhUu
	 haD9lC0d0EjFklc3Gyrr12Ok2pKzp71Gzxt46Uge4ge0MkDWzIulXe+tNxnH7maeeCTjS
	 m0c5aEc/7gPEjfYhAnDsyXY0NzaeAqNE95pwup5LyAa+JV3hTrMsHWx4xGKwFZJV1gGD9
	 A4I+PAuNZRO13Z3062bTJddzDlmoO7B+zmZSlefx3yhRRsfjeDT3bRJjzvBLyZkjhbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792079711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mkNMtqsX2YWk+nZqcj9+M8tuNizL7NZGfLO9i4JP5Co=;
	b=D/u4JOuU7K39DDAXSuFZGeHruAfrfnNZ87IXd4mJGOW236Ogsqq0287oIThpk6pLh0X3
	 OTBBlZghiNERPctXF0/ngsefGa4Eydpu086n3rKcAm+4if91VehRUqOrY2vGmzhCgvgHO
	 kCY87CxoTRVe1G0YrnCHtxVLbYKDUKr9eBIoFhJK5bplm7iitz8GWFuTSG7ZVjJwahTpK
	 ibhs72GOR1UUM7mSf2fKO8uNw4o2KoNIID1qbBhT1s6xMw4f09+KNll6aq7n6SbHyrGhw
	 SGm9+7Xs15YEGcRDbKBsm3u4T0nqBJ1MybtDxGEkCcNO0+AU0fAdCqTin8SBAYYk8tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792079710;
	bh=mkNMtqsX2YWk+nZqcj9+M8tuNizL7NZGfLO9i4JP5Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qjOxGo/pBdtWWJuBQD1f2vYtmdsOQj3AYXXUFwH+iY14BHcLjRNtECXZEX18y0qWE
	 ESuEAt3oAKXJ42IISfaTQdy2hxDQ/9Wxtl4dSoWK8bYDSazPlpUTmMUzpmUoDX7wLP
	 FZYMpgpZQ+g844wvKGTOE6hoFdP6z2b+f4elQs4ytO6mjcltY1+IqVtJVyLiqxqvRT
	 5hKu2ITWz/Mto7uy6e7Vo0pR+obu6CvUy6SBT/woE2HdDtY6mAjt4cHzeJsq5v2rOw
	 NmeB/QkKw69L2vTGAmm49pnqdCrGnnFdq0R/VAbEXbSehcFWUFpSQ1Pg3v4dqZavkS
	 zKfIsmJAqL6QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD60C407E9;
	Thu, 15 Oct 2026 15:55:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BE69769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21DFB60787
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmUac_zI0m9r for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C54B060745
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050324;
 b=gAPVzGcHZmj5VeTNHbaFVUu3sVb4w3pweH/QGCvxhgISI+77yV5nXL7s30+EhZS1ohoX
 n5l+I7NcM3Of1cBBXiR/O/nET/D3GUMzENYhUpN19uvR5mxZWgH9mIfILMqUwfaeiaMbw
 KHNd+jOY5KR+SwQpxenhDLoqf2mbfsom/Vwu8iI5QAva7UqMIXpkmQe3pY0wEYSgbKERT
 CaFIeup6FPsftxMWZZCqVAx78fabzTiXt/HBbEaNSgPH9m7Cs0/5CNpEaFSIaeqr8glBM
 CDHD0W22yhg/7h5SH5fWbarxQQXDn5DwMh1ZTDWRvvFnt2b7rS3COzZdqym8Mc+zjjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=mkNMtqsX2YWk+nZqcj9+M8tuNizL7NZGfLO9i4JP5Co=;
 b=Qkqni2pmXo25pMxiZ8hIgyHxIA+87II0v1/Q8T3puxrrS69+GHEjTSgE/yNnC9vJaP6s
 umQ64h4yZOUGqusuyhRl+dxz6nEIJZTJwPBM+Svibii04I9UUPAjkGEgnzdwrBPHsTGg1
 Uwsj/+9v8g98cLvlIR6iZADO8FE/+ZsI3AtKAET+RlOSTERtBfcYrIMBhwIzLWS4fc5in
 rdc21WVPnIXso2uJketgDBntwj9JAfRnWgvShwnT1R2QpQuBOZjr9TOZbEVkRMsyzANTg
 3GOahjFAroFKpdkwgvedqs3cgqhIZNxdTJNzObzHgaItteY+BGA/qT49opqwqk5CYcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nebusec.ai;
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=POF9OMQk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=zihanx@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=POF9OMQk
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C54B060745
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:45:21 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so1154440a91.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1792050321; x=1792655121; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkNMtqsX2YWk+nZqcj9+M8tuNizL7NZGfLO9i4JP5Co=;
 b=POF9OMQkr3qP2HRSSuG1srkHu6ER9Sb+c9P9XpX0jTvxB6n9fNJSI5WdWUg70ENgJU
 e7JKNjH95BC8y6fC7hzRmAZ+cyknb4ENX0cv/rVPSa95aTEx7xwOb+sCn2xMMhdY01aw
 P+7igolAchMdgcbSthIlFTB1Z8fp9E8WDloIXO2AqyEMF0pwuO9AC/uIPrhZRrtTzfcu
 hxNiHDkUd44/GS29xROAzDmOIk3mqIyEHjDfrkoRXwqnoonpRHcXnQL9VEf3uCsrneTb
 K2mnZf/8X8Y8uWmkKJW7cOViB4ljFsc2t+qoJ6isjwIAoYaH6wuFXzYNEX5IbLeQ3o2z
 J8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050321; x=1792655121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mkNMtqsX2YWk+nZqcj9+M8tuNizL7NZGfLO9i4JP5Co=;
 b=Xn7ALwQ9SeM7rNTk/hUUAXjkTVEe5v/9MCXgo5niqzIs1fANCXJi7Hv3xT97OSGImo
 uOetBsf3qRC4C8prWR/jfZVUlA9K+v1Y+4Ad2gwD+wm0jJdQcdq7MxZi+0PJfipLdwW5
 Cq1HkwdrX3x7G5lxWcoD5JvDTcuYwd70yM/cafrsi+tT8yK3GTqmXujMddSGn/gT961Q
 ysin7oxUXw9rC/Og6mBAX+SOp6pyYzWtpdeBJPsun0ON0WSOp0VQNrgpPDTtj93nVyBw
 je/XK9mMvCeydu/C69s0Y4Fv6VNRPK/8QV5KR+D7dQcSAdstivm3BiyXM35T4Wp0LDpF
 H4tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx2WZoY1lf6MiL8RPqjA8gxsJibx8XlPJa8Byc7Nrz8gnlz1RQOZ61+Mc5eDGuuKuBVXTO9YGxPUCfgTucEWg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJPSfnPRoryQEbdsHGbtwzzGgnwABpaXLaxlJnL7rM27ftZxymv
 ZNWpTMfWSytX4SalDmV5859Reu+vBSxB2POmIOdWKBup1ztQBsUSQjwEn8De+0HUaX/o
X-Gm-Gg: AYBFou0VgkyjOKfNer2AAdH0/0ztfndRFxHellBznB+tvvMDq2nNx8V+wWvzQy6+kLn
 t/fllpW+HEDH2cGN7i6GI0MV/YIhWYcJrEgJ0M/rN5LZ/QGj1WMj2kl22r2uiDUqIyQprl+yubm
 3QU9ggafIko5uLvV6jPwBKtZI4w/pKQDuTGGQUd0F9AUxvM0W5aFw4N5tMnaezwOWDW6BiMypUa
 Yn8GXtcprTpGQZbY7jbAIP2W5enUrHSI0SRJxFqO1DdDsAWdN7ikMoxiny/hoCsTCshARLYsXdx
 ClwsjKjKTtgnFmJ0Z3cOi80ny7x+Lav9fyNcX8y9KVkgR4qLp+c4LJDfA5VPoj2exRuNwUc5kHF
 RBQap1pYYVYuA5BhYlLPitB/ngXqxBw675RV7N4EVRC0IgniPU6v5tQJBhnzT/zCgUG/EPNIN4h
 ST/ECprew7JaV+8ZrQAZ86RQORxFkHgNcqe0dtCeoChsL9SkLhWkdV25L0sFS/Dct9RwiU4c0pA
 e0291GHNwoXCu51lplaqqBdnEICOA==
X-Received: by 2002:a17:90b:1d52:b0:3a6:e8fb:76b5 with SMTP id
 98e67ed59e1d1-3ab3a79001bmr16349899a91.37.1792050320802; 
 Thu, 15 Oct 2026 00:45:20 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:45:18 -0700 (PDT)
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
Subject: [PATCH nf v8 2/3] netfilter: nf_dup_netdev: bound asynchronous
 duplication
Date: Thu, 15 Oct 2026 07:43:08 +0000
Message-ID: <a23b041de631f3c3821de021cbd4d421f2359ae9.1792048855.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
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

The task-local transmit recursion counter covers synchronous
dev_queue_xmit() recursion, but does not follow a duplicated skb through
asynchronous receive paths. Carry a bounded duplication depth with the skb
and preserve it across skb and XDP conversions.

Store the depth in the sk_buff headers group. __copy_skb_header() copies
that group with a single memcpy(), so skb_clone() preserves the depth.
Propagate it explicitly when veth converts an skb to an XDP buffer and
when XDP buffers or frames are converted back to skbs in the core and
virtio paths. Preserve it through zero-copy XDP frame conversion as well.

Clear the depth when GRO reuses an skb and when AF_XDP or libeth
reinitializes a recycled XDP buffer, so a fresh packet does not inherit
stale recursion state.

Keep the existing recursion limit and reject MIRRED flow offload where
the software depth cannot be enforced.

Fixes: 502061f81d3e ("netfilter: nf_tables: add packet duplication to the netdev family")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v8:
  - explain how skb_clone() inherits the depth through the sk_buff headers
    group and identify the explicit skb/XDP propagation and reset paths
  - split the v7 NFQUEUE/netdev proposal and add the ingress
    TTL/hop-limit limit as a separate patch
  - preserve the IPv4/IPv6 recursion guard across NFQUEUE reinjection
  - bound netdev dup depth across software skb/XDP paths
  - stop IPv4 TTL and IPv6 hop-limit underflow before cloning
  - limit the netdev claim to software skb/XDP paths and document the
    MIRRED offload restriction
  - v7 Link:
    https://lore.kernel.org/all/cover.1791688819.git.zihanx@nebusec.ai/
changes in v7:
  - replace the v6 user-namespace setup restriction with NFQUEUE state
    capture and restoration
  - use a separate reinjection flag checked only in task context, and scope
    the netdev dup marker to its BH-disabled transmit section
  - cover queued IPv4/IPv6 duplication and nft_dup_netdev clones; restore the
    verdict task's previous state on every exit path
  - keep the claim limited to NFQUEUE reinjection, not independent device
    receive paths
  - add the netdev frontend Fixes tag for its separate NFQUEUE trigger path
  - v6 Link:
    https://lore.kernel.org/all/82abaa776053bb3e716095a783722452d87fa039.1791429178.git.zihanx@nebusec.ai/
changes in v6:
  - reroll the unchanged four-file setup-time restriction on nf.git main at
    ab699d296e06
  - do not present v5 build or runtime results as v6 validation
  - v5 Link:
    https://lore.kernel.org/all/20260929125832.25316-1-zihanx@nebusec.ai/
changes in v5:
  - describe the patch as a non-initial-userns setup restriction, not a
    general recursion fix; state that init_user_ns behavior is unchanged
  - remove path-specific trigger details and run-specific metrics from the
    public commit and cover prose
  - drop d877f07112f1 from Fixes: because it added a later frontend, not the
    shared duplication behavior addressed by this restriction
  - record the v5 build and setup-time validation, distinguishing them from
    earlier unpatched-baseline and root-OOM runs
  - v4 Link:
    https://lore.kernel.org/all/cover.1790408011.git.zihanx@nebusec.ai/
changes in v4:
  - add Fixes tags for TEE, IPv4/IPv6 nft dup, and netdev nft dup
    frontends
  - clarify that fcd53c51d037 only added a synchronous guard
  - clarify that this restricts non-initial user namespaces and does not
    fix asynchronous recursion in init_user_ns-owned network namespaces
  - state explicitly that the netdev loop was not runtime-reproduced
  - v3 Link:
    https://lore.kernel.org/all/cover.1790042930.git.zihanx@nebusec.ai/
changes in v3:
  - reroll the fix against the latest nf.git main after no follow-up on v2
  - add the Co-developed-by trailer and matching Signed-off-by
  - v2 Link:
    https://lore.kernel.org/all/cover.1788425393.git.zihanx@nebusec.ai/
changes in v2:
  - drop the persistent struct sk_buff::nf_duplicated field and nf_copy()
    change from v1
  - disable IPv4/IPv6 duplication in non-initial user namespaces
  - v1 Link:
    https://lore.kernel.org/all/cover.1787903722.git.zihanx@nebusec.ai/
---
 drivers/net/veth.c            |  3 +++
 drivers/net/virtio_net.c      |  3 +++
 include/linux/skbuff.h        |  9 +++++++++
 include/net/libeth/xdp.h      |  6 ++++--
 include/net/xdp.h             | 25 +++++++++++++++++++++++++
 net/core/gro.c                |  3 +++
 net/core/xdp.c                | 10 ++++++++++
 net/netfilter/nf_dup_netdev.c | 11 ++++++++++-
 net/xdp/xsk_buff_pool.c       |  2 ++
 9 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 71227d0389aa..e24a81a14301 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -771,6 +771,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	xdp_buff_set_nf_dup_netdev(xdp, skb->nf_dup_netdev);
+#endif
 
 	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..c78bcef1ef11 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2083,6 +2083,9 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
 	data_len = xdp->data_end - xdp->data;
 	skb_reserve(skb, headroom);
 	__skb_put(skb, data_len);
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	skb->nf_dup_netdev = xdp_buff_get_nf_dup_netdev(xdp);
+#endif
 
 	metasize = xdp->data - xdp->data_meta;
 	metasize = metasize > 0 ? metasize : 0;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..45eb9aeabfe7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -815,6 +815,7 @@ enum skb_tstamp_type {
  *	@peeked: this packet has been seen already, so stats have been
  *		done for it, don't do them again
  *	@nf_trace: netfilter packet trace flag
+ *	@nf_dup_netdev: netdev duplication depth
  *	@protocol: Packet protocol from driver
  *	@destructor: Destruct function
  *	@tcp_tsorted_anchor: list structure for TCP (tp->tsorted_sent_queue)
@@ -1012,6 +1013,9 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TRACE) || IS_ENABLED(CONFIG_NF_TABLES)
 	__u8			nf_trace:1;
 #endif
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	__u8			nf_dup_netdev:2;	/* netdev duplication depth */
+#endif
 #ifdef CONFIG_NET_SWITCHDEV
 	__u8			offload_fwd_mark:1;
 	__u8			offload_l3_fwd_mark:1;
@@ -4602,6 +4606,11 @@ static inline bool skb_metadata_differs(const struct sk_buff *skb_a,
 	u8 len_a = skb_metadata_len(skb_a);
 	u8 len_b = skb_metadata_len(skb_b);
 
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	if (skb_a->nf_dup_netdev != skb_b->nf_dup_netdev)
+		return true;
+#endif
+
 	if (!(len_a | len_b))
 		return false;
 
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 898723ab62e8..bccc244c19b9 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1181,10 +1181,12 @@ libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
 		     const struct libeth_xdp_buff_stash *src,
 		     struct xdp_rxq_info *rxq)
 {
-	if (likely(!src->data))
+	if (likely(!src->data)) {
 		dst->data = NULL;
-	else
+		dst->base.flags = 0;
+	} else {
 		libeth_xdp_load_stash(dst, src);
+	}
 
 	dst->base.rxq = rxq;
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..40ca174bb6b1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,9 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* Netfilter netdev-dup recursion depth, carried through XDP frames. */
+	XDP_FLAGS_NF_DUP_NETDEV_SHIFT	= 3,
+	XDP_FLAGS_NF_DUP_NETDEV_MASK	= 3U << XDP_FLAGS_NF_DUP_NETDEV_SHIFT,
 };
 
 struct xdp_buff {
@@ -106,6 +109,21 @@ struct xdp_buff {
 	};
 };
 
+static __always_inline u8
+xdp_buff_get_nf_dup_netdev(const struct xdp_buff *xdp)
+{
+	return (xdp->flags & XDP_FLAGS_NF_DUP_NETDEV_MASK) >>
+		XDP_FLAGS_NF_DUP_NETDEV_SHIFT;
+}
+
+static __always_inline void
+xdp_buff_set_nf_dup_netdev(struct xdp_buff *xdp, u8 depth)
+{
+	xdp->flags &= ~XDP_FLAGS_NF_DUP_NETDEV_MASK;
+	xdp->flags |= (depth << XDP_FLAGS_NF_DUP_NETDEV_SHIFT) &
+		      XDP_FLAGS_NF_DUP_NETDEV_MASK;
+}
+
 static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
 {
 	xdp->flags = 0;
@@ -310,6 +328,13 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
+static __always_inline u8
+xdp_frame_get_nf_dup_netdev(const struct xdp_frame *frame)
+{
+	return (frame->flags & XDP_FLAGS_NF_DUP_NETDEV_MASK) >>
+		XDP_FLAGS_NF_DUP_NETDEV_SHIFT;
+}
+
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..71044dba7cc2 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -671,6 +671,9 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 
 	skb->encapsulation = 0;
 	skb->ip_summed = CHECKSUM_NONE;
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	skb->nf_dup_netdev = 0;
+#endif
 
 	shinfo = skb_shinfo(skb);
 	shinfo->gso_type = 0;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..e9c66525c955 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -605,6 +605,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->headroom = metasize;
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
+	xdpf->flags = xdp->flags & XDP_FLAGS_NF_DUP_NETDEV_MASK;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
 	xsk_buff_free(xdp);
@@ -658,6 +659,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 		skb_mark_for_recycle(skb);
 
 	skb_record_rx_queue(skb, rxq->queue_index);
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	skb->nf_dup_netdev = xdp_buff_get_nf_dup_netdev(xdp);
+#endif
 
 	if (unlikely(nr_frags)) {
 		u32 tsize;
@@ -773,6 +777,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	skb->nf_dup_netdev = xdp_buff_get_nf_dup_netdev(xdp);
+#endif
 
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
 	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
@@ -819,6 +826,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 
 	skb_reserve(skb, headroom);
 	__skb_put(skb, xdpf->len);
+#if IS_ENABLED(CONFIG_NF_TABLES)
+	skb->nf_dup_netdev = xdp_frame_get_nf_dup_netdev(xdpf);
+#endif
 	if (xdpf->metasize)
 		skb_metadata_set(skb, xdpf->metasize);
 
diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index c6bd5c29bed6..0671df72fbfa 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -58,13 +58,18 @@ void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif)
 	struct net_device *dev;
 	struct sk_buff *skb;
 
+	if (pkt->skb->nf_dup_netdev > NF_RECURSION_LIMIT)
+		return;
+
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
 	if (dev == NULL)
 		return;
 
 	skb = skb_clone(pkt->skb, GFP_ATOMIC);
-	if (skb)
+	if (skb) {
+		skb->nf_dup_netdev = pkt->skb->nf_dup_netdev + 1;
 		nf_do_netdev_egress(skb, dev, nft_hook(pkt));
+	}
 }
 EXPORT_SYMBOL_GPL(nf_dup_netdev_egress);
 
@@ -75,6 +80,10 @@ int nft_fwd_dup_netdev_offload(struct nft_offload_ctx *ctx,
 	struct flow_action_entry *entry;
 	struct net_device *dev;
 
+	/* The netdev duplication limit is carried in the skb. */
+	if (id == FLOW_ACTION_MIRRED)
+		return -EOPNOTSUPP;
+
 	dev = dev_get_by_index(ctx->net, oif);
 	if (!dev)
 		return -EOPNOTSUPP;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..db46901a7ca6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -633,6 +633,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 		}
 
 		xskb = xp_get_xskb(pool, addr);
+		xskb->xdp.flags = 0;
 
 		*xdp = &xskb->xdp;
 		xdp++;
@@ -653,6 +654,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 	while (i--) {
 		xskb = list_first_entry(&pool->free_list, struct xdp_buff_xsk, list_node);
 		list_del_init(&xskb->list_node);
+		xskb->xdp.flags = 0;
 
 		*xdp = &xskb->xdp;
 		xdp++;
-- 
2.43.0

