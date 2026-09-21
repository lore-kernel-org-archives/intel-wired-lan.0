Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E8DC982DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 03:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C131280C4E;
	Mon, 21 Sep 2026 03:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95ks2leULasA; Mon, 21 Sep 2026 03:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 30EA180C5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789961319;
	b=K7w9pHOAD6gU5Rl4uT0CqVBoTFGh1L5do3KyVT+/L4pS/fsTIgDMYe12rrJ95OBY1KAc
	 zEJwlf4oqP/dS84FzJvLuIcG/KRsR47xSOA0KOgOww4gt2YSggOb9ZluSr8n6HlJs51Md
	 8SIpJ63HmB9exB2lFP900E9dg0rlafAaydWbY2Efa+ZUazwjiss7s/wJxH5LYtPPVRmXI
	 sYOTZXg2u8/hY7F8SRnHvYCypvoMUceW3RL6DHjc8Pak0nOMqT9zFYwE2VGBG3yI30HDy
	 vEuNiUM70/IM2WUpU0mNbv6RGB/F4SjwBkBbdcsGte4NI9oNVqJ94HlKWl7vHmdyz2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789961319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
	b=jkc+pLVmsuvcrEZHGIyOVgBFRLU+kBZwFRA3ntGsZZrJ8y75tqBxB2Y3lXgiuynUIOIV
	 sYnsYP9H+Yj+AadZBoI8th7MHvmmv3OAJl7sTZ+1/7lokj1clbtmPUVinsCWohhOT0tEp
	 kA4qjJQTi9zWkdivQoZW7z0eoi1tTtEqRShk3isWurlGRSsqIeLenEeEAUwVr+gmojtZH
	 Hu3Cqo8up/nPlC1Sb0jyR58y3hxW/fu5cW+E/5Qp/1iOoEUqnR1f1OM/SCg2hmh+GoFPC
	 SgNbYBjuELLIK1ybRtQaaWSeymMyGCfAUWMCiitPU+Za9aou6MYELzujm+vuTrpoCzw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789961319;
	bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTnR4KQrysce3Xq8NhG8ppYWv5S6g+tv83iQWfKZXi6oKQOxy53dYdW99ml7/eDkZ
	 Q1fSvHQJmPqM/wA+mVnM5ZQH2ZmqFPF9a95gnvK9aubMX5s1AuE3FRFr0zsqtrpvr9
	 vsLytwaBekOa9ol6ukm+3II/TSIyoF+s/vk2XETjFmY/VEMXBtiynZFWYirL7dASGv
	 jt/htwcetTUkqIPjqvte26nmsA8HL8GkX+6QYKp2NJ+SOEC6IpTv2glRvhBDYuVz6h
	 +CwseusBh1RrkCbq+ab5DoQzrseinIMa49gqWbCH+1h9ukd58GZnl8DUcWNCijMeuy
	 AjftejgpTxFIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30EA180C5C;
	Mon, 21 Sep 2026 03:28:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38FBB28C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ECCB4008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBfBxniT72zj for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 03:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 87B7840080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789961316;
 b=dxQCe1ClQ15EImp2iJFd6uMKOSvdKJcmB03SwSVWlUzRH1LngHlEqrZSALCZjBojLY9F
 NBQEg1n07CRbQ+ug3NSBXcuozyk2SdW2RRkwjPPSawfulOEWAvSgIWGJ9uKX+iaBDVHRW
 St8zxW7VPHVbdEcYGE+Vq7ec6677dlsXQjED5Kc3y7YRM1xiXsK1pLm85JmtiYdRMO8Gf
 4AEhjWOqrJ7M1XcE4xRDhlhuhpTtVtoKxoMld/qZQnoMucianszypcVUwW3b6b+irM82H
 uVO0w8v5zZEStv1+dqqpc2TZ+Qcaxp/QRJQOXuChRVTrXMfxhTCkEs378yVWI0DkoQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789961316;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
 b=Cbdm0L+L9pthZjnKqPR3UI1Nnf3ppiG+NzDxcNo21xqQ0O0kTG/1Xtuh4i+pb5Fzd5u8
 +/BRYUMR2qnX7JQlJA4dBzgfYxlkYIxhZwsAoiYWTxJqki0+NS4Vyk3Q087IIzt2RKAYL
 QFL1cZZysl1noSYRDplQvfhMWXnYhSUfMQeMlT0r/o/66/n+QKM98pXbyH97RV4KSLSr+
 SuTsq4uL/L3kIuRtZKcMlpd/3RrsFNuEYCoHBMiEjoqq+LE/TyrgoiCH6o50g8zvy023d
 Puer8qxbngduga6qt4HG0Pa3l5tK96wt5EyWl5anTxEWJ7I4ikEOEaSYfPnEtM6/ZiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BNK4Pcah; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=luckilystar08@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BNK4Pcah
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87B7840080
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:36 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2261830a91.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789961315; x=1790566115; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
 b=BNK4PcahPPp1OCFVfnkdx6ki7BDr+CZGGZjUSnyLKfmB1s8o9mmz/Poyi4uUc5rbjW
 ogMWJpt4GBlcmEHb9/2ZYWCFYyIG66jdW+K9xNGgu26qpDXyMgmhzWEwE9BSoXTyzpt+
 fpRrKVchS5pC6/9g18RpH0r5hUhj5Z10q447Vvl4sL3R5pQciY0uHXS7BgRRJOcz+WJJ
 QSxh/IDwQv1nNyvqqtNloUUr5Ba4EZtj1z2JWSMdyAEtLmgzQOpKRqzqg3JNje4x1iJF
 bM2Zvac+i0llxIYslTq3x0j3DtPHAl6EXxMXD9jKgak3ovfI72pPcgmtM+vNzTYK+PMR
 KIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789961315; x=1790566115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
 b=tJrFOtycFM8h5kE2T92EnkJREyyjCZR01q9QRTICM/iJ/msuHSG0LWwIUSywYwAw91
 dhZSvRuimm5gGES78avohFPd6zV8ayZUVahsqMZ04nKBvIWyglcMa3Y7v4Xn5D4XRnu/
 fERuoygFr5u+UGvW+gV4yg1ZgqwZAwRkcNVozzEHS8+UF/pVcxXWC4iR5eHYcbXhw9GO
 sps3+9j9Pm8Jj/n+sVf/vKCtpyQyiXj0p9u01zUYDfs4C8TZtzbZwVf8uWbweIHMDYdP
 hyCW3+Wqtv+QllRBE4xiAA5i57IAHIc5Mg/unEVSNLNjG1ERtdATWAR5HCaS9gAJpw6Z
 4UjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd7aKVDtUH2Z/CGMh082zPaONlmhaejbqjNCGONhaKPEJqGXs+Na9tpnqtQiHA6SDa4Jk/MhrttUvOTKb2ccQ=@lists.osuosl.org
