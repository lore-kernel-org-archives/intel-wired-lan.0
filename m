Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22B5C36010
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Apr 2025 20:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6808881192;
	Mon,  7 Apr 2025 20:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvO-juqkHOOr; Mon,  7 Apr 2025 20:31:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6D1681D72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744057867;
	bh=w9ovsHoE8JgQH4oLggs1TAJXs8X7Tpangv6cT0yEWGE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufvzmj1gczHT7OtDSNnG9eVuogxL4jhj8Vm8AFQAxayNoBZL6D0RXtYZLF8LxXLkp
	 DvcOg9tr53n87pLh4R/6PSoW4Nqcv0DOFEfknZrh7kS8x62UFbFJrJYQ8o0tGKR0W2
	 EPcEXft2vUU2AOaswa6nrNgk62BTqSwPKpa9PAQvb/AEzM61IVzuyJWfegrktUHxgQ
	 CmZw3LhPifjJQWw4aGzpS+hbiE8QkV7BIYpo/emedIMoilQudhzNDoBwCDJMwt7Y5s
	 Wi7ttR/bYmVUk4tEUqWm1CQcvWcoN4wa71YqY6SZ0k5tuD7kHjt8YsOJn9i5wmqdBl
	 ZgeZLJoTYDLBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6D1681D72;
	Mon,  7 Apr 2025 20:31:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22205DA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 20:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F414E81D72
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 20:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdAHZpkVTkYX for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Apr 2025 20:31:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 29F5E81192
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29F5E81192
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 29F5E81192
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 20:31:00 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1u1t7O-008Iqo-J2; Mon, 07 Apr 2025 22:30:54 +0200
Date: Mon, 7 Apr 2025 22:30:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Willem de Bruijn <willemb@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Mina Almasry <almasrymina@google.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Jianbo Liu <jianbol@nvidia.com>, Gal Pressman <gal@nvidia.com>
Message-ID: <6ad4b88c-4d08-4a77-baac-fdc0e2564d5b@lunn.ch>
References: <20250407123714.21646-1-mpazdan@arista.com>
 <20250407123714.21646-2-mpazdan@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407123714.21646-2-mpazdan@arista.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=w9ovsHoE8JgQH4oLggs1TAJXs8X7Tpangv6cT0yEWGE=; b=zk1qfI4oag4BvCspUMOS1Nf+MT
 fMx1LRMlR/se1AMr09cj03hH1ctbqgnxT1ENKy9/oNMx4oSZU0+iQ6rUdnjhNx8vgu3x28Pf8qEmp
 4f96vidN8sCC5ZQYYFAmFxwy2fPRR6cKawgwxQrKaqQHgPq1LzRAwYzZh5bXhEG0QbGc=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=zk1qfI4o
Subject: Re: [Intel-wired-lan] [PATCH 2/2] ice: add qsfp transceiver reset
 and presence pin control
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

On Mon, Apr 07, 2025 at 12:35:38PM +0000, Marek Pazdan wrote:
> Commit f3c1c896f5a8 ("ethtool: transceiver reset and presence pin control")
> adds ioctl API extension for get/set-phy-tunable so that transceiver
> reset and presence pin control is enabled.

As the name get/set-phy-tunable suggests, these are for PHY
properties, like downshift, fast link down, energy detected power
down.

What PHY are you using here?

     Andrew
