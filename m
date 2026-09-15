Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92C8C982C5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F43E80C98;
	Tue, 15 Sep 2026 17:18:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5vfPUCaNjBr; Tue, 15 Sep 2026 17:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CC1180BF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492681;
	b=YLubP5hIxpzsBjbk1sVy7jkXERBWtsE7DJHe2x1fK0OkXyPDo6KM/01LHelja2iu6bRb
	 bOw8FI4gsp5E/oQo2gdnYb9NRbR4Z5GJ+iptTquYVU12UPQaUl1u4mNf41AwT9uJ1VI/Y
	 PaP0Mbsg2e3eQCovanauWlUvEU608JU2h05wWFnSXA4jOktRNLSQhsU/V7GNrAvK/QKr7
	 y1FJcuweg6pUAwQPg2+FDFYgbt51xqhOyo1gMdDPKZftlLVGig+9S2ulHoZ6AoYWcKVyI
	 c1lsczXJhsnmXIOxY2OQZed8EKNYt3NUmCrQxJ1/cYmWXwr4+7eHHkEBLaGmjxaULzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uYw3XH3TVDlWH5yZkMBbor+NJ9bN2wpB4N7ncSus1u4=;
	b=tTURggRR9wurIzDNFlIK7BWU1wixhFfAj8H6JD3R5R7YV6aapFXOMDgO89QNG1ytTP49
	 RoPM8LyqhCLqNqfr67xwmzuiTZB+qlZdj0GVZXuHH+HLL7H/9VrMO3erE4La4/FhOx+qz
	 mDxsfAYt7Zla/ghNEd1ap2NNpoGtJ6Dw+ulJQOPy2XZtdVQ5rNwo4cZ5S9hX+rRrEQtVR
	 fkE8nKFrGeAECj5Fi+HD9ja2vNMPE+ffGmGxdKgUlSlIloBgeUTIdokWhrmNsnLaq0fTX
	 9vZshvYYZzm8Z/pEGUmdnO+Zw5fgCHfm9ed/MNOlTbpXSb/PqBCevyPFwVDnyZQdEgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492681;
	bh=uYw3XH3TVDlWH5yZkMBbor+NJ9bN2wpB4N7ncSus1u4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddGup1BSeC9PuZ0aOoTNjXikNf7Tai1vJmQGII+MOP5txHBVXzrNOhxR04L6fyHAs
	 VtZhyUpj//kAHd5uChxQSWgIcKhnyQsoVngiSmf7UnX0vhA1f6DZFJu9i/r7d7KdgU
	 Kkt1t+yxAY84+W4pIuysthOgwDNUIkTuFxmDUdwAcdkuJRldWRnq5QgV30wMLYh2Wy
	 sRxyRMCPoBaOZTeGVmfAHbStMRALGmmkB/Nj1tAnad9NDHSqCBnDH8abUVbnx0Q5lC
	 HakX1zAKHMPboYK6FgGXDrg6mJA9UFSu80zMEgBv6JFxDzvCjzmnTThyE5O9mmiW0h
	 yYYqOzv02mm0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC1180BF7;
	Tue, 15 Sep 2026 17:18:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65785493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AEA6401AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5tsrrk5nJRo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2E80C4018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460416;
 b=sEBRints+JWi1O8bH1LLWqKqEQ4+9/w3IIz32yYTDGjFRjAoO6ZiPK8ylau4bp4laxDz
 BQVRMAWwOWMeM9+xynnwN46AYyFu6US86lr8WCR44LMRY3zS1XVyKvhnxM3y+9j6kMSMl
 uHyOLlYE2BZUtJ+qBLNkudf7mRIsS9E6bkDdh0qPym0mMzNfx/MBQUuH1iNE22h8zXvNQ
 D4yW5X2/6EBcB4oG4KOMjXVWQfzVnCI3RbGpAGzeq0PBe6K6X+21Do2NNrV/4cm2eUKAQ
 LbcO4SlsFTK5BUdJH3n5147Nl/5QNXQRc1tD0+DibCcbqGVKjaj09DxyAwspU2S3zfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=uYw3XH3TVDlWH5yZkMBbor+NJ9bN2wpB4N7ncSus1u4=;
 b=MDuI4gH80C8PNPbcd+xAMjjsUT/FKKrDos0s8yrf8HYyDTegOyL9OPCbDFRZ7qON+WWP
 deGdHzULzSdRC/gq0jqEfuL6dUDc/HwD6moF4GwZ8NTjKfjfkB8PD6uqRBUnbHeV0M7RW
 iXZpS6pZwSVtNzqKKBDbzDxB7Ox6oe1OoBGD4JCDEjOJNN4OUVx6M0vjx0YQwJAO/T5PO
 gYxmsuZGaJEOgkdhTTWIcMFvEjfRotzPZvDZiPTrCtLZk5esPNzO84C8fIdaCoJn1AZ1+
 rwLos8sVKz2DRNg3EIuOtk5tGvHXwykiIvdZm3GMYua/3MFBhPEhFlrPb7x6X5P6NyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=C2N2J6ZG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com;
 envelope-from=3vp-oagukd7snpscphpphmf.dpnjoufm-xjsfe-mbomjtut.ptvptm.psh@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=C2N2J6ZG
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E80C4018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:14 +0000 (UTC)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso483297a91.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460414; x=1790065214; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uYw3XH3TVDlWH5yZkMBbor+NJ9bN2wpB4N7ncSus1u4=;
 b=C2N2J6ZGwMMbraxbA4CCFUiOYlI+sErgdkkeHcIpfoxcsrS4J+ypBgpHeXK17Qul3v
 URK+1UDvgSyrPNy1TKfTbewuALtv3o8RATvtUDTUdfM/oAMSDJEBxbZtQJzEHurzGi20
 Mt9joX1cpZk5CdUiV8t7Y5O4GfssM+u+QfA40jl1Cctg22GYk8Ib4emytpEVBT7V6+C8
 THJLHAtdqp5707FGTitlrfPAZUcXEzv+GuaXJJ+Lx+tk6UCK8G3bCSq10/KC/CqlXbNr
 Rk28LXayhJji0qt5H9xsCaHIjseSIBnwUI76wzdxMhYOOb+HwFN+gQD1jDF1kpsPhZcY
 EUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460414; x=1790065214;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uYw3XH3TVDlWH5yZkMBbor+NJ9bN2wpB4N7ncSus1u4=;
 b=YW8Xu/DJY6V0Yrp+Ej5dUHHEw35UYDPBe7zEULXYZp3wIAGuIrYWH+9idlJ6NXIFyS
 yD16S4+JdI0siACppNoGCefU4UePYdMDtxCtSgGfGFd79pSODKF2dT+j2+aQuhrcE9Of
 epEqY2Ecq3rYRNxQlO6ZLaTKFC10NbKElPK1JBoh1OlRn3wHmrCLO13xK0KXcStbohCE
 K53cQXdwziVE5tjsXmH+0lkLskePkuHDbMSyikXDGaVbVI9nAZL9+zWIj4WRCfOWW+JE
 K0J9dkO4bDAnqYqAGm5Ee2bxZ8+2JMT/ZK7rSgmHEHjON2YwPOUsRtSQd0rH7AUUsaA5
 1RWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfz/FoXIKj+KyqUsFeoh9w9elgC3jyjgNjCi0i476CA7op4A39pZbwqiGOCF/hoaQIDgFYQBZfULmpKirXQl4=@lists.osuosl.org
