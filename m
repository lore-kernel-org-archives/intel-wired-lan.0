Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E29606A33C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=z6i+mkmu;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+s9LNtA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0414A40840;
	Wed, 25 Nov 2026 17:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSv6mpmEzYmk; Wed, 25 Nov 2026 17:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7896240816
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795626748;
	b=VqXmb0VqgotoNgN/Ekj0S0KycMyDR3mpeB1b9KxDZgPoVX3DsTbuRrjjC4/AgL/gBFOq
	 rVCihU7IwVJ+9radrPcSsP5KACHyMxsGOG65G7jHdk8ss+6HIbB2J8+YcF+0D5qg8gpnq
	 vyYLNU9LGLlO8bQEOEhWUrhhikV2IKnLe7qOvVj7NbGIG6mjTQYmhu9YZ0YWEYoMMKtQ6
	 HCPK4kHsw4qRcppH5bD92F6jg+C3inSlBs7HzikvM+iqS4W3Lg2yAunJURjTEAguG1dxE
	 k6ZCD5de+c+I0b3oE/Pm1mUWTDqvNpojKILF4vKJTYBkwY6Ppmrvsz7FE9u2W7I9p6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795626748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
	b=WWNuFJ0+V/F7XAdvez45P6M6QQOMhVyQVTtkddia11B8z/aEjR4QPvDv265FnB1GchnA
	 iCWMhZgoEYeBS1YYCTVYAwS9DvVevjUnkJu/ldYOcDJPack436iwOCcsf66lF+Qgksb3T
	 qDIjJjWixbdcgPR1sAzYEGBARzXggz5+U52sW2ZZFdA3refrimTOFWPDI4NLyiRt5SMAh
	 JVyF6HhU+aCUIhPY47TUoGCJlp/Jm2s3K3+/Geg3q038FtDlA5mkYTHOPbHaxAJ/3wsTA
	 7Z5doysuqDDCTYj2E24/WgdWRLOeJixxhi7VLHN83PW/YvPW9ZElr20tMF0rymho0Tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795626748;
	bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z6i+mkmuBRz51N5Q6ZSkEsfR8kWq07nYqEhoCayVLOy6hy5eK1XH0G76ZlboiXEU6
	 diDi2IGe8/lt0yhlZMarlwzI/V33ShXyNcFz3JLExCriHfMrPRdJ5iFppEamqMGhS0
	 6FMrlH9vqiJMxQer0dRA0WnwuIb18zs84RvIo4RUKyssqUqRHn/FW+kgi1gHfOyl48
	 0zAOPgMHgThySE5ZoB5rDsUjLYORU5lNudvtFd8A80eKCycvQ81LQa5yjzcE83Ckji
	 KqUqEkgre8Enb71suJX6en4P8L93y7PJgpEkg/yN6S2J3niN8Fp2nhZ8u+8jJ38CPw
	 ojXz22N684I9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7896240816;
	Wed, 25 Nov 2026 17:12:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1FB626D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 17:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D393E80C23
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 17:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_NGfdoGbpAL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 17:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7DA580BF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=d+s9LNtA
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7DA580BF7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 17:12:26 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso5327884f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795626745; x=1796231545; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
 b=d+s9LNtA94cwR26Hs+AcR09YvfxIH82/mU9Ktc2iinD3HW4hilyLkEHbeWbkfTMcwy
 3zLePPJACA7WJanxsM8QTnSx3K87V7GlDgfBw1851PtdEwz7JXJSHLntdP7gXG4PREg/
 9OP3o7xIAqI5WQcMnLqd3+dfasdv/7R25nY+nd6jsAAVT12DNfPAiVOGKLqzMMcZnbBk
 fUiMDZJCsG1uOqaFi7QnmtFVanJb0W9KIkDDcAzwopX6v1QQ+3EuoAJT1zzpk/5IPgkB
 uhepB7OXdzWOixjXQ0g9xwxG5BAUG8nVz6ueFKJQ9uuatXff3WxDckn+8tBcuWy53fYq
 ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626745; x=1796231545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
 b=irhfpaKF1N43Aq29K6cdOEUixvjlF16VrPbslH7677KImBIcNyvBU7PmMXqO1RovgO
 L9mcqwYHA7gGT0ysx9ZB21NAmDm8M9pg0780QF8XU9/GbtUwFmUAWUFW02D78gtvNq89
 lAjx2DLK/zbAIcrst6ux/wfnHU+8Tj8R6ApsXDGsCo13fEqWI3e3brVR0Wi0Y2yMqg/T
 6d5+7XGG0AJQCC/+5d6XDI6pajADE21gaRasJ7aQdZpkFv3pK1aVSFK5HVFo5P8HcVSf
 1C7F4txHc+eHsPbJP1IGbA3eDnnhkWF6CsT3skQPQk7NJd1HRrV9kzguiAeGSNapIXTD
 LiAw==
