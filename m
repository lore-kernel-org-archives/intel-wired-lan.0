Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8829AC48BC4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 17 Feb 2024 18:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3678F6089C;
	Sat, 17 Feb 2024 18:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zahhIp1_MK-Q; Sat, 17 Feb 2024 18:41:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C51E60896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708195283;
	bh=hN8mFTdhqEE8m94XzHYn7TPoFI/jGHsVtmjgAXHWDME=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8RwSUWyatdFH1qBRvqQSzNOo6pTGm9ME0joDp4NvuqivHScqw9/UOz2veuUExjq9B
	 dzHdVmF5pZKg0p5o/5klJa3h5MQMlAkD6Kz+y0fhqdBy4lwdVU7s1+1DGntJNi1OAZ
	 WUNYcFuwWYXH+CTNOsuDMzNQEXzcgaZoM6JUc8PQbVrK6UPV+3cRmBQ+rJHCtU94aw
	 8HTpZNEYLxc/aylQe/9HZvqhrHJ9IWWjvCY9CmMJNqA4qgi4sB8QgMpOLUdNn5vAO+
	 ITqJYT/5d2Vg9tszXnflPJZ63XvVwPxc59HXHsT3qaSPXTjJw+wFJ+nU5kEqbQi6vZ
	 oPivKThPToLfQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C51E60896;
	Sat, 17 Feb 2024 18:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C5CDA1BF3E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Feb 2024 18:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0BBD4081D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Feb 2024 18:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snykRhGpQI3v for <intel-wired-lan@lists.osuosl.org>;
 Sat, 17 Feb 2024 18:41:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 00ABB407FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00ABB407FF
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00ABB407FF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Feb 2024 18:41:20 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rbPcp-0084vd-PD; Sat, 17 Feb 2024 19:41:23 +0100
Date: Sat, 17 Feb 2024 19:41:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <3fec8501-9b63-4749-9191-7c3ab1c2d923@lunn.ch>
References: <20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch>
 <20240217-keee-u32-cleanup-v3-1-fcf6b62a0c7f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-keee-u32-cleanup-v3-1-fcf6b62a0c7f@lunn.ch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=hN8mFTdhqEE8m94XzHYn7TPoFI/jGHsVtmjgAXHWDME=; b=ZtD2Uk8GlwP1MZCTBW0+7Et45s
 eh95E/EJKgFOuESha/N7GN9PFa8N5NFE2FDEHgC+7u9PWVatz4zb+m9bRHAVGzwsqjTyau5s3gNcU
 djwQjVJghFhtgApnqwk0a5jivl3rS0OVSO5LVCnQrKA3vJ3siQdRh+i6VBE4t6LlxvsI=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=ZtD2Uk8G
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/8] net: usb: r8152: Use
 linkmode helpers for EEE
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

On Sat, Feb 17, 2024 at 12:08:22PM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Rework determining if EEE is active to make is similar as to how
> phylib decides, and make use of a phylib helper to validate if EEE is
> valid in for the current link mode. This then requires that PHYLIB is
> selected.

I started on the next step to remove the _u32 values. And found i
missed a conversion in this file.

v4 tomorrow.


    Andrew

---
pw-bot: cr


