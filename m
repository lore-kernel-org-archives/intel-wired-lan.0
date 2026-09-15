Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C6CC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38C646071C;
	Tue, 15 Sep 2026 17:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdYA3iv5cEG6; Tue, 15 Sep 2026 17:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 311D6606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492685;
	b=iq/sEIuxunxnlWzvzTHOxcG6ZU4lKvNDrcOYY4njVSzOMmcx5qvm0rYrB9cVEIkaOdLX
	 GcUSygvmj1TbnU4JGZaxCUoZpFaFxQm7oQ9alE6+pRnO+vPx5Rnh4Cmu8OI1r+5WFE0Hp
	 yxBejpk4wubAM1e6I+g2GlWyS2eueUfnQKm3klm0bLt8IZhpKlC+P+dTA1n6d5ulk3nFB
	 yN/jXAYPZPzTs9p0bI2BrlSG+6TUtrqazvCreZdRt0ogodTMvZStfEkh8uwTuT/WeMK1o
	 uPZeNr89gjuoXOsSFVAdjdVtRL2J0ibjVKVtszu4QmEY7m8J06gBjYjjK5TS1k9M/Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yp7aMeBt5kbv9wDm9MP1w/VhRzf84I2dhiWVAxjsG5I=;
	b=ocPio4A47rYyFyp83Ozqb+pSZuNeA0jZt6FO7Z0dPDKflfMtvbg1iJ7QeFJ2g4V1vfFD
	 DRgZdsx0J/wG8wV89CMLr8VuIiR6V94A1V0Rb9/BazetfKZ2YhrZ724SL0TX4GD1Ef6Gi
	 8gxDuwP6sRj0zmu/AOq+umKYufbg0owGzVyM7GQnofw+vX9Wkoi6NIMlo8I5mc/xzrg5w
	 zVycgax9+zrQZ2rGMUMao5qRj6Xz1CPTgDE8KxjTOfwXTX2fj1FTfMKa/x7WfhUUxRpBM
	 dbhBjWehFWEQ1BgJbPTd56I5roA+E4tYj/CoQ7h4a67Inu764wFVnxhXP9mczyiri7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ml8gvoZd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492685;
	bh=Yp7aMeBt5kbv9wDm9MP1w/VhRzf84I2dhiWVAxjsG5I=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWlBPagVHTkWL0jkva3uMV+N4m+Uxj0MyvkZvtDYg4e6+55sKPPbxa2Igz2H4GNwD
	 iYMFp11vsh6HUOVkGaLa+lIhouT5FC6OllR0Kuxp5ohRpH+tWGNMj+Kdt5k+MTemLI
	 y3Qpoot0js5m8tOEUUyjUCvReLcm1zyO3KzENPINBzv1QyxmiNouju8j1/aGN5SFN/
	 SfmUEl8UWhNi4azc9+lzKo2g2+5jxaQhhOkxeZMBgbGENtfA5YIN1vSRGPBxjpgHtp
	 pE+4k4NRU7qj0gNW0tgrhzywgoCtzmsX1ziqhp6fkVPswxuAX6d5uWJi4W38jaoncs
	 1MHBm1lZ4W/hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311D6606F7;
	Tue, 15 Sep 2026 17:18:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A7622E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0088060721
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjRQxym4cZqO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F281B60681
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460419;
 b=sKYHdAysskWBw4sziMD1O24onnWtFLwvGZquPzP0LwEFGdC4pSVC3ytSMcqMzO9JqI+m
 IVgXknTz3HMp3A6awt/FjLawgJRM4OMGi2/52GkCqWAdi/APIPXTwJoFrT9d59ykEzqb7
 rBkYPQIhKtfHWGwiyinvJ7Oxq50Zw3lduYBWjb1wj+TVHI+CRBQPN2rG4aXiR9yJUaHiu
 ztXMqbGVtMBr/eTclRUZ/nK4qbJ+wYbQmXaTkldQdckspzlq7e8u/UoQzClRC0xxThpGw
 Y4koosbU8DLjb/XKXDigD/4X3d/FUjuI6HzeNuV3fA6d0YIG0YVIUR9WyxyqkELJnjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460419;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Yp7aMeBt5kbv9wDm9MP1w/VhRzf84I2dhiWVAxjsG5I=;
 b=NxezNshc2K+AU1yKjmVHwULLpipIiWAvm/QeZpMj7bSHxNxZoJF4ISSfSfakBkJIeteM
 RgdtLdQClXYcJD4hhXtO+6Y4HLFQz3mJkpf6y8P7/Kg88XgFFNnC/0VX+Aec/+VSJo6Ct
 qO1PL35PhSUpQO+VRjJHclsCESoEjGhY/A/Tg51Kf0yQRIJcLQeWC5EvYIcPiSGKRHNQk
 lTYeGt8xHiwI26kKwdcEPddqapLAH8eumkPqBF4Q6ChhjxfEmrK1te1PQqdE0ElFYPZ/8
 mYSIGBO9UG8tOZudjEfcyiPYX3+J7RI6hP9/GtsqlhQ3rX7q9i1q0lEJ12rjVs4zPIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=ml8gvoZd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3wf-oagukd8asuxhumuumrk.iusotzkr-2oxkj-rgtroyzy.uy0uyr.uxm@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=ml8gvoZd
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F281B60681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:18 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso97492095ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460418; x=1790065218; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yp7aMeBt5kbv9wDm9MP1w/VhRzf84I2dhiWVAxjsG5I=;
 b=ml8gvoZdrXmsyBJtbciLp8v/FxHA5wSyvJKdn6qhzu8rJX9UoDtSTx8PtyRG3zG6ps
 I1Od5mK+VK9d9tkVXmrbZrxsMdHfJX1OGkO6/h4f2sXB+YH5M4LHk0pl5I8n2Fh7IUEF
 IPOKB9CoTqyho8jXe+PfdL/dadj9tBoV2+xg/I/FFjWLOZSECf2HcrtV1dzBPlkvDvnE
 MPQsUnOLZUZ05MF5JstJKSdqriA4le2OmIAssQojIrgu4sPAOuag1ccSpvmzOJBGl0w9
 ypA4x6UAE3zWDYsu/fMflfrdLMHWDaf/HoBLzWr9iNxz71+OMxnU7qCIi7x4CYPHOzrd
 UVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460418; x=1790065218;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yp7aMeBt5kbv9wDm9MP1w/VhRzf84I2dhiWVAxjsG5I=;
 b=kCK3sc195sk2f01U+Z9NG1nKYEsXFbM0+XTikh7kY3SsToa6XDpf8qxJdUYITlF9tL
 gVUTw1RPLRdntFh0oDGaQj8H14i48q6rGYuqPisBclDk43jm2bFcNir8xeLcHpxWoeqH
 H8N2/UKX1Vu4A1mNhc1ge/sAJ+9Qv02v8dZmu8GtYhb1pixrCUogB8xXPLMOVA5dyqYE
 +EO6GQ6Ytj/Xh8KN6TNzKhFBzqlDyIsyxWC/eEAyNSjZm8TW5khYbzvpraA5sjCiqGwm
 J2oL4/GidaL3mOmxeUolmNSy/i5GXOYAV4ZJVxMgeDxfOHtxnVs3pdodRD/6ywFSTQ8W
 rfLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqy6gcRoTpBMzAOWXDuXVQExfINGioF85kML8kQd+M5HLpCD7DQT2+31lZkXl7C/lzl3WP32czJGK3uIuhunA=@lists.osuosl.org
