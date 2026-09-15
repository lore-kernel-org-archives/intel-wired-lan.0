Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE5EC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E323080BF7;
	Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EuEt8h7vADz0; Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C7E1280AEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492675;
	b=eAhiQzYLhK8hkahn59/RZ01kxFj6rHJsOqKJS3lMmQ0fBvb1eh0BfTeFMuiIFgb9skkp
	 8Qcagvde2+AF7W3usEX5G4h2GtciDSv0/yzS5sZyOB9fVzrBEQbSvBDAaqCGbRC8v/S1g
	 XuqvN43iim87YlfkCfgX1sNStc5JBMsTodRTEsXGJ6oJosU6QPaqFW+/VSlQKcYhO+gn7
	 Sr/V6qZevD32pNMKiMZZp0jcjRN6Wwry/R01QhYKfofSPx0bnfaMiE3NBOdRsso6M0sLm
	 f7y4vc7YhJodLQaJQu2mDBzDxwgbauqn3eKCQI/Q4o3fmeg6PeF+yiJelIc+bgpTHug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jD1fGYdmSfmtHfbCTu69NC0iIcRgu3QWne7aaYuG46g=;
	b=CjAI7Q2R1BvMPX9zDpVoWubgxc5pbwmSyZdqfM7miDffTd+a3LfJlhmunm/Az21rEN4b
	 vMUaboOdak94VtZYaVKuqM+G60uxE6tOk6gI+ovcZvQQF6aYzabVDyEVKxERvVOkJS4Y9
	 NpIuQQTIzATXcogHcA5YsgxLGCpL0U3ckCZUKrI3bUgavnHj2dGVxFXq/kPgXI+dw2oCv
	 4ZRrG8XgNCSfXumES/fOMDiuU4xw6DUiDrNLLU3OQJWHviS70LavUGOar9tXO/0PA6Sr2
	 DoiJFxmLWeCDmSnHAh61SeEcAZ+Wdp6hfAo+kW5zPd7mbZsMokx/lMgMI9F9Q64KxqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492675;
	bh=jD1fGYdmSfmtHfbCTu69NC0iIcRgu3QWne7aaYuG46g=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKbi2auBgZ32fI0QEEaYjfvWzg7dclcpzaPKWyBsVxKQBucP+98gJUCHvmBzQIaec
	 RFdBBo8T48EFDXqH5Ek7jtxQ1qgKulOztSnEee8t8+VCIe79YpFyw76zyt+dQhI6DP
	 O3/3miWE/oKnVnGYNm2EDlprpPaHl+ClBlQNy96G0mtkFT7LklOy1oTITho50Z1T+D
	 sJO9cM0as2a+8qSi//isCwMblM9IQCEBsIU4xZN7qsVKFpwJQKIN4jGPtZOpeQsHyJ
	 +GJbvpajTikNI+hJC2OBErzSutrP3VYbC/MwozSU8gNMOqzso6Pg25DWac4ylf0RO3
	 Cw0ER/EKeRJjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7E1280AEC;
	Tue, 15 Sep 2026 17:17:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B71C493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DE7C40402
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wucy6hOlAxUD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39AB6403A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460411;
 b=C6HJNsLzS7ixBdBHdrSVbAA3zgp/mSFbLctoYO1O2eIQcZTq9Tsz3ubzImJODI4ZJOxj
 K+BWH0vu19s1Hkxpknk5bDI8Ie2z5Y9X96HJI6MpJPHn+BkPPocoFo6D3Z2Ai6E7xztgG
 VTgdbZRxEVDqlthjjasU/E597k52xj79LoZxaYSd6i9sbbIvH20Q5VKJXL2uYzRVZbZE9
 Laid3ZitaJMQ85j8+9xd+ymY7or1MOHrn7c8Hf7KU1OekjLwzbC22lbyhdlNAucNTnZFZ
 1xBabirBKrS0Bw5O1XsinM4CqcfOteWWBqLrZcdwVoIdThYKlmoUED1j2pKcpxZJ5sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460411;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=jD1fGYdmSfmtHfbCTu69NC0iIcRgu3QWne7aaYuG46g=;
 b=lLRfhkzrSZyT7dCj/ouXjTotE+8V1WqMgcrHacXFkeyzJuAmRE0cH+SAvwnQd9DfdCsd
 NrghFXmAsf3rgG6WiSMxeIeBID3QVPu3zYT5AfmedMOWEJYZcVoonzCQsZljm9sZI7p9U
 u/oLLOoOKjgENYn9doXeuowNOSLhkGKuIbYFi97rq0cljdiWl4TXOxDpHXOKvc1GaMzg3
 RH7LDealwKpMOAgH/3waxWU2F1IEPuuTxgfDhujEMcs8gdFzTmEr4uEjomZu+YlU446hw
 Cw5CSPVDypDrscpW/LS0fhCU4FhTtOI9nBnkLifWntCp1KfNLIc2Y0WPHecZgbqKy8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=r7WpkVQu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com;
 envelope-from=3up-oagukd7cjloyldlldib.zljfkqbi-tfoba-ixkifpqp.lprlpi.lod@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=r7WpkVQu
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39AB6403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:09 +0000 (UTC)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2d001671a54so82266065ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460409; x=1790065209; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jD1fGYdmSfmtHfbCTu69NC0iIcRgu3QWne7aaYuG46g=;
 b=r7WpkVQuINm45qXhSWxIpfXG7MaYlSr9z50cVixVRNzPMdZUSDw5jcrM81DO/oikHH
 sGraQ8+vtgHDHsxaiKTlhIO43yVXmJmCNt7Yol67CaeXPP0KcgLy9JWJyVNRAEtiJ6H8
 9mmlH+jbfX21V7Iw+GOHnL9yvMB7CiugV0yup1naWaZO9aQxqQA1vXJef3IQMdNsV7JT
 TuqEkTkinpH28OYQty5iRP0+ae+TQZKo9i2fJBClmoCBhYAacVNx6eOjgqsmKUDM1frb
 GcUdH1nK7hgUDE2gwupHVXY/VQ3eEP1fOQPoAW/HiUrAjYpZMrl0jB2TZH7t1tR0z+tI
 3FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460409; x=1790065209;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jD1fGYdmSfmtHfbCTu69NC0iIcRgu3QWne7aaYuG46g=;
 b=GSG+b7oAKR1T06ogBr+UHtCO2I0z8I/intD4Q8/apwesQM8y6BBpxAWU6UB1sXa4ij
 U2ILk3uaMi/Q+y1E7fl0oBdn9ujx4wm0zYMWixRObBSagJCdw5bqIbTa7m6ZgzltMhPU
 Yy20c+zPj0MVi5hYtXV3aV/ifRy0YSpyod6NK9LZx6TYUdLHNCsrXcdNFpF9VQZCZsYe
 XSauwkvuQY4HAvxSfwnI1nC1rprC0TVZUCN2XGJzfgf/p/6lmIXlvCu0yVgjxjIrgy6Z
 dfXDnwgQVeeT9FWNFR1PM+hR4ESM42p76hYe9s9yIs4I9dbACnrYVFReUHd7Y4HL/nDA
 CC/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAHGnRGBvkBH93kUD9eQCfvHYa/MJPZxqfMp7LenU+b/JUK3FIg6Yb1i48NNdS88w4LYxNec8+lmHzuKLExi0=@lists.osuosl.org
