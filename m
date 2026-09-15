Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9CDC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CD8C809A7;
	Tue, 15 Sep 2026 17:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxbKeb0KrpeZ; Tue, 15 Sep 2026 17:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3050680790
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492669;
	b=k/7QbjjWnJFBFzOXGO+dOHql0JU7meB3Tlau0iQycfoTOYSx9vSSxcDIEu2wkzCcGSGx
	 RlG1YpzCVGizb+diKhVopGTc2XTipGvIL3RQ+SOyIxJajQFFNQpYx793oNeyFbEoivURs
	 4870PPFNZnB4Ntm+9rifH2SxE3nk+Q2rz0fmSNJZjlHvLaSfxju5ZHdHrcDvG/uokXAw7
	 /JpjNzoFzS80xhc+DAslvZMWSYAReeXWswF8VswvIvL5D+Zars5aqA1gvW/W/NEFCv3b4
	 kiVKVYEmiK3XYraTMICrKaNpQLfBmA5xWCxWnLh300g4AR/lDBEPNX9v5x4jXalknpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GmOofVahuDrknmhehkkjM5BCV+g3cc9ELbAHUqasD2M=;
	b=nyBLsGL32irKnTreZJ+pxCj5Gj2EbGqodDeBEDCdz56qVHrEwIfsyFAEWPETcicO8CVK
	 f18BSWiI7FSsmw0nLR8bv5KvfEaf3m3MsOutuMJoCuWAAYosJlXlMUF4snbuoNUqu2Blh
	 LaNUSFOT0a+96HvxaKvDgi/iF8yHmXwrTDmACWt6EHNqakuW+8SfjjO90Dy2EKaDEuqT5
	 HO9VpZEO7drEji9/sBoqryrHoMSkEzGJnLUbSpA+APc4E0W0ZCL7AVw5jsQcB0eodmEQZ
	 m31M3ccJTmnAILcxo386GsZyq8hO38d6jPo0zraMjiSB4vAQOKEWjAqfhfNAYD3qnGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492669;
	bh=GmOofVahuDrknmhehkkjM5BCV+g3cc9ELbAHUqasD2M=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKyTVXBKvAz9wXiTvXI9wB8khwmuFzdia8u0sCh1rZPsOrD39xJXeok3uVvaw7PUs
	 wnDwMYXWS+ma578Q/37MYP1NwsT/+oEYgXROXevl7OLKHiwyPuKCiIuKQEov4Qy/l+
	 c/FvuVTpatEA+UlLt1T0jrxy0zSpHfNqR+GNjD47eqh+O/bbmWvKwf2+Nb0UHY9eSl
	 LRLqSaR+cWFmChP+tylBZWX3D8QXV46o3riTm1PSaKLw7qrkNAk3YEZiqmD/inbaGj
	 /P5jbRtJhAfgJGHGFqECfL6dfBplXR7VcFe9md9OHkPyo/zGz8wxDjIVWlx0p3Zp2C
	 SdqPkYXtHDAQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3050680790;
	Tue, 15 Sep 2026 17:17:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9385493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AC45401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30KKjLWZRTye for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6DAA44018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460396;
 b=semzcZV+jLa7duxTg5fEGU14KfPxZr5QUzKirXiHabJR1W3ozoMu5PEDFDCgFfI0E8xI
 8Whd37dVWqoGtHJRBAg8WjsSBLPyUw/MQPcNbYK3s0E4U7lyOH4ZTeW59ozpbPofUKrEv
 zcBJxn0rfjhF6y/U1G4uhk1Evlf9V+dHl1tErRDt4a8iYS31lrviIHHn4KMw2wVumb4bm
 laz8ciGDeCqYlCILCEdMAtR10a30862EE1FSaqu7OYcVmqBea0DggdpjvCK4azuQjgBFd
 TsjLw74RFgJ/G+jx8geUkhISFQCqd0OtkYm6dSaJUSfADRXbpYBMyAMkDxCx4/KG69w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460396;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=GmOofVahuDrknmhehkkjM5BCV+g3cc9ELbAHUqasD2M=;
 b=SZ1a+NvM7LS+u1maKIsMJsrJbK3UDkZf1m2lZKIKKKp+dBROZ6QuC1PqE8CEyFvJgIrZ
 D3f7k84+aRnT/qdwjFGQXY8AUBlUAkBkXTjFTX9CgXW6PoPPNoHFrL9vCmAsII/x115RU
 i8Gnw5/+zCqo/PG/QegXia8qc1cUSebHtpwyB25U39aZSG+IgEWSf/8nrfOqtVGy1Lslj
 4zIMW8QOVZb27eomRIdbeyFo+6LZy7kwbHPArD0UYqwFoQ3/i7AmOq8qAuKaXJYvBax0L
 Pi/KsjVFhOsI4kwx+Le8OVkuNcdLtJlsLxL18z1evi8z0sgH1ZXlHl3rAvECTFW+gsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=nOSQ0G3S; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com;
 envelope-from=3qv-oagukd6kvxakxpxxpun.lxvrwcnu-franm-ujwurbcb.xbdxbu.xap@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=nOSQ0G3S
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DAA44018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so82540095ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460395; x=1790065195; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GmOofVahuDrknmhehkkjM5BCV+g3cc9ELbAHUqasD2M=;
 b=nOSQ0G3S3K6xhnhNkaTiZpcC7L4INgOcWHb34CbH6FQ9zWzKrRDodzC3MAX4GTjiOM
 /flpevrVeVdaY4QvQDQ4MwQqGnyMEUlXUQIjHTxq2jebBvuvSrQC/KCamAsCSSOZLNa/
 eHZuXYmpeRfWtfoSgbvjFsT2RF1icxNnIQ16Kmtblr3pjads/FsJ2gjZMzjdcb395ZaA
 x/y7C8W7j9+6ktufEnR2HhSBk3BAoLyA1E1Yi6YFJBYYleGQufva0DT85H5n+v5EX0M2
 VTNgxYcfyxZokv85gEO6WBlS/WOgvt40W0uRfRd2bSF1PeiRdgwriBOl3a4IocL5Jcht
 91Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460395; x=1790065195;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GmOofVahuDrknmhehkkjM5BCV+g3cc9ELbAHUqasD2M=;
 b=lD1pCwIDNdnhRplCgFtJvQVKUmlLYSTV80G1xi66ncn9FaFqiS/7dMKBOKeUFSqCil
 g4HZZ8MiL4kgfc2fqlTrT1Y59RmzFMfsZkTgh85moyoJCaIIFfRvStzZUpHbpvyV3hIy
 J5g0CQepthdrf4q88ghIsDFK6NB9udCDs2NbArDCZEX9a0A/gGJCoBpc4yEFXq/9B5yR
 8dvPyvMl5OXyaKrTmQIMIfeL6aepOsnKUrEJW6ddNJG/tO2Dsio77bVPPE9SMXp6x+9k
 3Z10A9p2kZf25iXy7x6moMRJB2EBDSC2Z1NijRKm0+9GbsCb8QkssuR7tmjV4VpNkFvT
 3hfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBytCB3o2z8y8sdh2qfu+9nYekawQiuUv4/vjXVpgqB7lPXJWzXi4YgWcjd/ikYHLiblJcwS4EiV9EnJ3I4EoEA=@lists.osuosl.org
