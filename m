Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88615E70714
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Sep 2023 11:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2101C83BD5;
	Thu, 21 Sep 2023 11:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2101C83BD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695294563;
	bh=GwfrzqgttNPIWoX2cWx1vgQTbPOlBQrzM4Pl309/q8E=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=H7N1RyfqYCOZ2seWdXSbCW4qOrSj0KigR7ZBsyp684fqjZ0UNloUXWGy0D6OuVvls
	 qUjdccQqbdWx3KSpZK9/nJrFnEtkF/dZwqzRwLhxxl+c3S+10AsZt/o8Pbs0lkbJif
	 QphLh84Cvy6v5AAPXk+pqHQKG0kf3Ju6jjMweiP1F7HVZSZQvQ6T57GnB5PdaUXoLP
	 Ye7BJhMiMVi9KRYdVBlVc4hLZT/eSRS6XF5FjNlFFrKn09Ysyg1sn2CAx6PpC4szmi
	 wrUecEiBA9sXcHIBl1/oEQDCDf0kC5CaU/zC9fZjc8Rtn+cb6l2tVd/L5gFfCYB47s
	 t4Slwb+vkeDPQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCTpBeuaSwR1; Thu, 21 Sep 2023 11:09:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39ABA83BE0;
	Thu, 21 Sep 2023 11:09:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39ABA83BE0
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 0B7A31BF3C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 11:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7BE260B50
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 11:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7BE260B50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SHP7qOVcw1B for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Sep 2023 11:09:19 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93C8C607D6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Sep 2023 11:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93C8C607D6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6B16E61E79;
 Thu, 21 Sep 2023 11:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E967DC4AF6F;
 Thu, 21 Sep 2023 11:09:14 +0000 (UTC)
Date: Thu, 21 Sep 2023 12:09:11 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20230921110911.GJ224399@kernel.org>
References: <20230912115626.105828-1-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912115626.105828-1-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1695294557;
 bh=2kCSV6P6YfeKSmCvyz6qPCQfpRAvSYHPQsHOVANhBmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W76eLcPAw4H/BBi1wsSNGxZjZFUI3sArOoZWHS+54hEC0lrQ0mn+HZUhhD8bddLl3
 vzsdCSFXS0E3diGzNDIUcTsOcTDN4aR1RccVZZEDtJepz0vIXJVtjHzC0qSaRmCuvJ
 NTIlJoXiIHSrs42tUlRzfiZGrW3Xk6Z164Vfsjt6HV0rP9096saieHSLRW8IMmTEqq
 X+GgsgNB2o3Owq4bRZzrYLaLfvnKNkcbaEiedgx4M7gYJkCdYWiIyIxzoUPbz9uwqH
 UE/0/hy5KPo5ry9BXXh+GLc58TUBkRUy/xECrNjb4XqwWJoQwbR1RinkJOD18trAUk
 njLkZPgI38MCQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=W76eLcPA
Subject: Re: [Intel-wired-lan] [PATCH] [PATCH iwl-next v2] ice: store VF's
 pci_dev ptr in ice_vf
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
Cc: leon@kernel.org, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Sep 12, 2023 at 07:56:26AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Extend struct ice_vf by vfdev.
> Calculation of vfdev falls more nicely into ice_create_vf_entries().
> 
> Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
