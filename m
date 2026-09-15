Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6488C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A16E180CB9;
	Tue, 15 Sep 2026 17:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Y3f1Xy5sUNo; Tue, 15 Sep 2026 17:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 65CE580C53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492683;
	b=fa/byJUcarb7nQzdqMzogW2NN2/1JG/lc3Iwvrh5Hzv35Ys+DOb+/YqrotaMt6BQXtla
	 9fGbdr4159Ms+d6g5ymDTPYVO9D+/MoJL2XmaRXuIsL6rvpPQhrODiAfbHBdDarqGDYgr
	 RfhKE0kDohmVUJWpemXOZmm0oNx5x2y3BYXWWK4YYBfbFGJTteDZ0nV9j94Mnc/tH5Lox
	 U3ZKKSvqhkoi4jHDpqDIdUSvU9xeFXkblCc549OWWVZyXi5vkldcPYNLPm7fb2nBw1SbF
	 lB0tMs3iABQdwhWW/wJgDZ2RJ1pVl/uQbJtVzzJ++p6QgTJrRFskFZR708nzAxwt3Gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CSHzy5Fr+v+g78gtgBhpLtU/5VBe17dtS9vTkuvViHg=;
	b=fyWJiFBLDraAgzCjm0yIqmuOlnJWzzuHLv3LWlkHQhtKXpuRjdMHa5zOZ/Rd0FEmvLZv
	 t7j8iwhwKRaYBBmlbhKAqKzf2bqaP1dRJ7RDZVNxGpzpTKlZuH/x45wrRdBIc4BuksZb5
	 MMycZa8+vXt1W14rRD5X813swDYUdE/1D93dgUpYreSH0QU34z4uAskPGcIKjCyV8lYuB
	 JiOpCLLtRHL6MNpQ4grq6uADcaN1VTr+qSzTejZ8pwpvnZchzbpZlk+fhzhiIyxYVK8ci
	 yhgcCgd+7LSSpTfecLI66AVKWOc4VOx16ObBh4xeAEJZVF4hJ3UcIhsJOwk5YtmAIGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="dtEiDH/Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492683;
	bh=CSHzy5Fr+v+g78gtgBhpLtU/5VBe17dtS9vTkuvViHg=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4/SMmYTjtdEEKS5I5862B7hzFqkkNnE6PliWmW/pNrxkYSpNztphEmbVLeEE/V7dU
	 2lXv1ctrfORXSH1NrOvLa1K5ru7hcvtZQk0qsuZIrx6mqVd41bAhSmTqFf3r5208hw
	 auwJ1jEheLHzDnNpVoAL8x21IasFwT5bhvxayn7Qg3OP8qWDVUpIe1mxZn1xfchwRp
	 kfA8LD8MKjiaXemJkSPJ5wtnHIrgnoS6XLVHqZyJu8oAWtF6mM9VL1iX2+AGFGzNYl
	 vpjEHbn3Xcuj0BL8x211trYt5/Ex+MmO1fMRE9O+heLfsb9bJq5aAcLnIrhzvzizv1
	 0rQhQtczzldJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65CE580C53;
	Tue, 15 Sep 2026 17:18:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 278C2493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24CE080C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ty104ZGB-oG0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D3C880C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460418;
 b=OdFNTzgKOERYAfnffPUC6H0d3qww5583cnPHlecWs53EM9C+/XteJOMP7jKeClDusHZX
 pznTKqzkhzeTjoTaIJ584T4vUXKYrIPwLCD6Wh3CYmfD3vmht4ZVjpNk+UWLfuQyumMdL
 0UzrZ97keWIAVSf2AudVB9+YK8KSWUXi2eVEnA9Pys1sxzZej7TBuBFDA5Qdz12SmpTjc
 FkbFSqKdOOuTQh9BGzVQs3vP2d8rpab45sqiaoygCPq/690IYjayp0ZWdFwG+n55ULmQ9
 Tt6WvgdYJaiVCYURf+mVeqmrrVC8dchiH+KvElPErEw1fTU6FIc37KxxKTs3B7VcGbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=CSHzy5Fr+v+g78gtgBhpLtU/5VBe17dtS9vTkuvViHg=;
 b=eWfy1Z6XjtGUCIVhTKvmzcfskUlKce3kYKDhWyZ0lWn8rf/Vyjq2pHZKZLavSxJ67fLx
 f23bD4HTpjMCY2WSi+OtrL3s7kJ5kEU/ZNq3X/BKBW1GWZZE2+PZumgI/qFZ6JA1uzki9
 WvEVBxLxJCzu0z/ve7cGvi6smB6V5pwpAVS57P2RR7ViLN61IK4PzFD7d/1TcRQGEWgjt
 sLmcwbkeU3Z46vUlsbm3R+8b1nT2nMU8tLcFljQuYPSdiuuabMidrGjjSfjljsMHBtkeM
 3H1NiwsPG/43phXCHsJvbHfZTevYLyh3NHU1yTrrWuvTukwsTTwoxMLGK+7i/C7Eszg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b="dtEiDH/Q"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3wp-oagukd78rtwgtlttlqj.htrnsyjq-1nwji-qfsqnxyx.txztxq.twl@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=dtEiDH/Q
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D3C880C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2d94a158dc8so62413545ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460417; x=1790065217; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CSHzy5Fr+v+g78gtgBhpLtU/5VBe17dtS9vTkuvViHg=;
 b=dtEiDH/Q9BXFm22Bm7hLwacuNvrtrS3mJM7xAHotVAeBj0nPbzaTP4LQXb8oKGYWyM
 FRCzOxzX76XZ+KSSbLGu0xtyHGLLuG6hqNfWwBRJMwzCsmrmbCq4z6xYkFZ8ucbV9RPb
 l2iZHnhnzBD8rPEojVzDn7Sr8a1/yRHkYeJXggP3EaN2mRbkv2DD4ZfAfNBFZpoYPGto
 Wruj65tnX80NRymqHbtAIwbWcUK34dlXwljMv8pl2z9xSyfW4Fi43WT59M31GzDzZQ0j
 cNoJMBsyyiGgSu1vfwyq2YOKTLQKT4R46x60s/At7bFKm6R9W6IodsXz8lHDj/aqjIwB
 JZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460417; x=1790065217;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CSHzy5Fr+v+g78gtgBhpLtU/5VBe17dtS9vTkuvViHg=;
 b=rhxC+rXdDW51qcve7VrJdZ3QGMywBQqVg6yJsCFYl9Qg0rYkFsiP3z8yNcQnfdGeOp
 gsR6IE0f77IlZHcMgjb0C5GuPFEKPA+4lIGmOymuRIpYUM0VEly76VTfR+WRzuZB0zYv
 0uhrm/f5QoJxmqbYgV1ZtWQbrjsJDJpjJ0c7RA9oHi4dcCYUSnHvnN8W7gKcTuFhNF0v
 wGnFkBM0vp4kxNluFokyrc19F+txnFiJsOa/w4t40I7TCLi9gQuT5e/0lXGWDhzDKsBQ
 s0UQfAV9qHknWfKr7cCgkrGeLjKrnSm4QVL+JtD2GLHj1lukXpk/KLWsbkZe+XrVlitn
 72Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6btIGj8OOWqwwHeC2WpFByQx4FqO5mIvJvb27keV3BjOcTDZuvHViOUhA31vv+uaFXmYMHK85hBTzJQpceYg=@lists.osuosl.org
