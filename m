Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F70C88E5C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B535340712;
	Wed, 16 Sep 2026 14:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9DYpC5mIAmZ; Wed, 16 Sep 2026 14:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D6C4E4054F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789567422;
	b=axL3xA+vD1Y5O5tAEv1SrVe5tLZAgnUm89/Y11ChMPb4CybyRXKawaNp6QJos/C4YZOo
	 hZROO426o83aUfmT0hNkL8uaBmWm26Miv9HtFah0CBwV6381jTgyWIfocN2v3EjL5QgVk
	 58FF2fp44bctZI2PZRWzL7HV0NQwsX4Jyhr2jDP6MWZe6kLosjQvHpEEfDJRdt5xkQjfc
	 +/ok3h+IhdMsQXWrwlAmWadaqhehZeiKaKMcwtuPPsGH6j6J5hcWrEkbIYeNU4cth3TiJ
	 LxM6lDNEpip3DoXuIl+6lHei3v/yH7jszBJiJrit0MggGAumTL02xwcvjWZCyPlAq7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789567422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RTklNyDdELG8FVUaFwZXb9SLYWWCJlJMJdzl9fP7xeo=;
	b=M2Y8CaBzG/aei+Q0Yl/ATAZsMs9pLrgm31VNhoMaSfji1Dz/YI8Xqee8RPIjwVD7WUMr
	 VbOIOi6W9xs5pzkm74TmrZvaeKsH8VbNiNZ+U14RW1TOYo187XzBsbmUTFMPWTCPtd2Nh
	 IAnfqv3XvVb17yw4M3fIlSEH/Itu2Qn4MwpBoLVwyDatdwdqkt7miipb1iYXvHjLkgBzY
	 lxp6jtpZL2sxCGFBAf1wRfmry4j5BwgLK1bJsldKhhFYZuiJAw4/nllnKYxHlUtlkD0Yh
	 zSyaD+p2U3XUyR4Uw6h2yXkprSXwDyYY9RSiz+0Z1tXLt92IEWIVPPZ4alnt+50csCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789567422;
	bh=RTklNyDdELG8FVUaFwZXb9SLYWWCJlJMJdzl9fP7xeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ApDCLGOTryk1lAJgZfY9TgFRC6lXKXWDagB8KcDg9G9KG1qmoqwmrTNNCT+dewCre
	 q74TUkKzYCxWlDGU6TT7DxxdCciZK7KuKlJHh5LoNgrAS+0VpvevIqBFVJ3ZjWk7gB
	 j4AmsFKmQ6wQqu4Fkk1NvfD/vC+BoqLB3DgpD04Az4fvnTuWs3/hEY7NlCdiOwgt17
	 zFrZYoSvL8gdpIZnjC87zjsT94/h3c3h/EdpUujXxZ9bbH6ESjBIxq95S6qQ2F5sX8
	 TNpc6p5XMBZcTuTEpvU5nGTo1lhocPV/AKfhi/AdQNM/DFsUo1ByRDxpwPJ1kT/MqL
	 ayb9aW3Lh04Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6C4E4054F;
	Wed, 16 Sep 2026 14:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 676C8352
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 463BF40301
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XCYoIntSuDRD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6150B40093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789567420;
 b=s+m9U3/2qyJBHLNHv4MVqtoJLfB2CABNgJwe71kESF30zUw7nwRG+GjlaFjc1H3DEj55
 87c1qMNKW215b/xb3h+DCxZ4wq/L7bn1lsBd0oyAADBJjQOp/x6DtSJxo/ZbIQCDSKY/L
 AbBz3iA73EohW9/J2H9UbV2RSxVxyinquS95Yt6evYMnb97jUv9pzk/bKIkmBoT9ZCWcl
 gZZhpWz67Hd6MXmcESz38wQOsmtR233/rkPM/rJF8X9HS+Ug7e5sgpfHpnGB2n/ybwts3
 7gKT1xCTUeMA6W5+tha3SPR/TM+jGH0hGwWLwgvHkdSuXzHJG1vlvvuXUhFDgb/4qiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789567420;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RTklNyDdELG8FVUaFwZXb9SLYWWCJlJMJdzl9fP7xeo=;
 b=DyqgdEoCVFzpWqh0H2OXCCWpm/kUmPJECNtXW3R9VzXrjFdj4A6GheVXwjhHhjcbYGxD
 NRFbLjC8hXj+D0YJkJhsmYfI6Houxc239WpLNh/LXwsJ4xlHtsGGbTIkUG+bRxfHtZ7yi
 Obbsyoa2gYoa+/KwaA4OQTGHx4h3o7weW9GNiBw6Xsi7BdhMrocbYhJyDHkT0m9Ozad6I
 4qu0xWswiY0LjQGNSmPRINPePeZ8WLm3B2j9PAHeFXl0SPIbA+5QEY2/tkRBMyjC6GLkp
 EtMWiOmVCTz74nP5jixRFaFMuXup/WUCQ6fRuuy8iVGsIQkemTA9fR6DtTOqRe+M60w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OW+dmqcH; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OW+dmqcH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6150B40093
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:03:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 078AA417F0;
 Wed, 16 Sep 2026 14:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F91F00893;
 Wed, 16 Sep 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789567418;
 bh=RTklNyDdELG8FVUaFwZXb9SLYWWCJlJMJdzl9fP7xeo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OW+dmqcHQLmsEkBdECc+bbk+IkuZWniisIeqhZ+g9FgphOgH9kxhmwB5iEvY7mq9o
 FNLqegOEe/PfBNsNytB2zQL78BlgUggnLWDFMU9v6xVqbv/dlp0bmx9fuB0Ey2Gutr
 fy3Ir4vldF/uKJ1fpKG6SVnUgPdaucqJekOK9JZiL1Ir9dbJJYfKVaMEMDMK+LNoTB
 2vVnAYpuhaTJ7Vs/4sIhuCVMgqbb+Fx3NKbeLZlf05N/dZ8agDBQXN5OVoDvu+vrRE
 rlnlYRVOw8kM72iSa3n9ApBB51yevQTgVOnksZfOW0UOFM9WzubgJx09MP0H+LWjJi
 VH/BFhpX5qiAg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com
Subject: Re: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
Date: Wed, 16 Sep 2026 15:03:23 +0100
Message-ID: <20260916140323.243046-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260915125529.3975723-3-aleksandr.loktionov@intel.com?part=3
---
ice: support RDMA on 4+-port E830 devices

This patch updates the ice driver to support RDMA on E830 devices configured
with more than 4 ports. It modifies the port limit check to skip disabling
RDMA capabilities for E830 hardware.

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..d85ae6d1c309a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2510,7 +2510,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
>  		}

[Severity: Medium]
Will this still log an inaccurate warning for E830 devices?

While this patch successfully preserves the RDMA capability for E830 hardware
with more than 4 ports, the code immediately following this block in
ice_recalc_port_limited_caps() remains:

		/* print message only when processing device capabilities
		 * during initialization.
		 */
		if (caps == &hw->dev_caps.common_cap)
			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");

Because hw->dev_caps.num_funcs > 4 is true, will E830 devices incorrectly
trigger this warning during initialization even though RDMA remains enabled?
