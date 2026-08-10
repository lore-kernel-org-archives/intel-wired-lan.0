Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39449C5AD7B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 17:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C60C04068E;
	Mon, 10 Aug 2026 17:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uu6dE8QHdTH0; Mon, 10 Aug 2026 17:57:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29DE840684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786384650;
	bh=sJGjyJAfrE29E39fw5p9eEIjpaHCubsz58nYmECUolI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ls2Mw3y5uaN2N/S1DY8ejig5Kqc3a73GI5IxAoPniLzEWpZEWHD3w8ZtFKWfQ3qNZ
	 NcysyKQ1y4sz+OBkr2rOI0PSl8V+BGVCzTRgyzwaEn4mCxKwNlIZ3zRCaXWtHKihRs
	 gi5AlSVkjHkQi5gN7urqQYf6F1RKD/aUTNUQLTGYnCq+ZRK9l5A2t6kI2ap8JbphhM
	 QyugehQElYJ4j3/gNDMm39KiXhzl7mqfLDS6bRtOCN3klNhIzvWeAwpJtWkQp85kHx
	 AuiVGvZDSEUH+GMHTiuSZrGVGDd/+ppZIQS2oh+kpg5ffv4kkW36B4CdT/yx6kNyDw
	 89MJFJvWhusAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29DE840684;
	Mon, 10 Aug 2026 17:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 843FA24E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 17:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C1FF6074E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 17:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQiJw6jHAizp for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 17:57:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 325D560746
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 325D560746
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 325D560746
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 17:57:26 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wtUFN-00Gxot-Ae; Mon, 10 Aug 2026 19:57:13 +0200
Date: Mon, 10 Aug 2026 19:57:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Malathi <malathi.a2000@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Message-ID: <0b5374f0-54ef-4730-8282-54cd9509dfee@lunn.ch>
References: <20260810063815.151326-1-malathi.a2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810063815.151326-1-malathi.a2000@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=sJGjyJAfrE29E39fw5p9eEIjpaHCubsz58nYmECUolI=; b=NmFzVmimdna6vCG42MyuFQ82H4
 SkxIOP9K6N5Le3hQ3I2oJHA6gPM2538b87rRWSkmMtOQkwkRo1T9UsCBw9PzLBGsmIK7/4c1HXRzl
 st5YBeQQcVb9lViTD2C5mPh6NgxjsWqkjkcZKwU6R/GoI7HM0VC2Rk13U43/7wAkKBXo=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=NmFzVmim
Subject: Re: [Intel-wired-lan] [PATCH net] e100: fix shift-out-of-bounds in
 e100_eeprom_load()
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

On Mon, Aug 10, 2026 at 06:38:15AM +0000, Malathi wrote:
> e100_eeprom_load() and e100_eeprom_save() start with an address length
> of 8 and call e100_eeprom_read() to auto-detect the real EEPROM address
> length. e100_eeprom_read() adjusts the length with
> 
> 	*addr_len -= (i - 16);
> 
> based on when the EEPROM drives a dummy zero onto EEDO. A malfunctioning
> or emulated device that drives EEDO low too early makes (i - 16) exceed
> the current length, underflowing the u16 addr_len to a large value such
> as 65529.

So this is a theoretical issue which never happens, and bothers
nobody. This does not meet the requirements for stable. Please target
net-next and drop the Fixes tag.

	Andrew
