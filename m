Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFCBC98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 17:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B595407C6;
	Tue, 22 Sep 2026 17:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kd0NS1DeCRhD; Tue, 22 Sep 2026 17:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B6896407D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790097723;
	b=c+4tUJpj4I6FhSOJQXFyJyJByBfT40/J+BjfO/7lBspCsk3EpeargaG4z6obDMTQ0VUX
	 9bu8u/DeDPQD6aIJtOc1DTVpR/IAkNzVoevJ2ZGnHImjA/RVC1o/CIXqkT3cjW2E7a2rS
	 HvwNOSTabtuSWUGJqh9NGouW2zDyitqI7ufBOBc13a+LoA6f7IDfmakvspmoCimwePFAZ
	 BVXsxgqsTafNi+vLyYxHKfESBZmgMgqjs8tzQBRDagk+EzXj+M5EMyzqU3cTkIIQJmPuc
	 /qVxvxhHFDbgcHbsj7Z9a0KnFzRYMgTJkSzekPujdy0d/WKuSRSMuUSiGgPW0FTUIBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790097723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
	b=AZPztah51X+ibcSTpzmV6gbI5KKdfOPHTj0l88rxKjeUezUXY9wOKTiiajEXPw8d2zo7
	 U5eYHbhCEb6IxdkE/tMnT5y9D5fMYwgHgDbbxL+DqaAcEUbvf0SGknETqDmmPy63SLDeU
	 Y3Kz/dFBempbStevxOTg3sjLUTaX3S/6dEhpr6w2H8P2VMy8QkdXg5aS2ioRqO3iEI5R+
	 pfir16/KqKxMuIA0hbRmG7qPi2K0Y9OHTksxoAHIn83XCdaIGYuSvjqnchSadEa7pf5GM
	 Ta38N4K8SUkpRaRhaDYjnEWPG53qQw/XibILCcZPdmqQ7KCvvGfPbnINWo2R7NGnwfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790097723;
	bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gR1crrLwwuahm3J2vjVQ61EPYMWKUCZiB/R5S4jPNaOR1ryjphlj4jbqywz6iFw6+
	 y62b9wH3UVjYDT0+n4cwQZLFpYI9EJxDZbqOcfP5LXel9W/77ym2Lwz3ni7RbXtDiC
	 Ph4XvtaNpFy7xSBecohiv1rYzCnC+go5TIX9yKIc5mrCuEs3jxjH6yc0qn1/TxV7X7
	 pvnOKvQyEG7wc0pdKgO3e5OUw+04Ttsw9LY90v1tVj6DqUOc2dhFaja2QDbQdHwKF9
	 JHOYrgTobGMYEopEvmbgnLL3DmxjeLNb/Y/Sc3RFWK5JQg0DPgTnDB8b1pWVwNXwmZ
	 9T7TULUa0sq8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6896407D6;
	Tue, 22 Sep 2026 17:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CEE4A12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C03BE60710
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSlQvARW-JBd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 17:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C93FE60645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790097721;
 b=Y3zR0353Xf632lGug9LTlU9u3JAygzFm9BIEM19+cuzMGQF5VzOvxeA27iP3Eyjt2QqS
 CXz1G7vQG5lYmmlBSLrSt53fMPARpp9i9DIzZxhKfI4t35dlDiWIVVDOPtxSRUO2WLu0k
 SLLSDEQtAGhVgfGB+lZosU97BBBuzc2oV4XcTX8jX3GpkgVBtEfmZJNaqaNTbaSRPaVmy
 8NPdIIDcYSWzWaBOZh4YYa1R7s6gK73qfUkKVc7SrxwcyBTsYYr/CmBREiTqrHM4uh14i
 2HeCHLbpZd7rfjGB4xWGCbo4LdpdTm2xTHCZUVvjtsqmoCpmTjC/GpHwmbiCokgRgxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790097721;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
 b=nrY6np1MiKe/fTE+fALAwZsJm05lXA9Y6Uy4NmyG4tpkJTps6r4ZTKE9b1a9ouNrk5n7
 5MLF2npjE+3cgTln3BG+dSn2iaEVLbnJjiUfUFYzqn6cPMtAR6l3p9nXlJk4FNbrIRJuC
 gpzr8rZpe90isojHnIJEA9Z7X0y9HxNHjegvMl9PLca7uaUnvNZw9kYmkW0QMDpWEZ8bc
 dbdIoMsJb3LGCC2/RDnbc8CIlM6L/VU9iIr3sl5kRQn6nS9gBdEYu33gcSqMpiQh/d13W
 JtZeQDjkbrnA3fqJvGzL5Z6EhSK26YHUF2/kClqxAuXj7k8JM1MDn8sUkWo6x5Mdq4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=roeck-us.net; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cuRDVJLi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cuRDVJLi
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C93FE60645
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 17:21:59 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so561535ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790097719; x=1790702519; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
 b=cuRDVJLiUYn4k5gtd5j/s5A2LfS0reQKPL9Py0ywjf33k4O1eokGvl468bDL8h0Hg0
 QrVxt2qM6VKBCSP0yIuoWUv6vcbgnAQ3YjxcYOKPjuEOjPoxnRAOncbN8/zBNxwZka17
 r1VMkkXWYAXvhdf7Q7ALo1FsQYq61XAGQfS5MarkoK1k0f9x2xDq16JIKbiLOI1Ka5fK
 OompOIZNvFps7KRrvUlAT9vmeMisR7NaOgjUlI978onKhh18ch/NF1ud8xE2lLMX6MZv
 X7E0IIv3zWd8SCHW24Dz+urtTmurnHEupeuBalPonOoRA3HzQW/aXEFJXYDgHZK8eCM/
 yAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097719; x=1790702519;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
 b=M2OYLqJotplop37YczCGC989XWhvTI7iPZnrbAOjE4hFPRhq08Q22xu0te5xHtgh+B
 m8OgFXGrL8MI58lE6p6cCPjKofGsIUIGkTwecvr2Fbb7kGrDWxONusUwHZj72xwhPZ2y
 IGYWSzCoXXEgCmCCP/1Sk3AXsj5Hd8PbjCcMAqHU4OXVtA6DgIamck9shTBbpi80pbYo
 8FRpBmJ4hMSSS3QF3elRImEqnN2UlxqbJcSnmMkkbTiaWEYZ/YZ3sOOqRoBIUFVrL/DC
 zWMQYluKZ4cyY3LYNMRjI/AjrO/1rwToZuFc0qdneISIY/NWgC3nTCEs1Jlvs8TXt3K0
 triQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvGbgo3w2c95zkmlNWs2LswaU3yCbe10FiojD0E2GdpG6qgvupaApJVwugKwLbSzNBtSBqRLO8YkpRgWb1fS4=@lists.osuosl.org
