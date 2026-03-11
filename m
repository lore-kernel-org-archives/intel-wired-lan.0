Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ECB1125807
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 13:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B71442163;
	Wed, 11 Mar 2026 13:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2gn4e8QBmo0; Wed, 11 Mar 2026 13:22:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14DD34215F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773235355;
	bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1+c3hB/yHoO+rACQQ/C1nFn4vSzZ9GEUf39MuK7+teTBn9vS1MQyRNvlLPehfcYbl
	 8bIjLkN/VlLW+KSQ4YhT2FtdeAaS59w+lHWBAlotwYgqWS4ktqNb932c1Wx74689m2
	 58C+3INcIYMC3X647iWhZ0HRPnbJVCGWhpyuhiy7DlrLGghhURJIOCemIWWCuuS8dg
	 1aWcPeY9KjpUEYpVnv48onEFKkll1FUL99qNZDKKMhcsANwwaZRclwIBe2Vv1VKyS2
	 2voqzf//jkArfGQWfRzEehx2jvb8mruGhgjIDAehH1KuXQzIN40GXObCHYQGr05R+P
	 Nk2DiX2i5ogGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14DD34215F;
	Wed, 11 Mar 2026 13:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95674228
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 13:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B679843AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 13:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0pHKpX2yHE9h for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 13:22:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.217.44;
 helo=mail-vs1-f44.google.com; envelope-from=geert.uytterhoeven@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8E4E082356
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E4E082356
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E4E082356
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 13:22:31 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-5fff774800cso3499993137.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 06:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235350; x=1773840150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
 b=lBhbzEDMr8OOMMcDwpqaPkzeIx1wB19R4L+FvNGTPx3KbzJ5SKyx1cw9mFd1Hf39ES
 zunlwACK8vAdrkXdUi9cAnReruGlomOK50i6Juroh98m8PblzjfTZPAxHsMqZYld/aXo
 veB+agXlnkr5SECD8WTsBrdwxYnM8BUJUXbcIb7SNzzHqJeLdUbE0OFt/I01FdJdjtqI
 gVuGUDRJET+lFjdngq117PxOrXMHsFuIoIYBkhkH47PfbwtvnwJ5ufFQQf94ar6yZ70x
 GFSXctye/z7VpBMIdn5qoUwtcjKhtpJdBN0nq4FIXboVWpSv/HhgiHrAfvjQH+wNLRV9
 m4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMVFD9H7lyT7RrtoVd85Adhp8yGMu48sFj4Sz+zQR/JqKM/VzAlyP+IcyJkhi762/T2UY684ET4RTrIcc0x2k=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzB86SBS3NTdorspHvuPJcFoBImZKx69+Nob2xvu4zQgv7Fswjy
 i2mI3mLYiz8/MOhcok4VQ8IIB/j+xiikpZvZuKy+zrESWsYZe8aWlj+510anK4kKcbM=
X-Gm-Gg: ATEYQzx/bBA5gFvDupeQTyznhRuQw1bNqfw21HN97zDf/p3EXSK/W0LqhfgFPWSSbli
 gghwdBpvNxq5zf4+iGO1K+frO2yyJFnOwUna8vKmoNkaCcjEnR9gSj/AmnRdMCwfwoPu4r8a72s
 MEVDSXZdj+Ix1ZXPCf9yhGdJXl9wtx3jrSDX+tjLuNhEvPwpNvvMosX4+6LX85RmF2zJEue9kSr
 L8Aru8GImmtGYLojFKwZyLsOaXBwH114vffBFoDdh5oWK8zYNCiPftCsupr8bRN/EHnTatYt4OO
 HMPAryB3RPgydwrkcc+/O0QsSPxZTjP3VuYs+oZvTNc5BD+B6jk+gZYbbfH4TBuWo/N9uyh2xVq
 PuhXXxM+AVdKlaOyYwCe8vrg79mjWAt+3eZlFQ/zp70b2h90Dpb+PVmJMNo8ZsRRhBrQEnrK+Hq
 7Gmzsfr5MErzuXnFgHnFKWLL0dbufcIg8npW0wCe9Sdws0ZO6sHzs0y4aoDguX
X-Received: by 2002:a05:6102:370c:b0:5ff:9ed3:448a with SMTP id
 ada2fe7eead31-601def4dc34mr950504137.24.1773235350058; 
 Wed, 11 Mar 2026 06:22:30 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-601de6ca1c2sm692066137.2.2026.03.11.06.22.29
 for <intel-wired-lan@lists.osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 06:22:29 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-5ffc879c1aeso4444910137.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 06:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVquQJ6EguWW0livlDWYpgxCkf1waWbxyRz3NcgRaNuP3vsuHEzSW8Eq2oEIVicNbLTXSaoaCDk6oMMepDA/mE=@lists.osuosl.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Subject: Re: [Intel-wired-lan] [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL
 over manual NULL check
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
