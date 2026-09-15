Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C1CC88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8626F60717;
	Tue, 15 Sep 2026 18:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNt7B9uzXrMl; Tue, 15 Sep 2026 18:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DFEF4606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789496723;
	b=KmujiXHxvYsiQAQPBOVpfvcnkjsX/SLMM1efd/skvAx4fwxTw6m7LoS+Wnm7EIukfVln
	 AlY7J12eSEzepl+4jGhWtXT51z7OSLQO5d29GeUNT9l/1zc36olo3klC3pkw0FnNvqtno
	 B/6VPAdI2Gvq6WCxoKklOQy4kA+CDe95sDqjzwqyitce04RSKinxwtCVSDh5IZ0hDEGAH
	 MlHhOTsYGKLG1Jh6T7WjK+4/NFza51keBoLFXwRv6CAW9aZ6GidpK/fKLKUmKYV2zgUrB
	 LvuSTYhwF7GoJU0D5l0yTd6/DGHSt0dhepuPbiIK7bSCDtBf0t8wSI2KhQm5jFDVVAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789496723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hTpYvUrNZYIcwT2p8Kp9xxQTu0Fq/HJPfq19mi+/XYs=;
	b=ODYd5k4WQZSUtYUFkYJTOHFWLuOCXf3P+rqWiBs0s33W5CoiBGVxqI6+zJAXo/wwTfKA
	 e8X8AvshiDT0VACQXjBvSOnVx6LDVh5WFii+8vBA+H+H5b0qTZpprD61x9bqhzL+pVV8D
	 zMP+7KJx7VSy+T7hKWuDaW2W2/rMV9+xbZdpE+Hh7rDm0mCUv/qp4NHxuRZNuGmH7Oyq+
	 nZ6rM4rQyu0lR0RtwbR3TAH8Z68FyAUKhljKU5cxRoXRXv/lBSa3ZXydvlmQZWxZ5ipCQ
	 FkizTFLme95fmmSnLDwOWzN7RfWeG+9VRIjpqM5sIc6jiTcx5CJSK/YtEVcXtrGFO8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8f94G9m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789496722;
	bh=hTpYvUrNZYIcwT2p8Kp9xxQTu0Fq/HJPfq19mi+/XYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SP1CXraIKM7F6pM+hATP+FZ6dOTK5sphz1B1Gx3r5s8IqmPJfp9OrwtxWOLlm+0r8
	 5H6bRguTKfP7T1J5C57bFV05ydZMHOhzshwjhi+VBxfCiw/srkT+FS3nce3hbGZI4K
	 g5zEBFyQXwbaxZ/yzuZxVUi+oJoUxxhbKYh57F56m4OT4Rb9hhr4drRQNxWB7IL+02
	 cIMuo4bOxk+Wm5IfzuDYPl4SnmE9tptGkLiqoYra9bbP3Eu2jsIPvkWRx5DVp5LQXv
	 zmxB96BeiVZ8fJMF9N3r3w7k0mPlgV1hv3KLufng2Icr6I2/kwNrEoOR/MM7eDkRzw
	 7bBFu6r5swlwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFEF4606CE;
	Tue, 15 Sep 2026 18:25:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D35A23F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A558606CE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Glp4-WmzPfL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 29057605DF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789496720;
 b=a+ADb/quOjp8LDuvHwAqloFEZpC6V3H/rwQNjkt15FD2CnuXN/d9tX/065s+DxeOaNkd
 7cSKOET3y06mYDiGYiV6MrswF+2C0nRxz0MFMninQFRZifplKN6MlR3xia05IoxwmgPX7
 C+nb/N7W7guXbYNDKYMgrK0CFObVyu2fL8JaQitWUFdxKbkzQ8Cg2tx+ww0QZ9sK0zKo9
 JPD65sSdWKFr2LJIQZ4jibisnciLLhhnemKIlyscitA0X/sOfnKKbk9YpvDMAGaDlzf6A
 k8Ncq22dp/uvdhGH2GLL46G0IcD9GeIo/HZT3Ale+Y1rVpzjndLIFofyMX1dhZSqqlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789496720;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=hTpYvUrNZYIcwT2p8Kp9xxQTu0Fq/HJPfq19mi+/XYs=;
 b=DpQW17zvmnKGWSpAN/n8RWu7j/UYh6ZtBICffL1fFBf0EylYZAmJc20sntZK9LegM+A4
 YSA2qmhB9h8MIkeOcJhXOHJZY/HEMP60C2L4h7FxCYdDgXOblF4Yyi+Hj+9pYqHLc9B3P
 gLXlWOulN8owEblCCV+3IFs84Wjby56I2xmjLc+hH8PXac5h+bEoAlw6LwvNdHp3rBsCB
 aWznyAhr82mu5rxR8KaMSQEyWxZz1Y4xY+buj0GU9elYO5yqg18W2SgYLFrKtgD4A6t6/
 ovoEpLUQvbK7yuQRHErn5th3WOB9uhGwD1KdLO9yT9vwb6aJsPVF1QBkhBuET44ocnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L8f94G9m; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L8f94G9m
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29057605DF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:25:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37E8543A1E;
 Tue, 15 Sep 2026 18:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146691F00898;
 Tue, 15 Sep 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789496719;
 bh=hTpYvUrNZYIcwT2p8Kp9xxQTu0Fq/HJPfq19mi+/XYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L8f94G9mzSlNx9J6peH2jq3tNsTcUAybrSOzdJm5ksOR557E4eGHcMVdBvQoWXcMq
 oYUWohx4rX6UR3J8jBc8XVQjQr+ber6bJ2vp50tNPAhHXUhxRHLXdtKpPq0X+kq2PU
 gS7xFPkE8iTk1ZUf6F23/XNJ6TOWElkc+PU1etQ49xAX2Mcf5D6gOEjjFrhGeHYmwr
 quZO6YQ0w3g8MteVh8aIX9AaqG/9TfYwvtfMkvsA6bgIrhU7eO551to4fm0v6bfd4/
 BM4spkKqe45r4JjrhXiFS+HNsR69yIhfKoowbJLuXi0Q2cu8W8a4U8wu0elxPZcyTv
 CP6MLWz/FZBtQ==