X-Gm-Message-State: AFuF++lznp/JifMahheQopR/DTY30ChvWgpgdqnGeNlcoecx6hNhfOYX
 hoam0qohfag5Gji3ee2hpAmRzD0+eilkc1HL7uVetAgIJl5D9cnAYtNINqOvFoZkkXedx4TZmIB
 X
X-Received: from pltt2.prod.google.com ([2002:a17:902:d142:b0:2dd:5303:f006])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64f:b0:2dd:278c:5eb
 with SMTP id d9443c01a7336-2dd83851f4amr602125ad.14.1789460417430; Tue, 15
 Sep 2026 01:20:17 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:43 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-27-morbo@google.com>
Subject: [PATCH 26/28] wifi: wil6210: Refactor resume_triggers2string() to use
 seq_buf
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

resume_triggers2string() builds a space-separated string of active resume
trigger names using a series of conditional strlcat() calls.

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() calls with struct seq_buf and seq_buf_puts().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:1.0 [editor_update_file, make_kernel_build_single_file=
]
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
 drivers/net/wireless/ath/wil6210/wmi.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/=
ath/wil6210/wmi.c
index 479b2418ca34..fcc9e9eb5732 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -7,6 +7,7 @@
 #include <linux/moduleparam.h>
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
+#include <linux/seq_buf.h>
=20
 #include "wil6210.h"
 #include "txrx.h"
@@ -3162,27 +3163,30 @@ int wmi_suspend(struct wil6210_priv *wil)
=20
 static void resume_triggers2string(u32 triggers, char *string, int str_siz=
e)
 {
-	string[0] =3D '\0';
+	struct seq_buf s;
+
+	seq_buf_init(&s, string, str_size);
=20
 	if (!triggers) {
-		strlcat(string, " UNKNOWN", str_size);
-		return;
+		seq_buf_puts(&s, " UNKNOWN");
+	} else {
+		if (triggers & WMI_RESUME_TRIGGER_HOST)
+			seq_buf_puts(&s, " HOST");
+
+		if (triggers & WMI_RESUME_TRIGGER_UCAST_RX)
+			seq_buf_puts(&s, " UCAST_RX");
+
+		if (triggers & WMI_RESUME_TRIGGER_BCAST_RX)
+			seq_buf_puts(&s, " BCAST_RX");
+
+		if (triggers & WMI_RESUME_TRIGGER_WMI_EVT)
+			seq_buf_puts(&s, " WMI_EVT");
+
+		if (triggers & WMI_RESUME_TRIGGER_DISCONNECT)
+			seq_buf_puts(&s, " DISCONNECT");
 	}
=20
-	if (triggers & WMI_RESUME_TRIGGER_HOST)
-		strlcat(string, " HOST", str_size);
-
-	if (triggers & WMI_RESUME_TRIGGER_UCAST_RX)
-		strlcat(string, " UCAST_RX", str_size);
-
-	if (triggers & WMI_RESUME_TRIGGER_BCAST_RX)
-		strlcat(string, " BCAST_RX", str_size);
-
-	if (triggers & WMI_RESUME_TRIGGER_WMI_EVT)
-		strlcat(string, " WMI_EVT", str_size);
-
-	if (triggers & WMI_RESUME_TRIGGER_DISCONNECT)
-		strlcat(string, " DISCONNECT", str_size);
+	seq_buf_str(&s);
 }
=20
 int wmi_resume(struct wil6210_priv *wil)
--=20
2.55.0.1032.g73a4cd73de-goog

