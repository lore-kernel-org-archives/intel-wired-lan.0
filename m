Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86250C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52E3E80BE7;
	Tue, 15 Sep 2026 17:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eEKm_O3V_h6; Tue, 15 Sep 2026 17:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 342C780AF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492665;
	b=Hqwy5CD8AFCKhSr0+D4X4tvjFqaaIg05ZVTf7f6zv/cw7+Ux8tmUEtEncgrjQ7jQKnG4
	 /7dlflEdyKN15UWOkfpR8Y9PgXS75V5Ui3tTkz1Kn+cM9Hte35K9iBCWTsU9S2UBt763P
	 wKa9sVi/pFqlLlGRLSD33AWO61sMnhUHO9nJrzdf02+sqPGw3ckpd+AqqzLRQ5LW0L/tk
	 kSAX3o+q/BN2+PyZ3Dmcyrof/ODGBBEyJWddgwsr2BUjTcJ4xZjfUQY3Ts6cWjYck8lrA
	 JjYBtjz9JFm0aJgAQ2vkDqMjcERi5X19kAuyhiiy+QX6YZgYD1kmkiZi6daqrk+4O5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=su2v7itwh4re1nYnX3JAIlBIidMghtZfDu1F4zgeEKU=;
	b=ZYTQj5Hal131Rvpyr9EntW7GsaUyrFVICYeNxoKFI4PKgaGAtqnWBEG80jk5bOHuIE8k
	 EgqA1gdZsD8OqownpMRb77TjmyP7wnQ6h3vLBH+/z3T7zAbkMt4WEdWo6gaYKFE3BIkoF
	 Q1KswISSy2ZYrRvyqLNJk74EEPBtBiQrvV9j0vzjDSdoWO52oJ3bri+U9nnJsFg+TnAK+
	 6sodC2krRNwl4Stv8zYGsFmUD3TFOXoFCbXK6FjgBWx7WFgTgcy7gmWBU90UiWkbrfSBb
	 bnRWyWkNbsZcLHv7klw8Fv1FbrKRxhsv8d0bM2VKq7N7L+cYI0/SEk1M9Wf//jbZj6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492665;
	bh=su2v7itwh4re1nYnX3JAIlBIidMghtZfDu1F4zgeEKU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EoGfGKE1ayxPsTWVzaDfj/rtBBupMAkCYPW6x2VDiRqE4jdJkt2tQ0RQxh0fnIRAV
	 JVIRYo720zeqKehYkh96CcZe1UGbIKwx6bMVEezxnj/ixUlOkik+kMpD3GhFTf/fzY
	 KKjDQ7BzQKt391OuTvUs68goOLYZkT3h5B4aITw2zjbuGd5bavt65cBnCSsRVMyaOZ
	 A3FZwfNfNNU6oYi1FQwrgxgn7ZXLyYHyCbqdOmZpU57vgmxMN2N6DVq6YyQmius7rH
	 lDv9XCTWpV911JEeMOiVu6uErpDZbPnI2cqIUqrYRAOVvvgUHbxpqjakhgbbTRWFUs
	 1uLO4tvQPpTfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 342C780AF5;
	Tue, 15 Sep 2026 17:17:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 447CC493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35EDD403E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIDVUpgCOkQ5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 30A14403D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460397;
 b=rvITaWZrETk9Sywm4t2XrnktASiI+9pwcMJG9rL64BIOK8hn2SkkBHvZiWp+leRjAhax
 HnZQqXKDVYPJo1SCubUJqonlgGTY1g1yBFW2EyfQvi9sFlZVjrzkTAf+Q5GJrBeRi3f4i
 p+/MPEChOhpD3FLP/6lKQZYg6p99cbBrK40LTV9/EvqhE9j0kR8gmZppBYxIvXQKcHaVO
 172b2jnfv0McuBtngcjnGeIjY4ZvYb89IhUCemoypKJ20MiDYpk+or9MDGpJ67ouHWSUv
 tildPdakE79ba0DFHUvKqwNi2fGpZ6WDSd2X1SXXIVzRxk/5REqezbFUgbWGp2Tz6Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=su2v7itwh4re1nYnX3JAIlBIidMghtZfDu1F4zgeEKU=;
 b=dG9MosZpMWF3zjwjNU/gqUF7Z6pX/KmNePWrZSn11xC6rwhTEBAtghHAH7TuZjYNusbI
 NDclHKvBnHbYQBSy+IK39l9BlCVchDYe4KONMUrzYjEaZ44bsyfDozyHTMuTJOK1L+CMl
 s9m5eUCen61Am8WCbTqAcMgtDoZXT0VZA9yvvPJDlZZ1iMxw8sVLPeJzYPso+vC/36wu1
 JjlUkJaet7KpewmPzfJLI0vtBONnFkE5VyUx2ZmwC5UfqdszqU1wNC1EuQdVxUKlD4kXS
 vuwCK+Z26FlW4gSWUSBD3m6JEfRr89vdN2cEGz5L7FA3MmR29hzlgK0mVLnvNrdu9PQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=tvTwxto9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3q_-oagukd6owyblyqyyqvo.mywsxdov-gsbon-vkxvscdc.yceycv.ybq@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=tvTwxto9
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30A14403D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2d6f75c1219so88122945ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460396; x=1790065196; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=su2v7itwh4re1nYnX3JAIlBIidMghtZfDu1F4zgeEKU=;
 b=tvTwxto91c7TpMbgU81gnL/pgKST4aQ3D/tSnY+oh2kEfebINL6DZ7I+zunGWAzuko
 bKPgEDwLmFyjMdZSQHBBTHdEWggyzRDNE8SzmwuE6vvV0GisV9Pd9jj3E45gUgyRnvWG
 GJRCZYBTK4JEx/JH/Wdn2JP45Uj4D3EswyJG+VV9+rzhrYsABi4NZryeQFV+ef9ptEdP
 c6Jlwpjnd1y8i+WWYIy4oZWDAmpsByAxKdX68mImsEhW2c+oXCcNuw1cPisBL7cRhNA3
 /3UdMLzEAWZaBgelUF4EMgq78ZlZX9dgxoG0OHX52qK4umz/ImW+pw60uCB+Kh82cG9n
 2TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460396; x=1790065196;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=su2v7itwh4re1nYnX3JAIlBIidMghtZfDu1F4zgeEKU=;
 b=lJkbSxk6A2fe86LYNOWhVvfZH9/oaI8AJ0cxg2wnucoA/1NkP0FgJ44OksXbMdfeJu
 t8cHHIPGaRpfKwUGP3bWmDHPI2LfBfxaMbeE9G4ob344zBrB3se4VNKSUIDeMdcxoOoG
 fPRWu4AcD9mI14G/NwRM2p0+PONEPkx8PfbUwonkHvM8IxiwQLbXSeZ+8q6MJX/ioFbC
 0Si3U65k+OGxK75djmzDkTfQkuj+B+OqVn3UVqSiE72Em9hbK5yT6r9jossjFrsNj5O3
 piKQcTIkhTMtDlhUklNH2ZjDs7X9h91wQAUuD+Y5Qz86VdllwfLf+JcH+/4cqom0Lo9Z
 SncA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPcx7sb+qfY4X20p+MCSSHzNnFhGxS9VwjUhImokNGZGfz3hnUiQ9QZEURQKmWzFjkZh1q3hgiP8eWP7SsUS8=@lists.osuosl.org
