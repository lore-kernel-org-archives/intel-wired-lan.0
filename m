Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E772C982C9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 21:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCF7740721;
	Wed, 16 Sep 2026 21:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flWTqNaY4367; Wed, 16 Sep 2026 21:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3D8D2404F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789595063;
	b=KJZypzCmwJ4R6FX4BFT/WVQ0juml7OCj+APcOe5VIdfPdSn8WgfqiA9jhtGkD5qriY+A
	 +PEb8e+aPIBW8TjlrK9R7/c5iJCEzk//D/0geiGWb5BcYanAvjVgSjX9HixpSKA6c+pFr
	 UkrzpB0tZRbV/v+d82eA9XSWSrJZxU1fp8yVNkRjEDl3thIs83KhGYhbhv9LQBFHb9dyc
	 SciFyxAVe+PnWkFh+ZEmcGTUd2x3fSBSdefJ0j1FB9XRz5Knpm+unALLKi2/dh3LtyHxw
	 lwVBDeqCYagC3ecZfKiMtEBrlfK5Oi3hwcvLu5xLWXv4fsYPFYvHj0WomCgGK3hawMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789595063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
	b=S9TxxKMtPz3lC9FobLOKg1LsCbbRqmrS3YaGFYLQN8ZTN9s+V2RczHwY+IfB/uIrQ4U5
	 ONSA1vUui2CE4Ge639GzbJJ5f20Uxds9z9wzQlkJ9tAOECG5PCVZBzchbl33TXYY9ufRr
	 ZncUmxAgJdsvMyZEs63R8ST8liSuANegA86IbUnyR5YTxIntZ18bqVJmBx6HLtgHtnnII
	 bSmcALCLAjM56/dj0USDxf5fWctJILfZGEXWhLeoCW96Vbdnp69mnlrIG3+krkaeBhr5i
	 m7r13gsI7d7d2LHsRIpFnWJZ8Fg4w9svPnypyypMPGMtcrdOKJInRZFW17i3Nv61VQA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789595063;
	bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VDNlsZY5ByRd3WOml7mG6yCtKqTuTIgqlhvGEn6e5OoR4t1sb9FHbB12dqO/6sY9e
	 K2agOu4FQ1xzJ6/W9v5HxkxkQjIdANfoI6KqTBhtyb5eUAq0lTLtmNdgs2OqCDF+3E
	 0dxLG0AVKu6hMU/RHpIKqKclIcWFgxHjdXKOKtyL2hI1I4/Dbj/kRRMslmECuSKhxW
	 guVaUhqvBi+syaZLqnuMKXgGVOxCVQuh3/IfeuNNXd/HUkAuqT+4GwhsGFyqyJTHHh
	 IvM9nNDsydMtnhchl6gCB0igRmmFZ6B3uiylHeo/BE87a6o52khb8HXHZwRc9a5lRN
	 QNq2tmlnG/iuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D8D2404F4;
	Wed, 16 Sep 2026 21:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF1582EB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CF5580E57
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWFoXb0I1SNO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 21:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B11F080E1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:3a::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789595059;
 b=ISu3w2EziDjYuzWrd210DHxH+7dBsgbdScN1j/gEJEAqExUs8/UeSbevtm9sys7HMDNz
 JoHSJzEb0mZCnWnYptYlP+ir7KGBK65Oh0JlUvxuEWtJGNLjaZkeXdf03jgcs4tLuahG5
 nc53k3AvAo/UKWhtwBODOD9ocF9d+TANzPEZMTQcchSfp3u+9bmMIzCkZd3VhiR2/7yNC
 +QwfQHTYG17Q7Pumm3lXRU6kg5MBR5OqyhJOoa0t5vp053mAlnQa/c6OSbGqlD840NFiy
 hzAvAR/lrpOFkBiWf7jB8hk0af774+nnhcmo/RhUjstAE0y/HT0v6B9HRTNCbKtTohg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789595059;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 b=WqLYnVaWnkxD/1Q+BuHpXGHbCM8n8PsEIpsorYyzrJSFV2TTersIr+2S/aEnQ/HuTn09
 jHvp0TsPr7HMWo7D5vt89w5VuZW4E0i5u6be5uz1TqX76DHCskz51B8cZFx8WeLpKKghm
 kThSZ+KaF90mUHphrNvL5iKmsLUmQo77W33Jzk023LjJp5LjdMfGmmIm0cbI7VeMgnyUQ
 B1BLN1J9OIpdyBnpE7O8/3nW6gQsFrUwYfJMhebiXzvtf2plos3sqB65T9E0Auoo6Q+wm
 6uZAx0fWsi5nmzkWBMeiKcJwzNKCAp/W+UPpjoNr9kIzgUPxDgKQNCQZClg78u0GCiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=ZAgK2oQN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:3a::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:3a::d;
 helo=mail-vs2-x0d.google.com; envelope-from=morbo@google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=ZAgK2oQN
