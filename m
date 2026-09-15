Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB50FC88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A70B060717;
	Tue, 15 Sep 2026 18:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Olk4iE29fFl4; Tue, 15 Sep 2026 18:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD5C36071C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789497026;
	b=mS/tymZQ8YRY3uIWmEvtpz0hUlSa8HOsBfwI9fY8Q85aL/pXh6Yy7MhVH6fg7teuh2ZK
	 TAyVDwgXpGPBQnD2Rl4omE8WHPOoZ6haf53Z2Q5vAMnR/2RwKYAYh1U5NxzrmfcdFCg2E
	 VUveS1hDT8ynNvPmy1oVMKLGMTrlN22l+XshcVbGcjG/nBhhw09wTRMhx1+ZCUjMniZsk
	 zqOkWgLR1WJTV2ShoOHGHB0JpV4qGOtfBdYNQZGsCcuYTxE7gVMUa0Pe7+ywa4EZLfkFt
	 OfE+eJrUApyKHFSIEIS7gD9h6YWW6TvEytnRUW1nRblII31MMLbAC1ftFmp3BTrNSQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789497026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zCJx1lMoPaoDeiIN5oezRLV8MqYpA3JhuUg8Z+dhoag=;
	b=PM8BZI04pWxvswOy4ghVxE+c4ZP970XVB7TIvEuwUd8gkH9cCKNFVe7DpYqnK41aTNOk
	 ol0HKr0Xp7qvFntPoLUDdc/RoumyNkn/+BAOvUDw6gmJsYIQnKSUbIcxSE3nKFCfdBoeW
	 8knsyAQ45ef0ACgRsu+KT7IwrX2y3ashbPVg7KveNmyXxvqHb9zZubhmwuxKcLTWLO1oP
	 KHtuuMvNwV9dWIqu8Gc+bBrnng/s/iX2nKBjHaD24tQbEfu9FgSaCobc4tZkPhFTtMFWQ
	 oKtioh3/7DQaVBrbFdKRPBPJn6EByGIEF9aR9w1ulVWlsyE/3SVLd3dpRcAOUmacSIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789497026;
	bh=zCJx1lMoPaoDeiIN5oezRLV8MqYpA3JhuUg8Z+dhoag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NcVgTQMI8Oqz2n5NSnjARhtFII5d0wns+jr1HD++KUdYmgiWAa14kA8xSlMXaijB1
	 ewiUO+gUL6s1GJ/DvCZFNq0iMLYK0/PpKpodA19LzFCvbJA3qcTQMT4UcLEGmY/JTM
	 r1MtbJcz2MJDK+UQL8kh089j5AgDc7NwykxXlUu4Ejxjx5Hi9i6wDdVMqMrdyM1kXl
	 VaW55IYOJrIAFtahy3lM5k9eXtMzZAdV6yEPlt3skx1BJLGayzbEOA4PIAWhSeUW6s
	 1rPk2p49S4ltYt1wm4kgVfFGreSWbDqpQLJyjApBu3etntdLg/emVOSZlq46m0Yu0p
	 0Xk7vBry7NhMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD5C36071C;
	Tue, 15 Sep 2026 18:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B3A223F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 581E640514
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 023bApiHMJCm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6287140506
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789497024;
 b=g1iF3g8nU5/HUtXSR4Px/zpw0UXEk0y+uGcrg9PeOJrPSAyc4lsL7Zzbj2/HmgEuXFcF
 wI6cJbc0aDH/mbcjBJHl/39azoTYpK83W46gcAQeD4++DENCcQtWviGvWoChAiI5WM2m7
 U0CYL5n3GueL/RFIE7kEXm/odDXrxVdgBIOppzgk9KESBtYd9GF8GoFx2zKqea0PFSXrS
 yJZjB5aqDoi0zYYZ8xGn247T7OrW1vx6qvEUgJ/HftNboyuIUE1BBhItrYSeuUCUbhoHl
 YDpsecayol3SozZtwkHiqdwRYGRLVewBfRF+csF04Z6s7siLdyg8lmz0VKyib8aoROQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789497024;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=zCJx1lMoPaoDeiIN5oezRLV8MqYpA3JhuUg8Z+dhoag=;
 b=lBXGmF4CvqN+Ah7dvTa91H8lzTdi7YXsj3iAK8ADEfcUi9pnw7rL+X4smKze+YHQl0Qr
 icYL1wi+NNkdPRCJh6jxhT/EOZLKFpjP11fLCkj+NztE0JTe7c+4NBa+LJ3YU3+l6GGkw
 KICS4CFc1yj6OamipFRQu+AhFtQFOi9WNrqatbs744QEg29/ZCLJ6OOcaxnBDyA51Jc+l
 6eGyEUl14dmHmtnijeBIm1VrO7qwAPqF2S+IqXkStNeVF6otET02jNb78fXhwYOtWmqpk
 hWjcRsXHJV0wD/UBs9gknkUekjdcBtps+MR8uMGeWIR9CiPky3LDzlU3QmLbqEnYbzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FtG1AIAh; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kees@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FtG1AIAh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6287140506
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2728C600CB;
 Tue, 15 Sep 2026 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE75C1F00898;
 Tue, 15 Sep 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789497021;
 bh=zCJx1lMoPaoDeiIN5oezRLV8MqYpA3JhuUg8Z+dhoag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FtG1AIAh8Ifu90TvPASnvJLKq/3hHoybYyG8CBtKd2A3Tko5EoQZmhxlykHybSWCY
 H6+cZEX9BUB3VzICpj+OZxPJ673u94nnolr9H+SDA6dBcoGGYAc9yHJcjV+Ep8BP0l
 el5biVBlyvnMpvBBdnmFKteUXHpcuI8Bb8Pu3nE8NtDNIpu6JJu8fFsiOvrLa3Qrgq
 NkHBRSaDsJkBM6eE9SQ++npMsQoPqmrvJCP6/7TZu7tvF19A4a5+2+kwcqpI8v/iuX
 YN51bg9WV0sHN4tZ47tD/7Vxl/N2tA6azTTrtrat6edEQApqlwzt/pVbGgznFVhGNY
 okL3wnYQoU9Ng==