X-Gm-Message-State: AFuF++mkoQ0VASLxUqonJOIo6iIdM8ALI7iOBbwrOj7bmvaH73KvOSNx
 UV168hQCePLV0wC3UfFFW/oh2YpGUTl/TKazJE91gQWRu7N+1pKBVlQ9+0A/i6/8UEfrOfyGEgr
 M
X-Received: from plpo14.prod.google.com ([2002:a17:903:3e0e:b0:2cc:e407:8fef])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3508:b0:2dd:8b2:6e64
 with SMTP id d9443c01a7336-2dd83851cd5mr695675ad.12.1789460395589; Tue, 15
 Sep 2026 01:19:55 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:25 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-9-morbo@google.com>
Subject: [PATCH 08/28] devlink: Refactor strlcat() to seq_buf in
 __devlink_compat_running_version()
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

__devlink_compat_running_version() appends running firmware version
strings and spaces to "buf" inside nested netlink attribute loops using
strlcat(), rescanning "buf" on every iteration.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf anchored at the current length of "buf" and append each version
entry with seq_buf_printf().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:v1 [editor_update_file, shell_command_run]
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
 net/devlink/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 55959b0ff5ab..987b071345c4 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -5,6 +5,7 @@
  */
=20
 #include <linux/device.h>
+#include <linux/seq_buf.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include "devl_internal.h"
@@ -1190,6 +1191,7 @@ static void __devlink_compat_running_version(struct d=
evlink *devlink,
 {
 	struct devlink_info_req req =3D {};
 	const struct nlattr *nlattr;
+	struct seq_buf s;
 	struct sk_buff *msg;
 	int rem, err;
=20
@@ -1202,6 +1204,9 @@ static void __devlink_compat_running_version(struct d=
evlink *devlink,
 	if (err)
 		goto free_msg;
=20
+	seq_buf_init(&s, buf, len);
+	s.len =3D strnlen(buf, len);
+
 	nla_for_each_attr_type(nlattr, DEVLINK_ATTR_INFO_VERSION_RUNNING,
 			       (void *)msg->data, msg->len, rem) {
 		const struct nlattr *kv;
@@ -1209,8 +1214,7 @@ static void __devlink_compat_running_version(struct d=
evlink *devlink,
=20
 		nla_for_each_nested_type(kv, DEVLINK_ATTR_INFO_VERSION_VALUE,
 					 nlattr, rem_kv) {
-			strlcat(buf, nla_data(kv), len);
-			strlcat(buf, " ", len);
+			seq_buf_printf(&s, "%s ", (const char *)nla_data(kv));
 		}
 	}
 free_msg:
--=20
2.55.0.1032.g73a4cd73de-goog