Date: Tue, 15 Sep 2026 11:25:18 -0700
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
Subject: Re: [PATCH 27/28] drm/xe/pf: Convert strlcat() to seq_buf in
 control_read()
Message-ID: <202609151115.33A35B7098@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-28-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-28-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:44AM +0000, Bill Wendling wrote:
> diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
> index 0f242db775e1..5db7fc067c4d 100644
> --- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/debugfs.h>
> +#include <linux/seq_buf.h>
>  
>  #include <drm/drm_print.h>
>  #include <drm/drm_debugfs.h>
> @@ -663,15 +664,15 @@ static ssize_t control_write(struct file *file, const char __user *buf, size_t c
>  static ssize_t control_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	char help[128];
> +	struct seq_buf s;
>  	size_t n;
>  
> -	help[0] = '\0';
> +	seq_buf_init(&s, help, sizeof(help));
>  	for (n = 0; n < ARRAY_SIZE(control_cmds); n++) {
> -		strlcat(help, control_cmds[n].cmd, sizeof(help));
> -		strlcat(help, "\n", sizeof(help));
> +		seq_buf_printf(&s, "%s\n", control_cmds[n].cmd);
>  	}

Yay seq_buf! I would tweak the 3 init stack variable lines into just
using the single DECLARE_SEQ_BUF:

DECLARE_SEQ_BUF(s, 128);

>  
> -	return simple_read_from_buffer(buf, count, ppos, help, strlen(help));
> +	return simple_read_from_buffer(buf, count, ppos, help, seq_buf_used(&s));

seq_buf_used() isn't correct in the case of full-buffer use. e.g. if
the help buffer ends up filled with 127 chars and a NUL terminator,
seq_buf_used() returns 128, but you want 127 here. Using strlen() ends up
being redundant, though. I think we need to add seq_buf_strlen() which
handles the same logic that seq_buf_str() does.

-Kees

-- 
Kees Cook
