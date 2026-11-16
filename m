Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8284606A330
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6zWbzSUg;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TVYQ4HeI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C157C80ECC;
	Mon, 16 Nov 2026 16:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lo_xiofXx_x; Mon, 16 Nov 2026 16:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0695880ED9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794847238;
	b=ikwuR6/MDCIl6/uGQGW3IWUwlpBxXrcG9gV2pDSbinm/glYCU4Rg+VbZbAPvEB5CvePg
	 gzZevyLJrfi/OvC5JuvUerAqr/W8kXhsh2QKT2v5zk4fAKMoE7xfnX+b2lV4QYs/hx/2+
	 jffn6+gEdCPapudMOOEXQFmQnKb/0x7+msPcdnr/Ko++N3fGNpEYNe3OmNR0kOU4xGWnW
	 Of8/dBDD45BdJm2cGv19AE2HtDTOlkh3HO5G4HAKNKZRCiMKGo5I9TJttvrcjGCofQUii
	 cbt+Lu70McFt2KmJtqsXZ8TwgVr9bdixnV1/+IzhE/+SLzjgsjUMZlv8JylDEg6W0Mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
	b=GTPXZVd1J7jb4/8CPap/qWs7yI8th8lWvv6IvNpXdy9mGPAbYF4BzUSk5qF64WErImtC
	 rjZqjzrsSDccjsAT6E/6iiCbIf6X8JgQHe/fIt0oqBlNKW/4/+usRBRBbDcq67BJMvnXO
	 U3nvxNmnD52o2jtMrQmQTS6crkCbT6se5sqtBGE3WU38OLlunNF4hvvYJWjFEJAAQcQBS
	 zIUU+Z803lzo8QfpN5i6qs4HZflaMbGoYsshzpM6DGqgEEfqlhp/QQqCobLJIqqRzqDEo
	 mK/xG8nVAsTDDRXpjgfbi9Bg9q69HQg1SukbVVrbWz7DB7+Bl9sQhmkJ2X8Vds1nupQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794847238;
	bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6zWbzSUgM2wl7cn5WTg+88upQJd+NXsBrJNCc8FkQvwoHfT7IKfKifVyquHIjcBnr
	 +yH4zV7orJwc/Bw/nmIx7PYXbIHyPghaByeAQDMwk8krVmTSNz6T8kD/dHA5u3H2Or
	 hIKl4Fd0P1XbGVVLzjbWvs9h4lnfszDKmE9+g5L5TtBy5Jxlm7ChOx1YxM9G5wUQhs
	 fEkEYXdCUOtHl32R9SYRRPlWq3icbNty4aK+ELrmKbGAshX+3dB1as/9BE3a8mzBGI
	 pywmRazz0W1hMMnt1//fVcr1syCjFDARpzjRCHPCQZlPOqZTx1EVGB/ckmCDs6iPtG
	 EBRB0XHkG4mmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0695880ED9;
	Mon, 16 Nov 2026 16:40:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 276C21E7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 16:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18C1C607CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 16:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3XmlvNwYE-D for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 16:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7E5060721
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=TVYQ4HeI
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7E5060721
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 16:40:33 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c50715c2757so467726966b.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794847231; x=1795452031;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
 b=TVYQ4HeIiSFMwgB0ywq7XjSa92zfz8CzbSskWGGhjj9w8lPeU+Zn5bZSKtAEfM96Zy
 2xxVdGq+ijOh+6xraAvJUegU1P3Z/FGybyXV9v+cqEjgdkoNanrDs2BtJ6yNKLF+gasg
 oJqdmt95TswtXwcLpStFBU+bqbRv+1Vp1/xDUhIBrbbcDgdj9DNVVSqy3KSzPeB+galK
 SX78XjVWFGH3bY99hTIO92AgsjEThBz1qqOxPxC9c4INRR89WXUd10knK9iW+K2didll
 F64SoDqKIeA29K7yHR7gHlExgJz1N2V6tEuutps4n70/Zo02aHV3QrYmett4ZOnCj11z
 N4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794847231; x=1795452031;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
 b=qpv+SO2bTZNlIgllUMFglLKiXKZP6iV/VWPwFM1fdIGJQYc1wwrkw49HFxat8D6Emu
 8n+Sircb8VUJ5KUlmAC622sZ0wAIau9cd+W5u4b7C3svcmxk4mAouwguFGJA7zi7UUPv
 84PozHpKh4MVQiyyZN7YqFcEf9UuvVlxRbIfsjQ0cNc6i14ALjIbAzjMNgbejwqscvUa
 Rh2Rj2On5B0yjHCU3bNckmv9FPwTFxEqVx40OGQ+atBVZu6JXeJAPe3tvVwETPnBKiSy
 dwLQ8yE9dkZ4zJv2r+QNFuIY0DE3M3wFW9EY0gEU7C8NuYmq5Gmmt+X8pGVjEX5sMWV5
 VwMw==
