Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98329C54E4A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Feb 2024 16:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B84B60E80;
	Wed, 28 Feb 2024 16:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWsTvqdu_pNz; Wed, 28 Feb 2024 16:27:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC8A360E51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709137659;
	bh=hWtL7++GjICFukUAoP4h+KhEWcLjTOAu9lMF7xAGsyw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lrDxzviM9+T7E0aJIWPeY0pdAW1EGW0yEFd9BzRNj0R4k9f4KjkxQIdMUsieuOGqr
	 6PGrN7QWLvjF9puI+6zg4xmqD5RnPRf6LfWAChq/7CLTjQaVC7+/LdqbNakucgFjx3
	 g7VtLohfA5knIsRsoY4U8dDtVhFyyfb7CkQ9THsaKADQ7jKZzX5i8gB3dpD6IMlwkK
	 fagFuYWw8Q7ayN8q0EnCkmjb/bBmpF4E+sYsv6lcG4FzQtMGeyXsMHGKM3k1Rn2i9S
	 YOJKPWr4mevmcotYESjAQDNtRTxt6/sSej02Fp2E9XUUOikEmoujH4DDxUQEGIW2N2
	 6OYvhuEfpa8jw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC8A360E51;
	Wed, 28 Feb 2024 16:27:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EB0B41BF2B3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 16:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6F448243B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 16:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIPD_tqOnnSt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Feb 2024 16:27:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 27EBC80C08
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27EBC80C08
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27EBC80C08
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 16:27:37 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dc238cb1b17so6083242276.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 08:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709137656; x=1709742456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWtL7++GjICFukUAoP4h+KhEWcLjTOAu9lMF7xAGsyw=;
 b=gr7W5qqI5rX18kUR5+HMUT4EpK38uV9MLa2QIHf9VoEXY3umrfaBRh98pppYEOP9SJ
 bWcN7/8DVrUNaPaHr7IzpzaUvCmTlowZHp4bn7v1Naf/wuhZbB+xvx2PlOAlcNgVLErS
 lmVQ0b4CR/VyQ4EPafmUduue6UMcmGSSfJOrVywBBp6n5p1v3lidtyupymJNro9e2IIZ
 AKvoNJB6MyAThnfskDk73eFBDs9P0FCQl/uH+7lg811lwTShnDzjkZ4mWJsWDNb7fuFb
 Nchu7Vu2THNZ0XyHdQYdtk/dCTgWmp8yX9prFTJaW4fMH5uxgdRi41s49PX8Q/P0sD69
 DRCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrqDqiTyFw786so05HacOSqg2d6nK1okpuBtsuim3xr13GyEWXu9A/puBaFSD45xGMrSKHeVOu4O5qZsU+WL4NMb72Qfp/iLIHYbrXxN9q8g==
X-Gm-Message-State: AOJu0YweQN8FM7t6gpQkoentGwpowMbayR52hRQQKuXaMwUTXLGY3sv6
 fr0D4lO3sLYAnSK37MIDt4VbPUSSHXI4/bYVIAMyo4Rp5nbG5QTL
X-Google-Smtp-Source: AGHT+IGgZ4Kkae23Sonz0Wy+ywJ8k8WbRQHuZh38JY+GnbqJ6cshhsv99aWcYpDQ6qckCPnCgMPxgg==
X-Received: by 2002:a25:e04e:0:b0:dcb:cdce:3902 with SMTP id
 x75-20020a25e04e000000b00dcbcdce3902mr2751167ybg.55.1709137655985; 
 Wed, 28 Feb 2024 08:27:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a5b0751000000b00dcc3c85f6a1sm1956317ybq.6.2024.02.28.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 08:27:35 -0800 (PST)
Date: Wed, 28 Feb 2024 08:27:34 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <Zd9e9i6FQzGWfHBq@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-11-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-11-aleksander.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709137656; x=1709742456; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hWtL7++GjICFukUAoP4h+KhEWcLjTOAu9lMF7xAGsyw=;
 b=QinqqSJUXP0sw5UTFY4dpZdK9qIJQOsrk6tAT8LExsjFBLS9KftuntehekU0+ZQ1Fb
 KD2YEjvCP4+IfeileZSl1t4zw4PTb1MOuKpNaVVJoHdw+94qpA3l8t+gFLylDLzKTDT2
 t+a0JKoJ3nwVGHHWTEluamPF80fcapFgPrL5ZxWO2NN8TKHlogr/X8D6Zmc0thggnJw0
 j9KGQfhdAE775t/+uG4RXesnkgxTClAoShy2zfMXtwpdEZU877GSpa0Mt0GVlLJxBqGG
 XacggQO9O0HZ0T+frUG5czE08cHaeM+q+p6IQxdEOgJGlovaRKQ6K2w4H0T8ArAm0dMm
 N84w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=QinqqSJU
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 10/21] btrfs: rename
 bitmap_set_bits() -> btrfs_bitmap_set_bits()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, dm-devel@redhat.com,
 Alexander Potapenko <glider@google.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-s390@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Ido Schimmel <idosch@nvidia.com>, David Sterba <dsterba@suse.com>,
 Andy Shevchenko <andy@kernel.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>, Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, ntfs3@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Feb 01, 2024 at 01:22:05PM +0100, Alexander Lobakin wrote:
> bitmap_set_bits() does not start with the FS' prefix and may collide
> with a new generic helper one day. It operates with the FS-specific
> types, so there's no change those two could do the same thing.
> Just add the prefix to exclude such possible conflict.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>
