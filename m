Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FF8CC6B34
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 11:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64A0F810F7;
	Thu, 15 Oct 2026 11:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWQPbA1WCu5h; Thu, 15 Oct 2026 11:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8789810FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792065481;
	b=XKUvqBYLKLcicZG4d1yoTWUqMBc/PqCRv5Tkox4FTCKZ1uXSx2uofMwaLFvTBVkg5Amh
	 ZV4FcHR22jISUrcUNAQt1Kw+QcziVNziQQMdJoP1C9XkSLMhWALtmDu3LlUhN1nvHbl1P
	 5BjOA68XuGTosCVesPc7FqHngdz/4/4rIjErrtYdzRsrkOkvZLNvX0IOfZXh8y/PhEbeT
	 jMZlIntvQnHc1AmyO6N6FtJ2vxhAWsQSZZbyR3p+fXChHKcym1jdssWqr80DgT7z2zFre
	 5GisWh/CdEGb8dP6KlM3b7uPOUPlhZ1lTb1DnerKuvrlfDhi0kARaocGMJQtf4c++oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792065481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=REXGDKP1Sfs7bEQY2ePHRfjQXRApmaak6ypxYmk68W4=;
	b=mpNQqvyx3mDRyNsp/Gzkka0G9YqlNsF0q0IaOA8Q4VpwknH3kBzyi5eORVWS+wdmlYFn
	 /WPHbJV7PxW1SKo9QTf0BWNjAgWqlo8Cq9ZmXsZskOj5Is/cgYFjEwVocfb9VW3dbIrJ7
	 VtQWtKVZDyX+kwazs9t5h+EyhmyizXUMG9NQLjiISmq4gcLjmtwQY2iTyl0/uh+Hnjmgp
	 JLBO26ue1ClXoR2t0zuQBzwz6N2t4efzbHNm0zKem1d3nZEwtHLAu72l6VGcRIpJDhOTn
	 Fh1GJdEdc2r/sfe3hvATapqCAnxZfk/NmU6dHSoHyLcINmeoHUqNGerN8NeDNeG5aeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FlSc9tv9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792065481;
	bh=REXGDKP1Sfs7bEQY2ePHRfjQXRApmaak6ypxYmk68W4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ojNKmCPnBZduROA6dPp3M8vK73KayozkyZXHKK/HLS9Fc6WNyzpgykhySHj/9P9gs
	 T2cPQpdOFuQGz28Wzz0Es+aIZj4ktjVmEIN45F1H8BAEtupr+ZYOCaXQVY4vVrHFwa
	 PyT4s9BAfLGKHkRBFUxxmW7uCLPf0uu7DaYeMZMatVcsNN/T2cbJDNqXq1/ccNOgvL
	 vDsutddaiMDk3ZGu0XM/oNR88YJ7SEkKMt8x6wCMudYMSfqfBXcOVJWhLP/sn9h7aI
	 GA2ZeFZxKJQFuDjVH/fcw1ojyvN3npDET6S5txPX/D+/qSNCa5Gmu6n0t+DydQYykX
	 4c8NLSF4CEtgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8789810FB;
	Thu, 15 Oct 2026 11:58:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAB7849D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC8EF810FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DshDD3tnue7K for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 11:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B48B4810F7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792065479;
 b=B2+R8XsOp8XGmLScwRcgnVKMHwsleXvOkgBOT6NpoD0TJHTWbcKmyoCLORYZVUspux6U
 nPgHK0n0wGdcNJvUkl2qEVjR3CtjJnHD45V9kNsUOXtxMg1pnQyw+Yx0mnjCn9/esq16g
 PK6WFOMs9daxfRTSxDjDCH0LY7VLOQqRXVym0GtvKEZStLV2GwQc6Kpj02vR7DCeozNr0
 8LWEEmEOQGIaEG2jj0SFDX1GE6Ak434gid3RvSrHBkCzQz1Am0lxaFeOcNF1hq5d2+Bta
 fzo2o8WkbuJyolUxU94SYx7Ccm2LpuHIJgMQLT5JMKVwq0pYdfwbQRO8JECxmVw4Erg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792065479;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=REXGDKP1Sfs7bEQY2ePHRfjQXRApmaak6ypxYmk68W4=;
 b=pCkV5yzY778s0Hm4sKnYZHduFOPAa7/maiYwSSWTZDrOwQMdr1sb392x8nBs+oX+KXfQ
 3LnzzqjEEbOwigo7jfXOMh4/7wL7op84ZqKfOUuu1TNSpD5GRVM0ULLCqdhptYdzA+qHE
 N5IotBZWMnCf0pOXi/vAbn6T7pU3IJ7XrQVa4H9w1ia8E6c02i35DaJmksQ7XlO1w95S3
 I3nBbjDBQ1MCWMu4dyPeNqurQDKEGcbZ0BIdduTnNkeC7uuIW8h+TcQyFefiVzVaXqZB+
 01hFYejaj9ktJZIJLpgumcFhhd/mVCVRuXlEceV/BntDJurWiPHdWLklSbI3NOz72GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linux.intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FlSc9tv9; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FlSc9tv9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B48B4810F7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792065479; x=1823601479;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=8v6mVyPC0n/PQUIsKO0pM8Qxy9UU+5Io8SybcG4u3Sg=;
 b=FlSc9tv9eELnhpr2hAG6FwShp6v0zOEUsUW54JWxosSuOy853AFYhB12
 gmUBKzfZoJYHltbFeaAXkti1lCe8Ex/XI1wlFcF1i7GHj4nr8cZL0H4Te
 QSS8LkKrk9KaWJVvpIDAwnTyw0qcF50aWBRM1GNwLLL+R+nGLlJ3rhtxw
 ChUOW2j17x0Ha0YRt+G2KDIQrFm3Cjb0qmq8v3QDJ5lzlDfK+EaBOpuTI
 E6nFZ5fybIaTV6LfjyCX4DNiN+tkoW/Ze8KBpLTJ87R5CuGG6sOcoi4Kq
 /aLhjnLoibhH4OKys38IgAPK+ISK1U8tKTawyupyZXOMXNZ0UDjUbUq2r w==;