Received: from mail-vs2-x0d.google.com (mail-vs2-x0d.google.com
 [IPv6:2a00:1450:4864:3a::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B11F080E1E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 21:44:18 +0000 (UTC)
Received: by mail-vs2-x0d.google.com with SMTP id
 ada2fe7eead31-791a9878aa9so83191137.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789595057; cv=none;
 d=google.com; s=arc-20260327;
 b=oZF6wq5HQJNGfmHOTEWIfTFrHMNo1LJZ45KJIH9K0UBpwc8onIdq074RRaC5kznUj7
 MKID09SctRSPqLUwp/uLKZHI37t2OgpAJOuxn9eUG6AKC0djieb2m1Dq/L71G4Ptadk7
 QlbHsvPJg8EgoCaxbb+eHWcJq5qtkGu/8ilsx5Xp7BHpNsaSyqhbzxlCzAzYlQVNTEnC
 chqOWalSteFkzmwM2ocXsU0O+zkIJ+a1Cg/cqhvcAhE86/CADVQBOwGyVivUwX5qqXAO
 lzPKVDNI7yAiQqHP4eEPmMDhRIZhOvYpPTVIzsXY/LDr4NJzQfeYou0m+9O1zAkCLpvn
 R+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 fh=69HwFgKyAByp7H6eVYT922PbW0G9q672ujLLA5bdW3c=;
 b=l3+ZFsip6H5WQ7w+nX/RWWWouhcpxj4dKaAncdC2qBP5QRLqSaWoZss3taeICGJJ+w
 Jhscvrp44XEBZt4MJDpHjIygOW1+xsOOIaMPL5Kd276lGzaC3dNP5jbX9cXEAjk9dOT1
 Gm4lZluVvPdKNFBu1x7IDdzewv/QPmnCRnjg2JmxVm/b6GWtrCdRRQERltfkt2Z4Z4As
 nRrjB0/SRMqhYvQY3b/KwO5AWc+7pzlmEyVIVpjFL373o456t/Ys4h3bL8RYy5GJ4+jO
 ufSj1zoaw+AHfgoogsTw9D/5tBXpgTmPKRR/Uxb7sn5pHVkaIguS9zX5/qgLxN7AyvGQ
 eloA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789595057; x=1790199857; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 b=ZAgK2oQNNBcL7APQyiPRwLme3uexh8xAagUQkJf/vTazktAcpvgh1v5Fl2o7C0TCt/
 vDaLkOIlPqCIEHhjiPH1gdCqgDzrxIQrgMFlVK5dLVaTmyuuhXnkSG7xJTHTex7tSDhm
 bThPsjfBImWr/R/Xn9MIiMt2vFcO+PAgrZMDR3Hw8sYj2EWaUIrwv5xNV1FLYbqd+EUF
 9szgd0qRoBqE6s1UxTxE4TmfCJOo0gVOZVwedELDRhOa3Yy6C0liZoncz3BPYuBtqghR
 ZuDCsvfywpYcQOJALGikrvZYm3zh5aCOVeKaUtXlhHS2ST9ibXV0rgZWkWPeVPctvRqn
 c5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595057; x=1790199857;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
 b=mDWH3WNSuX6k/RnlK3LlvEuzxNPFD6NZfKhaR5tTFK7AgTfJLo+Y+7z/m/3HuTuxBH
 Q5M4fu1NBKkN5u8y12un5p96mR6ipp1M7N49N2G0KRYSLX4bjcwgoblNhFGrpfp08oIA
 FJv8Fx2lOOw01HJJUZTA5DOFYPff+ZDpgEYef4Dy1hKJvkSrJN3y6+9EZMbgw95boGse
 AldfTsWDP4ySCxona251RoHjWhIKFbiWv02s9t/pKtt5N9HYGbbNxvpjzWxMsj9IxrUM
 bIdBYgqXD14JHK8V5AxCeYmxF2PPvh0t5eroMMjbELUDi/Vrd1K6SiUtOakLR4thBeh2
 ViFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztyDsW7EpUyIZALHC9wNthkJD3vSbc7oHkcyRo9gKdbzkQXZ7w8C7RhCD43/z0ObW6WPRKvW6UrQzWD+Axcmo=@lists.osuosl.org
X-Gm-Message-State: AFuF++nbFeo+WSk17zK8M7Qlx3ZilG4MxPgs5gF5GiHBOFg7ep3sf2mi
 Rm5YxBOn/0utmDc1mx5Lpc/QM8xvUkAVCRwL553z5KfnCFSZp85xoYOQ5SGir2PnvJGnDQKfpAX
 V1BRW6eiygHhhpt4BR4E+BV12DckRNbjToTDEW7s=
X-Gm-Gg: AYBFou1fjsD2H0kTDdr1APcMMTjqrHtbd1nzHdQcMNCs6235K2VYNDw8uAAQmUlUJ/J
 wFKvdY7/Gl61Re0j3fy1s8Jq46Zz96mL6fUoQizONCRyjtyTf37RhFykdvzRtP1n1252ZwKfh4s
 Zc9WAHybSMNWrTL35ZPeD7wsVCVu30nbUYcgpa0ecbJQBugqRFSVFaAgRVdMJf7aqYg+OLUWLtl
 m2u9XfR+YMdI+HetA2Uq5Rg53hVhk45HbEje3T0vWR7VQGSb+RdGKKOQmYTQk0/ZA1jL66gODxg
 a8Z08ld3op9kSTBnrz/NhAzn1wXkU6/EBxbORk+e6AyuWB2BLbI/Cbt/3K1ldT4Iv4X2Y96w3Rr
 6iysu0guAnB5aPkSRvm75
X-Received: by 2002:a05:6102:a85:b0:7a2:2a6b:e7b4 with SMTP id
 ada2fe7eead31-7a22a6be8efmr62586137.2.1789595055938; Wed, 16 Sep 2026
 14:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-26-morbo@google.com>
 <202609151258.5FC01072@keescook>
 <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
In-Reply-To: <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Sep 2026 14:43:59 -0700
X-Gm-Features: AcwNN1XbboPOY3deKY79Gty15vkSErYIT9HTgeQdVXaDzFhBvm8_kiOA449bIqU
Message-ID: <CAGG=3QVZRCJ94+DOfSsSDhsrXVYf-ec01NZBy299nYiCAYfXKg@mail.gmail.com>
Subject: Re: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
 codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
 linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 15, 2026 at 6:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Sep 15, 2026 at 01:00:00PM -0700, Kees Cook wrote:
> > Seems like seq_buf would be better her? But yes, at the very least, thi=
s
> > needs to be scnprintf, not snprintf (or add the checks as you have
> > here).
> >
> > The rest of the seq_buf conversions look right.
>
> This driver has been an orphan for a while now (we just made it official)=
 so
> I'd prefer it if we don't do anything here.
>
I'll remove those changes from future emails.

> And yes, that mega CC list is just gross.
>
Apologies. :-(

-bw
