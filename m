Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE1606A68C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Zj8mKvtm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndz0TBn+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 138DA6063E;
	Fri, 20 Nov 2026 23:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUt1pHJZtip5; Fri, 20 Nov 2026 23:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7877660650
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795216664;
	b=E9xX2T/0VCzFCdy/b6uBcGUos0fsvwzkyOoDF9ffzENKkGoMWzqQB8t4d26bjUw2w3wC
	 M7+qwZNAXLI745H1MIFEr0VzeQ9FUbCIZmF8VGWDX+jSoDzIEagcerXs/15JtiXr9LZsr
	 /LV92hoV3IR+NR1o11iA0Svg3PhnuYRKPaDy382K3mrDznMS3nRLNaWvPWVwFvVTfI74r
	 HKHfGL2Ld0GgZHmxE8dniiWocned0djCWOuLq1VfsPOi7lh7jLdjxijWH/zcAet6oIUs+
	 Mti2+I3Ltr1IzTXQkzaEi0GZGNFOzGug9T84+hTuRdHRauvL4VsNpezJ/yED8vkClhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795216664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
	b=RTjdQPzsB63pOfx6WhdRppsOaKal5Y8djiJ7cmoUeQpwQrlUlMjGqsp83cx31BFAvGMR
	 PONYc8MImi/YNtBMSjEyIe2wu4MzXzu4Ie8m8jUw0bHWIDJodbA6ujesnnyLIQlyxLnLI
	 sVeRFQFBd3v3SrcUQnoK1cFvJju5vbj4OJdSOj5XtojUHlRyzhi7KKQC+PFDSg6bXINnS
	 qL6sj/RlpMERJRD4LuScsTl3AR/RjRmogvtMDYZjqxgSE/C5DZxJaK4OWF4Dj8c6eh/Qm
	 FYk0n8tjKN1Ykw70XNfp6TTVmkFAWJTdK7KreQ8H3JGWFQTXMGtLe00AaZp6QliHa6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795216664;
	bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zj8mKvtmiGMR/XOSlEazI/MWvghSluYrUL6KmgVxHCQjtRMxeJH6ilB3H0ybYgCaP
	 Z0hYEbwcPg5ki1WIfww+k8YtMc6bopKymdOA6LyDCgkZfcxBedot9NRjqRMMGt/LDB
	 jNb4rpCl2jvXWJYDe/mDUz7ABbuqpWuU4rj8fI1CAyQq/9C9WBqK6pQ2l79CSAZPxL
	 1ftaPSkxgC8FPhXfZRluymrOMvY+ODDfDGGU23Iw4qL8SV+KNydBk5dWl17EYtItHZ
	 dSR4ZJ5gAMcVs7AgsS+OEezQW1bHeznMg0oVOgGF/TRD6dc++ef/tJ9Lxzlx1hHmm1
	 tMI8+7l7fTaZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7877660650;
	Fri, 20 Nov 2026 23:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A1D0465
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C39B40208
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MR4a9I96r3S for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 23:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7EE4440176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ndz0TBn+
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EE4440176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:17:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so14161525e9.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795216660; x=1795821460; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
 b=ndz0TBn+szr54QXb4WpkQDMPoHbVW3T8vqUi6iPYtdoM4wEmUTgF3eGBnWjJNaYe1a
 /A9lu6cXpHZbBg1u2/37yrxT1vd8Eiw/3jx33g95T42x2yoM8dZy42QTnUXORBHFlMQL
 2jUEoESBxOhe5AkzNSqIXj0+tOOsbA44BtUTOlSOgBg4S21LJQLcvlLufJloDKZFu2sd
 5PPNqpN2BYwjgptVSJPbueP4uOu7Jb+88Rxr2H8v4pJV/pfJ3iTPAfpxx8BtoZrySiEP
 N+PQtfVGjLwA/rQFaja257IYgWxMADRlrB37ll8BkftZV8mXADkBSgqny+WDPHpZF8XE
 NIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795216660; x=1795821460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
 b=l8vLyEMWkNLcbeZrMceR+d6yEmun8L/t/jooo8xleDvmaZZwn2K3Ak2ALquT0UyLSZ
 ZF/fqob2yXXR5rdLy3FDlem4sOSqKu5L3FLKspwjbe0kXuXrRJb3a/qJu4z9iSI6bQe5
 SrYPRka7UcGiAYdOYHSESuqtlVnGivqtJFxwGN1PIahRGODKaxn7jh8JO2IMHyN/VXz5
 lydh3D/8uOsha6yaVX+AN0M7HgmTTnZsHLFnLiATOu0ErPijXzQji0GReY06LME4asYi
 FIM+F+vf9WuAkqJg6gPcPzFJStrVi69YmWDEm6y8tWpt59+g5ZNHhKQX9Xb+N+znCsmX
 L6pA==
