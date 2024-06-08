Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EF8C27C65
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 13:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7F4A82156;
	Sat,  8 Jun 2024 13:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vpu8gpYG0Dik; Sat,  8 Jun 2024 13:00:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CF9782144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851612;
	bh=Pje+4ZWKEn2kVlEeGTtRhvjkP37G67HMwMmj7v6lmR8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9CfkkL2p0i0+VNAr4Zti29PP+VDWyhUtPlUozwm/QDXLi/B8th57gQqiV1aakThrn
	 p8RYzwPWp4QLsAwReRHFBaRKeo6dRPHh3mmmYnYiXUYG62HKTyCovGFl3o0NNcA53+
	 8cklfbvzccqp3s5erlSNPNvsPpRDgRQNUF0JQ7UTm3+ml4aIXr/wd69H03gNYiJfGV
	 cWa3ntVtKmFn5jBJNK+PNyKXbSTdiv2rwkU9lNRlJw/XY6+sqx/dTksBT4sGzMyxGQ
	 AoTTzRlCFUufhFoNuI66qYa92m0Bt+5PBBgmHwj+DJyvXzCzjuI5pHqPg9IF2k3nDP
	 ZqBvdLFV+PsXA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CF9782144;
	Sat,  8 Jun 2024 13:00:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 878951BF47E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 13:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81C0382141
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmHxPsABDmDF for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 13:00:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E909182078
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E909182078
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E909182078
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 13:00:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 32B6061243;
 Sat,  8 Jun 2024 13:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82912C2BD11;
 Sat,  8 Jun 2024 13:00:05 +0000 (UTC)
Date: Sat, 8 Jun 2024 14:00:03 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608130003.GD27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-12-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-12-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851606;
 bh=Ko2dva2R0y33Pjh2cNh4af7X+bEVHxW+/W5sDQ09gG0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mKPQqLxvj8+7ChKgF2jJGcPwLEhJ7C7pM2KxjbdgvYJwVDEo5gKvEe3Pmxx4IGXlb
 /Q82TbXoU1l+2qCau2DfbnukcJzI560nqH4ODQwIBleKx5a/+xdCh0xbfAS6iI8fCJ
 Xn/yAO9M1Oe5KG3esfxxYfXxZ6uH8WB1ZnYOcFif7X/gk7nNPch5YEj7PRZ1/dvwL8
 GJca/iMQWuc22MqV9Qk98my8yada43o2fja0wKMyZ0387D7Hkh5iDtWxzmmVLPAwup
 BLtqoUaoFM8xBoXjnL6pO+hq6EmHebS9FxFQKRuEgL1O1h76WujnLiviDhZoRmcDOD
 TVSfTaF3RENSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mKPQqLxv
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 11/12] iavf: handle set
 and get timestamps ops
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Wojciech Drewek <wojciech.drewek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:59AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which allow
> userspace to request timestamp enablement for the device. This support allows
> standard Linux applications to request the timestamping desired.
> 
> As with other devices that support timestamping all packets, the driver
> will upgrade any request for timestamping of a specific type of packet
> to HWTSTAMP_FILTER_ALL.
> 
> The current configuration is stored, so that it can be retrieved by
> calling .ndo_hwtstamp_get
> 
> The Tx timestamps are not implemented yet so calling set ops for
> Tx path will end with EOPNOTSUPP error code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

