Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8808EC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 19:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 461CE404F4;
	Tue, 15 Sep 2026 19:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmoz0UHN2rDL; Tue, 15 Sep 2026 19:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 96A20404EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789498823;
	b=ec3CDuZ3dJtNwxpZ1PDUZYOTff1NE8duCHR/jpQey/aSSohDJOMOatYHskaC9z0895Cm
	 D9iGgJ6IRi7bvwJ8Flcbk7NaVTlim8naTtHMYHHfw4Fq1/GoQtU275qu1UtIMsWPUTlL0
	 pbPp0/ZQNY8GctiKhQ/jKLagrra5rfREv5St0D7mkAv1DNeDRZExWD9XsQu/SA4C73Hyt
	 t7k8Eao8ag+KsIsllrsVf1nnLxjOWsFWKeIHb/pFbmxNVEi3ewFkLQQ9SGXyELaApdmna
	 fWAclo679Yz0gGcPX/6sHG+2Rlk5rRReqy6tDJkBBpU0XTAGrwfOA16YZw347QS1ziw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789498823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bH9D6fx46WAVM8PGx4wEKkSYBjKGmw5AvziupNUvWGk=;
	b=LZAp7V7KXE6izqE7FN3u9GTHN3ZTjb3ipLS9U4zH/KER8Z4KQkUDOEDhlAVTkb7Cj/gO
	 wyO8p/V+GIi5jjGzIn367E+EwsIIu/uKqdSLOQ2rdVboXGOvmKHDeyRU+9ckt8LTnzLPZ
	 GYapiNlHnTuvPQxXASw3egcIPl0CkoaB6E60ueXeCoKDNmYqZatEfPTwlvZqu2nFYnVHh
	 jq3+jmCZV7LrtZ053+xn+XNI2i0VF2aFj3hquVr7sbgb3KoK3xIC0J2giwjAIF4QBqJ2N
	 ui9yuNdW/2B1iW47ZCvkra+dVj0QBNS+nsUtpLgukmmLJCb9fGR2RcbI40Z+ELPqTOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789498823;
	bh=bH9D6fx46WAVM8PGx4wEKkSYBjKGmw5AvziupNUvWGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d134uGPrvjgVMkKlABDTc4F/sYZHWqKnTMF60CYS1N/5skuwTjLSMhjBDB5VE6g1/
	 0btxwWMqPWv8KuZTYnslxTFsqn9xTIEL32jmp3/o09G31jqdSjwcdRb3Dz1m4JCnWQ
	 gXx/C7jPLva54iZtCEPR7Kh/nKp+92uRyV+h55g1trK4qsMkdHFO51EQf/M+B2crE5
	 Pn9POSjH9IdBe3rGO3TUh4rKcOTGxL69J/i4IiqKrMaD6U9WDuELWKIFssMZcDvuoG
	 W/OIA5oV6ERt5ZCBvXORVC4uFmZPbSkxU/bZrEQkn5P+SzwVkRJd3BR1K9NpDhngXU
	 VcbO9f+fjFigw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96A20404EE;
	Tue, 15 Sep 2026 19:00:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A83F62D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E544400F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhpE2heJ2lAJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 19:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B4B7C400C5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789498821;
 b=M5v2R8IIYkRj0CFZ7eE+PX3q03MIQ9YvFsQ3bd6hlKEcGoZAptREibj0Ca5qw0K1is8I
 kW10vRYMLYL14jSi5sjxj53Du5eEe4Qd6GmGfx79AyqoQrApLRXXJ0bLA0dWY6DVpCSzO
 ocaveqI5/BYAwNnpgGw7S+VLm/kPVKxEPHQs2kdFzhK7RAqJ/8HiLWAWEg71YoTCEkWnF
 qw6YQfwCxzJaW1bzYf1l2KlH6iM+2pbV2RSD3IM2jGJgwRFpG0r/qnGi9q/oGbkJD+r1O
 DqPCoJxD2BVahHK7Rghgkiq3ah9sDy7WCRZZqHMxkfJpFuul/XfUu07U0wVmAnhxZ7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789498821;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=bH9D6fx46WAVM8PGx4wEKkSYBjKGmw5AvziupNUvWGk=;
 b=TxolV3LG8rbRMWx9W5Juph7WNcgA8jbrVWh94IoZyBcuHWnD6b2xRmRbVpBkpbBUewPU
 c6YbwHfV+wtCG5dsAgEGF5DWHxtSzcX5Cofv4QzM0N3xrsMNJmbQ8+YMb0wxANJiNEsD4
 PLFkLlMgtjlcRvqxwkts3N402Es40Qou7KYMKi71Uxsxxpmz886K2wizFeAjx7VlVr4UI
 gEVwQa20Jmcq9elk3+EyKfB+hkHGYkZNYt25I+EXQsVgaZqtYnxM5APGGNzMrtSdK3Kik
 oB1SlV+lJm30eRml4FM7/6eenthwW+WqTcjvPtEZiWY6FUL5oazIy81sO8SW+pv1twA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j0iSBaet; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j0iSBaet
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4B7C400C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:00:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D122602C3;
 Tue, 15 Sep 2026 19:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7C11F00899;
 Tue, 15 Sep 2026 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498819;
 bh=bH9D6fx46WAVM8PGx4wEKkSYBjKGmw5AvziupNUvWGk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=j0iSBaetC/3YCi18xNuSeB+n+7VnOF+QOgAvJx7ktLSNyWzdoyXHzZ/YPBs5rtm+n
 WA6gaCeYDOM7G68qSWfRsHvbbAN1voKYHzwbAYckQsRPEBWlfdZePBmdFPmQ1OMU/N
 sUCxn5+r/cR7FN5oCIcXoHFsLztawdQ7lZ2pVlHqL5qvTKh/9Qqc0Ta8A275Irt74k
 zf/eAGrgknulaZr5ylmpMNiuL5cL1xjelXuos4e0Xj/d9MPGQhh5E4WSCnRmy8X7rs
 HaD3mC4eIWM8qko0PgiUDZhDxobQu7+Yi4Weeos/5iSyNoUm6TMJqr9E5mfS6sKjxo
 y4BshIH81fNpw==
