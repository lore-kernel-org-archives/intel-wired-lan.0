Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B716C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECED040689;
	Thu, 17 Sep 2026 09:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LL43nVUiFLN0; Thu, 17 Sep 2026 09:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45CCF406A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789636938;
	b=O58saSkXIebpRzSXcBYlcpVtn7b+SJ+9k+I3Slymc5NKVCsVRHpp4LsYheVg1EqHenH1
	 FNON3spnHncxAB5YTB8GSoVsqYRC3a5uS3az4wTScwGvC3P3jmAxAS5zi6mgVDbR98zyj
	 jdxevT/RfrKhGb8g629uTeZJjjm2RVllO46zWr3T9pWpiWTLenHaovoGRf9+gmAmoIbro
	 jgOotGADqWW8MUKSZw/tyNErh7vr85jHygiDhThF1pAnCz+fe+xzNbcPTrjW5gg5Tljaf
	 czzqYXzar9DC0P8EOf3jNbMtDyzxd+JCVKYHp5nlci6TdF7gnkQ5d2zFij9VGJHusFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789636938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ALAV4SdzUXXFkvvyzjadDA5nRComQGypPbAV7K44zS4=;
	b=SgTEc9Fv2PedsJbDOMN4JaVyFuOGDxsTu/yrGj2pXRu2ywn3ME/KBF0MsYg5QTLfT6DH
	 uPP9EnVTczAi4SEaVXGEqdsbENjhKUE+3YW6SK2aT7EYePhUy10Ydo6HCqS51iiwAkqzv
	 I//ISiICY9ib9dCfXg5CMgidJxEwqK6DWaCgXfIgogfZ9Cjse/6hR2Cq3HbNDwV+htZTD
	 qlgJk1QLZQYpH1+CcUGNHVRLWsQbk4ubRvQtXlfGL+bFNfFglOLWY/2tDR0zDEZwXAgpk
	 IOywryi0aGxGhoDB52oWy62R26rGdBRnI8V9TLpE2P9kvTYqmyQhhngTm3xF+fyPqVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789636938;
	bh=ALAV4SdzUXXFkvvyzjadDA5nRComQGypPbAV7K44zS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1zauK8Q6zAMWppSgjocXSkiOZkDDP/Kfss5gulzwZ5VfD9G56mcAqdSHrEd48nM5h
	 vZ9z4DXgdqFvzZLoNA6p8BcccH0NA3gWQTCaHmtdZrZfMbupmPZrzMlS4cwZjua8R9
	 gVLtB5HVByXBPdFJ4g7IC8fjWyCDa1gvhal0I+5DaqeP/ZCNKyS7YGaQBLX+5yv1vQ
	 Ryt/CXsHoXTeCDKRUK1PdtWjJJ1TNFDJEckkUk8CVLHB491kj/RNYHSONnJHQkEeYS
	 pGTEbb3lkpHYSJRilnalJM106oVD8DruIJsMovJDiLCFmevvLnxmC4x7JABkUMy7We
	 oi2SAuLP0P+5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45CCF406A7;
	Thu, 17 Sep 2026 09:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FEFE422
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31E7A401F2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:22:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMos6jnQFjDJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:22:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D3A1D400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789636935;
 b=HKlSGARUAZQcpC8TDjISjxMssilg85CviTb3mrnH+Y2PJmT8pHMp1RWcZ/HAyMyPa77n
 m7bG5CaT70/zWMZBIxRnTF0hW+5rc69aiYzjtlkAwDHbbdQh1J2juG2Sh0G/uOofWVIis
 dCzui41MW9LjBQJRJ+LIW0xcAqumuNzWl4gKTNKigG5lttti9k+vIxo9VM0lIi0YqEdSg
 qXKWRHx+JM5YqlWq+8gUiLF28XT8WpBwJUCgYCthxmT9QKAnLZzAHzxOqby+GqaeLv2vi
 nROu5h4Pe/aGtTN4N54WCcE/5Wm/AVdr/Mks5qLOmiWaccXT73iYeHnnjN7y70/gHPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789636935;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ALAV4SdzUXXFkvvyzjadDA5nRComQGypPbAV7K44zS4=;
 b=COEeDHPTXXIGpaU97J8FBJBIufvRLZ9aUnvo3RKQkHxMjrTXBlUsYgtpNYcVoCakDagj
 hLzsx/q5VgghNkviiwggUelhY7Es+P7qIqzwbRTP/TCFGU1wME98zvqjrFbGsk5M8Pnxe
 0YnWLoJrk8uh3uun33/WZqnLaGE799TDk1eNWpcZyivc16DlHhOmWtsaWEp92qPmeh84w
 imZApzzRND+HwSOppK0QmU9uYPeK2vP+0CuCRVahsQZmdTjBACMAXiwvQRYMh/H80sk8f
 VBHUR1JPZzAxJfp8woKLKpHoA/PO4ltzuFY47OqDqjXMDM1f+2cpU4MkU7iWlSvm39w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WHlBzGb7; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WHlBzGb7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3A1D400F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789636935; x=1821172935;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XizrKC03PF6PblcGiGCjeGlG2cS3W1oVronU2P/cWf4=;
 b=WHlBzGb78QJvGOVPlVWPRg7Q61dbPcB/d7PnUKR2+NrYIhRYiymLAbud
 KGpufMkV3dEO/sFZ7k5WM/qMwbGEXudpgmnBhSslRhvf/29OPW87q6Nnf
 0h3pVy2Loa+sfEcfY7uexhYyVohf1CbwBKY2g2u6lrdnJc8NkaNS/surA
 KiQba3NC2pG1nZuwTNDUPoX55OEf8fDiEPOX5n8uLHq7bhQ4ItSbUAuhr
 mXZPAY5sJQ6UHNoYvtVo4C8uaEIatUdcboQrIqpxjZmVLF6NHrFrtpSAk
 xeMcD2JmoUTZDpRACVwhMt1XEPnD1iP8ct1uqpcbcxtIEtm4mj6u9TQ60 g==;
