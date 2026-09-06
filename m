Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A0AC79F99
	for <intel-wired-lan@archiver.kernel.org>; Sun,  6 Sep 2026 08:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F9780BF3;
	Sun,  6 Sep 2026 08:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xf5zCSacO6x6; Sun,  6 Sep 2026 08:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0DA480D2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788684652;
	b=Pf3xe331Y0wGkZhRHX2TLDC2jQ1QPmqVqjCSPtr3d9FrqSwMhhJyiQt2WJ5NKHCVHxPi
	 FLWMWvJoIuHiC4tCBKO8M0hAsZObEdC5SOOQsBczCIUFVOW1Rdpoe+ZF+4rZTO8qFeWyE
	 9v5UJxC1Bo/fULUWr5PKzfuYQ39TiqjiyRuzvvlwhrVcxfIcTiP5arRcJP4QNSJ1NDVGU
	 fsH6y5AgdWpSCTRtHOusdbdZxQLSC9NnfqsbUXaM9EUuaRmfJwDApZdg3bAfM1JzP5REw
	 A9hveZBFAn8fAaRofGcufqBAl4PF7BaYc9aNUz/AJYMWCZBzMfTz5sLsWjmSnXZ8rug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788684652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0id2YY5pP9gAEYb7cM3kFahfETFF3hnWLbjOK24RpHQ=;
	b=UUbD2aeHa7Mzxq2r3fVqHuh4VJMfztFZY57Ka+nG5r/JsL2e5DLxaohWx5t7nWpDK6Iq
	 GTghManXrUOmn4cj4xTlDkLNjbsZbVglfPm9ipBo5WMiWulHNc2V321jSlDQM2HTaw6pX
	 xEQiKaMnwiATygOsBjbadWqsVRFm7tcMB2zPfU4tdzIffc6zgni2Sep64YQ9JZ1rFiotc
	 9xQCn8/n+djLf8Ju3s319+6r+dyfVEv7vKvOzzhPKkEeu70/o1/dVUFgjOwt9t3gRJfpA
	 1y/J5YsYebffihvnxKKF9t31+szkHBGGCO/KqB9UMsF5/108RsPqIC0wyUMrW6b1uHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788684652;
	bh=0id2YY5pP9gAEYb7cM3kFahfETFF3hnWLbjOK24RpHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMi/kcPPjNto888dLhXBvhD6nzcFDSjHsqY6gR8PDr7FKnd/rvN8G8gMs4IoYYaxe
	 8g+AEp7EWYXnR15Rm+ZzBYhXv1uq6itppEikwqLAFGXBPkN01BPtE3ODeSM+vbIFJX
	 Jao13yxK+zpwTJbRnQA+8Ggu/viQxP5nJLjjnPJgUy6Rb3p22EV7RBXthUeFtr5KhJ
	 0g51bMWUiSX3pHuuDA5sfrqKukLTuY0R/wCOwIUXTIATVdMQcWds5UkUAp5VAywzlr
	 mhDRv/68WwFljhnMlP+tDNF13NESV7t/NAgsnhRcJRNE9OhQoRwPJKlzsKzjzzaCaW
	 56c2y1bQ4g7MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0DA480D2C;
	Sun,  6 Sep 2026 08:50:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DFCEEA48
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 08:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1387405E6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 08:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbQ4-Bv2ThsO for <intel-wired-lan@lists.osuosl.org>;
 Sun,  6 Sep 2026 08:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B1B2405D8
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788684650;
 b=ruNpRJhH8VW/HoM4mnPLLrhBmY3XhiRI7/pKjmKgnrtCrd8RWkQzEUU1z/GFGGcgBV0D
 9V6oiEH20tBpOt4NRFePIeyGqhxoa1DDQ8++IeRiXnHa69MOc6T1W3JURhrgsA1NoNJ3z
 ACdpLPU/uuDHByEJUbWrUHNcKUWL+GMmlQqmuszq+9lObhkfLqsbRguSOg4QaoA0ZXPFG
 uUghZBPFNUfTIvFc1kJ2miaiTYSg39turTRasvD244nEYYKrsUmIEtKZR9ZofXVJy8tij
 rodKUqOK7kvhfVhTKCDXiRlxe3RRkszMNysoc42MxbmwF+78RCpUHj/1uo/eTjcuSIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788684650;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=0id2YY5pP9gAEYb7cM3kFahfETFF3hnWLbjOK24RpHQ=;
 b=b3KTe7MiucGtx4Cbdi748BoVtUIzCdxpcbxJfF0BciPp+uttdYqODHMmEnlT481Kymi4
 Ko5aX6vwJkJ62GiBpG2FMpdmCIgZqbtQxYlbBniRu6dsYs3BsNSY6KEi+ZzvD0C5xTbYR
 dOjM/2acPiom4cf/aLRCan5pIDbmx5ZSyOcRME0ouJfB02nFdmH+O6qmUQDeOjrouIebB
 YpobhHWIJKZjdgmtOmmeQLQ3DmRtu7epnF8MhfxemGtfRdbiMMBBzTsbYWnN60790dnA3
 7IwlUzi9DIjEqjOcpIxpy1lQVU+aOPtpKaL7hA5sGc0ySPUfo2yYYvmLbXEHxs85zlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kdnF7prQ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kdnF7prQ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B1B2405D8
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 08:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F4EC600AA;
 Sun,  6 Sep 2026 08:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE01F00A3A;
 Sun,  6 Sep 2026 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788684646;
 bh=0id2YY5pP9gAEYb7cM3kFahfETFF3hnWLbjOK24RpHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kdnF7prQ8zopDeyyKcLUegLUsYl9i/7Z0B0Z/bFghhmV2Jtbyj/E4IJ5P9UZoO3nW
 M0lbYNeiprBfoX28//ylZBcpaKgCdPGNPS7C2oIIhVyLZ+xc+4i3d2U7Elq6yNwrHz
 WVWPW8lcqnb3KQ1Dq6O85vLPElvFEESM5B3MQ/pL6v9FunfVyV/dTrl36bjM2WVQfB
 ytYSuFMijPSQytIBk1NKRhjIwiIKvDxf4NeoSnRx2v8OEYx0MzzD+RZ1BWr/ERUtnb
 nQrf7sI2xxpcvV+cOgE6I/Bds8OEyVOAyCih/qreUR6iejI/3bcJrtrtU8ROWl+DvN
 5+n08F2mZa/0w==