X-Gm-Message-State: AFuF++nfW/Ozdpo+WTwXtNi/ZZdhkJ6940pKTMEEBM1D+0QKUEB4su6A
 cgT2CMdIjZL+6FZBcvCep920ei0BwYnR80zZMS8UkuJKe63OS1qVE/u7
X-Gm-Gg: AYBFou1dtQdaR8mRlhKnDDUD4DaGv1GCEISI7UwcQMvV3suT+8yl1CndxBEYryr46ZS
 mSqaHeDbbGAzFjmorCni083Ysm+NTjjzLwP0a8Vbod1NWawj8mVkoCUnLA5Wt0NUSJXZ3kHGQXr
 bcVwZGXWtLa4aauZP12bxE/xluKWMpT8SBN7Tql3wj/YVR+PGdgqCfWeBx2C1Zd724Su8l/J8Y+
 ihpY6QJfqeIHLa3Ejg1vC7wq9dE++h6EzuYsbBfomcf8Dl4GGCz+rjFb6g82PZRMZuQSKcME+wl
 VSKCVAzE9Owq0KGSd7XAdXum4URZoZvBlEkNo8cerGLFEAoZExqf0+kSgZRL2CdEQX+KxjnUitb
 jx1Ice9tQGku+2fws1Y3nSNUmDLttVGTFOXkQ2pacQy8hBxe0YyiBeF8Ee9srOXH8iVZ5bSqaAZ
 1OFvzdmogNLrOrEp6a8KIj2wL0NqY8jkcC3tbV3QQGyHoROgTNd6zMF+a8RotThJfDEhcuSSR9I
 O9T+h6Nl4sJ6RxoZZlWAnU4VC/w3VCFTkJuVQCFxnbUyyt6H97I8OtTRQ+1gpJem60kl34/5bBO
 Wa8=
X-Received: by 2002:a17:90b:3d87:b0:39e:6c6a:6579 with SMTP id
 98e67ed59e1d1-39e6c6a67ccmr8574108a91.60.1789961315385; 
 Sun, 20 Sep 2026 20:28:35 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37c8e7sm11448715a91.9.2026.09.20.20.28.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 20 Sep 2026 20:28:34 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: emil.s.tantilov@intel.com
Cc: Tian Xun Ng <luckilystar08@gmail.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Date: Mon, 21 Sep 2026 11:27:31 +0800
Message-ID: <20260921032827.32485-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <49cbb19e-dcce-4bdd-8cfa-68fb2445f952@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-3-luckilystar08@gmail.com>
 <49cbb19e-dcce-4bdd-8cfa-68fb2445f952@intel.com>
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

On 9/18/2026, Tantilov, Emil S wrote:
> This alone would not be enough, you need to make sure the reset handling
> does not trigger in the driver. Sashiko is also marking it:
> you will have to set IDPF_REMOVE_IN_PROG, though I am not sure if that
> alone would be sufficient.

You are right, and so is the review bot. I missed it because our hardware
takes the PF path.

On the VF path idpf_vf_trigger_reset() sends VIRTCHNL2_OP_RESET_VF unless
IDPF_REMOVE_IN_PROG is set, and idpf_shutdown() calls
idpf_deinit_dflt_mbx() immediately after the trigger, which frees the ASQ
while that message is still outstanding. That is an enqueue-then-free of
DMA memory, and on a system with the IOMMU translating it is exactly the
class of fault this series is trying to remove. On the PF path
idpf_trigger_reset() only writes PFGEN_CTRL, which is why our testing
never hit it.

I will drop this patch from v2 rather than paper over it with a flag.
It was never load bearing: the stray writes are stopped by patch 1, and
this one only restored parity with idpf_remove(). If it turns out to be
worth having, it belongs in its own series with the VF path handled
properly.

Thanks for catching it.
