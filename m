Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADC606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=v7y3ROcQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcQd5Rgx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51B1D40575;
	Tue, 27 Oct 2026 06:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvbuW5FL5ky4; Tue, 27 Oct 2026 06:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE5B04057C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083373;
	b=lj3NL8LBwA7EhinaTLv4hGNXcCu6rrtGMm0SgcmLaMdh96/i69plw9ARg9Is2xU/U8lM
	 ty8gycOFvzUtbZu908hI9aY6DABntVObCrlERNkrEUYwt020gr6FjW/QtkcALP2ut6Kk0
	 qeZwZSbMVHcaZuAHIWvpdwSjnAMcgEisY65lMb5CMwwaBkJdNs1vVWOslBP4G+imI/ZyX
	 PDNO46Pr6YZZOFdvPvCKRkWVwfFHNZ5CCCQrVb+3q6tVC541VrIgS2uem6Cj06QXKItG7
	 EKzxun6FJHIHm1xNG1U6VP7GeZR7vZwEbv/Gr7xBdLxQXN8aMovJJSwDE3o6e7pZMXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
	b=WAblHWW23CeKtf5LKCnP9GJKBwbyiGB73GoCcMx1g2EyNDXDhj9qZr4MBv9jj8xvB7oC
	 U+612DP/POZvs5B2sBOBzFfRrY3R6W2HEXeb/3DOP9RtPaUbA7N8VVHCcm+OWFyqcoU+P
	 bu7Ns+Ale8OA4N6o55EbfLmdWNgvPxXHce2cQTPa8qBUyn80CUxgeihLM0FKYDzXjKgls
	 AmPQCPq3KIz9j9rFROATokXGg7v7lyrTYRctPJ37I/I4qU3xOd3F8ahgJD+mMkvxfavv2
	 cDICkyGJg5SsQ6BhNBcY/o+EDCjTCd7d86b1wnpHorr3GDSYgqtIYEx9i4apJTCwatQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793083373;
	bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v7y3ROcQwDF0S5GmBjwc9gw7cPMBM4/zCewp5VSylqVxJ5PnowhsWIi/QoONFM5RF
	 3XH80R/wXbwVmvQzr077CsSzFwjhqBnA1I2EBylhchQrSUvWjF4Czu9QlW16a0Gd1v
	 mqcvXjakqme+qoaAhSKYuefYOlxHIZw20ri0fsum/WNZ8sQoroP871XHjXRraXOSet
	 zytGXH1etuGdjz/ZFrfLaZaOJ8v2tiWMeruHkJ2xoO40zlgL3bxt9n9H/2+3VoCDVB
	 +7yT2GbOnwQB0PogSFf3eDqQSs/isaXWjhupCeGcJlu0t5S1Le72GWPP1kqUbPqCv0
	 qhTf0PMJAlwpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE5B04057C;
	Tue, 27 Oct 2026 06:42:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32A6C120
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1896360687
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3-ZETtZ4Jtgo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 06:42:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FF23605F9
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083371;
 b=KbTnL8NI02ZjO9n24nZ7WEMOSenXlp1ovOK95hEI76PTf5RkGJhuCAew73uCS52jN9Nz
 Y9S7NCsyOfld0LVpTj5LsjuoodcFYpAq1OqiUB2YMuHat3CzsJXasBABQXSTz7V45VuTi
 w36H1KwhnPzkHPNZ0X4S/RopIaDwq7tLl/LMwLbZuSDXJcYvo2/Lp4l493FMI6LFk36N7
 Ezq21cU9lX5js+SC4IXrwmR/R2eYtOkd0LDRikqEgHb0/p2LAux2FoUwrjeGhwJIypRF8
 EUwvV6Id59FFkxXrH8SrJawxeFU9OeGfVkdkbmM+Cu3rHSCrstXUBDLsTHkdrZz/gug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083371;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
 b=G6XeLmMmGOYHpSSU7EQG2pMWO3lZamfYyz/y8hmyeNzjN7lN9h9ON+GtCZuzOIRpyVMV
 ZskRAHiN4GvLlao1iFO7DZSFEqlph0jXpHWzqQKHWuPHGCzIL4Zj3Qs8dCO4In4G8RsJ0
 9h8uNH8aMRTei0o9k+c8tYgr/EgcZ2cmygTgTCoTKWo2/zhpqlK6mInxw6dRsyZlCTmB3
 HRS9ClfIp6SMZ9DQK/Q+1vumx+xIj9Y+wYmKhbU2KfuxRT0EPpKA7Cdv7R3ufNIxcQjQp
 EkFYj76TIJDterb2pjT5JAl2zna3yiuyz6BQqZiSkhPUECk19yXZKGaJQME+DJYYEYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RcQd5Rgx; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=edumazet@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RcQd5Rgx
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FF23605F9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B87A43F5D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7775B1F031E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793083370;
 bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=RcQd5Rgx2hQVnLWed84Onq61jdm8RewlmVFnETkOabWqsAIYlP3t6v4NDguMWicf4
 XIoPv6Q/N2BjvVqNIdr0SJ4Q3tJrBxXi68L/8eqMPN8VxsDzTXBEyTU8ubCCCsPGAY
 cNzztg1U8597P0XqYS9yQ72n9R4sE77DtrOwpuyGA2TEC1rjOR8Pp7Et4MSElyd3Yo
 tGLt6gc98IH3gRI9dGsPCN0m2TxrII9PhM37Jmv7c8jshDscyh2A2II6jxlrQTgG8k
 8AYM3VgfN69mc04S0LIOcwWoYgPM8M20Ej+ABvrkFormUoOgBdW3LhTe4V7jY1wlgD
 FRQ4Oro1Oi57g==
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-4a75a5fa32dso837308fac.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 23:42:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByn5qRE7GunWD4hNlAx/m+RJ/hEbxPgSiqPNHEfHB889jPcU82PeMjmaK3veVH7zV4tmHUsksnWzRJ20XWFKek=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLJA1zXXfgPP6Cm5nCNytuQIfSDjSReRooy4CxJDvtpyBvlBSAY
 oaE4z3ktXIHYa3uKdUCNtOreon0Eb+VafvROM/HWiwuWyzahQ82pU8Xzr/6sNn2H70shh781YIS
 99j/+x+GV8r692tGi0LWdnvCSK/TTdiw=
