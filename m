Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84412C369C2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Apr 2025 16:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EFC7405AC;
	Fri, 25 Apr 2025 16:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mH1x4L0StIo; Fri, 25 Apr 2025 16:45:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D6F8416E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1745599518;
	bh=iCi51NJiqOxq8Ap0QsZ24YFbiufl1rVXZxeh59Z6vQ8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=29678v/9C3pl73VZIRiN/OiZXcFXfXQTG1XgQVgR0qX5YUFV1t3qQK0DGpaN+YcGZ
	 pSu18+liBYacbArIljAkI4oXrJUd2IXpI3H4PfayOpN9W/W2Qw6QL3ZVMRbXDZ67r5
	 UKW2yo1f/5tiDgD5X2TAmmCl3GTbqotfvorlUelJm1ImZ+OK56NRrP4gErxN1080PJ
	 r1VS0Mv9GjX20ViMdSH9jjb4pPDfe23GVPdjlJkAOn5inUb63YzDY6Pf3u2+0q1NKg
	 G6RSEMEoktZ4OcnpigOTn+bg4rRN7zdmjo3UpFDU/2yoR5+llXaKTgp58ctgQ4/BmS
	 eBsmkaT96CTTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D6F8416E8;
	Fri, 25 Apr 2025 16:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42B2E159
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Apr 2025 16:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 404CA60FDF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Apr 2025 16:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWZulhrSlau8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Apr 2025 16:45:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 705E660876
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 705E660876
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 705E660876
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Apr 2025 16:45:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0BB755C58A0;
 Fri, 25 Apr 2025 16:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E6C4CEE4;
 Fri, 25 Apr 2025 16:45:12 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:45:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20250425164510.GP3042781@horms.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
 <20250424171856.GK3042781@horms.kernel.org>
 <2a80cde6-27d4-46f2-8ad0-b7feefd4764c@jacekk.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a80cde6-27d4-46f2-8ad0-b7feefd4764c@jacekk.info>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1745599514;
 bh=Wow6JQPfakyrFETVMOiqJ/ZVDU/bPHWIfEcPRk1RCTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T4Rp+tDLxBpVeOUQg9/LnPyijQ+57i3HXJfngMCferBEuKAmb2TebW7oYqpB2AmGz
 gcyxEijR4YBZhU6+2qiV8GawHaRZuVWqqlHHxmfu4PPwH7EQ70L7Ntwv/en0vgWDdq
 qafvcAf14Kt8Mz70/rZeLjOhjbsv1UGeU4Nb/kS6abjrcx+LM0ao2hyyck/DdS4HwY
 A1DTL8D6zwr1PxN2AtTIS7pFNP9rfwzfVgUjc5CZJB6FwlbNKhmGgVXBkc1vEXgRQs
 iCzKGSClsUct73ydEWohviqpQvzjhMcjd9TiUnsvVrJSZnGWmV7jwIxomS9eh4ivE7
 yFGEAOsj8I1nA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=T4Rp+tDL
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
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

On Thu, Apr 24, 2025 at 07:37:26PM +0200, Jacek Kowalski wrote:
> > Although I do wonder if commit 4051f68318ca9 is backported,
> > will this patch (once accepted) end up being backported far enough?
> 
> Stable 5.10 (and newer) already has 4051f68318ca9 and ffd24fa2fcc7:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y#n4139
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y&id=8f1e3ad9456935f538c4ba06d2c04f2581ec385f
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/ethernet/intel/e1000e/ich8lan.c?h=linux-5.10.y&id=eb5e444fe37d467e54d2945c1293f311ce782f67
> 
> In my opinion my patch should be backported as well.

Yes, I agree.
