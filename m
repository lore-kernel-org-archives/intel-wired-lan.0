Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B0EC54E67
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Mar 2024 14:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DB72407F7;
	Tue, 26 Mar 2024 14:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJCNMnlipInd; Tue, 26 Mar 2024 14:36:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECFD2407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711463787;
	bh=QPsIbe1xORzujQlI2i5zZmGJjoOLX9u7cDoSEsjGRO4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mOlsv3Su/+hlzlVBelQrOsNxSMs9hLm74FrgSFwhQEZ4nagPjN3PrzW/5NLrak0MZ
	 6Y1bLryK7cdZZVO9K7g2Kp7jgZfIcWSgGEd96LpE9WePJf7WOlVACet5BH3oKdO0PC
	 oIb0EgdyTMDIRmU4nk9S8NQJFVS64coFK+FIR36DzSvWj6TpSwBrMUGiwxj6GczA36
	 ZboymnflRT4yfOt/j0zqVVftccWwoCimfZ0s3Bz6cH/Y6pyR1rY5G/UM1hGvweSxkz
	 QuN2yfTHcSnCOJ3tLYXixs5KVL2oTm2lo3RZdkhAEir+u9n0rDfrULaILT5YaWKJAL
	 Ry1kO7jkaZBbA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECFD2407FF;
	Tue, 26 Mar 2024 14:36:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E7C771BF4E2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 14:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3507407F7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 14:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JP-JxEDiMlmy for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Mar 2024 14:36:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D9EEE407B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9EEE407B9
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9EEE407B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 14:36:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 53627CE20B6;
 Tue, 26 Mar 2024 14:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79317C433F1;
 Tue, 26 Mar 2024 14:36:18 +0000 (UTC)
Date: Tue, 26 Mar 2024 14:36:16 +0000
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <20240326143616.GA403975@kernel.org>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325222951.1460656-4-helgaas@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1711463781;
 bh=T5+Ilvr1b291b954quPpgBb3WMNDJu0NuiX26qSRQHM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HOLND2jcqr9pzlZ0/W6u68xW9sxo5LaL+MKtPF7dPa0aiJMCqkhT98LeRf0bujSJM
 Aa4TBjibbEVL3Hv0ClMRocZaoqSY1KnXqSGMtGZNwipJeC+dR8i1BxCeuRWdkaO2xq
 QWn6ElobDNbOk5GfozD4c+Jbhr3JX2FVbEZCHzc3dDXxxtOqPY0x0AxUPoR9JUY5qZ
 n0vU4KN7M7ATBm3/UzyCjDoZc4K15QFWoJMRmGJWaC8m+P1u2Gwb5r7AZPWd6HK7So
 +sAeH/GwaJqoKLpWHJpYhNM4SuLIbDKFbTHC5Ubbvnax06TQgknCruQB8sPLh/hPzM
 An5+oSrus34kw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HOLND2jc
Subject: Re: [Intel-wired-lan] [PATCH 3/3] igc: Remove redundant runtime
 resume for ethtool ops
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
Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>,
 Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Zheng Yan <zheng.z.yan@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Mar 25, 2024 at 05:29:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 8c5ad0dae93c ("igc: Add ethtool support") added ethtool_ops.begin() and
> .complete(), which used pm_runtime_get_sync() to resume suspended devices
> before any ethtool_ops callback and allow suspend after it completed.
> 
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
> so the device is resumed before any ethtool_ops callback even if the driver
> didn't supply a .begin() callback.
> 
> Remove the .begin() and .complete() callbacks, which are now redundant
> because dev_ethtool() already resumes the device.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