X-Gm-Message-State: APuU4Z/KCeeuZJhDwKjqTA7in1HRG8q7sqXqlcN0/cnBj8oGwU9ryIWB
 xCK61cTJUh/r1ichgMR973Dn9rGlRwSspb+DDY3pXZV2F7yPwv0aTBk8
X-Gm-Gg: AYBFou0Olr/B1mJCTvSDspYG8pPR9aw5sQZsc0sERtfFQjesC7hm1jtgoHp9nIpDHRo
 w85htCfRGbifUj5zk5HEt52FWaPihhY9NO1T9bFLF6L2hpB2PUX0w8j9eZpu2X3sE8dgqRIjsCB
 viNjjBpPDKtZkffYRstRxd2VCyL+8Mk8o910k+9DielQxX1lr55365uzsQ/c9QkEVNtf+eM20Tv
 En+Dcn4p/6LXebkonKCEnUroX0QgJ0cSpayUBvTO3uRG7DZlzp0WykvfSNJ7CRgz+u7jyFAfcBa
 Ejfx72v1Wu0u06ftokG9f4AkyOBtsTZqDx64QahXVn6qrrRd7HFSL6s2HcTwPxSht+hXeE4EU5f
 p3vv5YltctqXrRn6Wwv8oYsVvLNX5AsRgBZIEnn+QMvo1/9Y4IwBnlcCaWI+grpKh4xtTeaqXDj
 YU3oQd9SyuyFBLpeW6Uk0zw9WGRSzo/yuSRKsrZBLSthb4OOF/bwUmA+RsVFCj/axEPG4EeO+sy
 ma7wvjcxaZd9y0pjCw/sdKl/ojrTmWw9AYCffRZGfaSHAa9m6GaQgktLaWvOT0GreWwf/DGi3Lv
 rOurkKdZ9CwLJDpGUBOJ+OEdlSu6P8YPtzHJBkhgafcQWweO3xTIdo/fIZk5gDZeYIQwuSxHcef
 nxSH+UMJD4omS/cEf8bThj3aXIMO4WpQbZ2U=
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb887c2923mr101689825e9.2.1795216659651; 
 Fri, 20 Nov 2026 15:17:39 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm151650265e9.15.2026.11.20.15.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 15:17:37 -0800 (PST)
Date: Sat, 21 Nov 2026 01:17:35 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
Message-ID: <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
References: <20261120210134.133238-1-antonio@mandelbit.com>
 <20261120210134.133238-2-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261120210134.133238-2-antonio@mandelbit.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20 Nov 22:01, Antonio Quartulli wrote:
>xsk_get_pool_from_qid() checks the queue id against the stack's real
>queue counts, which can be higher than the number of rings the device
>has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>before enabling VFs, then passes a NULL Tx ring to
>igb_txrx_ring_disable().
>
>Only disable and re-enable the rings the device has: skip the queue if
>it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>an Rx ring using the pool still stops using it.
>

What happens if a pool is bound to, say, queue 1 and the socket stays 
open across a runtime resume that falls back from MSI-X to MSI 
(queue 1 becomes invalid)?

If the socket is closed after igb_rtnl_resume_task() has reduced both
real queue counts to one, xsk_get_pool_from_qid() will return NULL for
queue 1. As I read it, igb_xsk_pool_disable() then returns -EINVAL
before doing the cleanup and resources get leaked.

I may be mistaken here, if so, please let me know :)

Best regards,
Janis