X-Gm-Message-State: AFuF++nTXgPrk9sCdZU0K0s3WYlidxMaXpkNyuXn9UHDkZQYNjAlquf2
 ebQ4vpUyH0paGg3rxUYfrZi1GcPJ+LRJ08kbQeQOnRF2qOSLAbK8h3nazfv48wM0PrbFBiJyZ4Y
 u
X-Received: from plbkq15.prod.google.com ([2002:a17:903:284f:b0:2dd:1c44:fe2])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a0c:b0:2d9:464f:d45f
 with SMTP id d9443c01a7336-2dd6c5ba2f0mr129830935ad.5.1789460408347; Tue, 15
 Sep 2026 01:20:08 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:33 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-17-morbo@google.com>
Subject: [PATCH 16/28] pinctrl: samsung: Use snprintf() to construct pin bank
 names
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

samsung_banks_node_get() constructs each pin bank node name by copying
bank->name with strscpy() and appending the suffix with strlcat().

In preparation for removing the deprecated strlcat() API[1], format the
node name in a single snprintf() call, which preserves the existing
truncation check against sizeof(node_name).

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini:Pro [editor_update_file, make_kernel_build_single_file,=
 checkpatch_run]
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
 drivers/pinctrl/samsung/pinctrl-samsung.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/sa=
msung/pinctrl-samsung.c
index 5ecc9ed4c44d..0d639eec689c 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1155,8 +1155,7 @@ static void samsung_banks_node_get(struct device *dev=
, struct samsung_pinctrl_dr
=20
 	bank =3D d->pin_banks;
 	for (i =3D 0; i < d->nr_banks; ++i, ++bank) {
-		strscpy(node_name, bank->name, sizeof(node_name));
-		len =3D strlcat(node_name, suffix, sizeof(node_name));
+		len =3D snprintf(node_name, sizeof(node_name), "%s%s", bank->name, suffi=
x);
 		if (len >=3D sizeof(node_name)) {
 			dev_err(dev, "Too long pin bank name '%s', ignoring\n",
 				bank->name);
--=20
2.55.0.1032.g73a4cd73de-goog