X-Gm-Message-State: AFuF++mGSUB6Ec84nrNwQ5ZlOSloAZBk3JkMvMwmVVBtdO/PvPE+iBzr
 k8/2Qy6MDy1ygCKDudT3GLjPyI7kWWAubqyru/JXFiv8Ig/TRJ9HYCE4cQqnkJtOSNF/aPIsWve
 l
X-Received: from plky9.prod.google.com ([2002:a17:902:7009:b0:2dd:3c92:b0a2])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c5:b0:2c6:90ec:f601
 with SMTP id d9443c01a7336-2dd6c5f3422mr125997365ad.8.1789460416594; Tue, 15
 Sep 2026 01:20:16 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:42 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-26-morbo@google.com>
Subject: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
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

The threaded ISR handlers (thunderx_ocx_com_threaded_isr(),
thunderx_ocx_lnk_threaded_isr(), and thunderx_l2c_threaded_isr()) build
multi-line error reports by formatting register details into a scratch
buffer and appending them to "msg" with strlcat().

In preparation for removing the deprecated strlcat() API[1], refactor the
ISR handlers to construct error messages using struct seq_buf.

Additionally, fix two bugs in decode_register(): initialize "str[0] =3D '\0=
'"
so callers do not append stale buffer contents when no error bits match,
and stop iterating if snprintf() truncates the buffer to avoid
underflowing the remaining "size" counter.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: AI:Claude-3-5-Sonnet [editor_update_file, shell_command_run]
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
 drivers/edac/thunderx_edac.c | 64 ++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index e7c335ca0c36..4e3781815b6d 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/seq_buf.h>
=20
 #include <asm/page.h>