X-Gm-Message-State: AFuF++lXhGFYeIXrZ/ZY+vDkg0iHhe8R77zpDdwXMziyxZjOmKaZgB5y
 iCMhTExicp4uTIh9j2IWotWLJUYtElQwHfxbPbGiBPywxygMbvUz9hed9RGBmv/bX6Xagx55ARB
 m
X-Received: from plrq10.prod.google.com ([2002:a17:902:b10a:b0:2dc:ff56:3f4c])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0e:b0:2d9:520c:38e7
 with SMTP id d9443c01a7336-2dd6c5c1330mr107218395ad.1.1789460394736; Tue, 15
 Sep 2026 01:19:54 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:24 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-8-morbo@google.com>
Subject: [PATCH 07/28] scsi: bfa: Use snprintf() in bfa_fcs_fabric_psymb_init()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
 Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Matthias Schwarzott <zzam@gentoo.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
 Kees Cook <kees@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>,
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
 "=?UTF-8?q?C=C3=A1ssio=20Gabriel?=" <cassiogabrielcontato@gmail.com>,
 Rong Zhang <i@rong.moe>, 
 Arun Raghavan <arunr@valvesoftware.com>, linux-arm-kernel@lists.infradead.org, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:37 +0000
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

Similar to bfa_fcs_fabric_nsymb_init(), bfa_fcs_fabric_psymb_init()
builds the port symbolic name using strscpy() and a chain of seven or
eight strlcat() calls.

