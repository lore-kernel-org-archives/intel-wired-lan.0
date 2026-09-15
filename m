Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C08EC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 10:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCF7040583;
	Tue, 15 Sep 2026 10:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-uw98erHxCc; Tue, 15 Sep 2026 10:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BF6A14057E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789467459;
	b=kRCVN6BzY0AtkuHR+0gydI8Pww+hBolEil8h1bml9fLxQm4Gt5r9oMBWSOjVZ1x/uz20
	 rwBD0gzBN8Vvgo728YzMb3WagXoGcRCIK4wjLGYCtirOlQxl+EDzkO1071XgnoLKUIbCX
	 gQa5eGSiNaWwxM2kULhFrDTy2wX+RzA8uqErD/Wz1rfRZ21pm7QoF2YX54ZFqYpknk9Ms
	 ju1pgcUKAbIjdkhyEopiRlL0YxLuTf4WqhGcnB0aUQrowN0smyREeDdkPLqLepH/kR3qO
	 GR4Rvg6qhnXE+fOzwrujTZEWZeDIPMGqBlYfR0H48knOphVYW4gwygdyffTzD52y8mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789467459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HyDScdwCUnZ6enJgBgFDn7eANm9IMu9XwvWhbn13gM8=;
	b=LBL67Y8dLP/jxlyoOZg4/F8gtAvXhiEkNHm1COZGfMES/9iBdKEfjQmbrF9EOW37Wtlr
	 +Eas4r9CafsgRmkG+wk+v7PqanGrh67ZF0Zv+ar40+izfTocq4MGHWs8Vs7wfNbBEx3SG
	 cbjeOrq5u8bWRStkobnFQIEsf3lG84eXqrW+48wBR4HKdcMxmbiFURfPBKtX6UqN7iJPZ
	 5BidllD32mhc2kGVkx6oTD4S9aPa3t//KvUAIwPeI0edCE/CjkKroQFKvY8IcFjcz+Vlb
	 yQbxztzqx0JT7t+fshwgRNQhipIDvvuSwVYwkAsxpax8DzGtqIHMcKF28qWkQVcL6FQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789467459;
	bh=HyDScdwCUnZ6enJgBgFDn7eANm9IMu9XwvWhbn13gM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ws1t+6hYXzOY+xEzL+PQ1GnkGonh2XDuwg/4U4n7gBwnYZcQQ3fEQfu4+dXUWvpB7
	 2RhCGnVoBnhXBt6X7skw5bcPPmQ5cCRN+Rrgdktm7SAY+wUZsLCcce67baF66BfrUV
	 u5jnqpUVxVU58uBoZ8HxMIwfNd3BwlP2QqUDDvjapVr4r5tUwTdk/AlXGj5zKMt1HI
	 Kll2J1Tx+yrDsJ5HagsTEICGWPlbxYuGezlFFmCCg7Qc/nihwnBYhAupUgTpT/t45N
	 slQ56/O01beQFOxkAqNDG1TP2Mtx+ACdoxVXDlXCU29lQ4Io0PSwPhorYTbtSUiEmS
	 YYkpG7TSnAmcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF6A14057E;
	Tue, 15 Sep 2026 10:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA929259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC4A360731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfvy6JaP2cKD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 10:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9CB7F605EF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789467457;
 b=hHVGOws9S7SvGsnKcz08wWlxut1otTPDZWB0fqI60gwhmFPb0RlWHqVvMM8s8x7Tu/Eb
 VTHCxvgb4hhvmuanRw5UHBcVJWMCzg3+2wztKq7AkiXe/PVK1kNFV2iXMIlEVua0z+443
 XOwyPQTyRtQ6B5B0djvENoiCnMLlmp1UHX9/pfzHH3O5w7WIkKHD5H1tON2mGiexFeDj7
 KeXaMlyEMWoTOoBtRjwno/yP/jPBlJZ7/2VgSfKeBV9POsulznr9YJEkOSYIG9sgKTgRB
 SdnQyyBOmm+7mu/DPMpvB+zOx3hOMi9Erw298F2cpSEjeHar1KPc07pVbrnoMGu/T0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789467457;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=HyDScdwCUnZ6enJgBgFDn7eANm9IMu9XwvWhbn13gM8=;
 b=lmWGw+se1NS632xdQ5zOHdT8CblIhjCU4uQngTacVqwdQDHKR+ckJatVQyXdtF9lFkyl
 zkll95CTk6hzw6QfuUPDRhWV6bWnxeTBMEzDvT3EQTv2NbEPcGd/b/cAuJU/0pbqRG6qg
 OfZ1h9NXpYVOKRk1M7U7fU2ZCs5XWN1yvh7feiy+wXW7VdreIWDhKCyQDfvUzhzRacuCA
 2h02dfRkmcQlUJcw8sojrSEbmPB3h34T90eHThKoV3XENxaLTBn1NJmUqtQbmGPxTpdnB
 x5E0oYkSJmmy+Lk9yXIsSdGJz6aqfbFhtexWELDo4RIc179h+MyPhs5rtSMDx9V1SjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EmlXJTu5; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=jlayton@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EmlXJTu5
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CB7F605EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:17:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DD3D6025F;
 Tue, 15 Sep 2026 10:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06521F000FF;
 Tue, 15 Sep 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789467454;
 bh=HyDScdwCUnZ6enJgBgFDn7eANm9IMu9XwvWhbn13gM8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EmlXJTu5VbhJ7/WBqBdUKhfW0RYldQ+P4RsoXoiLYeYBAjdlVTQ6GyoH+XTkgQI2S
 WHQZbEdSrmH7QSqlPxuEctAsY2uMqY2BrHi/SCAdbUiWL8AUnsGcpzYgMZOSTw1DsO
 o/4EhLlu0B8UUVBMFP/3cy+fQYlxbzkEsXqCF1a5D20wSvtOe8Sdwwly6fSrwVIaA1
 tSSyvEUOAbcCKIZaCDGrcZinqWae1nLhlDwywEeBeIeB1CGOUPh8JdVOyxQQ4FFkGM
 jY4ArBiG+Y5rmPz5vraDDGwnYrENRcaMfGycxKYMdA1niw7qswA0sKbcAacKqViyjs
 16wfSo0FVH8Vw==
