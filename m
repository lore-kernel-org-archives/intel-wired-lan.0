Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A49606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bkC1SW3c;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MpwugP4+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA3F880F0E;
	Wed, 25 Nov 2026 18:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8AMidocDBDD; Wed, 25 Nov 2026 18:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A26980DF9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795631494;
	b=b9qa/uscde0x/iZAk2cd8X87OiIWdT46tQyRrKVEnBEY0Vbf9ed9T8wtG2M0tepFzHpE
	 RHq8PihPoVQx+WlENU23pZRAkiGCyNNG7bZtwmSuo3ddx0snkZac6X2zxd/K67FZFeclx
	 +EQiIRivZHDP7tuL5mjpyqC0WC/2NvVXURZz54OEH7pM8w5Pd3dim7LWluYourviKGcti
	 o28DLy/U4xyP/uKYBtPDcncHrchrSPYl4RXlSTl3PsCEZ3Ai4COgMWMxqbopNvWP1T4KA
	 9XrXRpWDumUXdNSnnaijQkrzpKdKZar/sHC8qZgPUDrP5jB02/kZNeYmyvGs7qxxVGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795631494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
	b=DyIKTpSm4axVjbbj0amAj2nW1u7tGZPFDz03TUopV5CV3nvtvtiM4hDVB2M8GpmQZQKC
	 W18kCSLS8wuXmzJkx7BB60r8wBZ5IgehccweualNLcooZQ9Zo/f+RES6KkQ/vnHphjhlG
	 d9YIe9BwGIpqMaYvjFiIlDHWMZA6TsL2OEtfiJ1vOEJOgN79TNyu3Wem9J7m0lfS/8edL
	 5joJd/PNFxBBrtz8Vu2hA0STcxv8z3qo3kASDe/sbYDAEWQ1ZaYbyApLCnflSNwI+tuft
	 4+ZcbjcqWC0fGbFjLvvQ8+UrKTSHipZztNihVxExVhpyIxhawiqs4knzEK+xnjbaCcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795631494;
	bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bkC1SW3cKIoJsAxQh78tomWKX20ayorW6pm7+YGfk8UgYV7n9iNv8W8/9JErsiiRK
	 66JgZe6iqPcT4bAfrI5UNUK6noXqDqIZ14t2pmBkSZOylbpfLgepimkNDuLPGyG2Pa
	 FOhyO14COeINNJ62CxHODdIWB5lnzQJIpNqD8djRoJoiilrdwf7w0HkWH9oN2jvFP8
	 i4BGYCLo84NwzV2nD8du1o6iVbHWT2WZpixIPAx6dqAsDm6rWzWnpbUGAjvGr/c8Ie
	 ep/Nn33c9yhFs2fgyzHVnAeVtZzlkSn8IQYCpLxfkXMg06NnwtEjFOt+qQBx/AylVP
	 J5mwP+2Fl648w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A26980DF9;
	Wed, 25 Nov 2026 18:31:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBA7443
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D173F407FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGx02wvvWBS4 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 18:31:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D615407D1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=MpwugP4+
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D615407D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:31 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so1025201466b.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795631489; x=1796236289;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
 b=MpwugP4+tQDLbUQRTv7xKcVdMiwJBPHSHKnQzgX9BgC26rx3P3mJznO4LAsuT4lbTE
 wXhWrd+dOxt0Qd2olskIx8etGr7PgqZN8KnylhsDCtzYdt7NZVDhKKh1AEfaxL1UIsvq
 53RkDSczleVyukPR4yFKlfrcXQVsiaU9Be/DDzyZwZ9egZZ06Q9MES4NN6a7YaHp/s+S
 Ttu+0p18ZWu+7rEfyBSeqpnB6xsbV38M63FoRhwYn6iYSwQZNBuu+8hnOIVBR2RYoFG5
 HopXxL91Leb1Z9Joof1vZaHmjHfwLYP34obdTd5vfvWZQmDp8H2rg1Oz+K+PWyPUXpZP
 fSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631489; x=1796236289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
 b=lq8yZrOw0rzpr1zYrK+appzGqs57tSrdDzNFmbB+G7tHIWi/SeIr/O40gUARs6uvXm
 O0gSfQ+I68mlbyZ1xet77rlOr8j2kjvH88zA3C+7Bwf3kHj8hqM4OLskcY3ltxFTTX4h
 b54BCFjhz+pFqJuLUwKrR+CCFxG/yRA9Nb1iMyTqJNt/qjjJN1aNMoNiVhUJHiVOsaup
 pJ7UFZbJ5H7PBNWrWy2JXfPpWXhem6Cv3+D0BEcedIvUh35Ki2pKoWmenp1XVtZehbGC
 IqcXwdgAUThPSQxbdBwE0MlwHcHRvH/v5fLw5NMv9WIuU7cYpkjrtbPA5NS+YShMI9P9
 d7cA==
