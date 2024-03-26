Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9CC6FD1F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Mar 2024 11:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0ED560820;
	Tue, 26 Mar 2024 11:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pX6qCBt7cLOP; Tue, 26 Mar 2024 11:20:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D92C60AAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711452018;
	bh=mkzQtD+/6fFGHG6nBoNsQSZGyplaVcbH+RbFHATZfME=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DrWE/6jUXJcfSymGC0sj8djfiO1sWGwy2vtT4Pi/lixhCvvCCtMoNCFeK5ps7kkc8
	 X58ILU8xuUcwUxQoZpCpgcPJrPzCeqmN7QG8c3dhhsmqQdIrnDy1RPNAyIQi7Aerj5
	 QS/QE1kvJwT+Xd78QXawDWOX+FCEIDdBA0HCDYOU7r190ZRhKygp87NxkfAtkZxh+l
	 uv/ypEqyMlBZl8mltArWkljeN2kjiTJC3J1ACm2mnxW4W3G0y4kK4eLSzoCHvsL11V
	 h3BdfWO4RPvD6v8IqMDm2Je+CIw1HdjLxdxTYLWBbtepdvqnTEAVGdkuPs5C+qAoSn
	 MaIPJtHhWHcvg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D92C60AAF;
	Tue, 26 Mar 2024 11:20:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DB9F71BF45A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 11:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7C0E60AAF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 11:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7eQbGZwg_tSg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Mar 2024 11:20:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2001960820
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2001960820
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2001960820
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Mar 2024 11:20:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E689A60DBA;
 Tue, 26 Mar 2024 11:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B73C43394;
 Tue, 26 Mar 2024 11:20:13 +0000 (UTC)
Date: Tue, 26 Mar 2024 11:20:11 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240326112011.GK403975@kernel.org>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
 <20240325213433.829161-3-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325213433.829161-3-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1711452014;
 bh=01/BEHa9F9gCUEBCWWK/wR+sQ3S7GO2TUEPteNvdMbQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bjq6Mgypitwq+GXodBGgYQK4M7Do7yHs+qtmL5GyiS2EBEJKv4gQjCaIihUF4fKuB
 3/FVhIC2qsNQlsQ7fuX58Gdk1VaKcIVwW0w1bvPsAv51O2Be2wdwtvTD7XkHs/pPdR
 qVyPWOdDaodH/KzRurkAPgAOzrhNlJZZCvMxeiNT81Vio4iCh6LXb34mS8mGGZ2DqJ
 nUO27lW0j3brcFJnN7I5M7TYUcTW4hRzuvmPRla2a56hfrA+6NJ8htrIMJdAAs2CY9
 pjlJGtNmhHYDCBKRgCXV45SdEijEpDTcez6WJDz8nSl2dyhfuZj+lEBG75hUHZUF3S
 RgpQGvL32SM3g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Bjq6Mgyp
Subject: Re: [Intel-wired-lan] [iwl-next v1 2/3] ice: move devlink port code
 to a separate file
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
Cc: Piotr Raczynski <piotr.raczynski@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Wojciech Drewek <wojciech.drewek@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Mar 25, 2024 at 10:34:32PM +0100, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Keep devlink related code in a separate file. More devlink port code and
> handlers will be added here for other port operations.
> 
> Remove no longer needed include of our devlink.h in ice_lib.c.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