X-Received: by 2002:a05:6870:c22b:b0:48f:e25e:e202 with SMTP id
 586e51a60fabf-4a83f5b8983mr5062981fac.61.1793083369809; Mon, 26 Oct 2026
 23:42:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026091549.605810-1-p@1g4.org>
 <20261026091549.605810-2-p@1g4.org>
In-Reply-To: <20261026091549.605810-2-p@1g4.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 07:42:39 +0100
X-Gmail-Original-Message-ID: <CAL4WiioPvWBTb7uq2ny=AApqoDst6fFr6pVYDjw+LfP9UB9q2Q@mail.gmail.com>
X-Gm-Features: AclHuK95zom0Wqqrue6m7-lKPoAo3R_113cwV3WAYgHulj4dz6QgUcVJPRpgglw
Message-ID: <CAL4WiioPvWBTb7uq2ny=AApqoDst6fFr6pVYDjw+LfP9UB9q2Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX
 timestamps
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
 chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, 
 horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, 
 matthew.vick@intel.com, aduyck@mirantis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le lun. 26 oct. 2026 =C3=A0 10:16, Paul Moses <p@1g4.org> a =C3=A9crit :
>
> igc_request_tx_tstamp() takes an extra skb reference before transmit
> preparation. For GSO packets, igc_tso() calls skb_cow_head(), which can
> reach pskb_expand_head() with a shared skb when the header is cloned.
> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
> preparation to fail and the packet to be dropped.
>
> For non-GSO packets with CHECKSUM_PARTIAL, igc_tx_csum() falls back to
> skb_checksum_help() for unsupported checksum offsets. This can also
> reach pskb_expand_head() through skb_ensure_writable(). igc_tx_csum()
> ignores the error, allowing transmission to continue without completing
> the checksum.
>
> Move TSO and checksum preparation before TX timestamp reservation so
> the extra skb reference cannot interfere with either operation.
>
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Fixes: f38b782dccab ("igc: Add support for TSO")
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
