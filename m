Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D6C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 20:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA6B840575;
	Tue, 15 Sep 2026 20:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_tpQ5xLH7Gk; Tue, 15 Sep 2026 20:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1E636405A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789502408;
	b=BRcJq9jvixYMY/3CbfncpCUsnR8tAfiGazykgCoPbwjQZ0zCbNYfXSTnGRKzJE9i3GuI
	 b8ECQeim12opcL+aBAEuDl56vetr+h0rb01mwsTMveKsBD+O3qZr+/0xoIq436jPJmlZL
	 K6sVAR3QcMaQB4WrEcg+D4eZJN3+b7r+EORBlWoa53hr+DegQTgrsD1k7cFjahlDKwTIJ
	 IwBlEDMKbPxYjUJ+s+n+aMugc85SnQzWP3//XnhF+QzRycfaG1wGcUChDAHS0JaCTq8Z2
	 7RA6/QOF4HxSfwO4KMlXG2IuDVIC8W7rSJ3/4WnKe68al3xtuG08Hu/31VywT0DgZTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789502408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=060FvzlSY1s+NjIuTsRc9Ny+zBNXkBYeefHqKI9hLNs=;
	b=sR35qgTRRn570tlebQ4fhAQQXi1R2MIPtyT4bDx0BM05ZyFYiv62K81TEvKb9HtpNipY
	 /nnE+aVpEt7S23V9VgxJXDh7M4t3rQIsiaJ/sZsEvERNX/uMGcVHTMdOFZubMXyDD3qhX
	 dxDkWP2DTBiVBCenhCSkw8Y2har0wynmRllDBNH+W7iKo9OYsYdWdGH3qwoS9dnR606rk
	 5KSgvHVpo1cZT4rTvlSOowLF1+nDB7Ut43pC5LgB2KaPdSNjVH/Tbr1E7EK0IR9ssL0a7
	 I5OU8hZgSohNUwD8px2bO8OEPpdu+y2q2b2Mf1erj1FNKAESXvfBntHheJB69YKTr5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789502408;
	bh=060FvzlSY1s+NjIuTsRc9Ny+zBNXkBYeefHqKI9hLNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1vjd+2rJfLCpdcouzE9KrTpPwS7p1Dglb7w2ppC6l9VQMm66b3iyvfEmWVLYR6z4
	 U/W9DaoUym6SPiahlEqn+K64DzhjTw3DgbXAsUfGJ/nSMeEn91d7AoFW3dCNisX8+B
	 2Jq5/hKE8XeYRUDpEkyD4+meFlb5rZmgJPNa+JwPVqZm5PyJbTRiy9KPhKUfWhZSSg
	 +vctEcBlCQN1f3adLCQUC1SAMHaWhfQ+CHq38V7AUTUZmoT+KnMCJTusyBefzCd4XO
	 ne7yT8MG4Uyu/OIwU4DWh4hLzctZVpEc3O0uefvcsywXBBt4z1hL9cd//XXtbGeK9f
	 Y2nP0d+uuaXaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E636405A3;
	Tue, 15 Sep 2026 20:00:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2BD3352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D475560757
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ut5uYtmCb0R3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 20:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 40165606CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789502405;
 b=sifP1FGAmqOZ5OTXPBf3ut3pj5ryrnUIPCJmIcjptRC9GXX6u5445Ll7divMJ4Uo/yw1
 e9fqbC/DGQhR25xPeFIKx1/F0ffy+NgnQq3QIETOEk9kufE1QM7aUtjhRNBEbbh1gIt4f
 jIXZlypcgwzY2Fu3J7t2kqZGTfyY6o/jJTY5Xig6RO9I18Vs757cjba+7d8aa+AFJk3nz
 a7ubxZ4KyIoVnAoYnIwJVjNnmZfLoaPkCX+T1mzHU61bxRp4Dv2jY3kuLwnH8vkjIxwl6
 wiSXThORhT2ofnKhyKxZwfsOgDI2ab3FYtD4gE0Ye0gViQlbN7yxkM6TsgsP4X800Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789502405;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=060FvzlSY1s+NjIuTsRc9Ny+zBNXkBYeefHqKI9hLNs=;
 b=TczQCIic73CkneXJjE8942dWLFvGNml0/+66MgCsm0vxESGKgL2+dgsy5XDiMm8cRo5+
 5qKPNRn76zvGGcmJOeEt57q13O+l9WmWC6qkApPgw4w/4Uv55iDsXne8oJJ3BIfTHb5Xs
 ovf+MxNV/RIg7vPyE+A46rVzB8dJvoWbT5Q9aLOx0JbMCrk3BtSh6hVkhcaUe/gPNSZcB
 ZiqeM0sF2w7t1Dn8knSCEbh/BlAYx0pIyE+hSpz2HuKHpPt5o+DM4aF4Ja7DIuq0qWMjX
 sgR8DzANdTI348uvktgzFVvz7LDtOgwNHxFV/D2Hg5XM9egGnzE2nPRgta8EDMfFD1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k7PBojoR; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k7PBojoR
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40165606CE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:00:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2077F43B37;
 Tue, 15 Sep 2026 20:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069581F000FF;
 Tue, 15 Sep 2026 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789502402;
 bh=060FvzlSY1s+NjIuTsRc9Ny+zBNXkBYeefHqKI9hLNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=k7PBojoRGnlYP+7hm1RNQd5WiXBzFE9G/TC6RDJLFlkIfILpDtK/GBadjjEtwmvkI
 VltqHkns7rFQJUs7zOmt6Aou56t41/k1s3vtqxmfTJXB2iTYaoQOZMoaAQLEbiBATM
 QliN/deaZlJIoWJkLmj+D4VvTn5Jx146y3TPh/vvsa/DnZhr9eIjruGktKRmZd1F8W
 d/n8s23s+ioe/dcLrN5uPZzQxe+1Zt37jah6tmmp47xTq2Q8c6opmO/Bh9z6yBVHOy
 7ebwggwCD440EEMlDbbPNOt17kbvHZ9ZDz+ruV708XKWcQk5yesfJHNbhyUtEGTA1U
 d3OVGyDuwb7RA==
Date: Tue, 15 Sep 2026 13:00:00 -0700
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
Subject: Re: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
Message-ID: <202609151258.5FC01072@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-26-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-26-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:42AM +0000, Bill Wendling wrote:
> index e7c335ca0c36..4e3781815b6d 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -20,6 +20,7 @@
>  #include <linux/atomic.h>
>  #include <linux/bitfield.h>
>  #include <linux/circ_buf.h>
> +#include <linux/seq_buf.h>
>  
>  #include <asm/page.h>
>  
> @@ -47,12 +48,17 @@ static void decode_register(char *str, size_t size,
>  {
>  	int ret = 0;
>  
> +	if (size > 0)
> +		str[0] = '\0';
> +
>  	while (descr->type && descr->mask && descr->descr) {
>  		if (reg & descr->mask) {
>  			ret = snprintf(str, size, "\n\t%s, %s",
>  				       descr->type == ERR_CORRECTED ?
>  					 "Corrected" : "Uncorrected",
>  				       descr->descr);
> +			if (ret < 0 || ret >= size)
> +				break;
>  			str += ret;
>  			size -= ret;
>  		}

Seems like seq_buf would be better her? But yes, at the very least, this
needs to be scnprintf, not snprintf (or add the checks as you have
here).

The rest of the seq_buf conversions look right.

-- 
Kees Cook
