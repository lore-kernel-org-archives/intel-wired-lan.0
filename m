Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C8606A31E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mPvqq7os;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=dKYHNGRS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0103780B88;
	Wed, 25 Nov 2026 22:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FoN2TNkiwIn6; Wed, 25 Nov 2026 22:44:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A2B080CB6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795646671;
	b=o6KJUH78prufbfLDEBVAAQbEGkGK+RepTrexk7thCbsErwQnwGWN1s6T1baGSooRSz0n
	 Vgwr8weMFPgur/GHWaVw9NaqawhcrEWo+4eeNDHSLTFT37PqjbF/g0H8XZb6RQLd+Myrc
	 KAH1TgiIvP/1PDqaKNz4TCWRm1TJ0Krxovw0kOtPSOKLmsBUwF46HaC/ElQKeuH64UpgW
	 7ZpgWDeZd+6/F8lYG9HvXAoSH3q0qW58MPqU+z25tb8fa3bH64naVAMLY/keCk5G7aD9w
	 zwguXyTDbpDZ1+mWs15SP4/yjM7ybY8mWi6zRc8jh1r8Z+YqWI6dM5Iluras20kxPbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795646671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
	b=tFOmJm+/alIEwraVjF/i6p8ofQsBPl3SPyanAcB4wzSBUO3dstoYLlQdNKlxV+UrDcbD
	 MkB0Gfjh3/bsxdkWHL5eX/1XmtfjTadP+mNYiPHgzY3rmhUITnDtMNblVeP46ig0HezjY
	 XPYfrG6952TLxjE3uMxPWUMHHh5CGeeelJoS/lucZ4Gc+1cppXt6JcLP0BoKgqeqLHOFN
	 u7jowpYzsf4YlIGsv6IR5Rxr/sPXXE1WppIU5NinAztslzfwOLFWimJbg0Xb9sYMfsBbB
	 1G0WMJa0D+m385S79LIjjg05x5ak2blOpFKDLXDu/WMIKgqksYf/WlQYHJCkS6Oyumg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795646671;
	bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mPvqq7osjm35DZTesKIioWSA9SH9HSV+H6l9vGQu70uusBWlzNvRxsNGL95gY4hGD
	 KBN6/1vVxY52TK44lj83vbNcMntVfebKFs71Eko7dTGGB0oADeIc37oghs6SW+Xs9f
	 xHzlol/4gtdYHPQSSEkCPp1fqGjuA5oNIwOMBYqykmnOK86fRIbjcMUsUFQFPKFhx/
	 KIDhsuiQXJ8hNsn37q1Fz1bZaWKm1V9LOKz7qgOGLWVBQ+vir6Hkaz5yY/m4DgWhzM
	 hqgAyu6LBjKAPeDoio3+pdI1E+tEq3c6v8KsHdBRbZCmVJt6J54lLcUwg0vhO1k3yZ
	 gnC/VT7SrKFLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A2B080CB6;
	Wed, 25 Nov 2026 22:44:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC9A832D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE0764050A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccEYHgjVQyGS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 22:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B38BF40505
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=dKYHNGRS
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B38BF40505
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 22:44:28 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso1211094966b.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795646666; x=1796251466;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
 b=dKYHNGRS2FgU1cmlT17iCj2NtGd1fkj0q+cvotvC0oojfVlIAjF6hQyWmq+tyju8sh
 meShFdLj5MJwbcDQF4pVBVCi6wUC3u5cyw0Vy4cwxufgGw0rj92yUtHqu9SMAPV0cxfV
 ptzmzvibWM7c43okWydjVMpwmfEQwWoqelngHS/mOavPKitqwk2vHwx+VYDKQo21Icbk
 6+S8HIeu47YXitdkXuX5PMxsLl9uVrU2TA5kfZZ5JAZqihsIzwGwJdk942Zii0tCfzod
 KlPQ2O4UF79+RoiuqowNOjGzxtwY9Lqk6qqpsCYhGkRFVh11jTbMTIDWwxDy6Hr4oep4
 nQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795646666; x=1796251466;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
 b=Xaml3cuHDLfLJcnQApz3N8491IIEFVD/tn6rHjPoG62xPNaxxnjl1vs0uRQ704+WNa
 SHXST5XwCbv6tSt5JdHvNZVUQio9kvfPChtwPf3NVYY09YoJ5V6WJxO8YNfoB7wJ/TSb
 OK2uOSqQZr50r2pzpbqvohKNYICv+LF+ajPheDBK0C1D58rZmraJj4o+ozTZ97jOwJ4f
 ppS0dlzhHvXzmGjpGvKxMST7GquYhnDVSD/PMCqce/PXYni5UKTsCZIjMRiroQv8F2Cw
 wxMP+6F8yaSZfONid0gk9Wvi43atI6L3WyQxO1oKhnDg/8Qc3LUd/CTQsslu9EwidMcL
 Pf+w==
