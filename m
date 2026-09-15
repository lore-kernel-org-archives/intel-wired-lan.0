Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E340C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDBE94033B;
	Tue, 15 Sep 2026 18:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QGt2ahpVimR5; Tue, 15 Sep 2026 18:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02D0A40346
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789498353;
	b=Ff5+zDoIBQ5Uz79IjpMkCfFenhoQQBWpYGFK7t3mmSvXMF/INp3YNddx+kZ61pA9n9Ah
	 1BbZXKKPsU6YsAGJXYHQo7i7bx4JJV+bKd1IwD6byqVw7+LCXXPk2omoKzLwgn8d4ajiA
	 LFgK76RL4QwX8wLlUft/61p8RxpsojuAjroRYBXgcI0FL1xCfSxl3AbCyWIQSdjDn6WM+
	 fjL3Q50EiYrKGSsx2qnf4hgD5z5Bg5gTjWnUJigSsWsWkXm1CbN9SaWInQezv0zpRZs80
	 SU6wRY1fK7a7LuCSQppHF4nzPa4cTGA8Vo++QnlDVXEDD0VOQiCp6aE7gxQ13CtYLAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789498353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=72tlQhpdmngB3szUrALiHxqSz5LmQFAfQZTFPwAJsm8=;
	b=GpFXURBa3CtxFkdckELmlgaes7Rq5AEi3R175JA+6bespoX+Xami+pcw4+y2LaU5B/6+
	 h3cY3H/apYC91+smOE0tXl3WTkxK6Fe6TYdFVwx7IkaqFiyI99i3Ori0y0Wb0l6Q+3sWm
	 t9MnDLPib4smUaR72sesYrlmNKWgustm68j7fFjOKnfBZ8j+Pd0jcL6EObl1H9rBtAVi6
	 7iY5Aj0xNnC8h5+QNI9l60sRn4TeE3Tcf/fOIE+1ulzwUL179INdpPAZxcQAD9mPx2aF2
	 5y/FsyoK0IslWRs+nRoG8qd/MoeMi0YQfepL2/0vHT+qLtMjB6yFt5Vfdko+qr9U0pQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789498353;
	bh=72tlQhpdmngB3szUrALiHxqSz5LmQFAfQZTFPwAJsm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keU82A9awwcq1X5nyOMYP+j/4JSwTy1Bqch4+gmccXWXRHs0sXz6QkFKRXFgjKa0H
	 HkfovB/YX8JecT6q8IJh9DO0gORAioC++XeSdEhW4TJAp5itOeB2gQ7u8e/iL9QVgM
	 cROmu97LZXPyOOf7QP1tmjYAVT828VLE8ZaLVkBXCKwIa6VLN3T0g1IasXl+iWls1S
	 NCqezPIbwNOPd86sGusfMgtxULmVoi0D2OxJRgFwA5PrPsxeN2/uzOSppW+F926MgK
	 UpeIbrYhdWwTtiXPWnmg8Bui3MXdTsfkDMw6BKY+cCWziT+RX8iVkD2gEbHBkt8jmt
	 GfrEf/6PijziQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02D0A40346;
	Tue, 15 Sep 2026 18:52:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D94D62E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAF16606F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Om0zS1fQ0fH4 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 024FE606E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789498351;
 b=jxCGIFQfosnxNKDKJqeCBJLORPTNhbNaR8uYmTaqU9YIKRWk6BGfmc/NHGhoP+PKHq3A
 mRqjJVnzAtYfrDEaqC3A57hcQusc0sjxbNqP0RLF79BmiBqjhoHxfsbAgk6mYoBx7v5YR
 hodzQJ6P8KFfCAsCPCC6unP+Ulm3/zg4yOo9yAp/DY3l3+gbSGRUwcgKVVq8ZgFyQNk0N
 xxQ38c1kXtDfhRDLfEChfoPjV5kEG7+YNy2yCzMpxgmDtjTcCTAPL3WkxhTcGmXslm0/b
 +FAm72I/3YxMqaqGlIke18xU8vPDKQy+bIYxd1OFp/PJez41qorQmtP7/oBPMnUQMYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789498351;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=72tlQhpdmngB3szUrALiHxqSz5LmQFAfQZTFPwAJsm8=;
 b=MF1oE7N3CcUP2duSpuQrN+4d7fLcRu73Bpaxk+9osCT6x6nf3BpOojpnwXH/xElxg1Ax
 6quF4uyRwyLqAFZAgqKugM/duA96lS5gXseTnr2PNdLyFfwvmd7/7GnWz4A6iFSkObghW
 1uhPp3+9L5WcZkeoqTbEIToxDa0QtdmD/VN37HbKdyupzYavfuljv+z+GRAosLtYVU9Wn
 epMb56XwFT0NKWtHDpO3BzuEF8DzNYvvRX6LmkKwEVAtccSnAY/Lx2wfF1IGfWKTsxArS
 lZyUJECyT61FN4PENi5ATDYZPndMafSb3F6xAHtcV1udcU1QpYCjnIRcoE7/soGeUvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dj46Dqgm; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dj46Dqgm
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 024FE606E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:52:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0657C41A73;
 Tue, 15 Sep 2026 18:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A61F00898;
 Tue, 15 Sep 2026 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498349;
 bh=72tlQhpdmngB3szUrALiHxqSz5LmQFAfQZTFPwAJsm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dj46DqgmsACSwFq9HJ3ISBz0v7KQClcuynuO9qvwXog58wO/ScSuYdaGZKHgXWvfQ
 MNIiLR6/CWGcs2B0MhbCRK2aMTRY6dtK71/bGZdxyT8HaMz+gX3i3TsfrQcfD9O/2g
 F9R5HI4ZwuLIC/dDLbKGewTrvAWtmj2/uWtbnlwRjy3UiF9zVvG3Q4LlI0NpvD8aAJ
 DJrMkybpP4frmHg9A0BF8idW56jNNHHMO4Q37zU7dBONYMBSpnYs1SU5pr9ZdsZbOO
 Z8bm6ke0y1pxqCSk41Eg0cXZYLGeU6SHZOeCpu7UYnxm14Kt0coiGxiIX/45p1elM6
 JGYqDbDSmP+rQ==
Date: Tue, 15 Sep 2026 11:52:29 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>, nikitash.mariiaw@gmail.com
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
Subject: Re: [PATCH 21/28] NFS: nfsroot: Refactor root_nfs_cat() to use
 snprintf()
Message-ID: <202609151147.C5B45CB@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-22-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-22-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:38AM +0000, Bill Wendling wrote:
>  fs/nfs/nfsroot.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

This collides with:
https://lore.kernel.org/all/27956255dde39f58d73a7b51cb53cbe3d7804f54.1786411026.git.mariianikitash@google.com/

> +	ret = snprintf(dest + len, destlen - len, "%s%s",
> +		       (len && dest[len - 1] != ',') ? "," : "", src);

I prefer Mariia's version because this inline ternary is difficult
to read.

I was expecting to land hers soon if the NFS folks don't pipe up. It is
one of the rare cases of still being open-coded, but the strlen() usage
was pre-existing to check for the trailing comma, so it's not a clean
seq_buf() conversion candidate...

-- 
Kees Cook
