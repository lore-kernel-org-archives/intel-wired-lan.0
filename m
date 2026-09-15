Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFA4C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 11:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1395680CD4;
	Tue, 15 Sep 2026 11:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jh6ZyEjiG8oo; Tue, 15 Sep 2026 11:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BFD180CA9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789471813;
	b=iNlyWxZlsPup8j7oU7EVatciUpafFNECbMAG9pod7HD6L4mje+suojJgI78cG4MAW3k7
	 B3zBycL/JFY1N9IKdBS4Jb05Gp4TERPRBNPwmedGkmbSeuFqHG04SfM2pHon3sI8oaDGw
	 f0P4iLIgJl1H1/87Qr0JWRh8cprB8bxG5UDez4uobrM6J21r9aeUuGCPkgNjCztuWmZIC
	 d5jji2YsQTZvJVOHqeJQ76VE66Dpr/o56ZlzKC+NM1kM1yjv1TC6PrUE1g55a8Fr0QGRV
	 zQEuB64+MRvK4cpkDFw4yH5kme/1xO3IAzVlOx26WP3WWK5okiXEDDI/EZ373qyCVFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789471813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 Received:Received:Date:Message-ID:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:MIME-Version:Content-Type:X-Spamd-Result:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
	b=P5r1PIE1z1bqMfnoXZmG/lHNX3w7u7cQqFFP4X1anTpJMc0jOP36a7jlpUAHaFShyeWV
	 3124FUxSmq5kbw4oH4oYl1aVOTKP27oRmCUZ4BrlyPt6YcHlZkV8jcnoUataPo3+bI6Zx
	 ivmd6fzPRTZuMWiE+zy+/640VVCIfR3sd+tMkmrEydTFN73fgk4nX0RRkKITBgl1uYXHD
	 Hh+VQBc9HEWF69/N+ypKa1AMuyhDYINFvLR/8xZPzvkKboJqzLg1RUliJHoC6MWTzchpm
	 3mWfhN45mt9d3nr7BaitIkg2RtI+VmVZDT1vfpJpnQlPZNFGQ0/Nnm1QW0T8bLcHWPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789471813;
	bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUvqfctzgSRwofIFHHlSuKs+wvOzb3qiRmagYkcpRqci2yhTmHnv3+byf9JQ2GudC
	 reG5aA/lTqHFW8Az6GYUOsBZrX0pr6KxFlgm5wEGvBvRoyu/E54XUmwrKJgjsJwobO
	 iadKGyPfhizACwtBk7e8IQC2u10zr6umGKdaNiQxnDJhFQ2EJhArDB5X522rfl/MK9
	 VNubypIDI31NAW8fs21moZSqDGFCV34LSKMzT31FL58sGcQ2bCmDDfrvpCwObaZThT
	 Bm6g+mMAWvaOrqBWm/A2ZIBHvYmUE+1P7tr1qPWtW6vkutIx2nCFzk783X1vWeyGW1
	 3ieNsEDv4hFlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BFD180CA9;
	Tue, 15 Sep 2026 11:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D293C259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B87B940533
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3lwSgjqwV4f for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 11:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2803540568
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789471810;
 b=DkdbXMAEpqXCqBilN7aGJyKLxKxp2ECE8aW43UI/6PlcKn5EusCQICig5V36grQZmbEM
 vHBih+7K92KKALqjMzswU/71nYusOnwIH2qN0Br1Lp12NDi7r0ZsMiQDTcHUHkbQZJORH
 DxUP8gIZZEtEbXCVC71nq1QaTgUCFgRL9N0zi5WLPg7/qII05p1ashUWFbTAyVRt2R+ld
 F11p2gLw6kZ2ggvsZHnRzVEPXzNWLh/n/s5m2bv+eR8yNiO0WK600+h8SBaBPbcaLaHpo
 HWH69c2DWGIFMxCnhde2BB8G1EZjDNWnkhAYSrT5BgZ4zL5x270vtbdO8xgt5SxWvPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789471810;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:Received:Received:Date:Message-ID:From:
 To:Cc:Subject:In-Reply-To:References:User-Agent:MIME-Version:
 Content-Type:X-Spam-Level:X-Spam-Score:X-Spam-Flag:X-Spamd-Result;
 bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
 b=VO/TtXbI9ZD4vN//zzow8RT5ELBnJ6hNwE8M0b1hwgHbqYJXE42DGCoxA14r/8sSYWsq
 DZv7+MWQ+FSih5u8m0LPvxc37E6owpqVdHpHvY/RD9Vrr1pwKtwP6+NCbH6a7rrqPepzR
 TQs72b/gTlXYbEOv0ejDRaH+vYczk4P2DtFftR76UzrqZEtLG/IEbQPSVzTZINtUA1dVT
 ucPWDozRKK9UYVJrdM15Lbe4EdHx/LcmcxnT6SjEiahZH1dv21NtOTvvQYGqUBYq3uhz3
 AF3U7SNIZPl7p3ygZGnqzQX4ZdehY/0gY0IWGlBykyt40YUY5ps++nuQmG3jOfL4DVg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=suse.de; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=FSRxqY26; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=aSsl2yJ1; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=fM3MazBW; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mZlA7k8x; 
 arc=none smtp.remote-ip=195.135.223.131
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 15 Sep 2026 11:30:10 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=FSRxqY26; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=aSsl2yJ1; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=fM3MazBW; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mZlA7k8x
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.131;
 helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=<UNKNOWN> 
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2803540568
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:30:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D6D911FD70;
 Tue, 15 Sep 2026 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789471494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
 b=FSRxqY266D0vmKnF9nLIRDyWWQM9yhSRf7SWuTSbWdHKmTZfPMBWgLsJq7H8V56FVkky//
 8MrE9PciUwBdoFcR4M6TLhf0Be1H7UyuT3X6eiMNzlMbbIthbvGQDSnAd0oqm56+IjjTWt
 ZfmEPFx5zXWF3FpvnKWoZi5XGYuzP5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789471494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
 b=aSsl2yJ1+boxtQdbyNVNOLHSB2zJu6wAGQi+9pbebbTp2ClXENyw6idF+ycsnZ57BL4LP5
 ZfcRP6lnX00QOOBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789471489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
 b=fM3MazBW+hs/hKtvuJpOhLlGSwWwaQ2djpqh86ob84pD05SZM2CRj5VxxQICSBHMVzGpmM
 q+b1hMqeOfBJ55X5lnPhdG5/NgEY6B1UbwH5ynoyuWcf7dFOEalvw2kJzBP8r3CSUcnebL
 CgYXNAhYVAwFaBsCwZ7WQRZMQk8ez5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789471489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psqF+EOKBnDir7oSpdYk0cv/7bWaGxT8GNrr5rPj7yg=;
 b=mZlA7k8xRY7/6eU8iSFueII5CBhiyVG2bEJOGnMSAtyaRqGo3EYAuYa/xTgran4MSxXe1Y
 Y2dwysvA+85ERcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1B7713693;
 Tue, 15 Sep 2026 11:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2riGLf4qqWqtagAAD6G6ig
 (envelope-from <tiwai@suse.de>); Tue, 15 Sep 2026 11:24:46 +0000
