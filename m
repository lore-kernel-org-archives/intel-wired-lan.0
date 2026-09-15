Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1686C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94F8A8086E;
	Tue, 15 Sep 2026 18:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxMEaZjls9Li; Tue, 15 Sep 2026 18:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AAA1A808A9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789495532;
	b=QpiGKEqO13/6IxIC4zvBu32ZlzvpwHOJfW70p3Nu+SyMusmLCZnWQ094MeLtxKTzW9HR
	 IBRMgNtsFEV+ZusHekfB1oGmProAT+MhYZJidzKl3dZx3kWxkpc7Vgt0nGvFidUadpXyF
	 BQXpiVTeErOo8/kfZ5bsho7FxlJWCVJ7X9HD/wZVcPBpwcP/kbQ6kgAuIc5yVEl7/ijXo
	 xvCvGWn8vhw3H+TsSomWm8/9PAJhTtuHfSpv0HZsPYPyf+9CPWv1VIMskkKcl1453IqK7
	 KhdErujn9R3y7XbOAdspaNBCsRi5sK7VWejUyNC6/GeaqYnHsPpYDSlCbhlS55xxNfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789495532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mPeI+6lTU/Y8EitQI5ZfnrfapFmX8wWN22xo6A7UJaE=;
	b=KLURTkvbQ5j0U3UAE0c1FFJHv/I5J8fJiH/OoZCHa+OwI6kL/kXftuzOWcl9gk5jN8F2
	 AEUXBwl8w3qbiI7NCDNs7tFQKQS5CjsjmhPghcsvQYWCrArtGCa8YogU32ujUwJ3Yk2EY
	 SPhdmwWfr9eu6FNbF9Ml0pDsnFkvn2KscD+umzdRpFTwAyr9Dlg8PkMgIYdL0+kz8XXN9
	 NNCUufWh+z+MZpnPN7Ustsn/PuL01+z3T163EGvJQh0ZtoMj4cc5l9jQ0iBhvcOiiOJ/c
	 R8NZCJUPRIigm+BnrnAuiRtVSh8nmDsnuEfGG1uKI6QPFnGe6C/W7rMQxgFO5OkB3Iw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTo4X3Om;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789495532;
	bh=mPeI+6lTU/Y8EitQI5ZfnrfapFmX8wWN22xo6A7UJaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l8aAvf5Fpo5NjqB8mAZzSZ5qlRedXtKZz9nxUAxhoVGdhyjDjfXvaWmgpmWVrkwKq
	 YiUiaDr1hhtRbfq0wDKHuZGEB/uzfZc4RHv3B3G5f7qdiI9KeIq66KKjDwno71mTgb
	 rxWqpkWiAzMhVtyvCLU0PfSXCVVFTLDoIkG7k2NIhamiMkKO8rEpcWgcWxY+lP/8Os
	 OfMTC53V5f3RJbSvazn7D0DLnJ/njB8fQUtxqpVuQbVVFzjTZuepd1mHaJDNVgMdTS
	 BNj+dKbU0TITW3rLih0O9ptJ6Sof9DNhthQDyCJQ2HX9PCSX/iDMyadNeaYR8snBSB
	 urwIfzH62W9zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAA1A808A9;
	Tue, 15 Sep 2026 18:05:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF792E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3432808A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kvGwjODA-57 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D6CB68086E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789495531;
 b=QQIUJ7Nk20SOk4DD6MeGPpozMAYVyoiDYEalY07/1Rp+jIRwAEXfdTGUqp0YZj11XLTu
 0egH4/a9mI7NQp0rHhVq3n6hb2bluckE+xJFKwofugruoYGSzj7ovVEBvPWGwBAHIVFn+
 EyoxluWPhJX3eG3YKwAAlxtgLUvClHwhXxhWJJzFES+lmotA/A8L6WT3RDBgjC6L0841/
 x0NIDABWJs2RYRXnavZjNZFXdYQXXhCRQG0/rwEzirogjWeIJcumxIQzWx89snUBV329g
 h4B0OV+yicNxxpe4O7UsKCn7MVNwJ25Job3hcNkMJSi9Rh+xSsqJIjZx1psyl+fy4lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789495531;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=mPeI+6lTU/Y8EitQI5ZfnrfapFmX8wWN22xo6A7UJaE=;
 b=RQ8DeaaJl7RnycXgVJU4Zwkv56zx8YJYW+ZLm9s3wD2a23hikWR6ZVo6q+LuCvxxDkYZ
 Brup02MFreI/GdJsvJ/Raj4znv27D9/utTv35MgkfTlRaCJ0uB51KtYKPlZqRDiTx6kRQ
 sbZswvqHk8F9l1UWI/O25o6KZP3gFUvnlB6gba212qOtvk8sU/V61r8z3UiITQfxLAv5C
 UqukL5zDWdVv44TvnbBOciFj16fAnzqoMnlyipzsxu1mls1Hp5dADqQUOtX0XC8E1nkbR
 DAlkD8NJUmEccptKdAtYrgjUJjPuFa1n4e4s3CsofKQ4+gKHXKgVxa13sZ5Fnc4os2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jTo4X3Om; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jTo4X3Om
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6CB68086E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:05:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 002F941285;
 Tue, 15 Sep 2026 18:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF23A1F00898;
 Tue, 15 Sep 2026 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789495529;
 bh=mPeI+6lTU/Y8EitQI5ZfnrfapFmX8wWN22xo6A7UJaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jTo4X3Om6pjYJxMpPsXGw742bcwi+fNKt1WirPMCjMB3CN4+QeGCMAad0HowUYo27
 zkPX73/bpXrtYTMe0XsfHOKvy0auvvNyZSnejxr33FwP5Y4EAzd8YeVUzA5p/dgDEw
 5cFlE/iE3GLNGT0ByRP+/biS9WQfT2P4HJ97Jm9P9K/qgKyfL5uH3H46GOijU3awQE
 U05QkDGXb1dMAlMiuCtrF46H69n28W2iJaBayGHH26y3LSBp2/268of5pUNUCjMz6C
 lP5HOIiL9QmsIGugbJJQ+XSzW3eNNY7uy3+IQE3mKC77JsHqvgv78X1PoCadcnYcJG
 U7RPeBeWp4lDg==