X-Gm-Message-State: AFuF++mSedHoi78TOjyMkpXmgXDGWiYXNfDx3iT8PLR+n+et6q9Eys4v
 SZJa5h0+D3gRkKNsIdJg6XeJlTzssq2rZwmqy1pwqm6Ot7GEZp8xBhyXrsd0/SJ9bHJSkEveUfV
 2
X-Received: from pgap5.prod.google.com ([2002:a63:4205:0:b0:cc4:33fd:a4f7])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d8a:b0:3db:3e1c:8585
 with SMTP id adf61e73a8af0-3db4063b18fmr14587917637.27.1789460412692; Tue, 15
 Sep 2026 01:20:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:38 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-22-morbo@google.com>
Subject: [PATCH 21/28] NFS: nfsroot: Refactor root_nfs_cat() to use snprintf()
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

root_nfs_cat() computes the length of "dest" with strlen(), but then uses
up to two strlcat() calls to append a comma separator and "src",
rescanning "dest" each time.

In preparation for removing the deprecated strlcat() API[1], use the
already-computed length and a single snprintf() call to append the
optional comma and "src", returning -1 if the result is truncated.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:Claude-3.5-Sonnet [editor_update_file, make_kernel_bui=
ld_single_file]
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
 fs/nfs/nfsroot.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 432612d22437..a28208414aec 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -173,12 +173,15 @@ static int __init root_nfs_cat(char *dest, const char=
 *src,
 			       const size_t destlen)
 {
 	size_t len =3D strlen(dest);
+	int ret;
=20
-	if (len && dest[len - 1] !=3D ',')
-		if (strlcat(dest, ",", destlen) >=3D destlen)
-			return -1;
+	if (len >=3D destlen)
+		return -1;
=20
-	if (strlcat(dest, src, destlen) >=3D destlen)
+	ret =3D snprintf(dest + len, destlen - len, "%s%s",
+		       (len && dest[len - 1] !=3D ',') ? "," : "", src);
+
+	if (ret < 0 || ret >=3D destlen - len)
 		return -1;
 	return 0;
 }
--=20
2.55.0.1032.g73a4cd73de-goog

