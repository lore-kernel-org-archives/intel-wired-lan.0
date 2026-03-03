Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C976EDEBFA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Mar 2026 23:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD07340AE9;
	Tue,  3 Mar 2026 23:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlOtM4avv5l5; Tue,  3 Mar 2026 23:08:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AB7F40AD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772579313;
	bh=hyGTuCWGO45jPKeyWUndsgiqo1yT0pSCCNty9r3XSng=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eX/Fhp2tfnl8Y+YYyiSbL8r1rESl4vX/XZLJTbwyOcgUV+3+pck2EQT9McS8h35Kr
	 TACV6DRGrMWgBfMDLZT392IhMAGwlC1b+1UOgD6zGoiW0jrHm9Dr2Y3N26r4S+jVBZ
	 IpmuC+deV7S2BOwVTTd2WxahxqAKdiMl3z6qb2joOczt2BVKvJ1IAoGfY4x3TmefSw
	 ZOPGeSblwIh/1iN7cJe694hIQIfd6Yx+t9lYMWFqMkqGs4WC0qM8/3SAObKjE2Jk19
	 o2VmerAJDHZqpN4g3Gl2B5YaKJEokp00RDcOWkoFOXeSNVME3IrzcIYwMxynIfQg1k
	 z8zx4hlrBmbkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB7F40AD3;
	Tue,  3 Mar 2026 23:08:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AA01231
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 23:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BCD3402BB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 23:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDAbaua_WZQZ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Mar 2026 23:08:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D659F400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D659F400AC
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D659F400AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 23:08:30 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3791311b3a.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Mar 2026 15:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772579310; x=1773184110;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyGTuCWGO45jPKeyWUndsgiqo1yT0pSCCNty9r3XSng=;
 b=ltacIi+z2C5YzOhUD5DH7qHp60Xb81XbVCAoVHjDZu5rF+Ord3fYkMmbmRuS3XIRDc
 Q3mVMqKHUElkdATQiMQkI1Gr1Jf19CVukcP1XsL8LBguoNPad0M5QBx6EaClLHHB2pPd
 LT8W3JfZx+I01ntWzlSuC2dt+en6ln5afpyzR7U+L5JquQzHPuAGsVmrcFmLufxYpws3
 sobC1h1fm8XC0QcW/0FB2oFEJ/TfXuGpkwK5O/mWrhGu/jfiDZ3b8kEvXLU4dDL1plWE
 xIbj32Ds4rLKsBawN07NuATtlcsYl99k7MFSpd1xWM7WHEmCCUOtLPbuIhOg2IS/hfVH
 9Ytw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAyRWO5gHHW/PfGkio0mbAju+iJ0di294rszU5+CuKhuxLo8eUV153t82hHEKyUw3HRNeou8hhUEshPxKiCeg=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyS5FtCe8hNKjFiG3JU/agdkuJ1XJhsCFSuh5fTkOAR4JMvLW9I
 mGYcphBCefDGefWnRC8YHl0Bpu+XW8L8BWPB6H/ArAH4MJgupCxVdu6Ih0Vk89VxJBQ=
X-Gm-Gg: ATEYQzzYuGHdBdZZAE2uyk2ffbQpv6e4KU00p8jU7wCMT3XqMyyZTXX8iu+MUmYQVOM
 q2MCJUVQcIJFuYFiiFaXJbslFNBAdPp7fv1nziWybaHp1i/IV+iKnkzjaZSaH3/J3DcJ8/tp4zI
 GwWUP5PcadA1sJPuMOiApgFMg2C5QRWBTo42RRB53VTtqCARxxrSzlL/7UbSHU2PoxTwaM2fMlD
 8NWvlygM6MkpODeJoBf8khpX/jsG8RtmyW5qBuwJDZLq/i5gRMbrKh1jdXI8PyNRNNdzoe8Nov1
 Tq+NNLBCiQTxV++d+8K9cE/vuupEv384hhCUMrzRMjj11BVpHTdlN+wd5POmaG2FhSLAn4r0+LV
 7O7m/3HVVRvZuJfFrqFywa1or2xyd/NeWEksT4Ui4Egp8jceCFfs7/gfeDUH2EMQo7pGhdgeCp7
 gO31P7
X-Received: by 2002:a05:6a00:9193:b0:829:6f7d:3093 with SMTP id
 d2e1a72fcca58-8296f7d3294mr201387b3a.48.1772579310080; 
 Tue, 03 Mar 2026 15:08:30 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5c::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d8c7aesm21018686b3a.21.2026.03.03.15.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 15:08:29 -0800 (PST)
Date: Tue, 3 Mar 2026 15:08:28 -0800
From: Joe Damato <joe@dama.to>
To: maximilianpezzullo@gmail.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <aadp7PhlQMV7BFhC@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, maximilianpezzullo@gmail.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
 <20260303-master-v1-1-f180b1ad98b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-master-v1-1-f180b1ad98b5@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772579310; x=1773184110;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyGTuCWGO45jPKeyWUndsgiqo1yT0pSCCNty9r3XSng=;
 b=esHvX9c3Shnstl++HjOQtXPU713HGtlZC+hH6sZoMfRFu0GkrHV56TXLbmiT2LyQKo
 Lh1YSYjJCdkYPub4vyD9+BMBb2rA+WOH8fOhLri1IPBgy/NERQyvxtIfgA2fHc4Vel8S
 D3WIQ/a2sWvjbdTp6MJmMWSkiMdbIY52/99zbf6aTEjRl8dNbDxzx8cuHmvZebAVwU65
 69+AmLWoqgjRps4MYcG02MzdKDgSjKeod39anNGySXuRg7lDi6EpKraVxUaVc2l14DZ6
 k5M+0ZHn0Wuq6Zl00tUBjCuPmCmznV6tp3Su1MOrrCA29UQe3c98db3XNK9fUWYX/mb+
 Rr4w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=dama.to
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20230601.gappssmtp.com
 header.i=@dama-to.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=esHvX9c3
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igb: fix typos in comments
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

On Tue, Mar 03, 2026 at 10:38:20PM +0100, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>  - e1000_nvm.c: 'likley' -> 'likely'
>  - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
>  - e1000_mbx.h: 'exra' -> 'extra'

These changes seem fine, but codespell noted another spelling error in
e1000_defines.h ("Device Reset Aserted").

Maybe worthwhile to get that one too?

At any rate:

Reviewed-by: Joe Damato <joe@dama.to>
