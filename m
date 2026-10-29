Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aXIUJPdn;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fv/TOMoQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38B1B40780;
	Thu, 29 Oct 2026 14:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YNDt52dFhZKV; Thu, 29 Oct 2026 14:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9478D40523
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793285031;
	b=EpYGQPJo/uCp0M6K3v5D7hK17Qw5gBjGXEZW47kPTpxa49b5oYIRJtacoKRxi2kDyGJQ
	 2U4HrmUc1LhZmZ6DvufGVe5Sh7K3KUFmQy7FhikuTHlFpNeeMKpf98tHpvipaugECoh9s
	 SDB9JBNLfPKJl1WCCd6E9yMg550CgK1hQFSCykNPo/7pzm6YhGfsSNRd0dy2CAZwh2iMi
	 8IydiDbP4jj6Fm9NAqh6oRMpC4kfh8JgQXHW64uMKNAPAas/zU6L/o30RxK48w/yWYamq
	 J241Wv2UgLJhKpMOVDbvEVGk1adNq8eRD/I/M8Y+mogP1ttqNIxnDOKdXEgZ/3j9jAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793285031;
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
	bh=vZVQ08PEe0mNSO6/4Jc1Cu/6t8BKZ3UH7zw5d17+udQ=;
	b=BllXasadwT/BKkW/9QuAbmYqwLcJmqmq0YkWmVlJnzYVWakhBuzXNfmf2pTKl42EhbNn
	 r+88j5Choijck6mV1cfZ1IeV6N5siuKL4QsV3CcYoltNYg4vKbVOPBL7dRZJ9VX5QYxiQ
	 VtQ+ljeKI5GxENvlvO8d7ddcMgowBgzkWq0yrDyh6BCA2n7BKYU6Y4eY4BEpRO/F2WQnR
	 UHRJItq76dArg99D60QixzEK2jhkP4djkysfQc42vKx1c9EQtXjszGY+wsmsHoZfXQxn8
	 7J3Lu0SI3iyK75KQcVmabNsuJnoMikg0fhZyIb0kT2OorJCn4Yfwf0vOS+gAq2+eDUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793285031;
	bh=vZVQ08PEe0mNSO6/4Jc1Cu/6t8BKZ3UH7zw5d17+udQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXIUJPdnvW8eNfKyLniLUtInvhLcPhe6D/CJ6dycHFG8AUGI0pjuRKPLTYy80ukvQ
	 ohLrU5k25IAyRrLDv0kwmliDusCnGK5rLZJfx+8f1m0IJyYS0SEFwjK1geI2e/RTCH
	 RI0c8rSR7W8+ZSoKQ2ZVlpC0/u6j9i41QMtEiBMM5nN6JZlCGyBrRM+czX9ZyFAIbz
	 4Gkw1pPHZLNDfC6vVySqn1v11wcxmcLKEdkw5aMD7dBz0ZnhkadtOpYKqze8gYBzo8
	 UexXYM2w+sUsifB4J0cftXVoZ87CwTo/WZJkTB5V+1eSwytt3KMdY84t/Vbszho/DN
	 MMg0LmlZTrVtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9478D40523;
	Thu, 29 Oct 2026 14:43:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D1572FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED5A606C6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSCzIxExSek6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 14:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A4D9606E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793285029;
 b=duIYcXwxItGaZtl6TdqLNzYsliX57KqksD1NqRf5A3zTa5NGHG3f1PUsFxtB0tEcILpN
 CEyh4+Gg8z5a4KVeFF8mlfMdHbIDHNE9C8C+o+5jKfSxNsl9VTU92kIQYwNtZT/Mcbhim
 hNRSM9+kyQT/iiExkkuviQT8mYg+ya9+6wrG205BsVFfSXgjdaZGUhGMRgI1KKIJDKQgo
 ulTkQTxxjChXSdBRuhzl32n7IvjFaWDRxlx+3xZoXoZfvVsW2rlVuO2pRDHgwGYd+MZyw
 HDrec9k5iI6t16V+Zb3pY9fQZnDIR4o3Rh13K9s4Iqn+sguDaVIV9pDpxhsvbf29jzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793285029;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=vZVQ08PEe0mNSO6/4Jc1Cu/6t8BKZ3UH7zw5d17+udQ=;
 b=JRYxw2r8WULoK8yS9Bu5rDeoHCDpR5fCkL+H0g2roNLgbdDYBPmxyEuLfTVujPemBrj8
 vTzPS0+ddI1R9q0NQf5PXkC3s53fBhPo193Jovax2TBeRq0wrLeh6Frb8Q9wWIv90RD1K
 C3Thv2RJkPcGEsrC33FkM2fr3MNwc2KZk6/TkXb8vBAb8ntA5dAaBCaUmRvHTak5bPApO
 JnmRbev+T1AWtbmrbtjNtjVec9++Uumk1pfoduPGNA81pMui7vNnQcS8ipbQdp4XZ26Aq
 KhLGZrZJBQcztW977dKxkKx4xXpkE2cxfkCSsY6lPeT/nAvrPtSZ8F5dGJfUqubgchg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linux.intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="fv/TOMoQ"; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fv/TOMoQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A4D9606E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793285029; x=1824821029;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=f4wX3a7fY6e+qDCdOUilf/mvnW99yMJXQQJ/TDiRkbQ=;
 b=fv/TOMoQIfyDDorhzThY2+WGUQR/yMMe0ebJaOefH6D6StxlkksMdjVi
 tzrH1NOitecjwj/wZTyXj2uu3lZWp/R9S/u9Wi3OCbLEGWdcx9efxwzRO
 Mbz2LNPV9oPoY6418zM0Y9bINKsDqg31B7xft4oqZ3ijnJ9OMgBmf7ArD
 tRBjm5kjLdX/I9njL3t5Rjtr8MWpUrlet2RPgmQaEkzAR9Tq1MJVAAEfS
 txBJ3EQjXSWIZnMIImOaCpb5L4Z0D3caLjF8cWfWX+UAwIweRCZxNrsve
 ED6PMA08DeGF4eyEfBX38VMICObtwcLSNsWGyN5Q7MHPWUcitKzf5cyoV Q==;
