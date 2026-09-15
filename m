Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E9DC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8F55809C4;
	Tue, 15 Sep 2026 18:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmXjhvvfOT9d; Tue, 15 Sep 2026 18:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 536A2809C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789497580;
	b=fLBPvAB83puHpuOxjo2Sm4ZY8Nzf0jqY7EYk5DFrGXhP10UT/4mXUv/vEuDVA5f7/LPs
	 2SSPXzuLBfNuy28FUTEvGCICS7HfU2BOrT6PT34MDWExKgEY/3fWZapBnCgs4UNXt7IW5
	 7A4CKBdZwa0aUo1xEB8HHb86Hp8Hnn8nRUpOQUx1PQxfGxDacJN2ZK0jnX/XfX/DIy9F0
	 uzuhve0CALhSJ2Cp7Kixr5dXBQ96EtviePq/M/INnB6DVHy+ZlqvPz5qT6W5ruWBDEd4O
	 sZC1ZyxrPyxSmFYmULKtXdn0ZDfL9KOgDB+8wUUmSyklrpTIqkWrMnPXm7RIm9Yoo9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789497580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GJPdbx3D50uXJoO9DA6FVACvDwK6YiddMGPdvjxQNDI=;
	b=sCvm3A/JKpF51ulQdAQLHjpdFmGKDPOKB8L5bxDXzro5Wz0Or7VJT9AhvHghsI+L1XCk
	 YN/MVzw1E7pPoXjcwKpoIDyLxgD34K2WtvUJHcMqcDvJHWQGVOBW3klpScrM7fUl4iftH
	 zlS+MAsIzetA8IeGaAIp0WGaH2V/aVBgEw41AJctokFkFLo3SvUJFynHcpEwlpYX7/yAu
	 p6OSvyxMJ/7KxXSFC3udN8jtODCbiWyH6iY1XL5zV5lS1Ut/5UiZgoLDdG2FSvedmxM60
	 34TY7CMhqkUQ7salfbLiWxnFwHJCeg4zGSHEBWXvLEgGGePQL+1+BIWv3Biku6/Inxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789497580;
	bh=GJPdbx3D50uXJoO9DA6FVACvDwK6YiddMGPdvjxQNDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pMoTD+2t6G3N54Yfchyi5xy+vAVCUu1aGQ2/IkObdvobdcJjyBpM2Cra9ri+bthIz
	 OCE9fXrxkk3P4YM+pxrTRrLVCWtaKOd/ds2Hsq9C7bV/4x+RWDVmFBVuFyGG6Xdqca
	 kT7MI9txrnKaMnB98IsTotBvNFaiXVfkTEpoV32Drv2rQjxDGCJK0iesRmOWg/xqop
	 rm6OeR4W+Vc2VZ1EPpoICH3g1P1oukJEkqalvIKkT1YrCe/T9QkS/SpNqyglRLdeVH
	 vI1GXTECU2KhtJL91iqDJpiGABGPgolkS+rJ8WffZ9FqwOAin3Uiq9kWSsZbCTHFOX
	 cbx/yYjzN98pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 536A2809C0;
	Tue, 15 Sep 2026 18:39:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7850DEB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69FEC402BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbJUGADnTi9G for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD788402A5
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789497577;
 b=joodwvmGkXUo+XoHF7IoSWbq+m9h10IJCcXl+3mdvuGzoWt3XxOeYQBZqgbfNMRe1Z+J
 uHvZesKkNCzVT6pyGOI68QuPSlk+1UTAhm/E/8O4umB+MDXnea5olhJARn9SZdM4cjsPQ
 k/xJVfhvLQ8+d1O7U5XTU+HJL1jUEFUxkzgR+sL9HaQSBanKWBvGSmSWNzoPSFeUR+dSK
 mr9boRpm1sIOnFApC2AMlOivwa2q80TTsrNemzKOPEdU7LA4NbyeWsWTxxyoVId9Ltfsd
 CVT0xeCPw4hk6NnE94yxV3tcMAP2n+CKG8dUL4OJeF6lVX9lhVNzMK6NHZGj5+ztA/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789497577;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=GJPdbx3D50uXJoO9DA6FVACvDwK6YiddMGPdvjxQNDI=;
 b=E1/AEbBLJzyNeZA0WOPXF3Jk5+0FIDOqSgODYayrtOHbKijS+Q6KUr3xeaRpNdt91NrB
 YrY7o8kM5BXk3UW+UBiLIH56Vq7xivSrsaHvn/SygpeJVNssfjFkKwsZGnEWxzqFduJWf
 7gHPyXCjWf0i8G18SUXDIsnGR5k13wdpDNXuCa8oNrTTUeoulC7bIpDrPgmVYda8jz5+L
 W3h6SlZZpz1fBOBAGVGLq8JSgq/RK3g9RQLPCVBs3/YuY0RP1jK4RJaTa1pw8hM4Bt422
 IdX/jbRYCWYk3Hh788o61gZGxBPHOsUbMocpSbA6JXhVOOyg/DcrmLu8dZsS46liA3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iOL9B39Y; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iOL9B39Y
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD788402A5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:39:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 628B6600E2;
 Tue, 15 Sep 2026 18:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A81F0089C;
 Tue, 15 Sep 2026 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789497575;
 bh=GJPdbx3D50uXJoO9DA6FVACvDwK6YiddMGPdvjxQNDI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iOL9B39YLpHi8j/xTA9excdhrKO592Vs8pzjMn2WO6qs93YmBgp8kN456Jg5lMCy6
 XJQGOVecXRri/3bcjHRJ3V1TxEOLZnGLdxEXkLCo61bSiTSWlhwLyfpSdI0g6XHGN0
 zfnbSiswF6ZzNw024O4YR4IzccqeFVoDS+eKWav2JzrUR3XY+RCD/1Z1ycqZximCTE
 FGEgiuUWvhoS17iVeOKscTJDytdCI3y1YEfkgwLeB5MYcxUTTV2RL6qSmZ8QgffJ33
 paW7DU7d8WC2zDUgoqcOdITAZn2TffzdgN/2BZFlDYJ2xE6SZwoaQlfH4TZExND7F7
 8sLdcjP8y9Ayw==
