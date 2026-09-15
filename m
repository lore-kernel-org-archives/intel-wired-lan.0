Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78035C88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 15:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 349AB80A53;
	Tue, 15 Sep 2026 15:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1IYNsEMx29F; Tue, 15 Sep 2026 15:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C31380A66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484718;
	b=Sreft213HPOGRpI2YpabEI3Ku2PfV0Z2GBrJ7J5ydxJihhzg/6XeuwWRcaUG6qi+yaGx
	 kncAKi4u2dbUKh65wKIgozYwQMTJp923FuydO2/ZcG7OuFDndpZwjPawd2euQn3QMKWex
	 u01eKqf4Z5kwLR0b7DAz9Fet4guZCT+3ozYLCpvvKMa7ostuGvW0ZCTuIEe+dmCqqDx/o
	 6qxa4P8ZN2AmDvZuSvw6UUi7dF0bVWsDMlP7PrRI/k2YfiegydQU03og3mv1dWUvfIIc6
	 cqK6esO5F7hgajryCRbcniwK1Yr15+fIDltiXefzmRXTr544ELha5COuFHI4wP+SdEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789484718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=92Jyv3r5iRKPp9A+0MWzJBMIdxeAT/qbE/UD5yjhWE0=;
	b=lQADvcpfXeKZRdp02OE0jXDOnLacfeVnuxLIzj8FNf53LoLHPAEQGglE00XNmHUROje3
	 bcuxATqmr3O6TSVhQAouVjRwRzZPaoc44rdiChDx/wm27sn7m1cmhp1IXVm/um9tH5Gk4
	 Rr/+gUqe8RtIsO8DKYnpQZ0wcJzEYId9CrdsodI2rKE2Afou27/9aW8TxW6sChZV2vjZW
	 tXj+MY0R0bGOqjPF7ITg3BRW3t0Ay8I7PE78e2gHsRFnqqAnXi8fJiXc9j75SZs87rYTM
	 XU5Av4MQ+7VzQ+IfuYIeQh4NOSSI1pQx5nV+NYZKFo5U9YC4fqUesyxsZu/KQ/d34+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf5L5wnm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789484718;
	bh=92Jyv3r5iRKPp9A+0MWzJBMIdxeAT/qbE/UD5yjhWE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vBaL2i7x1HkQVtKfISOV5AuJHxiN6eOkBymBXJQcZIcPUaM2heFYS444Uf3eDbI9K
	 u7PjxaCyFtprGa8NbSC+wFFdKjlu+FvrOujBTCgsRWHQ8ihJle9DxrwSi2ckB+lkm8
	 OoJVxpMblnp2qalbl3HxTKaqHuLRbVUdI40tnijTBXO2ZvBn3Pf4jB5yNjbnE721id
	 176tN9w02KUpUn8V8TiqpGKTDjiM9E3kIL7uoD74Rnn06z9LnSTJw/oloUkDuwcPWX
	 E6yk263RKfC7tIhvDa3eg9gsA3SQQVt6QtjOUEJ+O+V9RU7g+scadMPqq0zhSQWqvK
	 F8qOUcSWXLVBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C31380A66;
	Tue, 15 Sep 2026 15:05:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B896CEB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA29280A66
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id by2ULGEhojrM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 15:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9DCB180A53
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789484716;
 b=qGdjT+Rsn2Nv1u//IbeOpzZ/SQQJf2X40Ber3cs4GB/3/eFmuigf1HKBm9Swco+15mfX
 oLMm6xkRkpS05chk3GkxF6VEgXxIaNyF5edYoh/OFQo0kwBpingELkFHRVYN/rUO9Xafp
 rGSLyp4967IuqWWPdtD0oCx+zJOdiV+az5HniNRWTtRsjIZrVfvJOEeXjfTmtln5rNrwS
 flp7Fdb/lXpebqzShb+JN+izzIMeg4LOLEY7ZgdMknksEpCuCkWxE4gRko1+psdm+MSP1
 ez8Bvm1UxVyUgVCsn7hFpH1CqfaZm5KnSIHeNguF0ypkcy2C5Xm8PMbIV+fdkfih05g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484716;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=92Jyv3r5iRKPp9A+0MWzJBMIdxeAT/qbE/UD5yjhWE0=;
 b=g/lidicw1WecOx+hXZlZwpC2JlBbAbp7VZvJRjOCaX74bdshIJyzfpE3RegPmZOn8EnA
 Gd+wUNgAzxiJeMhPfCaB8qdYXlOxdx5UGYjV73axboM1dIw9KKZ9qrp2XxQnKZSPpdQgU
 uUSc8484hNfZ91gi3KIVt+jwOEZABpP7xY97XgqHFUX4atjdf9nOHeaLgbNxniqZZx/E6
 UfUMrEvRJSzj2lFaIxzvkPlIxI75UVAOH1vwpADVbCHh4bEq6ML2wffYuG2VYAFl4P8cs
 zVDbxUYAvqlRw8Mfu2Sdt0GCWOaGuvenQvoG6PU5mWxQxDKy1iGmlJA/t2LZN0WbRxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gf5L5wnm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=robh@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gf5L5wnm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DCB180A53
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:05:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45559602C3;
 Tue, 15 Sep 2026 15:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609DE1F00893;
 Tue, 15 Sep 2026 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789484714;
 bh=92Jyv3r5iRKPp9A+0MWzJBMIdxeAT/qbE/UD5yjhWE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gf5L5wnmtccLwoqcVRv226Jxh21B1B//39SXNk9kc4N8OS1FTlhq9PWO0oO0C2lV5
 /puLCofTcTcdOq9gexMECkzKA3ObUOxFvtdLZex77Bqia2hDmeu6n908Nd0hiX8iF9
 qTYQDbAMbNgjSO8+cNHSBskD1SEuiooBkMWuneDZS5c3lKtRyIRRattmm2nfwDtRhi
 /vDHelzWwxEEbNDJ6m9bDtWIf3Gi0xBkpoRi48jhIlvmxyg1p97zwYUvcCDIpP4GL2
 89RyOdTBK97/VTtSVGn5HnnYF5QSg1YyyyGBUWH6C6xYN7eMiLrpeTG7VTkcG879bb
 BqI5RrgGxycEw==