Date: Tue, 15 Sep 2026 13:24:46 +0200
Message-ID: <877bkmn4e9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org,	Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,	WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,	"James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,	Helge Deller <deller@gmx.de>,
 Thomas Gleixner <tglx@kernel.org>,	Ingo Molnar <mingo@redhat.com>,	Borislav
 Petkov <bp@alien8.de>,	Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,	"H. Peter Anvin" <hpa@zytor.com>,	Ian Abbott
 <abbotti@mev.co.uk>,	H Hartley Sweeten <hsweeten@visionengravers.com>,	Tony
 Luck <tony.luck@intel.com>,	Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,	Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,	David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,	Matthew Brost <matthew.brost@intel.com>,
 =?ISO-8859-1?Q?=22Thomas_Hellstr=F6m=22?=
 <thomas.hellstrom@linux.intel.com>,	Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,	Matthias Schwarzott
 <zzam@gentoo.org>,	Mauro Carvalho Chehab <mchehab@kernel.org>,	Tony Nguyen
 <anthony.l.nguyen@intel.com>,	Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,	Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,	Eric Dumazet
 <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,	Paolo Abeni
 <pabeni@redhat.com>,	Arend van Spriel <arend.vanspriel@broadcom.com>,	Rob
 Herring <robh@kernel.org>,	Saravana Kannan <saravanak@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,	Sylwester Nawrocki
 <s.nawrocki@samsung.com>,	Peter Griffin <peter.griffin@linaro.org>,	Alim
 Akhtar <alim.akhtar@samsung.com>,	Linus Walleij <linusw@kernel.org>,	Anil
 Gurumurthy <anil.gurumurthy@qlogic.com>,	Sudarsana Kalluru
 <sudarsana.kalluru@qlogic.com>,	"Martin K. Petersen" <mkp@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>,	Anna Schumaker <anna@kernel.org>,
 Mike Marshall <hubcap@omnibond.com>,	Martin Brandenburg
 <martin@omnibond.com>,	Kees Cook <kees@kernel.org>,	Jiri Pirko
 <jiri@resnulli.us>,	Simon Horman <horms@kernel.org>,	Chuck Lever
 <cel@kernel.org>,	Jeff Layton <jlayton@kernel.org>,	NeilBrown
 <neil@brown.name>,	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo
 <Dai.Ngo@oracle.com>,	Tom Talpey <tom@talpey.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Andrew Morton
 <akpm@linux-foundation.org>,	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Kanglong Wang <wangkanglong@loongson.cn>,	Tiezhu Yang
 <yangtiezhu@loongson.cn>,	Qiang Ma <maqianga@uniontech.com>,	Randy Dunlap
 <rdunlap@infradead.org>,	Pengpeng Hou <pengpeng@iscas.ac.cn>,	Ard
 Biesheuvel <ardb@kernel.org>,	Breno Leitao <leitao@debian.org>,	Thorsten
 Blum <blum@kernel.org>,	Harshit Mogalapalli
 <harshit.m.mogalapalli@oracle.com>,	Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,	Lyude Paul <lyude@redhat.com>,	Ashutosh Desai
 <ashutoshdesai993@gmail.com>,	Imre Deak <imre.deak@intel.com>,	Dmitry
 Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,	Johan Hovold
 <johan@kernel.org>,	Johannes Berg <johannes.berg@intel.com>,	Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,	Alexander Stein
 <alexander.stein@ew.tq-group.com>,	Cryolitia PukNgae
 <cryolitia@uniontech.com>,	Jiaming Zhang <r772577952@gmail.com>,	Will
 Porter <mrwillporter@gmail.com>,	Cen Zhang <zzzccc427@gmail.com>,
 =?ISO-8859-1?Q?=22C=E1ssio_Gabriel=22?= <cassiogabrielcontato@gmail.com>,
 Rong Zhang <i@rong.moe>,	Arun Raghavan <arunr@valvesoftware.com>,
 linux-arm-kernel@lists.infradead.org,	loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org,	linux-parisc@vger.kernel.org,
 linux-edac@vger.kernel.org,	dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,	linux-input@vger.kernel.org,
 linux-media@vger.kernel.org,	intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org,	linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev,	brcm80211-dev-list.pdl@broadcom.com,
 devicetree@vger.kernel.org,	linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org,	linux-scsi@vger.kernel.org,
 linux-nfs@vger.kernel.org,	devel@lists.orangefs.org,
 linux-hardening@vger.kernel.org,	linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/28] Replace remaining strlcat() call sites with
 snprintf()/seq_buf()
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
References: <20260915081910.4142719-1-morbo@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 FORGED_RECIPIENTS(2.00)[m:morbo@google.com,m:linux@armlinux.org.uk,m:kernel@xen0n.name,m:tsbogend@alpha.franken.de,m:James.Bottomley@HansenPartnership.com,m:deller@gmx.de,m:bp@alien8.de,m:hpa@zytor.com,m:hsweeten@visionengravers.com,m:tony.luck@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:matthew.brost@intel.com,m:rodrigo.vivi@intel.com,m:dmitry.torokhov@gmail.com,m:zzam@gentoo.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:arend.vanspriel@broadcom.com,m:neil@brown.name,m:rdunlap@infradead.org,m:pengpeng@iscas.ac.cn,m:leitao@debian.org,m:ashutoshdesai993@gmail.com,m:imre.deak@intel.com,m:johannes.berg@intel.com,m:miriam.rachel.korenblit@intel.com,m:alexander.stein@ew.tq-group.com,m:r772577952@gmail.com,m:mrwillporter@gmail.com,m:zzzccc427@gmail.com,m:cassiogabrielcontato@gmail.com,s:brcm80211@lists.linux.dev,s:devel@lists.orangefs.org];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[netdev]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,armlinux.org.uk,kernel.org,xen0n.name,alpha.franken.de,HansenPartnership.com,gmx.de,redhat.com,alien8.de,linux.intel.com,zytor.com,mev.co.uk,visionengravers.com,intel.com,suse.de,gmail.com,ffwll.ch,gentoo.org,lunn.ch,davemloft.net,google.com,broadcom.com,samsung.com,linaro.org,qlogic.com,omnibond.com,resnulli.us,brown.name,oracle.com,talpey.com,perex.cz,suse.com,linux-foundation.org,loongson.cn,uniontech.com,infradead.org,iscas.ac.cn,debian.org,linuxfoundation.org,oss.qualcomm.com,ew.tq-group.com,rong.moe,valvesoftware.com,lists.infradead.org,lists.linux.dev,lists.freedesktop.org,lists.osuosl.org,lists.orangefs.org];
 R_RATELIMIT(0.00)[to_ip_from(RL638gsp8obb334m9k7xcnfris)];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[110];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

On Tue, 15 Sep 2026 10:18:17 +0200,
Bill Wendling wrote:
> 
> strlcat() is deprecated: like strcat(), it requires re-scanning the
> destination string from the beginning on every call, which is O(n^2)
> when used to build up a string incrementally, and its truncation
> behavior is easy to get wrong.

... but what many of your patches do is to replace strlcat() with
open-codes, which is more error-prone and easier to get wrong than
a single strlcat() call.

> See:
> 
>   https://github.com/KSPP/linux/issues/370

It's clear that strlcat() isn't perfect and sometimes inefficient.
But blindly deprecating without providing a good alternative doesn't
sound like a right approach to me.


thanks,

Takashi
