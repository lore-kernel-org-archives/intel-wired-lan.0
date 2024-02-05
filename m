Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C668C48286
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Feb 2024 01:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E19DC415E1;
	Mon,  5 Feb 2024 01:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E19DC415E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707095048;
	bh=ydVVpH1MXT/6v5fE3x4y0WvWdVutdQ2BrQO5Y/VShyU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Or1YiEStQsKk8qDTOdBS9ewXBzC7R/7i7ZaJvJr6fpyVX7VIeR4rboLh+i2pEfaOh
	 PvGJwhkH/X7yV1yxMA95N3IZay44rSfN0QNzWdjfFeZDX7yD5ZbJAuc26XyEaW+bjK
	 n+qKLejbTpVBKfwK7ddijwu9t9n25qr8hKy4lOfXXYfSSNMsmhdmAvex1M0p0h6qRb
	 KCZmkXyalM1Z2/HTnXZoDNZS10Y7NfeZun5WNXVQ8rNtpXmDLC1IjD411zl871X4iV
	 Lgp0CG81Lm7OjDPrs1vQQ1EiiwKwsNs3HLE9sHg0L7GvDZysRGEuh6TcFRRyv+GI9d
	 Jdf9BcTTDzUIg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fc9sMTlK_PNO; Mon,  5 Feb 2024 01:04:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC11415E2;
	Mon,  5 Feb 2024 01:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FC11415E2
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5061A1BF48C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 01:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24E1F60AE2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 01:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24E1F60AE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hn0d-2Fthur9 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Feb 2024 01:04:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4ABB660AA8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 01:04:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ABB660AA8
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rWnOl-006zML-2k; Mon, 05 Feb 2024 02:03:47 +0100
Date: Mon, 5 Feb 2024 02:03:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <d807dd9a-5318-482b-a85a-02baccec8701@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=ydVVpH1MXT/6v5fE3x4y0WvWdVutdQ2BrQO5Y/VShyU=; b=h2jz/QQ6GSQVIcYNEsytv/+T8T
 Qtq3S60UqS5g3ORbQWlvKKhAuF0fS/0FPLC3zTePged381H1i/aiR6XsNLniGfMaTwsx4EeM2ZF5Q
 lgfYZP31IUhQQTTVp2XYPS6qVWombRdu6+y/hFn9yBFRJTZwmMKeEl4fBUQolDmMMo0s=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=h2jz/QQ6
Subject: Re: [Intel-wired-lan] [PATCH 0/8] drivers: net: Convert EEE
 handling to use linkmode bitmaps
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
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Feb 04, 2024 at 05:40:17PM -0600, Andrew Lunn wrote:
> EEE has until recently been limited to lower speeds due to the use of
> the legacy u32 for link speeds. This restriction has been lifted, with
> the use of linkmode bitmaps. This patchset convert some MAC drivers
> still using the old _u32 to link modes, with the aim of soon being
> able to remove the legacy _u32 members in the keee structure.
> 
> A couple of Intel drivers do odd things with EEE, setting the autoneg
> bit. It is unclear why, no other driver does, ethtool does not display
> it, and EEE is always negotiated. One patch in this series deletes
> this code. Comments on why its actually useful and should be kept are
> gratefully received.

Gerr. How many people have i said to put the tree in the Subject: And
then i forget myself :-(

net-next.

	Andrew