Date: Tue, 15 Sep 2026 10:05:11 -0500
From: Rob Herring <robh@kernel.org>
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
 Saravana Kannan <saravanak@kernel.org>,
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
 Kees Cook <kees@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>,
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
Subject: Re: [PATCH 10/28] of/fdt: Replace strlcat() with snprintf() in
 early_init_dt_scan_chosen()
Message-ID: <20260915150511.GB1926857-robh@kernel.org>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-11-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-11-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:27AM +0000, Bill Wendling wrote:
> When CONFIG_CMDLINE_EXTEND is enabled, early_init_dt_scan_chosen() uses
> two strlcat() calls to append a space and CONFIG_CMDLINE to the command
> line buffer.
> 
> In preparation for removing the deprecated strlcat() API[1], replace the
> strlcat() calls with a single snprintf() call using the existing string
> length.
> 
> Additionally, check for a NULL initial_boot_params pointer and jump to
> "handle_cmdline" so that CONFIG_CMDLINE handling still occurs without
> dereferencing a NULL FDT pointer in fdt_path_offset().
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Cc: codemender-patching+linux@google.com
> Assisted-by: Assistant:Claude-3.5-Sonnet [editor_update_file, shell_command_run]
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a64afc3ded3d..311021a83f03 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1095,6 +1095,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>  	const void *rng_seed;
>  	const void *fdt = initial_boot_params;
>  
> +	if (!fdt)
> +		goto handle_cmdline;
> +
>  	node = fdt_path_offset(fdt, "/chosen");
>  	if (node < 0)
>  		node = fdt_path_offset(fdt, "/chosen@0");
> @@ -1133,8 +1136,12 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>  	 */
>  #ifdef CONFIG_CMDLINE
>  #if defined(CONFIG_CMDLINE_EXTEND)
> -	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
> -	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +	{

No need for brackets.

> +		size_t len = strlen(cmdline);
> +
> +		if (len < COMMAND_LINE_SIZE)
> +			snprintf(cmdline + len, COMMAND_LINE_SIZE - len, " %s", CONFIG_CMDLINE);
> +	}
>  #elif defined(CONFIG_CMDLINE_FORCE)
>  	strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>  #else
> -- 
> 2.55.0.1032.g73a4cd73de-goog
> 