X-CSE-ConnectionGUID: WZpRNr4hTcyYSZNd0wIiQg==
X-CSE-MsgGUID: KEDsgMo3T56uB3V8fOZGzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92549913"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92549913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:22:14 -0700
X-CSE-ConnectionGUID: zIvLWTLTRlWGA3o8oVBj0A==
X-CSE-MsgGUID: tUC/x3aLRY+kYzd5R0F8aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="267451472"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:22:14 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 86CA020B5708;
 Thu, 17 Sep 2026 02:22:12 -0700 (PDT)
Message-ID: <7df5cf3e-b4f7-407f-8da4-c0abdc7752ce@linux.intel.com>
Date: Thu, 17 Sep 2026 11:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 15.09.2026 14:55, Aleksandr Loktionov wrote:

> +static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
> +{
> +	u8 an_info = p->phy.link_info.an_info;
> +
> +	if (an_info & ICE_AQ_AN_COMPLETED)
> +		return true;
> +	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
> +	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> +	       !(an_info & ICE_AQ_LP_AN_ABILITY);

When link is down and AN hasn't completed, this still silently no-ops the disable request (unchanged from before). Worth confirming that's the intended UX, or returning -EINVAL here too.

> +}
> +
>  /**
>   * ice_setup_autoneg
>   * @p: port info
> @@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
>  			}
>  		}
>  	} else {
> -		/* If autoneg is currently enabled */
> -		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
> +		/* If autoneg completed or link partner does not support AN */
> +		if (ice_autoneg_disable_allowed(p)) {
>  			/* If autoneg is supported 10GBASE_T is the only PHY
>  			 * that can disable it, so otherwise return error
>  			 */

Thanks,
Tomasz