Date: Tue, 15 Sep 2026 11:39:34 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, codemender-patching+linux@google.com,
 Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Kanglong Wang <wangkanglong@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Qiang Ma <maqianga@uniontech.com>,
 Randy Dunlap <rdunlap@infradead.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>,
 Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lyude Paul <lyude@redhat.com>, Ashutosh Desai <ashutoshdesai993@gmail.com>,
 Imre Deak <imre.deak@intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, Will Porter <mrwillporter@gmail.com>,
 Cen Zhang <zzzccc427@gmail.com>,
 =?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
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
Subject: Re: [PATCH 01/28] ALSA: ac97: Refactor snd_ac97_get_name() to use
 snprintf()
Message-ID: <202609151134.361FEA04@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-2-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-2-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:18AM +0000, Bill Wendling wrote:
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -1850,10 +1850,12 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name,
>  
>  	pid = look_for_codec_id(snd_ac97_codec_ids, id);
>  	if (pid) {
> -		strlcat(name, " ", maxlen);
> -		strlcat(name, pid->name, maxlen);
> +		int l = strlen(name);
> +
>  		if (pid->mask != 0xffffffff)
> -			sprintf(name + strlen(name), " rev %u", id & ~pid->mask);
> +			snprintf(name + l, maxlen - l, " %s rev %u", pid->name, id & ~pid->mask);
> +		else
> +			snprintf(name + l, maxlen - l, " %s", pid->name);
>  		if (ac97 && pid->patch) {
>  			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
>  			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
> @@ -1861,6 +1863,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name,
>  		}
>  	} else {
>  		int l = strlen(name);
> +
>  		snprintf(name + l, maxlen - l, " id %x", id & 0xff);
>  	}
>  }

I'd rather not open-code the length math here. Can't we use seq_buf()
instead?

-- 
Kees Cook
