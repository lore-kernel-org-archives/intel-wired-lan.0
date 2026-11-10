Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888B606A32D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8AQVRvMB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kymx3Z5Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9C7081401;
	Tue, 10 Nov 2026 21:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ufYxLGKCMio; Tue, 10 Nov 2026 21:45:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B901E813F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794347145;
	b=P0llj6hCaQX+oXXxfJsTyNOHCxy5g9JwOfrpAY65+/Fhw5BeG2yNoWqzyIH7IbnJMDl2
	 /62ZS3prN69xuuF/ee8XRYqXXz+xIvrlxPF1cCKlx02yQuVeHyz7GBtNxmV5au2UnRgqV
	 fuYV08ydLfXa95JBM3sK1QIhrK123HCHhHGXVmL0oguwTaYO62BuLAqCLU5p/3rNvdKRX
	 HPUh34bH90uz0sk/eX4JAYMsx9NoODjKMv4TDCNnPmj1poyyhwqMeG2e2t9Yrsab+R6+i
	 uCxLmyPYFLuRGpDNvv/EWtGU9rwrzJg6YiY8Y08NNI9uELaEa39TLCCjV8IuDyAZrZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794347145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=35fQk2prx0lBB02/47r4mEUB8fpBOI29YWOfBrE+Kf0=;
	b=X+DkUmftoNFucd8KnRaCMREtyoDFizbyN58B/QdCnQFDUON8JPSjBQc+ib/24RM8gprW
	 kZ+e4d7DBEkPR7j7mxryVO5Tf9G6kftg1ItUr99sEqQKDGcvNvmLDbKErjO5ksTTyaMgf
	 zKizlstBp5pfqD31N0y6fNjeUaF9pusFqv7894RGcp8jYeZ3vzffUHJRM983EYWiZVOTD
	 3WWS6+ufZDMiSbUabW9jYVFxp650kvguRosxucU0KcnYas0sRTQkkiNX35cUvAlXR4MU2
	 mFUvGXzijBjtzGwj6AxwAQPYnsU/9mELr16E/7+h7Gxj6nrsPkt0zM26k/WVG9d1FRA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794347145;
	bh=35fQk2prx0lBB02/47r4mEUB8fpBOI29YWOfBrE+Kf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8AQVRvMBECTaRw+cKBZqhv3WYke1aqlSFsB0+9mVTKFgS1IA0TxLonN8G4vqS0O6R
	 BKsxp2/GCOBEC/RxL0fn9zAglcvzPXDEs/4rvsH6PVetqkqFiNl885/qh+4zVJwnO1
	 eqXWj5p4YYVLbdgSeNT97k9rehCKRrut3WkV6wjpKEcYvbaopQsT1/C1NpfRJqDTv+
	 pYX/4mceSP3rhfDsNHy/3hAz5Xe+gRI7I90jg4Ch076//nTksHmKBwqQk/Jthp/fUI
	 C8D264DKdLdOV4SKr56NCzvYCaCRCss2UDsXL0kWmLnNho/zaRHmn/Zc1qV77rlpgO
	 hXSZBru9E2ymg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B901E813F5;
	Tue, 10 Nov 2026 21:45:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3EB0731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 21:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C818360A92
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 21:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsPikx36uorQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 21:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 185CC60A89
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kymx3Z5Q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 185CC60A89
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 21:45:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA79C41918;
 Tue, 10 Nov 2026 21:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBBE1F0089F;
 Tue, 10 Nov 2026 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794347142;
 bh=35fQk2prx0lBB02/47r4mEUB8fpBOI29YWOfBrE+Kf0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kymx3Z5QuLjhVt9c5TXAk+kfoV9+Q69m2rh6gKaY2iciQySjWz776ENyyzO76ntE/
 /uzWTdV8hdYbQdh1l4IyeQ5fyyv9r2cCWu0qjO5wH2a+J4S0bzy6nNaTA6trhTE0GW
 /L1dwdPvEztraG/h+sVCOy641h7Uk/TMwO2q4hRzVBg/Rkxmb7cReJ+LatfFNQPTkP
 6patrVaXaDmYcM/GxuvUQx3acPjDDOm/3QA23frVW+hN4rGRkeHMgbj+Hzf1wrVZRK
 Mzim6bafAA11Nz4YojXw6wG9MXECjIaGYV2Ai4JM+kIAL0NrS4PfdlrklEcr67vMyR
 y6wV8M99tyxhQ==
Date: Tue, 10 Nov 2026 13:45:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ding Meng <meng.ding@siemens.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, p@1g4.org,
 gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <20261110134539.12d860ef@kernel.org>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu,  5 Nov 2026 15:16:08 +0800 Ding Meng wrote:
> +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> +  enabled and the driver is using NAPI. This hidden configuration is
> +  selected automatically by busy-poll support and by drivers that need
> +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> +  use deferred timestamp conversion must select it so the networking
> +  stack can find the device and call its timestamp callback even when
> +  busy polling is disabled. The struct contains also two other fields,
> +  but they are reserved and undefined.

Just take napi_id from under CONFIG_NET_RX_BUSY_POLL instead of
complicating everyone's lives.
-- 
pw-bot: cr