X-Forwarded-Encrypted: i=1;
 AL+hErE5HC4/B/HgW8/YJvkJmUgseU4zrS8bTyZFISlZd2rnSYBVbdL6RHK9Y+6o2sxdSy1PjtRNcZ6ZaFhRJJsM4E0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+Ck1hpzJfPI9kutcJapY90hzKZ9B1Gbp3voN2qX30EnlJObBZi
 apu5DY0J5iZzJp4KlMbLh6x7eddiE5BkWJMQwgVYC878gBIM8YqDO/wC5WJv4UjnuZI=
X-Gm-Gg: AZFdTZce0jXYNpm1vs9pqxzg2uxGxNy/iC3tVyrBibTywv3o/U1JQ9LDpMhMtTfZBGM
 b/ronn374BuVyr9IPeDwRKQ8/PwXGfRKaz9V90PPDGf+x2D4emHkmFhvc6/A80Kk8vWx4RV82dT
 XI3LhiB3x92Bva8cxHlHAeKa1BZW8tx38t2SlNYQIkr20KZzuLjdo9ipz93wYzAjgaxU10rUazr
 UKVd3HYAVgQri21kpBi5gRI+nQLOOnUYDYFHFP47/9VvSDN7iowB9+u5bCeFTeL6RBKPTCF3bXU
 lZryPaQNxSkMgK+HxVc9lz2rexJOifcOj8cQOjnd3NbWxnVvbZjBRjMuRbw86A+iSJDuYOjhvHh
 TAdf/H/svUgTU2mStRmJXoYnxAJxq0+/DRGV62CL58WPeEt2DwvDX+vjSoItoPgrmttmVDNnYFh
 oP0W39LyJ2jvu9ZHrDuaegRXAXj7Vb2QlXw/UnZnmHtKFrA7KMiNuV3tgfJte9MKbBaVUA9afxC
 Rv2/AQ9YAk8l5OLymyN86mxRznXoPp2YEcPnvf2aViEPxLHYcnZRo0Djvrcawe0DWhy74Q6IOuU
 PfyzQgJIg3yB3hcofo46Wm4Pteu0nVb4ZbwaUo+sCPzwXMRI5/FBUJ35Fg==
X-Received: by 2002:a17:907:3f18:b0:c46:9711:e30e with SMTP id
 a640c23a62f3a-c5131a1601amr1649414366b.29.1795646666482; 
 Wed, 25 Nov 2026 14:44:26 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.55]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad00232sm717202666b.12.2026.11.25.14.44.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 14:44:25 -0800 (PST)
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
Date: Wed, 25 Nov 2026 22:44:20 +0000
Message-ID: <20261125224421.79289-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
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
 <20261125183125.25801-1-tianyi@cloudflare.com>
 <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
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

On Wed, 2026-11-25 at 14:02 -0800, Alexander Duyck wrote:
> The thing is once you start making modifications to the frame all that
> metadata should probably be thrown out anyway since none of it is
> really valid.

I see what you mean now. Today the kernel does the opposite in both
cases:

- When XDP changes the frame and returns XDP_PASS, the driver still
  reports the RX hints of the old frame.
- When XDP redirects a frame that it did not change, the RX hints are
  lost.

The right time to drop them should be when the frame is modified, not
whether it is redirected. I will look in this direction. Thank you,
this really hits the nail on the head.

> If anything, the path you are taking now with disabling
> CHECKSUM_COMPLETE is the opposite direction of how I would probably go
> about this.

Agreed. Once XDP has the infrastructure to pass an adjusted
CHECKSUM_COMPLETE to the driver, or to simply invalidate it once the
frame is modified, we should bring it back.

> That is why back in the day we had strongly encouraged
> people to use non-zero UDP checksum on their tunnels and had added the
> ability to convert the CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE when
> decapsulating generic UDP tunnels.

Yes, I fully agree, and thanks for the history behind it. I am glad
that UDP over IPv6 requires a non-zero checksum in most cases, and that
ice reports CHECKSUM_NONE for a zero checksum.

Thanks,
Tianyi
