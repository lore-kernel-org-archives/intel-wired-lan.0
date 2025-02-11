Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6473C0219D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Feb 2025 14:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E7A560E0B;
	Tue, 11 Feb 2025 14:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxY4TUWzQfXK; Tue, 11 Feb 2025 14:16:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96F0C60E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739283414;
	bh=MHoZjbvXKpF/JWLLQoRJo6AmGuTjc7g47NiAq5yc2Gg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjV8WVPqjMOufYzfggo4fazc5VZH5tcZj7S0p/EA2aDzn8y3vbJF/IuekE542ZjWX
	 omasx+qpCxHjl4p7NcYCOJzSGCtTbXAVI1NDzHaSyPm9a+4OPkBJJZSmI6gjXSDJ2v
	 jqZ4VJHlKVMIGH9ujBgQLJXmNcKP06QDJDcAnkdRrKW/biVPMIYlpBsHVkOvbPnxa0
	 jctELI8rabJPS1zqh9g/lD2C+NMfXG0v9PizX0wdV6wiG91plGLKpdMOxp823sag+d
	 J1qbhA7KSWz+rNIRVd/WJitA68oHL2DHyarkH0F7b1WSD0o12dJrpMfPsPVEgPFx0R
	 nUdgNBZDtmsRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F0C60E21;
	Tue, 11 Feb 2025 14:16:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC5CC2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 14:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F66560E21
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 14:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfuSkWDbsZGM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Feb 2025 14:16:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E52E260E0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E52E260E0B
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E52E260E0B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Feb 2025 14:16:51 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1thr4A-00D58x-IZ; Tue, 11 Feb 2025 15:16:46 +0100
Date: Tue, 11 Feb 2025 15:16:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Simon Horman <horms@kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>
Message-ID: <f8c9cc3f-4cba-488b-9c93-c31b404f4d63@lunn.ch>
References: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
 <87644679-1f6c-45f4-b9fd-eff1a5117b7b@molgen.mpg.de>
 <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
 <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>
 <7085302f-af69-484a-8558-2aa823379fbe@lunn.ch>
 <DS0PR11MB77856580F83D80DE883C82F0F0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB77856580F83D80DE883C82F0F0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=MHoZjbvXKpF/JWLLQoRJo6AmGuTjc7g47NiAq5yc2Gg=; b=jI9/2iGSopbwXMPv5YRoojOaQP
 0uXqUZBP6tSnNqdwbjbameYwGw/61ZPxu2jKPwPfIoabYATOVYv0XYgv9/w3JPTpCHRZZIf9I2i7x
 uDoQ8iPvgYI2bjMpOBVi92IIBck8XbawtMOkrLuxvbUXU3nU9/8mBYgtSFp8H//nAd50=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=jI9/2iGS
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
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

> Actually there is only one adapter across all portfolio of ixgbe adapters
> which supports this feature. That is 82599, none other supports it.
> Even next generations (x540, x550) didn't provide support for reading thermal
> data sensor.
> As E610 is some type of extending x550 it also follows this path at this point.

It is something you should consider. The machine disappears off the
net for no obvious reason, and needs a cold boot to get it back? vs
HWMON entries you can monitor, a warning when the critical value is
reached, which probably reaches the network console and so gets logged
somewhere, and then the emergency value which shuts down the NIC
without any notification getting out of the box.

Also, if there is temperature information, Linux can take an active
part in managing it. If the critical value is reached, it could
downshift to a lower link mode. Better to have a slower link than no
link and a cold boot.

	Andrew