X-CSE-ConnectionGUID: uNhdfOs8TbaGGyNa6PtAJw==
X-CSE-MsgGUID: DmEuYfO1R4mW9/m14tt1lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1923120"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1923120"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:43:48 -0700
X-CSE-ConnectionGUID: ULX5YVIXSr2wRg8dFr0rwA==
X-CSE-MsgGUID: QMSYGGrcTDKq2Q+xTbHdoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5066587"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:43:48 -0700
Received: from [10.102.88.133] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.133])
 by linux.intel.com (Postfix) with ESMTP id 3B24920B8CD1;
 Thu, 29 Oct 2026 07:43:47 -0700 (PDT)
Message-ID: <d8ef0283-7fa0-4e88-9a6d-519ea4922294@linux.intel.com>
Date: Thu, 29 Oct 2026 15:43:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 1/2] ice: parse external Root of Trust
 capability
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
References: <cover.1793119681.git.aleksandr.loktionov@intel.com>
 <7d67f40ea838a9b9e363a26eded23deef8a8ff6c.1793119681.git.aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <7d67f40ea838a9b9e363a26eded23deef8a8ff6c.1793119681.git.aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 27.10.2026 18:45, Aleksandr Loktionov wrote:
> Reserve the external PQC Root of Trust capability ID in the shared libie
> capability list and parse its value into the device capabilities.
> 
> Firmware reports 1 when an external Root of Trust (eRoT) controller is
> present and 0 when it is not. Keep a separate bit for an explicit value
> other than 0 or 1, so the flash path can reject an unknown answer
> instead of reading it as absence: an image the eRoT turns down leaves an
> erased flash bank behind, so guessing is worse than not flashing. Set
> both bits with |=, so a duplicated capability entry cannot undo a verdict
> already taken from an earlier one: an invalid value always rejects the
> update, and a mix of 0 and 1 keeps the eRoT checks enabled.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 7 +++++++
>  drivers/net/ethernet/intel/ice/ice_type.h   | 3 +++
>  include/linux/net/intel/libie/adminq.h      | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 81187214..cc387c6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2482,6 +2482,13 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
>  	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
>  		caps->tx_sched_topo_comp_mode_en = (number == 1);
>  		break;
> +	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
> +		/* sticky, so a duplicated entry cannot clear an earlier verdict */
> +		caps->external_pqc_rot_present |= (number == 1);
> +		caps->external_pqc_rot_invalid |= (number != 0 && number != 1);
> +		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot = %u\n",
> +			  prefix, number);
> +		break;
>  	default:
>  		/* Not one of the recognized common capabilities */
>  		found = false;
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 4b6ed42..1ff69f7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -311,6 +311,9 @@ struct ice_hw_common_caps {
>  	/* Post update reset restriction */
>  	bool reset_restrict_support;
>  	bool tx_sched_topo_comp_mode_en;
> +	/* External Root of Trust (eRoT) controller present */
> +	bool external_pqc_rot_present;
> +	bool external_pqc_rot_invalid;
>  };
>  
>  /* IEEE 1588 TIME_SYNC specific info */
> diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
> index 839114d..df42f5b 100644
> --- a/include/linux/net/intel/libie/adminq.h
> +++ b/include/linux/net/intel/libie/adminq.h
> @@ -175,6 +175,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
>  #define LIBIE_AQC_CAPS_PENDING_OROM_VER			0x004B
>  #define LIBIE_AQC_CAPS_NET_VER				0x004C
>  #define LIBIE_AQC_CAPS_PENDING_NET_VER			0x004D
> +#define LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT		0x004E
>  #define LIBIE_AQC_CAPS_RDMA				0x0051
>  #define LIBIE_AQC_CAPS_LED				0x0061
>  #define LIBIE_AQC_CAPS_SDP				0x0062


Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

