Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8A7C48BC3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Feb 2024 12:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D8C3409C0;
	Tue, 20 Feb 2024 12:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vaAoMP7P440A; Tue, 20 Feb 2024 12:56:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75E744070B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708433779;
	bh=ENXpTX7s0VpOWqmoeICjloXStTsQwhGAKR2p6Thu77M=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TRhlzSYhlhZNM7MUGgUUNS8b0iZ6ryefiYfQs7WzL5q3PyBjqySqfqnl6HicORils
	 wS3+qQMu00JBLzvUyoeCJl0JceFdmUQgalNgZ+Qa12cTjpxhtUMNrSLx2Uy7OQ6mF1
	 hKQIVskdun7dwObOYg4ruDE02yNIn+dbKxYKmTkR2JNlw+TaUStHM9z72WDKrTo6gQ
	 y3Dum7xLlNxIp0WXTu6Gz1auMdspuj0F5Mg1VQSh3dqrAdpraapP5KzLseguULb150
	 txQos6adkdXhg3GnqIVXXkxP0IiSbY697SdeuuM3dSpqPXWRzXjwXfMdbeBdTkPNjy
	 oLJz9MY11TyJg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75E744070B;
	Tue, 20 Feb 2024 12:56:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 8209F1BF5B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 12:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DB0781BBD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 12:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5whmjEEaCM0I for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Feb 2024 12:56:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A691C81B60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A691C81B60
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A691C81B60
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Feb 2024 12:56:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9D593CE1859;
 Tue, 20 Feb 2024 12:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FE2C433C7;
 Tue, 20 Feb 2024 12:56:10 +0000 (UTC)
Date: Tue, 20 Feb 2024 12:56:08 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20240220125608.GG40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-1-71f13b7c3e60@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-1-71f13b7c3e60@lunn.ch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1708433773;
 bh=Q5BWa8LkWf902AxVTsQ/Vk7boyDKv6MiQY5w+ZXdYKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NDL51/xP6pc6UuWIIrE/ULokhaA0Vsu3/GWwd+ew91wGsc1nIk9kL/zCarULtlWWk
 n8oXykLkk1lkVXPdj28ctAzMV3NjQq12HaTujBx4w5zB+Nl4HBaCCz65guDc+uGA6n
 BNp3HCFt8zpK5YVEoZV05JTsAK/3s1Nkn0bsertTXPh0yzb5mx80ghJdLuKmrP/ThN
 NFsQi7M1r663rsSy7vyAcU9/4hamPARjn0qnQQOa/KUVf7/nFACL8E5oaJ+76oAPQ7
 zFUqw71sreswoZq5sS/mbllizqCcdsXgJFzjVbFryODclY7YAY7+8vFZ7hYxh3W1en
 cuQlAhiLsdg1g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NDL51/xP
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/9] net: usb: r8152: Use
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
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, Feb 18, 2024 at 11:06:58AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Rework determining if EEE is active to make is similar as to how
> phylib decides, and make use of a phylib helper to validate if EEE is
> valid in for the current link mode. This then requires that PHYLIB is
> selected.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>

