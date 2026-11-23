Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BF606A335
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=s9lvqEs1;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=e4NxxpUX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B06C60603;
	Mon, 23 Nov 2026 20:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_SvnPofKxB8; Mon, 23 Nov 2026 20:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B79146068B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795466143;
	b=HY2eEV+ANj8ExZRRzHStJLd0/sbHStnjYQIJmeoJygVZ3eUw1CXCQTOeuITrAc1lxkvY
	 /telUs7k3i9eMQwejB7ZyLQyPdU+1XEnKmsCjVnTDMWuPEWhJQ4WIKgMZz+DGFkN9iLVP
	 KNPwma7wCCwqCrELL51IhKyw+jC65zCIuVuv3Wcb7vzZmBiafYLsgeREoy+GP0Kkz2O3Q
	 UZMm65QP1AnAfWjgmunBtOciHeqnQcttFpwxmVY4P32QZjAIS/Wl9i9nChJy0MmwY4m3n
	 mHRHx+etnnVyi1i+IsexCsyh9STcFYFqc0BHB5k/Xm+Yitle2KMFyy8oDyXAhEJDBbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795466143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
	b=gDjYjaCl8uW7tAriWDneUi3CS8B5sR/Gyfh9NzuXo4dhzSUbj0QU9aqzIF/sjCBULih0
	 lwsfLcMCnjc8oKacK0wtpvmQUXQKzGoiO/zBtchwRWb/JXQ2WiSF6tIa1ktajPy0ce633
	 NWqLABQTroW8gmzF92klJhMipOXVGosOkOpO4Ith9n6ZtQVtsdlaOzbCqS//mTmsyHHfo
	 zQDGhqDwxOvjnSWiccINcQiIW9GHW8BkClZik/4aJmK1JNEsaQ0AtozEBb1+MlxpCXVUa
	 qrVkDw8R4PDnOnr6Z3rBA9ILND10dWOWAhx5YhKiKgjmkHv5k2JXclYbiJYHAkChwmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795466143;
	bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9lvqEs1Xg6xtP3Y0RvixQiy9JOvVVKPVEP1iUlTjGcmwrF13W9q0NqA3BUKIcDfq
	 8qEYL4rF+i4UtfdHjhkRgXWg3QNsvD5QxXGTA9XqYfU5ZviFlHAraAL9SK3ZYlAM1O
	 kpHrMUmEOFzrlTCQ20QVLWYLlc/QcDDQJiiqjqJ0NeuVjCLUOGDJgnXOFRxYjgMxsz
	 OzGgcNcAXQBbFeQBfDH9ciD7pJXDfAT+FcAxZmsZvG1vX40c4P2WHq3qQbTvpcJ+lM
	 GArNb9/ThYkHJ8GvaVZSVYwZx5xfgqZJ6JSqxiEL2To3w1hAeKI3llRCvh3gQh+l4h
	 ukzGdGHQEl73w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B79146068B;
	Mon, 23 Nov 2026 20:35:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B66EC499
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C9F04022A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIrZlX2F5twx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7748040081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=e4NxxpUX
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7748040081
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:35:39 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6aa9606ddadso2498269eaf.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795466139; x=1796070939;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
 b=e4NxxpUXSy01kCoVUtb6l4d3I8MVWGJjDHUJ99g7cQw76NvC8OCZ/7LhdNw4iT9WMH
 xgDN9iYOKx7Lbowk/7349VUz8uBuFlE4iRcxSFEAHD1hk6jehj3wyDA2wPOMl6LV923Z
 XgqKwONdiAH4wWqlr1JhZp9fOVFA9aG4/EG3rxLw+9f4u5q1ufzm3oQt8F3wgdpFrueh
 y+GzxF+0Aw5So2+5Y43Hsz4nZPzd3uJQoYA+GuKnZ2k1QtPrZe3UBBLcPyPAfBjFm86w
 VjNpc72qArBQdJljcyQyj4O6sFmRrgSk/ToAx1HQ604CzR0kpRIDbmJ585+jTuvWHprq
 69Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466139; x=1796070939;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
 b=WurFRkiKkHWear8rDx/Wq8b/fv8Ozqpm5Rx7DAVMiu00Lsaw2Vb6LWXE3sIFHRPDcO
 fxn3BkQQyoUGkpXiJKbPd4fARWbOenyH+oSpL8VknECXRD9MDrvLFSjFCIMG8YK/YxRq
 u3647Lbk4WqnFtEhR+YYGdaTsfCA1pAYnVXDiJA9GGSyLYzu6BRkWJi2veTqhy6JvNXm
 nXL75PEsB9thY+HTSuhsKhyLpo5xBCFFitbNB/L8yWyC6YoSCsBBOMK8hfDd38zztzpE
 YYVscixK6dFM78QmsYY2iP0tQmq0hjke1er/J+O/7dEeDf8EC1ihV6W4yALwHzq4DBgE
 msjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGdVO3BM6uSUHSWSN9kJcsERtPLq09eh8F2LBvmD7uG/coOEVLTRvvc+0T8g432MiYc7oxAPfIHVcOE4ymUAng=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+3g1YbeNyOqDSvLOqcC05CIn+kdt7722YArhCxWT1C9oAA4nB+
 qobnr6PHMJPrawOP1DBlCmBjYfuFcEseQUYdoCtDStFID3sbDNfWJx3CXTY6ao+3dvBmg9S6kef
 L3no1E8+ruX4I+4NUtJklJ+UwOmnV2kCCIUtqKhVbdQ==
