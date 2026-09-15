Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F72FC982C5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6999080BF0;
	Tue, 15 Sep 2026 17:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgAeUzhhel8V; Tue, 15 Sep 2026 17:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4DF5880AE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492664;
	b=VERgZWxDGeJWeQGnHyYwVS0M7X0/jHp+JNeSsRUdhVVuTfUtkIr9HWIGkQehuMWylV/5
	 SawhVIH++dtOR77R5e9iS7pqYlmwISlLn7Bxyp8i0BUp29XOMf8R0VfmshuETb2DSqzH8
	 EYbFe7MVa5+ib12hmc5FWcMND0GCeLntqVHZBmA9m7yft4cGkuIrXqNonpUQGKJYnMeOr
	 mRrpXv0IB9giE/66Iq1xzxxaxu4FKe47IYq1MaXqudx9BwAg26oGyoliH6jjlVpKXC5rg
	 DN2PVY6SO8NvS39IBC+G4JYvUfUD5mFAkE8vNITAfb2W8XcVzJ5k1mSvXH/7J7x85gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eIty82Ymjj64Fl6mn4Z3/QHhmY1e0QRFUR4BQSE5AwY=;
	b=CVmDyrI0A4ofbsKxevnyJrM2U8VWyLUlVnhxV6yvGHB7U2lk52ZK0z2Z7ScupynKfOD6
	 YwyAAgZACFxIVQxnoRggVXRJpUGEvY24bF9HNiLuLLvqqOTXpaGCDqItQ/W0mXYIBJYmp
	 j5XSNaBIMMqFAoXHuHgeTCFkDYSFrT/oc4YBGtS5O57shE0B7XiKZJ83y3Tikd2yyRfeQ
	 E1Sf41inM1skljZMi0TEN4DL/B8ZQb3BiiseHLvw0Q2eEy2xQzBaa6DOjnGDA3J0ClpAU
	 09NawUo8SzBwSO9bFxrTh3NPBzmnCHrPUTJAlM/HkW+3jm4a26KyudMX89kUMId5btA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492664;
	bh=eIty82Ymjj64Fl6mn4Z3/QHhmY1e0QRFUR4BQSE5AwY=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZOqmBM6GwfggEsPpKIjYh/E0St6pEEUkHJpaP6xZ6ei/Ruf2I/ug+dJF4DQSnjkF8
	 7ioWU7q6s90Lw66r2Z2Lq/UD5HW+21T44qqwMO4CkOFQYsUp/RGH9nIopxv2tvk40a
	 V0tN5QbWh6dI1HVwDlXMGHZNOBWTUl1vIlHBoNS9Z1Uf24kWR/XJ0rwZrZm9bDXoRD
	 sOaz86tFvOzjs6dNYVq5DIe51zj4mIwVchH5hIVoUb2KWOpCb+jysrNaCgvmd4PgYy
	 yrYfMQriZekdRoqDZ/Q5jTfeqZWj9Qpbg8zhNE3ZTzBwtMG8dNvv1DLuxqGQOIga+3
	 r07Xu2aIWn0eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DF5880AE7;
	Tue, 15 Sep 2026 17:17:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF3DD2E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C167D40402
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_Iz87YRSLky for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98493403A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460395;
 b=CAkQ2hqFcvZQsOOJ2VVK1diAYqL2OXoWCDos5SmvJ5T1ufOQy4kVYbC5L64tJLI5Gxeo
 fXPzq3SnDWNMdAbdpLjc3Mc3DCm8+9QO8BNXvUzEWULAGD/TcrBz2Vo08oiHb+WPIRpxC
 s1Kdhvk7+QalDCddAidEvK87L4NfQaEvQW7MS+XrpTFT0T/NWeleQ4bNsANWzsEJWeS7c
 pZoe+JDPApjZhc1EmjkGNHRE5IaFhEy6XkZrID+VyzlFTmZKiTBLTusLEx9qsFxqzu3B9
 l1YqVZowL5rYBZZTd9XEbBFIPrjPN0tGpy3wnSXjKo0Jm61YMnKK2gR913SpyWFswpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460395;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=eIty82Ymjj64Fl6mn4Z3/QHhmY1e0QRFUR4BQSE5AwY=;
 b=KVvWLfdEfE3HeyV6sKu+xQo68iXQLkywN1usC+k5TiN1qmnLW2RP3wxMyJ7NoEyh2zGX
 kG6AprniA6+vRjaU9YwRLppVwMyQZ50Ujh3Xar1MXL+1UA0z8wz45mZgcxMOtwj5g2zYp
 sSiksiieR5Jmv+SCiCgI0Lz19ZQeWK8czvIRQRf8RjJGeX18zxynWpziKyO6E9oBzI+4i
 myXtCMR6nl2IrS7FkdLI2x6EQ60IMvD9tJMWHJKeahDGOCwtRqN288rYAyocLdFAcQMWc
 0KAFeBMvLDL1L1vnDkE4aDyFMbT4GA93/yVsVPxO0KEqnVq2x/uYJFke38/2bQaiV7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=lKV5t6MR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com;
 envelope-from=3qf-oagukd6guwzjwowwotm.kwuqvbmt-eqzml-tivtqaba.wacwat.wzo@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=lKV5t6MR
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com
 [IPv6:2607:f8b0:4864:20::547])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98493403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so3348261a12.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460394; x=1790065194; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eIty82Ymjj64Fl6mn4Z3/QHhmY1e0QRFUR4BQSE5AwY=;
 b=lKV5t6MRO6I3QbqUFkJUSvtfCelk6WCJWLM62NBRV/3vaMdi3JXUeJzixT4FoyPchq
 P1MDIOXPRp55+397raqFPryLhRJs2D96PKZW6oIKzsm6k/J4ui6EO9vqagnGjU/aBh2J
 9saMti5tOoyAvHeNUG7ro77oifwslIMaMlWVyfnIQmhVdrAVXdFZ5Wt7nkW/5tkKJMKV
 jead8UMzls/wCXMTZzP1JvPgwjz+/pPnUPpsURPjOaVX/jc4AOTvUDYzXjByBB5aOOE7
 NW1DEaSooDBwqza1EbEpcG/hHORgkp51pD9fzEQB8VN+IovuTxWgi24/KoPM+3XRsJu0
 WaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460394; x=1790065194;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eIty82Ymjj64Fl6mn4Z3/QHhmY1e0QRFUR4BQSE5AwY=;
 b=YSCnEMVPu8KtoSFEvKC8lSY8rGnAnRPshTQajnuRE67xQBqVNrowq4HAe/EH1OeZ6H
 +72A+F6Qj4vucH2tgPnrxOvQAzEUERp4ONvM7pRsFNF2Xa4V3WO8w1Lqv+deDR8MEiKW
 4qhR+9ojSha4RxuYggxiRpgu9oW3nU6WwxhWYhUMt31EqTAmxfQP23Cqcg2bhnqv6uCK
 hUFAYdGGFL6qmHTqRA5J5jHu4Q2T+rWBHZT7XPJxWeghqTzuvBFTpT+3G4ZhDuYs2gH4
 nYs/OVABkfA2EzxJ0MbMHb1o0Bkaw/JT/FOi4EUYHZVnvdHb8m+lG1wJ+6dVCnWR2YSO
 7wlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByRNMw88MsfgVx/le/hStV36Xt3MhvRZRHde74hbx6p5x94SF7Kcj9vKrq09cE705JgWreMHpQxf5mlus85p9I=@lists.osuosl.org
