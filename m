Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E30C4345F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 27 Apr 2024 14:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7313C606E9;
	Sat, 27 Apr 2024 14:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q99hiX5AKKBc; Sat, 27 Apr 2024 14:57:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD50D6076C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1714229856;
	bh=d+aqRagttxFNCsGdMbKJoGeAdWY/bId28ivWAvxrR8Y=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BzLw3RRGBkqTQbNA7pL0x7ISqRX90chUg3do9g9dc+eJgzOVe3SbToZoqEcMse7Hk
	 I7jlbDVmHj7EgnuIzHmJNPxGj2v+AZTcURAzX6nEsNIOecL0eMBRw3JNmZsJPOIj/2
	 nPa3Jnm9GXnicriey8+chkJxEkw0orpoLrmyZT6BrcpTQu2ysadlN0xgrlURp0bjjB
	 Cc6TuwKSG/etvKm9Vr0DeCTdaZkVjoFgJjQj7dnVjtv600SrcCNIHTmKgauoXO2eIf
	 fD3zdMQiu33NxgOGJtqjuDnyJC0yZW+CElXgA2sivGgqoVzbKJjYEbiK7unRbYX4of
	 QMRbvJEa/rchA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD50D6076C;
	Sat, 27 Apr 2024 14:57:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C8FED1BF3DD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 Apr 2024 14:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C23DB40518
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 Apr 2024 14:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hmd5AaPMv0_6 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 27 Apr 2024 14:57:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F183A40175
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F183A40175
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F183A40175
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 Apr 2024 14:57:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C63CBCE1882;
 Sat, 27 Apr 2024 14:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D15C113CE;
 Sat, 27 Apr 2024 14:57:28 +0000 (UTC)
Date: Sat, 27 Apr 2024 15:57:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20240427145726.GT516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-8-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-8-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1714229850;
 bh=mCv9x1EKrhloSSiqcx+RUqM7323tzFzD08bdhSgkKsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kAP8MeSuQZWSzGNFPVf9BF26QJPQG4sWzrWBffWmqIlDap/oD7povPZJXD3piZEBX
 82zVTKTktPNuUlb3gbGx/+kS4j89DVrmKYLxOoN/eQuSqYcBZ4Ed/Csk9YZiEryEhI
 Wu0hSqNTSnVZCB6gC4cNcR67Lo2U2kqcHVi2LlidR1DNuc6WTCqdEvUaFxdwBEDwOX
 e8QUFOYbKEH8iFiX6dPFYqldbvcnrcGKaKuqrZ43tIfEB5zgFq4IENiEQwhpO60wZp
 CseDW0FKtrdS5b51aDJG94c4RlH0vkPmlDCY5UXYkcDx0aMAw4Pka/mqcfp4sxpwfp
 EZYATY28u2l7A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=kAP8MeSu
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 7/7] i40e: Add and use
 helper to reconfigure TC for given VSI
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
Cc: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
 netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, Apr 27, 2024 at 09:26:08AM +0200, Ivan Vecera wrote:
> Add helper i40e_vsi_reconfig_tc(vsi) that configures TC
> for given VSI using previously stored TC bitmap.
> 
> Effectively replaces open-coded patterns:
> 
> enabled_tc = vsi->tc_config.enabled_tc;
> vsi->tc_config.enabled_tc = 0;
> i40e_vsi_config_tc(vsi, enabled_tc);
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

