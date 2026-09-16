Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D78FC982C4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 15:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32EC360829;
	Wed, 16 Sep 2026 15:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bivSAUOkNxyk; Wed, 16 Sep 2026 15:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 658E3607CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789571927;
	b=DlJHroSHtlGmJK0iOGl9Wj2LgPNBRRYW7Hea6dHZW5fXnCzKliJg2HQdV6q1Gga+fzmc
	 GXTsMRvJAMkrVzIDMc5XxoHF48/KJItFmBgYSzckfbJc7Lv8ZoVcHx/L16lFEsETlA8ZA
	 oWdkvMGYxWZ011JtR4RiEtiooLupC+LG6KsDdfW+pPt6/dhO8YrVcAZ9u712wkfUViro4
	 Sx0x7G6FM5X0nwFVmDfLYkGOZLabTTSB6N6j7ZQPnVT6a+cpYXZ/0hZXJwJh+Mg7SmCHK
	 Iqy7crtfgowNDIjarkI4McbYzXuisgyRiIxwHlKGhu/bBGRmysTmOCEkyMcd8CXZ5Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789571927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-Virus-Scanned:Received:DKIM-Signature:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3ZSg2A9Jc3tPW66xvM7m3+dRrVCDgCi9cK4YxnfVb38=;
	b=b1FkhClgCY4YPJHZVg+n34pfVdRM02rRAj6a7iE53TU++dyKaBEAL9vufmTpPSK2kZaz
	 oD6TmDEpFYz2CeDpdzxv9qVOrkyKnWb021f267fybmmx0vj3UcS6tfM4la8bO9Nd6VACL
	 3kRVy2v9183jx0RqOwMgvcekLo2bbKXbt/4Je8KCyCgV179qrJPoWHn7oZJOAnQZ03e2e
	 YWPAG9HMFU/4zZByitOeCfU1j1WJlk1AMdhT67GC3jzGkyxRwbTgegTF4gKPsZZBVBtqQ
	 UDegNXcHd5Rl+maB/E4rPumxzEw56hKtrKsOvtrTktTCtlS8fFWuB4CUi90nVU4Y/yA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789571927;
	bh=3ZSg2A9Jc3tPW66xvM7m3+dRrVCDgCi9cK4YxnfVb38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+AFtJdedI9VOmXiZwkUQzECSRVkKeHXG33octpxr69U1RgBMImGxgA8SL9b1XPWI
	 X2Cm79KXF/sCMIhDQPnZrDztcW5tOrw90o2au6ZdKV2YfgNanZ8g3TyrR1npzvDkhv
	 S9GXFcf6saqKfyHw9eXcKsjXUzd3esDKDtzfEf8SZ5nZg2JT9BHjEyodETXCG8+W/C
	 t8KlBLS3uub2oYXPwfnZ4e4XLGq1EJp/0sQCVVgq/JcEyK5WuDnk2zPm7QoxIeaXNA
	 rcLHnPJF2zbQr9upINwJTBmwmK4zdpRNeCTN4POlYr023lYPWuo0HTOVsmzV1SVlL2
	 yW4UkPTwHxu6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 658E3607CE;
	Wed, 16 Sep 2026 15:18:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 455EA224
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 01:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A30880C1C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 01:21:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5fFpx2cCONg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 01:21:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 45D5E80C1A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789521665;
 b=f8dvDFhAVgYMT4+w/S/x1LRZiB7UCcJeTg0BVlkTFSFQa9Ji50ZIMEQ7XMYBGLIwls0C
 XD40FfgFW5nrUy+iagzeBVjN6D9C39W56vr9SA4Z90dZj818JdkHj5fulmTX2unFwY1mM
 ekACRORJBFGBVRVXzFewNVq6CN4XmzU+EE/y+l9edMJlbG8Unpgi6tpff9NX2AeG5/prf
 f/hDBl1DGjxDHtMm63WZ8l7IYRkcqyzdme3vK4oZRJsBcwK2JOdzzhbvTMwwqx+e0rR6Z
 pLqMvI1EidMXyoa7jGqxgVVJoDJLAfxvr2vCMhw9o+dfWHHD3XK/nDWKJdQrT+yJYaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789521665;
 h=X-Greylist:Received-SPF:Received:X-Virus-Scanned:Received:
 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=3ZSg2A9Jc3tPW66xvM7m3+dRrVCDgCi9cK4YxnfVb38=;
 b=Zgvex62dQI1L6QWLAlu3H6q5oskS3TstJJwk9bEK0jbaAf/7Wxl0HMMUgCUr9D2rXEUK
 Q8xTCqvHHV0bCcnM4hYG38AXrIIia931U9w23JhbE+4QKrr2QDJGueAQNjWrbDw8mnNl3
 kgUC/nsoLwDLP2igdCsLbPk6p4zlATEDI/Blg3EKR4LBqCTzmQPmcSHiY4mf4baG1snjW
 iQcHrR/acvFFiHFI8jD8DNGoTuWOtrjtwj7CFBf5/6QK/q+u+m2gmTMwkZ1+1fmvak6ci
 PTjQUGz6H4jZq71u3+rhya9UP38cPRQsz2Ox+h+0SX8/nBcxrnrIWEURitx8I4FSAuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=alien8.de; 
 dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=alien8 header.b=hnodkwuX; 
 arc=none smtp.remote-ip=65.109.113.108