Message-ID: <8a9fe28336742405a5cb02a5c343371f32568fbd.camel@kernel.org>
Subject: Re: [PATCH 02/28] sunrpc: Refactor rpc_sockaddr2uaddr() to use
 snprintf() instead of strlcat()
From: Jeff Layton <jlayton@kernel.org>
To: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Cc: codemender-patching+linux@google.com, Russell King
 <linux@armlinux.org.uk>,  Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer	 <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley"	 <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>,  Thomas Gleixner	 <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Ian Abbott	 <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Tony Luck <tony.luck@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthias Schwarzott
 <zzam@gentoo.org>, Mauro Carvalho Chehab	 <mchehab@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Arend van
 Spriel <arend.vanspriel@broadcom.com>, Rob Herring	 <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter
 Griffin	 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Linus Walleij <linusw@kernel.org>, Anil Gurumurthy
 <anil.gurumurthy@qlogic.com>, Sudarsana Kalluru	
 <sudarsana.kalluru@qlogic.com>, "Martin K. Petersen" <mkp@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Mike Marshall <hubcap@omnibond.com>,  Martin Brandenburg	
 <martin@omnibond.com>, Kees Cook <kees@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>,  Simon Horman <horms@kernel.org>, Chuck Lever
 <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Jaroslav Kysela	 <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Andrew Morton	 <akpm@linux-foundation.org>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>,  Kanglong Wang
 <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Qiang Ma	
 <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, Pengpeng
 Hou	 <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>, Breno Leitao
 <leitao@debian.org>, Thorsten Blum <blum@kernel.org>, Harshit Mogalapalli	
 <harshit.m.mogalapalli@oracle.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>, Ashutosh Desai
 <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, Dmitry
 Baryshkov	 <dmitry.baryshkov@oss.qualcomm.com>, Johan Hovold
 <johan@kernel.org>,  Johannes Berg <johannes.berg@intel.com>, Miri
 Korenblit <miriam.rachel.korenblit@intel.com>, Alexander Stein	
 <alexander.stein@ew.tq-group.com>, Cryolitia PukNgae
 <cryolitia@uniontech.com>,  Jiaming Zhang <r772577952@gmail.com>, Will
 Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?ISO-8859-1?Q?C=E1ssio?= Gabriel	 <cassiogabrielcontato@gmail.com>, Rong
 Zhang <i@rong.moe>, Arun Raghavan	 <arunr@valvesoftware.com>,
 linux-arm-kernel@lists.infradead.org, 	loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-edac@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 	linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, 	intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, 	linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, 	brcm80211-dev-list.pdl@broadcom.com,
 devicetree@vger.kernel.org, 	linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-scsi@vger.kernel.org,
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Date: Tue, 15 Sep 2026 06:17:25 -0400
In-Reply-To: <20260915081910.4142719-3-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-3-morbo@google.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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