X-CSE-ConnectionGUID: 1vRlVhE8QAG8sByuLg8uLA==
X-CSE-MsgGUID: l8FBXxHzTh2Hf/0RVyuYag==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="844005"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="844005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:57:57 -0700
X-CSE-ConnectionGUID: urYKVG98SaiVPmUTpvR+fw==
X-CSE-MsgGUID: BZKX2UMITtami9psvUl/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1642883"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:57:56 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id A9ECF20B5708;
 Thu, 15 Oct 2026 04:57:55 -0700 (PDT)
Message-ID: <c144182e-ed4b-4c0e-bf9f-ab750d3c9ea1@linux.intel.com>
Date: Thu, 15 Oct 2026 13:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/2] ice: parse external Root of Trust
 capability
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
 <20261008141418.958066-2-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20261008141418.958066-2-aleksandr.loktionov@intel.com>
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



On 8.10.2026 16:14, Aleksandr Loktionov wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 6bde8f5..f1262d9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2484,6 +2484,12 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
>  	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
>  		caps->tx_sched_topo_comp_mode_en = (number == 1);
>  		break;
> +	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
> +		caps->external_pqc_rot_present = (number == 1);
> +		caps->external_pqc_rot_invalid = (number != 0 && number != 1);

Nit: plain assignment, not sticky - if firmware ever emitted this capability entry twice in one response, a later valid value would silently clear a prior "invalid" verdict. Consider |= if "fail closed" is meant to be strict.

> +		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot = %u\n",
> +			  prefix, number);
> +		break;
>  	default:
>  		/* Not one of the recognized common capabilities */
>  		found = false;

Thanks,
Tomasz