X-Forwarded-Encrypted: i=1;
 AL+hErFiZVPzr/N1bpRrvwTBhh3qf3R0qcpJXPn5S/+ZekOHwXS2SPdZtcYd4spDTvxKBtwh1IM9FUowRbgPLACMjsk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9ML03cxJ1FYfExCDAj5H88mRn3Px1597jQsvQqVU4ux/przb0W
 rfrB67Vm1OWDWLcyME6PcDg8avmCvEtpoamZaT2DqYmzn6H2UTf/smjzqlBkq36Plmk=
X-Gm-Gg: AYBFou0PTKQ/KyU0X0//ZZM3n0W8EjIcgDqdYci4xqL8DAm6Jm7W+4CTCrWUR98W+xF
 fPshOs2ww3imvodCmWDT1vPnZ4dLLs86Gnw6fv36RZ/cxT9wQ+PFFMRv4KtNdHNDgAJS992Psrt
 mCEvkW3IH5Hrcp34SjlPHSbpugJV4XMCXDLkHn1x/Ja81eiyRQfh9oCMZ05bQ9hqI3eKus7hooc
 8PA4TS3r/qqB0yrnns0xIL3F++2PRv9dpChqeR8g1RDyIisNe3nDBFg18biQaVlyu7yPEGADDP5
 OmA5NnU1bRfT8KYtk8dyvIT2grbM9oKX9b54NpcX6kytBY5DUhWuPGbki9b4VNw548dsWbAXR7R
 FZhU3nJv9Y4DlOImqXnUgH76052IUSNqu/0Roj7/991wJeF1frBhoEozqh7m9Z+i1uhyfMwcQzY
 x0ZMTRANyVtMqofMz5DNAU+/9ovG1Ix7W651OkiQBqhvARmllWIqTwADT7gR7LX58aAJu+ZcZq2
 srvkuAy4CiY9O/O462qNIUX1Xo04Wh3BtOwmXhO7oC3roHdjQ3sef2mwAOlNP7+fI4Pbj3MS0yu
 tfNRsvs/zKp4ZywF0vct2e1QXK3TdcR5
X-Received: by 2002:a17:907:d10:b0:c4c:ddd1:cffa with SMTP id
 a640c23a62f3a-c5096398ae2mr930659766b.29.1794847231194; 
 Mon, 16 Nov 2026 08:40:31 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b7b2c9sm444919166b.73.2026.11.16.08.40.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 08:40:30 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel-team@cloudflare.com,
 tianyi.gao@linux.dev
Subject: Re: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb core
 extension area of xdp_buff
Date: Mon, 16 Nov 2026 16:40:28 +0000
Message-ID: <20261116164028.37110-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-206188@kernel.org>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
 <sashiko-outbox-206188@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Nov 10, 2026 at 04:23:22AM +0000, sashiko-bot@kernel.org wrote:

[ ... ]

> [Severity: Critical]
> This problem wasn't introduced by this patch, but clearing xdp->data before
> checking whether xdp_build_skb_from_buff() succeeded causes an invalid page
> dereference and leaks the head buffer [1] when skb allocation fails:

[ ... ]

> Should xdp->data = NULL be moved after the !skb check (since
> __libeth_xdp_return_buff() already clears xdp->data on the failure path)?
>
> [1] https://sashiko.dev/#/bug/linux-d6eb94b5-df62-4b78-9f73-358fdd002a0c

This is a pre-existing issue in ice from commit 93f53db9f9dc ("ice:
switch to Page Pool"), not related to this series. Cc Michal, the
author of that commit.

Cheers,
Tianyi
