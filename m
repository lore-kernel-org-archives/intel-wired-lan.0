Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E96C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 10:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B0CF60B69;
	Tue, 12 Dec 2023 10:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B0CF60B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702375289;
	bh=3/WDLuizY5p3J0RK0fMIXquAU73/24rHRoatge3OEqo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BvvjUl8lcV+TvcWmhn2GivLVADriJ132RQsRgqvE/GhskuvqRNoqpb6H/DyjgQfmD
	 nv5Aoi+ng+86/GcB9t0ygehkawEGyijqNulaZMTdLgiAnlaW1SDMwmy8goTKNGA8Bg
	 zY+ML/9j/BZz3niPDC3fizWHN7hPNaoakYnHnZP7429lnLIK5x6BQUQN7zYLPVnw7i
	 aD5b/k6cn8uQc1GQIdHDP/bit7YKoCnMx1os7Ir8e/Ag/9wy2+7TDzYrL9DJMj3In9
	 Mrd8SPajVE1OMNlw4p2nVlKp75MLpHCMLvLdSkx6ebdyg9nHRK7uZsWa/MHFDyBiMK
	 aqP+GXRAqCw/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLcxBvggEXKh; Tue, 12 Dec 2023 10:01:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B1CA60E13;
	Tue, 12 Dec 2023 10:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B1CA60E13
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7A3C01BF383
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5273940267
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5273940267
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05IGHuJdW5k8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 10:01:25 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9132D40266
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9132D40266
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1FC79B81142;
 Tue, 12 Dec 2023 10:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36339C433C7;
 Tue, 12 Dec 2023 10:01:21 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:01:18 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20231212100118.GU5817@kernel.org>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-2-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231206192919.3826128-2-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702375282;
 bh=xB0XC5NParDMdJCBHxBgpR5zJlLTnRVrgWYfP+1E7KU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cGN8bY1XZ6SbddqG1hJFxctwloZFsJVbK6lryQAJ47Vigg6gHAO56IU4BMvda6oWb
 RZ2j1q460uQAU7UJoV1CphJGj7vt18qwKUbwhbYqj9AinHss3RRxSbldr6jH0vD5xA
 3EWjBejReIIVca5wE5XSN5eSi/Bcw9xJ/F9xO7KQNfxPuOH5TRu9IHiBeAZVjJk/B7
 FCc2RSk0eXbR1QDkHocTQGODHaUGGodxAJsTs7Fsm0V7BEW7i2EIapuyYt5MGNwNEH
 Wlh+EMkGJkULbpz7nvjXN67ViGO+hCWG3FWdH31szRByEeGfGC7JDrdqs4zaVL/Fvo
 bjJjvkgUNVD4g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cGN8bY1X
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: introduce new
 E825C devices family
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Michal Michalik <michal.michalik@intel.com>, Jan Glaza <jan.glaza@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Dec 06, 2023 at 08:29:17PM +0100, Grzegorz Nitka wrote:
> Introduce new Intel Ethernet E825C family devices.
> Add new PCI device IDs which are going to be supported by the
> driver:
> - 579C: Intel(R) Ethernet Connection E825-C for backplane
> - 579D: Intel(R) Ethernet Connection E825-C for QSFP
> - 579E: Intel(R) Ethernet Connection E825-C for SFP
> - 579F: Intel(R) Ethernet Connection E825-C for SGMII
> 
> Add helper function ice_is_e825c() to verify if the running device
> belongs to E825C family.
> 
> Co-developed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