X-Forwarded-Encrypted: i=1;
 AL+hErG5XMfID7aND+kEtlBOPQMQSBpEmcaIaj7pzAfRjJ5Xd96EafMmtF0xvfTkGgCka/M08Fqbj2qhCgD9J9mZrNM=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+UzzzqY5KjnmcALGf/OacZdZOMqlHYGj4Y4LJDjsHv07LMyFvH
 Wk67Qa182raoNP8WmjiHqLQNj7UzC79EnURtycIJdZcMwKpFSWAlXspCRLMs+Jm4kmo=
X-Gm-Gg: AZFdTZcc7fe8G8xSHfC3fx9BcjtSN9GtbLlOabSDtHeu7SxbOUVeThxE1bT/ftxGjkF
 gX3372+15E+uzwBTk2D5xMf429r7CAoanbIEGXuSBE8kJpg6XVST5sohak1qOYP5iIefvEli1sI
 ZKBEiIOumReLGkSEQydBZ5VQiijP2SH3Tp1IIyQySmrVKq8vdqhqjZZXA6mfJQEazFbiIjK2Dl4
 12NEFc3a6l70F13wI3P5CBBij6UqlEbELroaTcoT3gQ62cUg4qjN2mGxqCBfgTZhq4ylmww9QI4
 WYAgp1uRVcHgvxaLFTG+h3tlem/mnVoiEej6AWqT80VRJfdlH3+x4dxWuMUw4Rsm2MT/dIVHinQ
 pJ+10kBus62bcjOyJa9QgovfO81ITQbxNf9cJ2gX0Ss5fHejhT2mT+QX7WfO6bxoLIVxWEEIqIT
 Opqd4G+6zeh3YWdbTks+ln6btN+/IhvgQdjQ4rmDYGMvLmSMUiqvs0VeBTuu1PrF8OH8rszLy4C
 1dbEE3K018mnyXUb2fiqxx+V1lEilZZjeErCht2SUqNar0+l94wAKhfA5Tql9FjsniZKnp05P8z
 Hl1aGLSYf2ILNom0vmdKsALZXBse/ctgpZrZAIpj1PCPInU=
X-Received: by 2002:a05:6402:e05:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6ba37e890fcmr14784410a12.26.1795631489325; 
 Wed, 25 Nov 2026 10:31:29 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba9b131d3bsm5877128a12.34.2026.11.25.10.31.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 10:31:28 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 18:31:23 +0000
Message-ID: <20261125183125.25801-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
 <20261125090732.69233-1-tianyi@cloudflare.com>
 <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-25 at 08:32 -0800, Alexander Duyck wrote:
> Realistically speaking there is an easy solution to this in the
> program itself. It would be to look at using something like the
> REDIRECT action instead of just stripping the tunnels and passing it
> back to the original interface. It would then take the frame and stop
> processing the remaining descriptor data. As it stands that would be
> the more correct solution as you could then just redirect it to the
> tunnel interface I assume you have stacked on top of it and have it
> receive the frame instead of having received it at the interface that
> just head the header stripped.
>
> It would also match up better with how the stack would actually expect
> this to work if you didn't have the XDP program in place.

That is exactly what we are trying to do. Our traffic will be
redirected anyway, to a cpumap for load balancing. We tried to keep the
RX metadata across the redirect autonomously in [2], but this has been
strongly opposed so far [5][6].

[2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/
[5] https://lore.kernel.org/all/20261117161856.6f6c2ce9@kernel.org/
[6] https://lore.kernel.org/all/20250716142015.0b309c71@kernel.org/

Thanks,
Tianyi
