Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCBFC47258
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jan 2024 16:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E369E83D58;
	Thu, 25 Jan 2024 16:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E369E83D58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706201286;
	bh=Brtm+X/hPzncxyQIojg0OUi8pFhxYzTJe+3ddjp2XmE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LRP8/QtAUlfluBNX03gDmw3L93jMvkaV2m5oeR0mQbsKVO67TVlD6Y1vl8OMOBEtR
	 ppwMQ7AV9GMn48pQSSCSDHtar1XpwADIZNGP/f5C6qZcTnqX7S+eJWps2xvQ6FZdo6
	 PPvaYYl5icSlRVm3bUwylFzzjpCUNGwQqfeEEa+fe21t07Y7bpTAkZeVzT39Egkos/
	 YyJ/vPNoU/uH76aGbWwTcq4wb5ewV9nWMlePd4Gh0AZq0sNT5qtb8ZAM7SNkkMLxZw
	 1Nm/kjSQth6H+vDATcLHS3heQI33HpCc0eUqoSfrUbvWgvS/ULxNdBHysb4hEhewZP
	 a72oekmKr7kdw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKKoFgDQspyL; Thu, 25 Jan 2024 16:48:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B66C832E7;
	Thu, 25 Jan 2024 16:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B66C832E7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1C0771BF310
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 16:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE21D4356B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 16:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE21D4356B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9z-Jf5jJ11K for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jan 2024 16:48:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E76ED42EFB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 16:48:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E76ED42EFB
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rT2tM-0066OD-LT; Thu, 25 Jan 2024 17:47:52 +0100
Date: Thu, 25 Jan 2024 17:47:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <2caec578-a268-4e82-95df-9573a52d6b7b@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
 <87ede5eumt.fsf@kurt.kurt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ede5eumt.fsf@kurt.kurt.home>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=Brtm+X/hPzncxyQIojg0OUi8pFhxYzTJe+3ddjp2XmE=; b=A8NYRUI39YdzMH9pdsr99ygVSB
 oaAkxDkTi3L+nmIf1a6Nqq+vwIzBBCPFxwwD3MdLzM1Tpzxspyq9qUAEH/o3Kq2oSbqZPQE5JQciO
 B9HzL2plMrw0L1J6ZeB2aeACdKmIjhM5ChJa3F5euEtFW4uNiQUpPCYhJCIGCBsnm+bA=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=A8NYRUI3
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next] igc: Add support for LEDs
 on i225/i226
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 25, 2024 at 08:31:54AM +0100, Kurt Kanzenbach wrote:
> On Wed Jan 24 2024, Andrew Lunn wrote:
> > On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> >> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> >> from user space using the netdev trigger. The LEDs are named as
> >> igc-<bus><device>-<led> to be easily identified.
> >> 
> >> Offloading activity and link speed is supported. Tested on Intel i225.
> >
> > Nice to see something not driver by phylib/DSA making use of LEDs.
> >
> > Is there no plain on/off support? Ideally we want that for software
> > blinking for when a mode is not supported.
> 
> Plain on and off is supported is supported, too. Should be possible to
> implement brightness_set().

Great.

Its actually better to first implement brightness_set(). That gives
you full support for everything the netdev trigger has. Then add
offload, which is optional, and will fall back to software for modes
which cannot be offloaded.

      Andrew
