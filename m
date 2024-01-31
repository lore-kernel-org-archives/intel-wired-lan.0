Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF8C47258
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Jan 2024 21:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A1F7614E4;
	Wed, 31 Jan 2024 21:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A1F7614E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706735589;
	bh=CeBv//p4KifhhJq8A/dJibUw8SEEng+UVVtN4T8ou1A=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5PLxeIMdhIOn0JLeFpc+V60p2+ytA7DAr7dMgZkwM+egA6CGti6qx555+VzRbILXH
	 UUKBEcczS7G86pRdKgbITlmovDlaeRCjZuYrYPGpTJ+kcgFFac1JmUtRcRDynHM9oP
	 PGgBzBV9UhgC8/nQiONMq9DgTCwh/t2xN0ArUtqy3Y+Z1DmxIm+sgl4xPNehI/gSY5
	 ibECEK9L7Mz9n4bt8teumD1A91L0/h6GNFOwA44Wh7xv48xuWzirJsg3s8pz1rgbdY
	 /syG5rUQE0Zk9rRZNqyLx9MHQZ+9ULIlPFextksJjGCukm6AZfidv/HiIaobh+11S8
	 4oV9Li1UdqwTQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwhSv6AK3eDi; Wed, 31 Jan 2024 21:13:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BD61614E6;
	Wed, 31 Jan 2024 21:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BD61614E6
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6BFB71BF4DB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 21:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F88D84563
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 21:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F88D84563
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M933LH3rMUyS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Jan 2024 21:13:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A82DB84561
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 21:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A82DB84561
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 05C6E619EB;
 Wed, 31 Jan 2024 21:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990BC43394;
 Wed, 31 Jan 2024 21:13:01 +0000 (UTC)
Date: Wed, 31 Jan 2024 13:12:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Message-ID: <20240131131258.47c05b7e@kernel.org>
In-Reply-To: <20240131134621.1017530-1-hayatake396@gmail.com>
References: <20240131134621.1017530-1-hayatake396@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706735583;
 bh=KpeAZao1g931gOPKrARuB7csMwiSRG+PLjdP6UwwNN0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mHYp/br4PIDgr2Q2UoE2YGQ9ybcMX5UUpZjaqU4OWWRx3mz93/SKLXjbGoMBcqGtJ
 HzH+OOvNl1XNol3OrCKwFgZVB5YZ/czTicEfZwCOO3r30cN7qCdZL9YYzDhhuY2+wx
 WX7CYjDJ5Rf8IdaXwg7R99cFfEn485JP9llYEuzEUYGewIzg/vvrE2l6t3xoFYLd1O
 4sC/m+sJXDsu/0g+faGE4XrVPbT3PeneVq5q4gD6CDUEUw1pZaqdyT3qI+DLHjG2xw
 ZobrCtsxoRmenhAMZPVTSRgwwZCvVdLzp8fOV/SPY1NthbyXZAgUVfW91qKJM5dPe7
 wxnnYftoxanVw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mHYp/br4
Subject: Re: [Intel-wired-lan] [PATCH net-next v6] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 laforge@gnumonks.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 vladimir.oltean@nxp.com, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 mailhol.vincent@wanadoo.fr
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 31 Jan 2024 13:46:22 +0000 Takeru Hayasaka wrote:
>  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
>  include/uapi/linux/ethtool.h                  | 48 +++++++++++

Could you split the uAPI changes and the driver changes to two separate
commits? You should post them as a patch series, but combining them
into a single commit makes the uAPI addition to easy to miss.
-- 
pw-bot: cr