X-Forwarded-Encrypted: i=1;
 AL+hErFnosHkbB6Ei0ty3H0Pqs35kybTxpPttKbN65amv6d/lsX4bsnoFi3HTh/sddzooR6/FOF+NzdIMpxQTm6wfc0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+Goicd0pxMUBTqSn5NU34uCWDqL2wfuBb6gDqn4BlwRtOqdy/a
 bCipM7UK3nzOvgZg1vCxWIGY9pWdne+y4qhwbnHjX1N013S+QS/Vh93G5MNn0vn0taghOZcT0DU
 gjsxw0FfdctxCAf55rzMGxSsG9CeV/Nw=
X-Gm-Gg: AZFdTZcIuRd0BpUhp/GlP34VxxZNZ8S0HhhZ1LPpAF974hqNpwqHS21vLawXa0lHnbV
 AB+CUTpP7OrATyPp5k0azazNcRZtSSiiwOmJ2q8ylTu+rf73aEDokNxRPuQtXoSUxL0yRMvYdMu
 nhbqsGP3bKZ2/t8iqMbM2QPNmKE5ZfGBqJh02sqECsJ7AjzDIuQgaOi60nGXMPQFnLpUPnBSU9F
 eqLjKci4sxCcOK/0rCsdha2k9bssQwt1Vw2mBkluC67E5SBwlgIMFlSpWQPy/xLSO8w84DnfdBq
 KsKLCB3VHXqahlkxoYJbnl47GAO1bq4xILYWTFRCr2jIHROLnfHcSgZ1KzgyAQQ3PcaSpcsvl50
 uVmwR09O/WA9M055uvAqQqROldjnm3u60zJ53zqShRwtO/+OBTl9XPhsllVPG1JoUif/DddZuE+
 nycIOQY8pd714iPf61DsIsTMyBjrMwy1fgjZ5N+PKsDKelVIPGRFDod2DfI/go3qXqmjBPa7cIz
 mc=
X-Received: by 2002:a05:6000:22c2:b0:4ad:5e91:8fcb with SMTP id
 ffacd0b85a97d-4ad5e918ff5mr40436095f8f.25.1795626744643; Wed, 25 Nov 2026
 09:12:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125095201.98279-1-tianyi@cloudflare.com>
In-Reply-To: <20261125095201.98279-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 09:11:48 -0800
X-Gm-Features: Aa3M54q8-DxDcUDtWvuQUs-FdItJ_4u0pWoknbY5prhGbfAwCOiyuV9WM_nf0wM
Message-ID: <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
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
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, 
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 1:52=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().
>
> On Cloudflare servers, an XDP load balancer removes the encapsulation
> of the packets that it accepts locally. Our production traffic hits
> netdev_rx_csum_fault() all the time.

Thank you for addressing my comments. My biggest concern as this point
is still this opens up potential holes for exploitation. While it
doesn't appear to directly enable an exploit it is one of those things
that can be stacked to allow for someone to take advantage of things.
I would rank it up there with the e1000e jumbo frames packet
truncation issue/fix from back in the day
(CVE-2009-4536/CVE-2009-1385).

I will give this my "Reviewed-by" as there is some level of XDP-based
shooting yourself in the foot required to trigger this. However, that
said my suggestion would be to be very careful stripping headers like
this as it could lead to future exploits.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
