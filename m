Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0E1C3271E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Jul 2024 12:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8186E80D75;
	Mon,  8 Jul 2024 12:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 497wjps2H4Cq; Mon,  8 Jul 2024 12:42:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 756B980E1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720442521;
	bh=iiEQqxBnuL1nnqUpnLZk6XSz3/t8Aebtkk4MLLxwQIc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XYUTSOx6riCl8NfRpl2eyTBMrb06njec2QlXWHnj2PUd0X6wZtr306n3D9Xw8X8W6
	 Ms+jtpF6Z2jhlR2OumXdOFxsstGgpaVtPNeVwhFtbSpPZ62HZz8ZQJIabpRTBFb92k
	 qa+75Bu6XcmG3RYcqxCvReOPyTxZzr0B8PIq57AQ9xnCJhlz5IZi9l+sSXMubJes5A
	 KJMUtDFZ0pk3oXC0TJEMlN+8lRX6fm4HFrgMowyVvoOcKQfylhg3p2ZuGOEL1rBE82
	 oW7jpxJzbpbf4LuWIZtjZP1yA57fd1fY2cc3G5lwtjM1C/UThi2iMboaEGYHdK3VYa
	 iMt7p57t9v/6A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756B980E1E;
	Mon,  8 Jul 2024 12:42:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 217361BF390
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 12:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B18160627
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 12:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MnWnjnLRbCuJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Jul 2024 12:42:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C437605C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C437605C6
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C437605C6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 12:41:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4F01460BB7;
 Mon,  8 Jul 2024 12:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C5BC116B1;
 Mon,  8 Jul 2024 12:41:55 +0000 (UTC)
Date: Mon, 8 Jul 2024 13:41:53 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240708124153.GQ1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-5-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-5-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1720442518;
 bh=5nQj+rts9YS9Ia5kQOE7Jvlvi0YFlA7izBiZdjKmwlM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KKEz5M3X7+Cx6EplGd79DL1xlzDx5b8XkquKiT9sTPAmH8w2ngNC3PkWfz7HinF5i
 4UPP7gj7omvpNraMTa1HVhDQJjfYLDnVx0bhRHYC58vKl3QwsJoB8eoZw+ULSpusgB
 3CRDnqJ8E74R+nSUXO1dy46GD0LJ+qupfI/k1ZizZ3oGCWNYmh0wLG9RKSmiMbWBf/
 VycI3bHcM76tXOMfvW6leVaZFRax4BqAyaGRB9EgsDe/dHDyOrHC0G2hAOQE2CAPyk
 wpGlBkC8/F/wmDaCKXDBxLPYazc0nuWKrVWCLhnjmCrdAY57gB/J2/kbWt7LNsmVD0
 f22qY8l9Rhu8A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KKEz5M3X
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ice: print ethtool
 stats as part of Tx hang devlink health reporter
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
Cc: willemb@google.com, Wojciech Drewek <wojciech.drewek@intel.com>,
 dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
 Igor Bagnucki <igor.bagnucki@intel.com>, joe@perches.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, apw@canonical.com,
 lukas.bulwahn@gmail.com, akpm@linux-foundation.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 03, 2024 at 08:59:20AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Print the ethtool stats as part of Tx hang devlink health dump.
> 
> Move the declarations of ethtool functions that devlink health uses out
> to a new file: ice_ethtool_common.h
> 
> To utilize our existing ethtool code in this context, convert it to
> non-static.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

