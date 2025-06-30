Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C9C83029
	for <intel-wired-lan@archiver.kernel.org>; Mon, 30 Jun 2025 17:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3163184687;
	Mon, 30 Jun 2025 17:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykaqAGG9anNM; Mon, 30 Jun 2025 17:00:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9B50846EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1751302842;
	bh=jw/L88OzfTod1vK8AuCwgzrRUHVHShUQpNYEhzG8+/I=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YoR3iIuynlBARxRoqfeyJp924Uod/Il0OwmMCGWKEf6KsbO5rihpBWRX+88z0Wa+Z
	 WUOdTbwZ5iKgCdGl4nHElXzEvM2rn8ZrU1fvszsA/Wzt+MLdPKiGF8JIUeVCfePv12
	 1FNi4brmd+Ea5x/IShgFtYut4hEeoPl4Usn6/ikK9/0gfgCnQ6zSgWHpTMEB95Ul8Z
	 5INW89ea8+yH6NvywJ9qRitGylvakKayI3MKuTji7kvU+dngJ1XQRvWhQCpsP1nm1z
	 JSd/ym7BW9in6BRcEFfkTRqKOIIexkUigaMy2Zs1ZPpv9tQPTL0WIMezqiWHdg2S2Q
	 MdaG8VSB7kidA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9B50846EC;
	Mon, 30 Jun 2025 17:00:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70712DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 17:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62521846EC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 17:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PotW2UZ_JZXL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 30 Jun 2025 17:00:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CCD5D84687
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCD5D84687
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCD5D84687
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Jun 2025 17:00:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 341E461126;
 Mon, 30 Jun 2025 17:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17E4C4CEE3;
 Mon, 30 Jun 2025 17:00:36 +0000 (UTC)
Date: Mon, 30 Jun 2025 18:00:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vlad URSU <vlad@ursu.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Message-ID: <20250630170034.GM41770@horms.kernel.org>
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
 <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1751302838;
 bh=A1ZSkoTFKTKhjpljfgDctJifOFrYqObAJ6IZojsoYAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GFvLYFGjbDkqPXBkpc0o6ksJ1DVo7hJR8iHF/K3W8LjK6nqYMxBji7QEtmFfs5IFy
 kSoeHEXn0wcJs03fuCYeOaqLJATW6Rw5RSrhJ/BUgyssQG1pvNmay7bmWOjCWASDr4
 xbgnvQ5n/u1F/ZH8bvLXRXtAUWowWD7Wroa5bipVNj3uGewBLJrAbJZxBV/0XcI9nq
 95Vc8Lnk7LTDc032hy1qySIga/KUrwe9k3Ehsu3+ICOxugNySSLDrFwih3gdsGgx2+
 Ds9uwkFi6BJadQhGEOi/j4+y7EAVb5BHyTL2WBI62MMa9eSp14qrMwjWnAIJRLs8F6
 JePBQM1iIE8uQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GFvLYFGj
Subject: Re: [Intel-wired-lan] [PATCH v4 2/2] e1000e: ignore uninitialized
 checksum word on tgp
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

On Mon, Jun 30, 2025 at 10:35:00AM +0200, Jacek Kowalski wrote:
> As described by Vitaly Lifshits:
> 
> > Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> > driver cannot perform checksum validation and correction. This means
> > that all NVM images must leave the factory with correct checksum and
> > checksum valid bit set.
> 
> Unfortunately some systems have left the factory with an uninitialized
> value of 0xFFFF at register address 0x3F (checksum word location).
> So on Tiger Lake platform we ignore the computed checksum when such
> condition is encountered.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Tested-by: Vlad URSU <vlad@ursu.me>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
> Cc: stable@vger.kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