X-Gm-Message-State: AFuF++nOzg9BxbOBI7CFZwL7uZdEkTz7JgtkY+/psJtSlEA4f07JIitd
 pnI1VWht83L31uzMIne3hXJKWVCWPoSoYYOFegLeFXjkbXb1F1X5Qzd6ekGbBfWSZiepdvf1roy
 J
X-Received: from pghd13.prod.google.com ([2002:a63:fd0d:0:b0:cc4:37f6:e897])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c7:b0:3d3:ae1f:d7f4
 with SMTP id adf61e73a8af0-3dd528bd7dbmr272615637.20.1789460393063; Tue, 15
 Sep 2026 01:19:53 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:22 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-6-morbo@google.com>
Subject: [PATCH 05/28] ALSA: usb-audio: Refactor usb_audio_make_longname() to
 use seq_buf
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

usb_audio_make_longname() builds card->longname incrementally from the
vendor/manufacturer name, shortname, USB device path, and USB speed using
strscpy(), strlcat(), and manual buffer offset calculations for
usb_make_path().

In preparation for removing the deprecated strlcat() API[1], refactor
usb_audio_make_longname() to use struct seq_buf to track the buffer
position and remaining space across these operations.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini:3.5-pro [git, make, checkpatch]
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
 sound/usb/card.c | 58 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 9307da95efbe..bdca8085fca6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/seq_buf.h>
 #include <linux/ctype.h>
 #include <linux/usb.h>
 #include <linux/moduleparam.h>