Date: Sun, 6 Sep 2026 09:50:42 +0100
From: Simon Horman <horms@kernel.org>
To: "Rawda, Tony" <Tony.Rawda@disney.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
 "sasha.neftin@intel.com" <sasha.neftin@intel.com>
Subject: Re: [PATCH] e1000e: set fixed clock frequency indication for Alder
 Point
Message-ID: <20260906085042.GF40544@horms.kernel.org>
References: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
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

On Thu, Sep 03, 2026 at 06:06:33PM +0000, Rawda, Tony wrote:
> On some Alder Point (e1000_pch_adp) platforms the XTAL value reported in
> the software STRAP is incorrect, so the SYSCFI bit in TSYNCRXCTL selects
> a 24 MHz base frequency while the SYSTIM counter actually advances at
> 38.4 MHz. As a result the PTP hardware clock runs ~1.6x too fast
> (38.4/24), which prevents ptp4l and other PTP-based time sync from
> disciplining the clock.
> 
> Commit 688a0d61b2d7 ("e1000e: set fixed clock frequency indication for
> Nahum 11 and Nahum 13") fixed the same problem for e1000_pch_mtp,
> e1000_pch_lnp and e1000_pch_ptp. Alder Point silicon likewise always
> runs at 38.4 MHz, so give it the same fixed-frequency override in both
> e1000e_get_base_timinca() and e1000e_ptp_init().
> 
> Observed on an HP Z2 Mini G9 with I219-LM (17) [8086:1a1c]: before the
> change the PHC advanced 16.0 s per 10.0 s of wall-clock time and
> /sys/class/ptp/ptpN/max_adjustment read 999999999 (MAX_PPB_24MHZ);
> afterwards it advances ~10.0 s and max_adjustment reads 230769100
> (MAX_PPB_38400KHZ).
> 
> Fixes: 59e466888038 ("e1000e: Add support for Alder Lake")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Rawda <Tony.Rawda@disney.com>

Reviewed-by: Simon Horman <horms@kernel.org>

