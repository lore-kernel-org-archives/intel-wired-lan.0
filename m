Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE37C47DDB
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jan 2024 19:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6651F42158;
	Fri, 26 Jan 2024 19:32:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6651F42158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706297522;
	bh=jEJ8aMPjBWMpqg5C0dRsCMzUhhrn6JUTlvI0tBNqAUo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=72kLeG5dzJ6jYAoGzDKBMprEL3cJ9nq1okVrtZe5hbw2XTT9GEtZUxYMyZcWX4ALZ
	 dpVFfgprR+/oen5WlpaxzWJtDlF89fFcjF2pbr4cku2Yk3n+PyDhsnSA7Gakb9mAol
	 7YqPPM10CzOrNb9rorPITaecBvRf0iSQ+wcDOqm62RaCWhkuLudXQQZjELhXu+AMmM
	 8wVV1DzIa/uHjn/73gq2MlFe6s67JUtfX0hbNhwPIWDICR3c72BmW4Xgnw2hEi2Ckp
	 SGe2AOjM0YSy1UU0siam2wtkjMe8ELt0PQRPqTMSmGOB4vijjeUOAJ2HH70bggKTmv
	 WqV3MZrGT+oMg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8MAA0fpUWqCH; Fri, 26 Jan 2024 19:32:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EE684215A;
	Fri, 26 Jan 2024 19:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EE684215A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 21D121BF2F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 19:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECBD561499
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 19:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECBD561499
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6Zh-8ubRVPE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jan 2024 19:31:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B568E60F21
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 19:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B568E60F21
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9F36D62308;
 Fri, 26 Jan 2024 19:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4FC433F1;
 Fri, 26 Jan 2024 19:31:55 +0000 (UTC)
Date: Fri, 26 Jan 2024 19:31:52 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240126193152.GC401354@kernel.org>
References: <20240125085459.13096-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085459.13096-1-wojciech.drewek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706297517;
 bh=0/gi19UjEgJe4xm59PJQWWgwTm1xGi9jlTcxXelyEr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CeFX1CME2O6T9rk7uTOsI66c0vGvv958hv7NxrVDQBRwFFcmX1ud4nxVb7paO4/ZI
 lTgqLTrTC3JfOmY2NNgQN0RHXFDwKuByEN/zhWq5U7Hjls1BjtqdVGEHLmLO+xIThc
 B5GpEqEBo2n0B0jgACIEmPkyfFksByd7yHfYEsAAM67aM6XhqDNCEN8SAyRoRpQfQj
 bAQH4oFFDiNres/dr6gNfByN9L/VyRuF0u31TfsPKr507BXq+bYhFqWqA/6D2NpL0c
 HrY0juRMXjlF7MA8TselGrtlISgMy/f9x3gtOFeOD8N6WZK+zywf1+YKQHWHAWpQ0T
 uhZwHrnRx2nAQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CeFX1CME
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Remove and readd
 netdev during devlink reload
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
Cc: jiri@resnulli.us, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 paul.m.stillwell.jr@intel.com, przemyslaw.kitszel@intel.com,
 vadim.fedorenko@linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 25, 2024 at 09:54:59AM +0100, Wojciech Drewek wrote:
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
> 
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
> 
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