@@ -651,7 +652,9 @@ static void usb_audio_make_longname(struct usb_device *=
dev,
 	struct snd_card *card =3D chip->card;
 	const struct usb_audio_device_name *preset;
 	const char *s =3D NULL;
-	int len;
+	struct seq_buf sb;
+	char *buf;
+	size_t size;
=20
 	preset =3D lookup_device_name(chip->usb_id);
=20
@@ -667,44 +670,61 @@ static void usb_audio_make_longname(struct usb_device=
 *dev,
 		s =3D preset->vendor_name;
 	else if (quirk && quirk->vendor_name)
 		s =3D quirk->vendor_name;
-	*card->longname =3D 0;
-	if (s && *s)
-		strscpy(card->longname, s);
-	else if (dev->manufacturer && *dev->manufacturer)
-		strscpy(card->longname, dev->manufacturer);
=20
-	if (*card->longname) {
-		strim(card->longname);
-		if (*card->longname)
-			strlcat(card->longname, " ", sizeof(card->longname));
+	seq_buf_init(&sb, card->longname, sizeof(card->longname));
+
+	if (s && *s)
+		seq_buf_puts(&sb, s);
+	else if (dev->manufacturer && *dev->manufacturer)
+		seq_buf_puts(&sb, dev->manufacturer);
+
+	if (seq_buf_used(&sb)) {
+		char *trimmed;
+
+		seq_buf_str(&sb);
+		trimmed =3D strim(card->longname);
+		if (trimmed !=3D card->longname)
+			memmove(card->longname, trimmed, strlen(trimmed) + 1);
+		sb.len =3D strlen(card->longname);
+		if (sb.len)
+			seq_buf_putc(&sb, ' ');
 	}
=20
-	strlcat(card->longname, card->shortname, sizeof(card->longname));
+	seq_buf_puts(&sb, card->shortname);
=20
-	len =3D strlcat(card->longname, " at ", sizeof(card->longname));
+	seq_buf_puts(&sb, " at ");
=20
-	if (len < sizeof(card->longname))
-		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
+	size =3D seq_buf_get_buf(&sb, &buf);
+	if (size > 0) {
+		int path_len =3D usb_make_path(dev, buf, size);
+
+		if (path_len >=3D 0)
+			seq_buf_commit(&sb, path_len);
+		else
+			seq_buf_set_overflow(&sb);
+	}
=20
 	switch (snd_usb_get_speed(dev)) {
 	case USB_SPEED_LOW:
-		strlcat(card->longname, ", low speed", sizeof(card->longname));
+		seq_buf_puts(&sb, ", low speed");
 		break;
 	case USB_SPEED_FULL:
-		strlcat(card->longname, ", full speed", sizeof(card->longname));
+		seq_buf_puts(&sb, ", full speed");
 		break;
 	case USB_SPEED_HIGH:
-		strlcat(card->longname, ", high speed", sizeof(card->longname));
+		seq_buf_puts(&sb, ", high speed");
 		break;
 	case USB_SPEED_SUPER:
-		strlcat(card->longname, ", super speed", sizeof(card->longname));
+		seq_buf_puts(&sb, ", super speed");
 		break;
 	case USB_SPEED_SUPER_PLUS:
-		strlcat(card->longname, ", super speed plus", sizeof(card->longname));
+		seq_buf_puts(&sb, ", super speed plus");
 		break;
 	default:
 		break;
 	}
+
+	seq_buf_str(&sb);
 }
=20
 static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
--=20
2.55.0.1032.g73a4cd73de-goog