On Tue, 2026-09-15 at 08:18 +0000, Bill Wendling wrote:
> rpc_sockaddr2uaddr() formats the IP address into "addrbuf", formats the
> port into a temporary "portbuf" buffer with snprintf(), and then appends
> "portbuf" to "addrbuf" using strlcat().
>=20
> In preparation for removing the deprecated strlcat() API[1], capture the
> length returned by rpc_ntop4() and rpc_ntop6_noscopeid() and format the
> port directly onto the end of "addrbuf" with snprintf(). This eliminates
> the strlcat() call and the temporary "portbuf" buffer.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Cc: codemender-patching+linux@google.com
> Assisted-by: CoPilot:3.5-sonnet [editor_update_file, shell_command_run]
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Matthias Schwarzott <zzam@gentoo.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
> Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
> Cc: "Martin K. Petersen" <mkp@kernel.org>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Chuck Lever <cel@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: NeilBrown <neil@brown.name>
> Cc: Olga Kornievskaia <okorniev@redhat.com>
> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Kanglong Wang <wangkanglong@loongson.cn>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Thorsten Blum <blum@kernel.org>
> Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Cryolitia PukNgae <cryolitia@uniontech.com>
> Cc: Jiaming Zhang <r772577952@gmail.com>
> Cc: Will Porter <mrwillporter@gmail.com>
> Cc: Cen Zhang <zzzccc427@gmail.com>
> Cc: "C=C3=A1ssio Gabriel" <cassiogabrielcontato@gmail.com>
> Cc: Rong Zhang <i@rong.moe>
> Cc: Arun Raghavan <arunr@valvesoftware.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211@lists.linux.dev
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: devel@lists.orangefs.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> ---
>  net/sunrpc/addr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> index 97ff11973c49..a1e4173e5a53 100644
> --- a/net/sunrpc/addr.c
> +++ b/net/sunrpc/addr.c
> @@ -264,18 +264,20 @@ EXPORT_SYMBOL_GPL(rpc_pton);
>   */
>  char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
>  {
> -	char portbuf[RPCBIND_MAXUADDRPLEN];
>  	char addrbuf[RPCBIND_MAXUADDRLEN];
>  	unsigned short port;
> +	size_t len;
> =20
>  	switch (sap->sa_family) {
>  	case AF_INET:
> -		if (rpc_ntop4(sap, addrbuf, sizeof(addrbuf)) =3D=3D 0)
> +		len =3D rpc_ntop4(sap, addrbuf, sizeof(addrbuf));
> +		if (len =3D=3D 0 || len >=3D sizeof(addrbuf))
>  			return NULL;
>  		port =3D ntohs(((struct sockaddr_in *)sap)->sin_port);
>  		break;
>  	case AF_INET6:
> -		if (rpc_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf)) =3D=3D 0)
> +		len =3D rpc_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf));
> +		if (len =3D=3D 0 || len >=3D sizeof(addrbuf))
>  			return NULL;
>  		port =3D ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
>  		break;
> @@ -283,11 +285,8 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap,=
 gfp_t gfp_flags)
>  		return NULL;
>  	}
> =20
> -	if (snprintf(portbuf, sizeof(portbuf),
> -		     ".%u.%u", port >> 8, port & 0xff) >=3D (int)sizeof(portbuf))
> -		return NULL;
> -
> -	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >=3D sizeof(addrbuf))
> +	if (snprintf(addrbuf + len, sizeof(addrbuf) - len,
> +		     ".%u.%u", port >> 8, port & 0xff) >=3D sizeof(addrbuf) - len)
>  		return NULL;
> =20
>  	return kstrdup(addrbuf, gfp_flags);
> @@ -352,3 +351,4 @@ size_t rpc_uaddr2sockaddr(struct net *net, const char=
 *uaddr,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rpc_uaddr2sockaddr);
> +


The last blank line here is not needed. The rest looks fine though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