X-Gm-Gg: AZFdTZccLp5GyuhRkg6ikBEigEe+nioArUCoAA1T4lxueix9Fx8gaKU8admL8YcvKng
 Bx1N0b4LlcSwU87EZeq66+y0OHqZnj54ApYsAlBraykBUP6ro0/0v/LC5KiEP19osMBvhN6BrRm
 eF7wC4WOKOgnQGzHuI52Xns+fut8vDFUXnopT8szV2F3uCZGZ76+9L7aYqPPNdeIGgC2oEwE/4C
 COWfjSqvpWj3kXwyUNsh36LpoHHNOk9mKf1+sTl0lnzcD7+heNXYHKDBynZwAUQCk5lvM1Zsd1R
 7gW6/ddSniPPd+fTYjXVRBdS3p34SvL9dVpRb6gIJLRh4wp13/zePVN2iiUc8sLdDI2q8gkmuw6
 Jy9yzbez5T0PAdB77gcFw0BsNt4nInMZleGeOR0199LF5qI/eok+gWM46L3E83CJ3989N6/zolr
 97eENa17b/ig==
X-Received: by 2002:a05:6820:a78c:20b0:716:bca7:41de with SMTP id
 006d021491bc7-71b395b5dc2mr6723471eaf.87.1795466138983; Mon, 23 Nov 2026
 12:35:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
In-Reply-To: <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 20:35:27 +0000
X-Gm-Features: Aa3M54plANLdGi-6T1QT2FegAb5y7dpeYS4xxUrv2cDoobb2gOCJGSKfYwT1pMM
Message-ID: <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>, 
 Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-23 at 10:49 -0800, Alexander H Duyck wrote:
> I'm not sure this is the best fix for this. If we are needing all NICs
> that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
> event of a frame being modified by XDP it really feels like we should
> probably look at moving this further up the stack.

Thanks for the review, Alex.

IMHO we should first make sure XDP programs do not cause "hw csum
failure" in current kernels. Whatever an XDP program does, it should
not be able to trigger a hw csum failure. It's not an uncommon use
case, e.g., Katran from Meta [3] and Cloudflare's load balancer. And
existing selftests already do it (test_xdp_native_adjst_head_* and
test_xdp_native_adjst_tail_* in
tools/testing/selftests/drivers/net/xdp.py).

> Also even if we go the multiple driver fix route I wonder if we
> shouldn't look at adding a new XDP return type to indicate that we are
> passing a modified frame

IMHO that is for net-next. There we can add optimizations, such as a
way to keep CHECKSUM_COMPLETE for programs that do not change the
frame, potentially after [1] or [2] is accepted.


[3] https://github.com/facebookincubator/katran/blob/13a0d69221e43b4941b81303e6726ddc61a12169/katran/lib/bpf/pckt_encap.h#L137
