Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF5C27C5E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Jun 2024 19:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4459760A44;
	Mon, 10 Jun 2024 19:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMaQW_AshRyg; Mon, 10 Jun 2024 19:27:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95E1160908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718047659;
	bh=MiZyu8VhPCk0AXuRPnHhqHOvpBJ0fh6/3Mj663IB6kk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PjPB8adFPAUe/WXpFwaQWvMwCX1j8nNkieGikYAx7ha+OwrFDqOfEkl3F02XYAt4W
	 qna7iFsAtgwbtIZ58t2HM8+Zuv50jIrpfZaBkOJsJumXY4rqUjEzLheSw0ua9V5fX1
	 u1l3Sh1hCooZL32ZsPaDd8N8LwWHkYzFGCi6ynnNRL9pRrU7VWll7G13B5fp8OvHMk
	 yxxVFT3Nvj6fNIKOVqXE8OdXptEUM/7oJ3JXOyStRA+EHNmeqVZrq4L8PVZ6wnJEP9
	 XH0K6NLcJLmPflzAEX8OAPtqOXEtR/htRsXldP2IMRvtOE6wBRFLOUI8UvJErGsX1p
	 u+d5Y5IGCSvsQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95E1160908;
	Mon, 10 Jun 2024 19:27:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0F38B1BF3B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 19:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 065B282215
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 19:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ri_Lzk8_ouSF for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Jun 2024 19:27:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 19E008220D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19E008220D
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19E008220D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 19:27:36 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1sGkfs-00HK4x-Qm; Mon, 10 Jun 2024 21:27:24 +0200
Date: Mon, 10 Jun 2024 21:27:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Richard chien <m8809301@gmail.com>
Message-ID: <ef5029dc-baad-49d8-8c95-03ec41df5858@lunn.ch>
References: <20240609081526.5621-1-richard.chien@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609081526.5621-1-richard.chien@hpe.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=MiZyu8VhPCk0AXuRPnHhqHOvpBJ0fh6/3Mj663IB6kk=; b=rkkQy4DgBiRXuV0GDiC21jNbL+
 +sKzjfXkmyigg916XMHJle6k/JKxg//GmdgAAHq0vw9sjlLS0X+V9I6mjsJytGeZt4hXaqAaI3IUP
 hwcrxGVxlZN3G9Aa//f+OkUhuEq5isbDMQ6LSxUM/U387T4lfW0gZ8cj4lexim+NJNgE=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=rkkQy4Dg
Subject: Re: [Intel-wired-lan] [PATCH] igb: Add support for firmware update
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
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 Richard chien <richard.chien@hpe.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Jun 09, 2024 at 04:15:26PM +0800, Richard chien wrote:
> This patch adds support for firmware update to the in-tree igb driver and it is actually a port from the out-of-tree igb driver.
> In-band firmware update is one of the essential system maintenance tasks. To simplify this task, the Intel online firmware update
> utility provides a common interface that works across different Intel NICs running the igb/ixgbe/i40e drivers. Unfortunately, the
> in-tree igb and ixgbe drivers are unable to support this firmware update utility, causing problems for enterprise users who do not
> or cannot use out-of-distro drivers due to security and various other reasons (e.g. commercial Linux distros do not provide technical
> support for out-of-distro drivers). As a result, getting this feature into the in-tree igb driver is highly desirable.

I don't really follow what this code is doing, but it seems to make
ethtool -e and -E dual purpose? Please could you show examples of how
this is used.

Thanks
	Andrew