In preparation for removing the deprecated strlcat() API[1], replace the
chained strscpy() and strlcat() calls with a single snprintf() call.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini-3.5-Pro:20241215 [editor_update_file, make_kernel_build=
_single_file]
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc: "Martin K. Petersen" <mkp@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Simon Horman <horms@kernel.org>
Cc: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Kanglong Wang <wangkanglong@loongson.cn>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Qiang Ma <maqianga@uniontech.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jiaming Zhang <r772577952@gmail.com>
Cc: Will Porter <mrwillporter@gmail.com>
Cc: Cen Zhang <zzzccc427@gmail.com>
Cc: "C=C3=A1ssio Gabriel" <cassiogabrielcontato@gmail.com>
Cc: Rong Zhang <i@rong.moe>
Cc: Arun Raghavan <arunr@valvesoftware.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-input@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: devicetree@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: devel@lists.orangefs.org
Cc: linux-hardening@vger.kernel.org
Cc: linux-sound@vger.kernel.org
---
 drivers/scsi/bfa/bfa_fcs.c | 49 ++++++++++----------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
index 7a4e0e8c7182..9fe0343c0b32 100644
--- a/drivers/scsi/bfa/bfa_fcs.c
+++ b/drivers/scsi/bfa/bfa_fcs.c
@@ -760,49 +760,26 @@ bfa_fcs_fabric_psymb_init(struct bfa_fcs_fabric_s *fa=
bric)
=20
 	bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
=20
-	/* Model name/number */
-	strscpy(port_cfg->sym_name.symname, model,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->sym_name.symname, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-		BFA_SYMNAME_MAXLEN);
-
-	/* Driver Version */
-	strlcat(port_cfg->sym_name.symname, driver_info->version,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->sym_name.symname, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-		BFA_SYMNAME_MAXLEN);
-
-	/* Host machine name */
-	strlcat(port_cfg->sym_name.symname,
-		driver_info->host_machine_name,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->sym_name.symname, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-		BFA_SYMNAME_MAXLEN);
-
 	/*
 	 * Host OS Info :
 	 * If OS Patch Info is not there, do not truncate any bytes from the
 	 * OS name string and instead copy the entire OS info string (64 bytes).
 	 */
 	if (driver_info->host_os_patch[0] =3D=3D '\0') {
-		strlcat(port_cfg->sym_name.symname,
-			driver_info->host_os_name,
-			BFA_SYMNAME_MAXLEN);
-		strlcat(port_cfg->sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
+		snprintf(port_cfg->sym_name.symname, BFA_SYMNAME_MAXLEN,
+			 "%s%s%s%s%s%s%s%s",
+			 model, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->version, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->host_machine_name, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->host_os_name, BFA_FCS_PORT_SYMBNAME_SEPARATOR);
 	} else {
-		strlcat(port_cfg->sym_name.symname,
-			driver_info->host_os_name,
-			BFA_SYMNAME_MAXLEN);
-		strlcat(port_cfg->sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-		/* Append host OS Patch Info */
-		strlcat(port_cfg->sym_name.symname,
-			driver_info->host_os_patch,
-			BFA_SYMNAME_MAXLEN);
+		snprintf(port_cfg->sym_name.symname, BFA_SYMNAME_MAXLEN,
+			 "%s%s%s%s%s%s%s%s%s",
+			 model, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->version, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->host_machine_name, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->host_os_name, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+			 driver_info->host_os_patch);
 	}
=20
 	/* null terminate */
--=20
2.55.0.1032.g73a4cd73de-goog

