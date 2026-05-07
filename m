Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D0CD3427
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 May 2026 12:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA35B6101F;
	Thu,  7 May 2026 12:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1WCTs8sjG7n; Thu,  7 May 2026 12:15:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFEB06101D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778156158;
	bh=k3DI5VHNsX2dtInGmX3aR5Hyj7MlF2pGpMlNqzUivf8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wq1jmOf7OJ+snd0dqjOFT3XdjTj5Ui9Y8pNpRjTFdukmdLhoabuyJJU9THrn0ZY5a
	 mxxP+Eb07HGHxsK4CF9P6z7PMzfIttbrRo99ls2IHg/aYafn5UAF40I62NSFvhHtMj
	 Njv0tT4kKqrPVT5nwhSn4GQiKJglKYeHek5p8TKIYx2HgE1G2hzqN1uo5gmGL3ubks
	 yAPVWoiH3ZhjU+myRtuCUxb8Y4jMn0Brwp8vJUO1gASXLDU9C55uGBwxF2MdMURu5T
	 5tZzry323vuAHoCHKopkWGSVMiCXZHfqyPxdfQJFKtv/HdWeXdteG9eu8/1WhIASzN
	 Bz1KGeVKDzxXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFEB06101D;
	Thu,  7 May 2026 12:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA99317
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FBC06101D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7v4mP3IPdTUj for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 May 2026 12:15:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6174561019
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6174561019
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6174561019
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:15:56 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wKxdh-001o9u-9v; Thu, 07 May 2026 14:15:37 +0200
Date: Thu, 7 May 2026 14:15:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 KhaiWenTan <khai.wen.tan@linux.intel.com>,
 anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, hector.blanco.alcaine@intel.com
Message-ID: <a74089d5-1b27-4d05-bd8c-9ec2226667be@lunn.ch>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260430154105.505739ac@pumpkin>
 <63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
 <20260506104053.7a4f5bf5@pumpkin>
 <78e48cc4-759f-46e1-83c7-1c9442308ae3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e48cc4-759f-46e1-83c7-1c9442308ae3@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=k3DI5VHNsX2dtInGmX3aR5Hyj7MlF2pGpMlNqzUivf8=; b=MvG1GfRfk8yPoSwjN4if1WBYr7
 uAOS9Oxk/4pLC4AqlwuIGpKPaCLF4vPWHlY31q/mU4dnmdaeDsHwZaJ6t6dLT0wbD8bVA1haBle/3
 bvyc/NMBTWqn6TpqhJ8RUcmYxbUdNbdyYw93LjwJ7s7QfjOXTzAPr4pGtifjReRzwiH0=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=MvG1GfRf
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/3] igc: add support for
 forcing link speed without autonegotiation
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

> I agree that for normal Ethernet use, auto-negotiation on both link
> partners is safer and avoids the issues you mentioned.
> 
> The reason for this patch is the more specific PROFINET Fast Start Up
> (FSU) use case. For FSU, the requirement is different from normal Ethernet
> use. It is intended for deterministic startup, for example in industrial
> robot/tool-change applications.
> 
> One of the startup optimizations is to use "fixed transmission parameters"
> instead of automatic detection in the profinet specification:
>   https://us.profinet.com/profinet_tech/fast-start-up/

Automotive also have similar requirements. For them, Autoneg is slow,
takes around 1 second, where as a fixed link is operative very
fast. There are even some automotive ethernet devices which don't even
support autoneg.

So this use case makes sense to me, for embedded systems. If the
hardware can do it, any most PHYs can, i see no reason not to support
it. And anything using phylib gets it for free.

	Andrew