=20
@@ -47,12 +48,17 @@ static void decode_register(char *str, size_t size,
 {
 	int ret =3D 0;
=20
+	if (size > 0)
+		str[0] =3D '\0';
+
 	while (descr->type && descr->mask && descr->descr) {
 		if (reg & descr->mask) {
 			ret =3D snprintf(str, size, "\n\t%s, %s",
 				       descr->type =3D=3D ERR_CORRECTED ?
 					 "Corrected" : "Uncorrected",
 				       descr->descr);
+			if (ret < 0 || ret >=3D size)
+				break;
 			str +=3D ret;
 			size -=3D ret;
 		}
@@ -1115,35 +1121,37 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(in=
t irq, void *irq_id)
=20
 	while (CIRC_CNT(ocx->com_ring_head, ocx->com_ring_tail,
 			ARRAY_SIZE(ocx->com_err_ctx))) {
+		struct seq_buf s;
+
 		tail =3D ring_pos(ocx->com_ring_tail,
 				ARRAY_SIZE(ocx->com_err_ctx));
 		ctx =3D &ocx->com_err_ctx[tail];
=20
-		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
-			ocx->edac_dev->ctl_name, ctx->reg_com_int);
+		seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);
+
+		seq_buf_printf(&s, "%s: OCX_COM_INT: %016llx",
+			       ocx->edac_dev->ctl_name, ctx->reg_com_int);
=20
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
=20
-		strlcat(msg, other, OCX_MESSAGE_SIZE);
+		seq_buf_puts(&s, other);
=20
 		for (lane =3D 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
-				snprintf(other, OCX_OTHER_SIZE,
-					 "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx",
-					 lane, ctx->reg_lane_int[lane],
-					 lane, ctx->reg_lane_stat11[lane]);
-
-				strlcat(msg, other, OCX_MESSAGE_SIZE);
+				seq_buf_printf(&s,
+					       "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx"=
,
+					       lane, ctx->reg_lane_int[lane],
+					       lane, ctx->reg_lane_stat11[lane]);
=20
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strlcat(msg, other, OCX_MESSAGE_SIZE);
+				seq_buf_puts(&s, other);
 			}
=20
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
-			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(ocx->edac_dev, 0, 0, seq_buf_str(&s));
=20
 		ocx->com_ring_tail++;
 	}
@@ -1196,25 +1204,28 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(in=
t irq, void *irq_id)
=20
 	while (CIRC_CNT(ocx->link_ring_head, ocx->link_ring_tail,
 			ARRAY_SIZE(ocx->link_err_ctx))) {
+		struct seq_buf s;
+
 		tail =3D ring_pos(ocx->link_ring_head,
 				ARRAY_SIZE(ocx->link_err_ctx));
=20
 		ctx =3D &ocx->link_err_ctx[tail];
=20
-		snprintf(msg, OCX_MESSAGE_SIZE,
-			 "%s: OCX_COM_LINK_INT[%d]: %016llx",
-			 ocx->edac_dev->ctl_name,
-			 ctx->link, ctx->reg_com_link_int);
+		seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);
+
+		seq_buf_printf(&s, "%s: OCX_COM_LINK_INT[%d]: %016llx",
+			       ocx->edac_dev->ctl_name,
+			       ctx->link, ctx->reg_com_link_int);
=20
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
=20
-		strlcat(msg, other, OCX_MESSAGE_SIZE);
+		seq_buf_puts(&s, other);
=20
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
-			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ue(ocx->edac_dev, 0, 0, seq_buf_str(&s));
 		else if (ctx->reg_com_link_int & OCX_COM_LINK_INT_CE)
-			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(ocx->edac_dev, 0, 0, seq_buf_str(&s));
=20
 		ocx->link_ring_tail++;
 	}
@@ -1880,22 +1891,25 @@ static irqreturn_t thunderx_l2c_threaded_isr(int ir=
q, void *irq_id)
=20
 	while (CIRC_CNT(l2c->ring_head, l2c->ring_tail,
 			ARRAY_SIZE(l2c->err_ctx))) {
+		struct seq_buf s;
+
 		tail =3D ring_pos(l2c->ring_tail, ARRAY_SIZE(l2c->err_ctx));
 		ctx =3D &l2c->err_ctx[tail];
=20
-		snprintf(msg, L2C_MESSAGE_SIZE,
-			 "%s: %s: %016llx, %s: %016llx",
-			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
-			 ctx->reg_ext_name, ctx->reg_ext);
+		seq_buf_init(&s, msg, L2C_MESSAGE_SIZE);
+
+		seq_buf_printf(&s, "%s: %s: %016llx, %s: %016llx",
+			       l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
+			       ctx->reg_ext_name, ctx->reg_ext);
=20
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
=20
-		strlcat(msg, other, L2C_MESSAGE_SIZE);
+		seq_buf_puts(&s, other);
=20
 		if (ctx->reg_int & mask_ue)
-			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
+			edac_device_handle_ue(l2c->edac_dev, 0, 0, seq_buf_str(&s));
 		else if (ctx->reg_int & mask_ce)
-			edac_device_handle_ce(l2c->edac_dev, 0, 0, msg);
+			edac_device_handle_ce(l2c->edac_dev, 0, 0, seq_buf_str(&s));
=20
 		l2c->ring_tail++;
 	}
--=20
2.55.0.1032.g73a4cd73de-goog

