Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED57C3DA70
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jul 2024 13:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ABEB40634;
	Tue, 30 Jul 2024 13:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60hWa6uVno3P; Tue, 30 Jul 2024 13:58:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7796C4063C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722347921;
	bh=KjkXYneYVqJAd9l6x7SXO4ya6waBJhS/04FBwQX66G0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=o4lmRrWOGOU5D8gZXIg4f/1FkE6ZrjC1nGwm5x+SI2yEyW++F5OylvPZ2f+G1U6pQ
	 sYRWZ48BYTnlk2a5/D1cThwZKh9wlP6I0eLN6OOQOuz5tBJJ4DksM1AqmU+BUgroQh
	 ONoz3u8zc/gDExhvce3hUaSIrh8+ggv4jsbavxLzy/Xj9Up+/eMoUV03Pa4+HV3MKu
	 o/NJtBAEqsd4UDOADjZA68vmfLiHmRBqDZXIQen3DFcn2O6zLwtfz5z0wbQslSGOHa
	 iDpyXjHWJBki1ebq3vmXRrwQbaFTKHgF1W8OMXnn1HFXYsDa/H+lwYvzXgI0/0dy8W
	 bas3I28WP8trg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7796C4063C;
	Tue, 30 Jul 2024 13:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DFCCB1BF969
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 13:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB3A760718
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 13:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcIJx0Zv7lOX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jul 2024 13:58:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4508A606D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4508A606D0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4508A606D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 13:58:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE2E561F10;
 Tue, 30 Jul 2024 13:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F790C4AF0C;
 Tue, 30 Jul 2024 13:58:36 +0000 (UTC)
Date: Tue, 30 Jul 2024 06:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240730065835.191bd1de@kernel.org>
In-Reply-To: <20240730105121.78985-1-wojciech.drewek@intel.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1722347916;
 bh=KjkXYneYVqJAd9l6x7SXO4ya6waBJhS/04FBwQX66G0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QpL2VvftFHuabJeI5M8ltW6gSJPSls5CwIilVGrGlBzz4Aqq30Rwpn5rIQiBfXLKg
 +PvNEjv3E3tVJOYoeI/hwFJBeJyZcIhAd0c/LzK4Pg2xlXheGDJ3NrWglp+qtgOBGj
 LsTJCbP+DSr/YElIyJvgQ8Ao/1JS+JKmQtOUC3qLC0bu787+JMX1BCuzoAx3idzc/u
 GrSn0OCPGZ0QfZDcEFF8aut4d29yxEu8JNNtoD5k0rQ3GanqoR4Cuy/uai/B+8XO9p
 tiRSmwW5IRaKLMkjaKIxmfdrtdA4wme4LSYtz9JH4LfYFJ9mxivWD4iD55eTkE7cqs
 8iOSVQ7SGb0Tw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QpL2Vvft
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Implement ethtool reset
 support
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
Cc: netdev@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 simon.horman@corigine.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 30 Jul 2024 12:51:21 +0200 Wojciech Drewek wrote:
> ETH_RESET_MAC - ICE_RESET_CORER

Core doesn't really sound like MAC, what is it?
And does PF reset reset mostly PCIe side or more?
My knee jerk mapping would be to map Core to dedicated
and PF to DMA.