Date: Tue, 15 Sep 2026 12:00:19 -0700
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
Subject: Re: [PATCH 03/28] ARM: atags: Replace strlcat() with snprintf() for
 cmdline extend
Message-ID: <202609151155.CC22827@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-4-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-4-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:20AM +0000, Bill Wendling wrote:
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -121,9 +121,10 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
>  static int __init parse_tag_cmdline(const struct tag *tag)
>  {
>  #if defined(CONFIG_CMDLINE_EXTEND)
> -	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
> -	strlcat(default_command_line, tag->u.cmdline.cmdline,
> -		COMMAND_LINE_SIZE);
> +	size_t len = strlen(default_command_line);
> +
> +	snprintf(default_command_line + len, COMMAND_LINE_SIZE - len,
> +		 " %s", tag->u.cmdline.cmdline);
>  #elif defined(CONFIG_CMDLINE_FORCE)
>  	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
>  #else

It's pretty clear we have a pattern of "simple append" that is needed,
and while strlcat() does that, it's horrible. I feel like we need an
appending scnprintf(), and it needs to return like strscpy() does (i.e.
-E2BIG on truncation).

My goal would be:

- don't open-code string length math
- never leave the destination unterminated
- allow for format strings
- yes/no return indication for "did this truncate?"

Initializing a whole seq_buf struct for these small cases is too much
overhead...

For both cases (small without seq_buf, large with seq_buf), it is also
frequently needed to know the resulting strlen. seq_buf doesn't do this
right today, and a strscpy-style return value also doesn't tell us. :(

-- 
Kees Cook