X-Gm-Message-State: AFuF++ka9fUn9Vh2U4nqoxm2DYlDhwIy/ZUQZgSt1spDHbTxa8nVDTXc
 tj7EKjqWajweL9wqEMPvLRnOe9xoNEzULgT3yKz3VC0d6zNqA1WC3vfm
X-Gm-Gg: AYBFou1x4xplkbrfRiDXc/eaIYhF0pukYh2GzHU0EwPBoQFeJB9H9RFgsA4xO/o2dd6
 oSfgq7J7bMUt5TNIPQDeTV1mXHnYPe6vB9/JQeIvMUe8/BKuz4LvWMRDhXi3t8Uuc0Y+Jwsim2T
 ZQFkIU9jN2RO3l9bwCFQqyuYY6mj4cXWh0F8i7sOC1G4xdIWauuD8cHk7EYvvvs8t1SwmnJuvPP
 PUKY3xEvY8FaGkWJ1gH2AZf6Fxc44RcWll1PLXIspvii7GJPIKHlgIrMAFgrFLcZNS6D/pJrIvP
 rw+MnBohtsEVm5slJld3+wh/vU+UIkQMGIkGt1N6FSfFarCJ0UF5hnuZ+7EqtAxSHheatmNhaq/
 CYk1lJF65CXcAVdmHLQrlBvk+GiG4UBFIWbEOWakddOUuJ209+DM+mH4BvoyW8GJyFYM6k9Gaf5
 0D+KIfcO4vb+Sob4btEVk5niFQfpN3op21XfA84N4SFJkjmggvWn2AmwsEQTNU4mYruvnRuuAuU
 gDELo1Xd6JB
X-Received: by 2002:a17:903:228e:b0:2dd:ad73:c984 with SMTP id
 d9443c01a7336-2df69d5ac91mr681945ad.28.1790097718673; 
 Tue, 22 Sep 2026 10:21:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d047c40sm13644575ad.50.2026.09.22.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:21:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 10:21:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
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

On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  drivers/comedi/comedi_fops.c                          |  5 +++--
>  drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
>  drivers/hwmon/fschmd.c                                |  3 ++-
>  drivers/hwmon/nct7904.c                               |  5 +++--
>  drivers/hwmon/sch56xx-common.c                        |  3 ++-
>  drivers/hwmon/w83793.c                                |  5 +++--

I don't know how other subsystem maintainers want to handle it,
but please send the hwmon patches separately; I'll want to apply
it through the hwmon tree to avoid the potential of merge conflicts.

Thanks,
Guenter