X-Greylist: delayed 552 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 16 Sep 2026 01:21:05 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=alien8 header.b=hnodkwuX
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=65.109.113.108;
 helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45D5E80C1A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 01:21:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E139440E01F9; 
 Wed, 16 Sep 2026 01:11:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Via_o3Lf8krk; Wed, 16 Sep 2026 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1789521101; bh=3ZSg2A9Jc3tPW66xvM7m3+dRrVCDgCi9cK4YxnfVb38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hnodkwuXLSWfi6qopViNWmJ1DPlBw5Qh3eySg1tCSS2QD436Qt0nPX6UFExBzVDyC
 7SyGGcsWnxzv7hOn9TLSBnJ4ro6jptALPeAa4mABB02U8A8kyDVYgQcRGWluq/fx/T
 EMGtgYR0BJRN0noLxTL7Cqn0kUZN/e7hpblUXONwx5NZPJTHRigWmkF7fbX5MiTlCA
 Ug3X16M/GCzJ2EvHdJ5Au6IDIT+Teyvf2UrAOoXUtxWbGbeGeSpEE7gTOLS6aVWh3O
 QVHdu8R2pS0Kic8RVQoKePhKFLfyptiUBo3kdERUO2eAyR7oGf6dcBxiUoTp1pRM8k
 m/r9x41iu9V1E1kuNZgnm55bT9n6FqBusi5N/v4THEAMC+1O/CgmoqbgmjA7wOtzc6
 W7ZqppfDVVsuffyZT3M74O0p3N7ChLh7uahpi/aocg/EFvFx64JaafjbILfpcHrftc
 VeSWvKyuAw8fZobdLPp2FioEpzYkD4+kshFyvw+tvXaJdvVomypIlYIV9a17prjpSB
 JHHcRnkltsxttm2SQz3HffWQnaJXpVgSEO454rAL+eZ3iP64nohKluW8bKWtFst3Yl
 /vVNOphRdFEgFwxGUoFDnKGfTct3/OisLyDq0AYpAEsYHVrTzhg/UGC8HQSC4ByBBB
 u7UrMRdF4GDpZnl/0v0mduZE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D932740E00B9;
 Wed, 16 Sep 2026 01:09:49 +0000 (UTC)
Date: Tue, 15 Sep 2026 18:09:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
 codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
 =?utf-8?Q?C=C3=A1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
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
Subject: Re: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
Message-ID: <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-26-morbo@google.com>
 <202609151258.5FC01072@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202609151258.5FC01072@keescook>
X-Mailman-Approved-At: Wed, 16 Sep 2026 15:18:46 +0000
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

On Tue, Sep 15, 2026 at 01:00:00PM -0700, Kees Cook wrote:
> Seems like seq_buf would be better her? But yes, at the very least, this
> needs to be scnprintf, not snprintf (or add the checks as you have
> here).
> 
> The rest of the seq_buf conversions look right.

This driver has been an orphan for a while now (we just made it official) so
I'd prefer it if we don't do anything here.

And yes, that mega CC list is just gross.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
