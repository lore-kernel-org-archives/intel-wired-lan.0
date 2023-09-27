Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26C3E80AA6
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Sep 2023 13:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A5D8610F5;
	Wed, 27 Sep 2023 13:48:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A5D8610F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695822496;
	bh=H8jq5WCDjIH11FaOU0oPL9y+WmdvRnUhupw1yJzWxoM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ggq0VFQEqXYE20dY1IxsYHzV5Gtr3rrvBC3WV+X2NcVte536+ZzNKnED65770/dls
	 GxI6Y50MR8FIm14Pr9AEgh8cGfljYZVJPpHoNJW1dMWCOu6i32n/sxwXYztXJSZ5fj
	 JY7a4Ys/2DXxmPzn+iFMa3b8qR1zsAazqbmUoSWXiITfcUfO7b+lr31Lu17g0FGZN1
	 w+N06LXrcLqWSeaI6r40ltOYQ6l6aQEdNhQb5mXbfU8D5y9v5jRqaHCaphevJKGI1C
	 gcVcbSSBuwG0Tw2KqZJ0gMJ848DB9Hj5BiwI1ygO5wZqSvrmBRAPsASZ6peGLDmJKz
	 20G62kamyyUlQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzT4BKTk-_G4; Wed, 27 Sep 2023 13:48:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C9A5610C4;
	Wed, 27 Sep 2023 13:48:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C9A5610C4
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B7F5B1BF275
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 13:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ABA241AD7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 13:48:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ABA241AD7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDI3as6nIGQi for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Sep 2023 13:48:13 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C06EB41AD5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Sep 2023 13:48:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C06EB41AD5
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qlUtc-007eMG-R4; Wed, 27 Sep 2023 15:48:08 +0200
Date: Wed, 27 Sep 2023 15:48:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Knitter <konrad.knitter@intel.com>
Message-ID: <7e525cbc-1f68-4826-9d70-f2f4c99776d8@lunn.ch>
References: <20230927133857.559432-1-konrad.knitter@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230927133857.559432-1-konrad.knitter@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=upWcfxFHp21c3N/P/Zf9mRzfCLqhI1aD4eMLF3ok/Vk=; b=zpKuWcYUCROCbiL5d33QV6GJe6
 K+sLFFPnrw5610zFse0PD5AcMNI/KulQXr4sbCyaWKhtAxUch9xTQa/H1xUwBbVAUQ+pSZVhU5kAO
 jjxnRVPXNdq/SzfPEAwV4rjlucaoDtkzls5m/XqHcpqX4y60us59DZeLLpLEsDXDZWew=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=zpKuWcYU
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: read internal
 temperature sensor
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
Cc: netdev@vger.kernel.org, Marcin Domagala <marcinx.domagala@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Sep 27, 2023 at 03:38:57PM +0200, Konrad Knitter wrote:
> Since 4.30 firmware exposes internal thermal sensor reading via admin
> queue commands. Expose those readouts via hwmon API when supported.
> 
> Driver provides current reading from HW as well as device specific
> thresholds for thermal alarm (Warning, Critical, Fatal) events.

Hi Konrad

Please also Cc: the hwmon Maintainer to get his review comments.

       Andew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
