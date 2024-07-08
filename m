Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85563C3271E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Jul 2024 13:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3469C40A50;
	Mon,  8 Jul 2024 13:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSJB0AAUnBol; Mon,  8 Jul 2024 13:55:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53A8140396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720446936;
	bh=lfL9pKqna9Hvw5zif8kfCtYL7191qcWg/aKdG9oibyU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ByXfYqecNlDRuku3Z/pjwXWHnjw9dPC+X4nr60Gi4JbSRtsnCt0g/h+o496vlxlqb
	 kzPY8kB1JEL7Rx0beU8pJ/FgJ88WezfwoHkuEsfoGkz3M3sIsasa3Kwmrv4zK6rtUK
	 wNHHbVfrgZcO2f4EJlopKtRCId3u2Xc4mvPvoBWYnE43nuJg0XHRCC4fLwkLP9XPQ0
	 X+eg322MYQuohUxyHtH50xGkh1OgzQUKk8swsAPMB0NCyH3MR7K+7KQgp0i9ZrHxq7
	 RO87o7mxAItarWZUGbsbtq/t77KRpOj4yQRs0btqP7UALG5eHvUlVntcgd5f4YbIP7
	 6qlMlzg0tlQ2w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53A8140396;
	Mon,  8 Jul 2024 13:55:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6AFC91BF484
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5709740396
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgvQ0oTAQ94N for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Jul 2024 13:55:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 89E3940359
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89E3940359
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89E3940359
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:55:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B6FB860BBB;
 Mon,  8 Jul 2024 13:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D9C116B1;
 Mon,  8 Jul 2024 13:55:31 +0000 (UTC)
Date: Mon, 8 Jul 2024 14:55:29 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Message-ID: <20240708135529.GW1481495@kernel.org>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
 <20240704122655.39671-6-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704122655.39671-6-piotr.kwapulinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1720446932;
 bh=os3BeGXRPspxFXn3m4faOMU69cBInTEvRSHgs+1ecoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MIHpFdgQSiWMM0oTbm6Z9TYcbE3hTsm0MzdzBuMb1yH53OLsNpV0dO+TMk/xgVpdv
 H/DVwDAoVvUIlfxYSasXsF1vusoorJHGFeI3Uo4OwvAH3v9ESzYCmU6ldYq32HgQF9
 JDP5vm1TIdoZAhP+OyplorLBhO+gy7PJMzKfKgpow9O1nDFsMFhmQ8MESbHtHVlit1
 Bj4zmwNWcAEw8h+XGgLBl8CKalpK7ZNmc3z928kd339ZtvgrBEES7/vVMnjC+7ZoKv
 OyAT4xDhchiGGrg5v7anCOFra0KVKtNHZNULtfjDxutMoNnZrfKW6DWfi5+vto+iuW
 QsAyLgw1TiQLg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MIHpFdgQ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 5/7] ixgbe: Add ixgbe_x540
 multiple header inclusion protection
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jul 04, 2024 at 02:26:53PM +0200, Piotr Kwapulinski wrote:
> Required to adopt x540 specific functions by E610 device.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

