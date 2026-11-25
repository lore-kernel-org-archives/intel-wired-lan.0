Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2779606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6/66gNDX;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=H1jv1D1a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4C2F608B2;
	Wed, 25 Nov 2026 18:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFkexiZk1f8l; Wed, 25 Nov 2026 18:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31C1060776
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795631516;
	b=sT4aEBjlcAbdXn5VuCYmVP/pfc1hv50UANP0uxxW19L6Q4hLjRl9BEBabmpsqwA5xk9I
	 e5uV3cJD/bwCwlVSfeLH1r4gRujmguIEBMnMSiPFnhVpxeVlGHqmggxWtNlSxb/nqXzjw
	 T2faegLbpae2rNaQoefFaORDeFm3GVc2paRgM+riUBvWLYrS/BKlat6FNWamO6rPdyRmU
	 T4RRPw6jOE0QDV4rxRJIa4vJUIKoJywczCX+f9G86/y5stXdKBdvfU12PBHO85F4dO4RA
	 t9eX4wWeH0zdHY9M+32Mf68bl9TVGRcgb0vHKMQsg5E9Nqx0sWFmbSW6zqCAJ0nmIUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795631516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
	b=KcY5ofRY1pE24KOQ9pr2L+2yf8OK+ZzGd2PWDO4NOpxN81qRj3PuZQwkCyFrhB0xbxx3
	 Om4kUb0ZUwQSjBxPltA+hn2H/95JQRpBl0HX2DXZUtYyjUoKMiKDitGiXVO8c8x5FPvwY
	 2b5+ILg99A3z3kmYCQ18TmrQ04wRmnzZH6Kceo0Q/ZWaGD4gale37YGoNdqxlyDCKrbWv
	 OE4fTDcPqfEefa0yVIAp6sStt84obnhMoia2gFMZAKyVWzavGeaMbnSNpwRp5Y6uUYBoP
	 h1pC2+MfMRwFjoskX1WFwQ9MhmD6W0NfK9/QmUOncfDBg624jcNyE7cizGWzKkugBdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=H1jv1D1a;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795631516;
	bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6/66gNDXIdhqI7dOoJdPClT0Vv7Rt2R0UftRrl/BwTPyg8ZAozGfRN8fOk9eFhR9a
	 rW2uPap+oD6TTYI38UpS6WeUDj9l7i/A0/ieJupsYiuGTrxMsbEZt2/gkVAgkLzYZ7
	 5HPcP0yqcvTPfv98qUpG7euDE8ls8V/z/hkhddv7lAjwW9oVTASO2cD/3Uk5QIdJrB
	 xiCur9qhfrVA8FlCqZrOXayNH4wrXhvQyw/LB9AePRawLHG9HJJpCgGbvLhe+7RaoB
	 6354pgPBAqAO+puKb4kO3oIHpXcMLU36SS6Y//TBfrffXBEYpwKv7gd+e65bWfsymp
	 3sRgDn8kVVzsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31C1060776;
	Wed, 25 Nov 2026 18:31:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A66926D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E484360776
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sdxe6Qq5uQTS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 18:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F07D60755
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=H1jv1D1a
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F07D60755
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:31:53 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c516a1623d0so633431766b.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795631512; x=1796236312;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
 b=H1jv1D1a1JxeLUeFVTYHs1toChO6mWUFpVDOPzeWeYYTfXY8dvuqreqcG2Q1ViaDtJ
 u1vPWWelpoKqEneGrEIWYlx+5DzxuY+xw1JvhOUjFhq3lq/qEMXX1YyOPwc/XMuULE+T
 g1U6K0yXwoyxZRD1fpuaWfka/I5pnbxyNiiGmSmTnI8W9HSxDIeXTD9GFDrWesM73nj0
 tovo4jYG1+iEwUOUhqXeH2oZo8I9tLg70IMlhUj+BfepklICVZmDohCBi2pLB2rwUuJa
 EHymsLxQFp923PUsZfryFnJe2vkhNUfRQspxQZQlJ4B6sFGKPXHFf+SRwsL2z4OZ+rCM
 O8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631512; x=1796236312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
 b=RGvRUGFvgsm3FU2Fpq0dLxNp0lQUhHjLCHdIdLUWWtoIujn0nMYq3we8BTtpAwWjsx
 iax86mbwgAFanBq2anon2V/fNcegLVEkgHD01S9zMEb1z0csauqPYPdHTdLHzpjd9zrO
 SgFZdF39WjX21PuZtpjjREHJiav+AoKLsxp2r1EO+5ZkHOhrjW/Usrv3EoUADIdiiiR8
 cZrc7FBPm69hpdhf1JZAnFdjc4kGYkGfTIxWDA8f40Lncty/aON9x3jkvSbxS8XXsB4U
 DEtHthyAEj+iBvGzlawi4FObn4jRAr9ZLXUcHtB5o0fZgfKaCqQi9msONBsFDHCHxj+m
 irkA==
