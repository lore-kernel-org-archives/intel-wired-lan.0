Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94145C5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 21:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D861407E2;
	Thu, 20 Aug 2026 21:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmvtYaab5jht; Thu, 20 Aug 2026 21:41:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787262072;
	bh=5yI93gnwy7UKZyDGlar0JhbcT00ARq4NQYfFqw4pe3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfuUb6qhr/i0/ShLyKBEQN5EQXgzyU4HX7O2eXAQ1zRprlVb4tOW/XV23rGSEiV/e
	 m+G2YqIvIpYMj9ir/OkE0lDT3cAv1uES0VHzgpRb7Y/1RbLtRbrxUq5tBzMu7Q180H
	 94c3cOEvrHLCDHj754QAt3BdNB5ogCYKTVCSudKfi1+jc/CJuP+GHD741hHRFF2Ocf
	 aTLG4E0wvb64PSVzPkpzXDjS1HO+TB5kryf8wqB4pEN/jYFMcvQUH5xbvxI74eWqcN
	 Z+EUtqoReoy97ZfQW8xAEXNDkjnT41VgtM+LQTpQ7xJGBaX+UHs0DF5tzksg7M4bYw
	 FezjXBSsiwEfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8D5D40809;
	Thu, 20 Aug 2026 21:41:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 323E1279
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 21:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FA48407E2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 21:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nkxVB1L-Nu8n for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 21:41:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eZaDkdjI
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 949FC4051F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 21:41:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50DFD43684;
 Thu, 20 Aug 2026 21:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D2C1F000E9;
 Thu, 20 Aug 2026 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787262070;
 bh=5yI93gnwy7UKZyDGlar0JhbcT00ARq4NQYfFqw4pe3I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eZaDkdjIgbImlfSGdajNMnma5g0sb+nBd+5zAYUIc5RMZ///1FP60XNlx7oHUbrNS
 adLo94ieT3M9IR33igB6SRx38Got/VIhixM9eoTDRtvs7Z9qxspVKbKzujC/wAck5F
 RX7CRKhE4nYR/gpG1dW/R3biiOOAGvDk1Oi0yRWl15CMH3Xi0YbTnKbGWo+59tvKMS
 ToSTT4WpKfU4PTHldij0xTsNTivO1dW+l7OgqlYRCYJD1ZY0GtCMC1gLRw1xHin6BQ
 ADOESE+u36WXJ6qxVswBZsXgv5BJXPdR+QgO00y2NgNl27EvSdHviXlQ112p9K9+g4
 5gnMqTGXBYCNg==
Date: Thu, 20 Aug 2026 14:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <rafal.romanowski@intel.com>,
 <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, <marcin.szycik@linux.intel.com>,
 <anthony.l.nguyen@intel.com>, <horms@kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array
 overflow via proper realloc
Message-ID: <20260820144109.14e7777b@kernel.org>
In-Reply-To: <53c50cd8-edfa-4fe3-aec7-a6d66194e635@intel.com>
References: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
 <20260817205047.3612990-1-kuba@kernel.org>
 <53c50cd8-edfa-4fe3-aec7-a6d66194e635@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 19 Aug 2026 12:52:39 +0200 Przemek Kitszel wrote:
> I see no point documenting such minor details in commit message.
> 
> As a whole, this patch trades a real bug - memory overwrite -  for
> a slightly different order of operations and slightly different
> failure point when there is no memory

My concern is that you're backing out of the promise not to turn
a fail in kmalloc() during ethtool -L into a broken interface.
Fix it right?
