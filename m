Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A37AC46CD2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jan 2024 22:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA4FA40180;
	Wed, 24 Jan 2024 22:11:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA4FA40180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706134298;
	bh=xZieFivIRR+qZkM66u8Vp/j+fHUnHH2DjcGNne9o7Pw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=orJ0ze6oeMSaXyauzrZpQHkMUvBQQ+5DQL7rNNXvqYQtm9yhm5aI1W8Cxug+vnDqj
	 8hHBh2HO57OU0h6uMf+URabx50kfYTi7TKsPIg5xg4/YxhiwUst/HapkHKf41d57iX
	 St5HDgQiSNJyWeTAGH+qY1ErA+Y1tdAaZJ1LyUg0qw1ccKnmBgqL65jcwgACXDYi9F
	 zM/moUy4tSL2uuY4uqVqt/BRw8uBE3zIAFQdbyd2dzsZLtTQDI9shWqoSCC536RjW/
	 thK/yVaNRbizyFUSSpJP6hAJSBGFAhhCZT7nTPelfbJ6Lqpy/YS8J4E9+w2055H7Gx
	 A6HAXHk2ap+nQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYN7QQ-r9Ckk; Wed, 24 Jan 2024 22:11:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57B3D40181;
	Wed, 24 Jan 2024 22:11:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57B3D40181
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DA65F1BF831
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 22:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F834185D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 22:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0F834185D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFhEBbH_OCRK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jan 2024 22:11:34 +0000 (UTC)
X-Greylist: delayed 1157 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 24 Jan 2024 22:11:34 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3113141755
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3113141755
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 22:11:34 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rSlAC-0062A2-Bq; Wed, 24 Jan 2024 22:52:04 +0100
Date: Wed, 24 Jan 2024 22:52:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124082408.49138-1-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=xZieFivIRR+qZkM66u8Vp/j+fHUnHH2DjcGNne9o7Pw=; b=Z73P74dmS+p7IF5kAvwIfSg0pW
 lvDNRIOCT67DiIF7F20bUP4PxnviUbgJvtC4Wiw82zvwpkrBC3gQMNfbSoeetELXBUkRBqzoSiIaz
 ArEvHTBPage3x14c2mL6c7XSfUiAQ5UBbKiTVxF7g0rLc8O+Uv3qTWipWMCp9A7YyB1U=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=Z73P74dm
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

On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading activity and link speed is supported. Tested on Intel i225.

Nice to see something not driver by phylib/DSA making use of LEDs.

Is there no plain on/off support? Ideally we want that for software
blinking for when a mode is not supported.

	 Andrew