X-Forwarded-Encrypted: i=1;
 AL+hErESrhtHu1r5LnwqmE+XiuxJGWUQTdfeP8UyYN5ddvyXH92GVE4KK5u8tEjN5gJO4fw/8OVBa/Xo0g/d20QlnE4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8RGMJP+/nm30EKDX0cCNlpgQnvzkl2sXjzgF3xj/qppj/d3jCa
 PapwKn+cKM+786cvMnooRDw+D5Dwi58lIl0VVYN0qmK8Cs+XWb0YJ2zqcXbKT2eWEv4=
X-Gm-Gg: AZFdTZeF5Riz0y2sE3oDILfLqeKlEDaoWtYlaBFD7b3HCpNuY96UsruvIb24a7nquZe
 6CgvNLBesSlOE1TEqnFTLdBfb6HmbmTFdiPeOmv34ME+8rfHRI6uVxT5nc4zp33KffoOGe4NxH3
 B/fmejQRB1vdEJf39Iu7Ms18BJ+Q4mzx6KOA1po640yV4q67jsv4KnBuXP+qn/RsZjNJI16whfl
 o+XdRmnT22FSW9FAujd89Qj4qCZ10gvTjA1d7K1mWxhdBvp3MG1al9MUBUFZMvlwnPGBhnIPvcf
 bMhlfirFA2MV/hSNyELDv4guLavnRLwabOrESsXPo1/vVWfkFW1msjC9mVS36IRium7uusJhaiL
 ukMb/Elp6JIvjV+reW8dvornTIoZxFDS2tNE5Fzw4b3sy7hFX1Ki3dF5Cw537pZbtf681SNt7FH
 iWv+4Jh4jMmXh9WAnrRl39E1LSGZ0O5CyE66hgZqzOH4LHbxuxScCA1bkounbgAkm1Ig+ZCBeS5
 M1AjJTwm1WqZTFbDZXPst+aS46HsbWnhTXR+D6mh9wyFQxL0+5GIBzzvNG9jR++0MeKFI+W94am
 Kf98Yu/VtVu2aEivwA2pNSj5/BF1sQVWTST6RzXGeEL97sE=
X-Received: by 2002:a17:907:a88f:b0:c46:d493:501a with SMTP id
 a640c23a62f3a-c513a8410d9mr1669468866b.22.1795631511890; 
 Wed, 25 Nov 2026 10:31:51 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afe01a0sm686554566b.68.2026.11.25.10.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 10:31:51 -0800 (PST)
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
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 18:31:33 +0000
Message-ID: <20261125183134.25863-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
References: <20261125095201.98279-1-tianyi@cloudflare.com>
 <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the reviews and the ack, Olek, Przemek and Alex.

Also adding back Maciej's ack, as Przemek suggested:

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

On Wed, 2026-11-25 at 09:11 -0800, Alexander Duyck wrote:
> I would rank it up there with the e1000e jumbo frames packet
> truncation issue/fix from back in the day
> (CVE-2009-4536/CVE-2009-1385).

Thank you for the pointer. It is interesting to see how it was exploited
back then.

As you said, this case needs an XDP program that changes the packet and
still returns XDP_PASS. So far I have not noticed a way that it can be
stacked with other bugs, but I will keep it in mind.

Thanks,
Tianyi