Date: Tue, 15 Sep 2026 11:05:29 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
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
 nikitash.mariiaw@gmail.com, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-edac@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org,
 devel@lists.orangefs.org, linux-hardening@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/28] Replace remaining strlcat() call sites with
 snprintf()/seq_buf()
Message-ID: <202609151055.AFC6267@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:17AM +0000, Bill Wendling wrote:
> strlcat() is deprecated: like strcat(), it requires re-scanning the
> destination string from the beginning on every call, which is O(n^2)
> when used to build up a string incrementally, and its truncation
> behavior is easy to get wrong. See:
> 
>   https://github.com/KSPP/linux/issues/370
> 
> This series removes the remaining strlcat() call sites in the tree
> (plus the one inside fortify-string.h's strcat() implementation
> itself), replacing each with snprintf(), scnprintf(), or the seq_buf()
> API, whichever best fits the surrounding code.

Thanks for tackling this!

A few global notes:

- This series almost certainly needs to be sent as separate single
  patches to each subsystem maintainer (rather than a giant CC list).

- As others noted already, we don't want to do anything as just an
  open-coded strlen/sprintf; this doesn't gain us anything. If we can't
  use seq_buf or some other solution, we need to figure out what we _can_
  do for a given use.

- There are some collisions with other in-flight patches, e.g.  Mariia's[1]

- The "Assisted-by:" trailer doesn't need the level of detail you've
  got, which changed recently[2]. Now the desired trailer would just be:
    Assisted-by: LLM

- Please avoid including the Cc list in the email body (above or below
  the "---" line), as it ends up being redundant.

I'll go look through the individual patches...

-Kees

[1] https://lore.kernel.org/all/27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com/
[2] https://git.kernel.org/linus/816d9992d9ed ("coding-assistants: simplify attribution")

-- 
Kees Cook