Date: Tue, 15 Sep 2026 11:30:21 -0700
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
Subject: Re: [PATCH 28/28] drm/xe/pf: Refactor strlcat() to seq_buf in
 sched_group_engines_read()
Message-ID: <202609151126.29464A5E1@keescook>
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-29-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081910.4142719-29-morbo@google.com>
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

On Tue, Sep 15, 2026 at 08:18:45AM +0000, Bill Wendling wrote:
> diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c

This is the same file touched as
https://lore.kernel.org/all/20260915081910.4142719-28-morbo@google.com/
and doing the same thing, roughly? I think it'd be best to combine
these, especially since one depends on the other's addition of seq_buf.h

> index 5db7fc067c4d..548a50f74422 100644
> --- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
> @@ -377,8 +377,10 @@ static ssize_t sched_group_engines_read(struct file *file, char __user *buf,
>  	struct xe_hw_engine *hwe;
>  	enum xe_hw_engine_id id;
>  	char engines[128];
> +	struct seq_buf s;
> +	const char *s_str;
>  
> -	engines[0] = '\0';
> +	seq_buf_init(&s, engines, sizeof(engines));

As with the others, DECLARE_SEQ_BUF should be used.

>  	if (group < num_groups) {
>  		for_each_hw_engine(hwe, gt, id) {
> @@ -386,15 +388,14 @@ static ssize_t sched_group_engines_read(struct file *file, char __user *buf,
>  			u16 guc_logical_instance = xe_hwe_guc_logical_instance(hwe);
>  			u32 mask = groups[group].engines[guc_class];
>  
> -			if (mask & BIT(guc_logical_instance)) {
> -				strlcat(engines, hwe->name, sizeof(engines));
> -				strlcat(engines, " ", sizeof(engines));
> -			}
> +			if (mask & BIT(guc_logical_instance))
> +				seq_buf_printf(&s, "%s ", hwe->name);
>  		}
> -		strlcat(engines, "\n", sizeof(engines));
> +		seq_buf_puts(&s, "\n");
>  	}
>  
> -	return simple_read_from_buffer(buf, count, ppos, engines, strlen(engines));
> +	s_str = seq_buf_str(&s);
> +	return simple_read_from_buffer(buf, count, ppos, s_str, strlen(s_str));

While this is the correct length, it does illustrate why I think we need
a new seq_buf helper to get the strlen result detected from NUL
termination like seq_buf_str().

-Kees

-- 
Kees Cook
