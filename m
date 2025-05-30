Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F327C5B543
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 May 2025 00:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A3CD61775;
	Fri, 30 May 2025 00:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8-_EJ-cD1zx; Fri, 30 May 2025 00:33:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D246861778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1748565198;
	bh=NQvdTxmbBmPADvv5Bbcr1DYjCqG9xYmrWl2KDuQ7cd4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sK/lMdT+hTJSPWWkagslExn+Y57ZE1/ok3dYbhfK7eQDNVbVaAhi1K6XS0YGtLqSv
	 3y0aFMfHGHTn+nyH8I0OfcEGqu1m/lwQdTNLstXibIIVu2XJqxW6BRgXLV+2G/p9el
	 aBT+8DQ+45MclnBXDpSR9q/UHBj8itvNIVoppU1VKA7hsN8J15kRtfrYpJYBT8/QnK
	 b1eQNr/AN+joIIFRvozvNVggplOgsFJR1miiQN/ZVcNNjbObfS9Tz3nrYIr4EIT63t
	 VBu0e7Gtkh7KlN2xCaheLJYJ8RQB52hClLijM4BvnhiejwYaByRKFzmoVEFzoNnOAQ
	 PInDhpzws6hMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D246861778;
	Fri, 30 May 2025 00:33:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50C34236
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 May 2025 00:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 424FB61778
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 May 2025 00:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1DOGyo3dvgj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 May 2025 00:33:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A181061775
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A181061775
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A181061775
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 May 2025 00:33:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E0BD960010;
 Fri, 30 May 2025 00:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC2BC4CEE7;
 Fri, 30 May 2025 00:33:12 +0000 (UTC)
Date: Thu, 29 May 2025 17:33:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com,
 milena.olech@intel.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org
Message-ID: <20250529173311.15fcff9b@kernel.org>
In-Reply-To: <20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
 <20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1748565194;
 bh=NQvdTxmbBmPADvv5Bbcr1DYjCqG9xYmrWl2KDuQ7cd4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E+n7t5zfIFrF1CjovLBdfycoxonkpvmWIN0L7aYqj25oaLSpUpaYTviCLiAh2pE/6
 S4h8xcxxOf95sbBmUGh5dJzDId6h3o4t9EalM9eCBCqV7q7nf/Jh+SqJNhUXHoleEc
 L6wmVYboycw+cVdrv94ihOoltdFrMRaMSoEiA7CXZ2Ydsnu2+ARz4eSIs7aRs1jvVP
 OD4ndEQ3ryL/7KldvqM3YFgyvFbZpmvEuRHRXDULSm8gdPI7igggoLKyCObYmylMaa
 CryyCHOL1DdOUdU0GZmWjkniRReeDHu3cMn7KszmDGwxF1JVZc6Cxtbb6NV9wbhy3d
 hzLAAfCVfMwbw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=E+n7t5zf
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/3] dpll: add
 phase-offset-monitor feature to netlink spec
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

On Fri, 23 May 2025 17:42:22 +0200 Arkadiusz Kubalewski wrote:
> +Phase offset measurement is typically performed against the current active
> +source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> +the capability to monitor phase offsets across all available inputs.
> +The attribute and current feature state shall be included in the response
> +message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> +In such cases, users can also control the feature using the
> +``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> +values for the attribute.

Since we're waiting for the merge window to be over - could you mention
the attribute the PHASE_OFFSET comes out as? DPLL_A_PIN_PHASE_OFFSET ?

BTW I noticed that in the YAML spec, in a comment we say
DPLL_A_PHASE_OFFSET a couple of times, missing the _PIN.
