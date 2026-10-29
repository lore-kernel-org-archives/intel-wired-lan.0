Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF526606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jKsLMSev;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QTzS9EsB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCA5340638;
	Thu, 29 Oct 2026 14:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoWr6x8q00is; Thu, 29 Oct 2026 14:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 679C940523
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793285033;
	b=ZtqhP71QJ9VVYQPgetWMHmWchZUxDNBeEYlT+iYYxTZbAv4JaOX0d/7JWG0fn/gEZSqd
	 GKsipMozbPXxZwTSnouB+hRqAZoy2/0xFoEfjAneLPc3heDFtApvYfPPc6xELfKrHGilb
	 9NMfFipw2v9rn5OzfEowgJq5kGgqCxMwF3QcfYNeODhEKlQ23b+ASC/sa/FvXPW8p4IFn
	 190Lv7Aw4W/ylmQ01cATAl6O247zVOnMG5T+1r2sVkoX+uZfhXkb/WVAvhLaHPmxyOKkj
	 Uacu6XDDwPLhd83O2LJfqYWmtlcBXzT8Jg5/Smq9gpeUbV2bLRk34XdIQH0AkM7kMrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793285033;
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
	bh=SiARdWfU29LECSirbeUbqMC7tV1hAo8aCsTSk1BtKSw=;
	b=ZGcsooH3mtWg+tbR2+/5kkNCp+Qc4Y3yTqg5TtSljcPCTo8daySpgKdHqWqxdVQiRYJP
	 0LOPRkLLuB69Cw2IVBc4QVASvDDMtKrxyWOPYq6IX/t4c+rvGnY9omgtS7UCHgc7ui0mh
	 bLqefRHfIkvlt+fjoJqnTgWmxizkQCnljFyMUedwvlRfTtBz6B1jZyJ83CAM7aD2e8Tw7
	 5E+r1UOPWjvEqQ6QOF/0SAZOfs+5tecQFfwYmOOMv4ei16OvXOU1WTfeFUDBtD9+7DFhA
	 S2mL0hi2G/wlU27iyQixcjvfjUhSYOqH7jur94jXR9WIqEfElbIVdklGkwf9MEZEO5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793285033;
	bh=SiARdWfU29LECSirbeUbqMC7tV1hAo8aCsTSk1BtKSw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jKsLMSev+HYUB8XDcs7Ico1o8R9xYGneXWuuyu73P7cvmnWGslATpt/+PZf7nl0O/
	 DnyZyvQRIjv/ZZLN1zvUNF5L/1IrZ0Rtw5qHL4jAXfs37oG2Z2XKwbHF8AuNiJpsIZ
	 FryHrFRrywgMb1fuMAvxLkVm9RFasQoBfZImhdwifIYmIjJTJVA/gg4JuSiE7tZfKq
	 D5RGAAx7qc6NESD/eN8ereSRPboyf6dmkTaX9utsjLqMHyPUpFVvUoU5751NZHKvIX
	 HQnFG3Y8oCy9YvMMIl1oHW1zuPG+GCtN2djv8hsyOwav1CU2FR6CwmPiOz4cnmhWgq
	 WkSXjIh9S3Aqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 679C940523;
	Thu, 29 Oct 2026 14:43:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D89362
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B3AB606C6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sy7ahAxx6DIj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 14:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D266E606E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793285031;
 b=f4SqkNljK3x+YEeAsM/PiuhsA17TVpMwU/+3sFb1Ho8OUHWubDuwtpHHftCk/8AzrW3k
 jB2X1NQ3zd2igf378deEgw0w0XWFDgcGRM1PRNjB8LozvtVYNHmDGUFCTe0nCnewj6PKs
 /ZtuwT22h8pS+Ywm78ZWSYSaHOV6Dg54uS0Rrs9D2Ws37CuHds/ke9ZgFOgPpdrC/RRqn
 zQvVeA6JBfVwXAYG1yX4I7k+J+CIUQ5tBDy4seak5gjRRMSuKNnZSRhiE8Jcxu3JKoas8
 xmGxIiIY8LswQnMmnjtlBM/hZOiVdFGKZDRCO8jOveq0l9XZBmjDoBBEL6fVu20kHRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793285031;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=SiARdWfU29LECSirbeUbqMC7tV1hAo8aCsTSk1BtKSw=;
 b=T+ZsOABd19VO6l47U6s060gsdtL0uHipwBZkzg3p8KPJGEzHXTMbZ20lZf+QpldH851t
 mmE6IxptI6CCYQcCZuJQjZrXp1w3/y0Kcz/+r5AZh2KQNPZldLnxY7XXIEcwZjmAcGRo7
 EiXMDmynWLn0wjLD+UtfFQp7zej1jiavYaqSOH5XNOqVvshfhdzU4UDWaUyIDBxdImofh
 H7gbJCIQiAjXFkEO1/EXZ9p5bj+FNnX3Au9pANeMM4jwxwCtClxfwDuI8ebp1MvSmPVkg
 JsmCxtyydKQwri6fyOAJ3e8zAL6Xj6aDs171jBaGW4TPUZQqxgbcIRq3+g7QNrsp1NA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linux.intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QTzS9EsB; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QTzS9EsB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D266E606E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793285030; x=1824821030;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=VGEueJ3NrveHRA/HbQZsJPiJX/CJaUtpIn1tDcZyj+Q=;
 b=QTzS9EsBfFZNfFQbfJJM05w+oBvScEBbXfu7xaodrnkq29IxeQy0NMKL
 ZV27FHy/w0Ex3ASiqLa4pBKZ9QlxXIzIprEkpYsMwAlBH38xop0/mrCCC
 F5e1tRLBORZ3t+rJktLVkbPuILkGC/1SUDrEROAAL40CaxyRH1tW24lLU
 1UBIDeoWkQLCp8nH94gFa9vvsmZBG/TEwF4NvD0F1jwVdbnRmpHEcVXyX
 7T3nk6Uyu/S4osOp5nppe9OcKMJqd1BMSjepH0BqEQ3n56EHwqbWWNLpg
 X6zKwAfoaju6yEfS926Uck/vlAgsPz3BhuytvXCn8ZILvBntWfHQQsshC Q==;
X-CSE-ConnectionGUID: yON3DZ/uSaCevWy6sBR9/g==
X-CSE-MsgGUID: nIlNd612Q1yCAm6W7KU4Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1923125"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1923125"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:43:50 -0700
X-CSE-ConnectionGUID: 3W/vH78/TSuPr86uwgsucg==
X-CSE-MsgGUID: 2le9jTQuR9KVJnP2QAeO2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5066601"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:43:51 -0700
Received: from [10.102.88.133] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.133])
 by linux.intel.com (Postfix) with ESMTP id A67D020B8CD1;
 Thu, 29 Oct 2026 07:43:49 -0700 (PDT)
Message-ID: <42a39046-32d4-4b93-b182-90843430c12b@linux.intel.com>
Date: Thu, 29 Oct 2026 15:43:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 2/2] ice: reject partial NVM update on eRoT
 adapters
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
References: <cover.1793119681.git.aleksandr.loktionov@intel.com>
 <9fe20320948a496217f4888b8196f64f1cdd3874.1793119681.git.aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <9fe20320948a496217f4888b8196f64f1cdd3874.1793119681.git.aleksandr.loktionov@intel.com>
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
> An eRoT authenticates the complete NVM image, so a PLDM capsule that
> carries only part of the components is not a valid update on such an
> adapter. Report that from the driver: it knows the components an eRoT
> adapter needs, so it can reject the image with a reason in the extended
> ACK before anything is written to the device.
> 
> Reject a repeated component and a component without data while the
> component tables are sent, and require all four components before the
> first bank is erased. Check the component set again before activation,
> because an image whose device record selects no component at all skips
> the flash path and still reaches that step. Reject a single component
> request up front, and accept the Manifest component only when firmware
> reports eRoT presence. Adapters whose firmware does not report eRoT
> keep their current handling.
> 
> Read the device capabilities once per flash attempt and act on that
> snapshot, then reuse it for the pending update check the attempt
> already makes, so an update still costs one List Device Capabilities
> round trip. The cached copy in hw->dev_caps cannot decide this: a
> driver loaded while firmware was already in recovery mode never reads
> it, and a reset re-parses it in place. An explicit capability value
> other than 0 or 1 rejects every update, because an answer the driver
> cannot interpret is not evidence that the image is complete.
> 
> No activation is requested for the Manifest: the AQ activation select
> mask and the pending update capabilities have no Manifest entry, so the
> driver writes the bank and leaves the activation flag zero. It can
> neither activate nor roll back that bank, which is documented along
> with the other eRoT update limits.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      |  24 +++
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 193 +++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  4 files changed, 192 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> index 792e9f8..a8d8cb5 100644
> --- a/Documentation/networking/devlink/ice.rst
> +++ b/Documentation/networking/devlink/ice.rst
> @@ -205,6 +205,30 @@ The ``ice`` driver implements support for flash update using the
>  combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
>  ``fw.netlist`` components.
>  
> +When firmware reports an external Root of Trust (eRoT), the image must
> +also contain the ``fw.pqc_manifest`` component and all four components
> +must be updated together. A single component request is rejected before
> +anything is written to the device. An image that misses one of the four
> +components, repeats one, or carries a component without data is
> +rejected before any flash bank is erased, but by then any previously
> +pending update has already been canceled. The driver queries the device
> +capabilities for every flash attempt, so these restrictions follow what
> +the firmware reports at that moment, including on a driver loaded while
> +the firmware was already in recovery mode. Adapters whose firmware does
> +not report the eRoT capability keep their previous handling, and a
> +``fw.pqc_manifest`` component always requires a reported eRoT
> +capability. A reported eRoT capability value other than 0 or 1 makes
> +every flash update fail with ``-EIO``; update such firmware out of band.
> +
> +These checks reject images the adapter cannot use. They do not
> +authenticate image contents and they do not make the update atomic. The
> +driver cannot activate or roll back the ``fw.pqc_manifest`` component:
> +the AQ activation select mask names only ``fw.mgmt``, ``fw.undi`` and
> +``fw.netlist``, and no pending update capability describes a Manifest.
> +If an update fails after the Manifest bank has been written, the state
> +of that bank is defined by the firmware, not by the driver, and
> +recovering the adapter then needs out-of-band tooling.
> +
>  .. list-table:: List of supported overwrite modes
>     :widths: 5 95
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 848ac58..072cd0b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1748,6 +1748,7 @@ struct ice_aqc_nvm_comp_tbl {
>  #define NVM_COMP_ID_OROM	0x5
>  #define NVM_COMP_ID_NVM		0x6
>  #define NVM_COMP_ID_NETLIST	0x8
> +#define NVM_COMP_ID_MANIFEST	0x12
>  
>  	u8 comp_class_idx;
>  #define FWU_COMP_CLASS_IDX_NOT_USE 0x0
> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> index 3631461..93ddcbe 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> @@ -9,6 +9,15 @@
>  #include "ice_lib.h"
>  #include "ice_fw_update.h"
>  
> +/* Bitmask values for ice_fwu_priv::seen_components */
> +#define ICE_FWU_COMP_NVM		BIT(0)
> +#define ICE_FWU_COMP_OROM		BIT(1)
> +#define ICE_FWU_COMP_NETLIST		BIT(2)
> +#define ICE_FWU_COMP_MANIFEST		BIT(3)
> +/* Components an eRoT adapter requires in a single update */
> +#define ICE_FWU_COMP_ALL_EROT		(ICE_FWU_COMP_NVM | ICE_FWU_COMP_OROM | \
> +					 ICE_FWU_COMP_NETLIST | ICE_FWU_COMP_MANIFEST)
> +
>  struct ice_fwu_priv {
>  	struct pldmfw context;
>  
> @@ -29,6 +38,10 @@ struct ice_fwu_priv {
>  
>  	/* Track if EMP reset is available */
>  	u8 emp_reset_available;
> +
> +	/* Bitmask of components seen in this image (ICE_FWU_COMP_*) */
> +	u8 seen_components;
> +	bool erot_present;
>  };
>  
>  /**
> @@ -108,6 +121,9 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
>  	case NVM_COMP_ID_NETLIST:
>  		component = "fw.netlist";
>  		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		component = "fw.pqc_manifest";
> +		break;
>  	default:
>  		WARN(1, "Unexpected unknown component identifier 0x%02x", id);
>  		return -EINVAL;
> @@ -220,12 +236,26 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>  	struct ice_pf *pf = priv->pf;
>  	struct ice_hw *hw = &pf->hw;
>  	size_t length;
> +	u8 comp_bit;
>  	int status;
>  
>  	switch (component->identifier) {
>  	case NVM_COMP_ID_OROM:
> +		comp_bit = ICE_FWU_COMP_OROM;
> +		break;
>  	case NVM_COMP_ID_NVM:
> +		comp_bit = ICE_FWU_COMP_NVM;
> +		break;
>  	case NVM_COMP_ID_NETLIST:
> +		comp_bit = ICE_FWU_COMP_NETLIST;
> +		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		if (!priv->erot_present) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Manifest component requires an eRoT capable adapter");
> +			return -EOPNOTSUPP;
> +		}
> +		comp_bit = ICE_FWU_COMP_MANIFEST;
>  		break;
>  	default:
>  		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
> @@ -234,6 +264,19 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (priv->erot_present) {
> +		if (priv->seen_components & comp_bit) {
> +			NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
> +			return -EINVAL;
> +		}
> +		/* the PLDM parser accepts a component without any data */
> +		if (!component->component_size) {
> +			NL_SET_ERR_MSG_MOD(extack, "Firmware component carries no data to flash");
> +			return -EINVAL;
> +		}
> +		priv->seen_components |= comp_bit;
> +	}
> +
>  	length = struct_size(comp_tbl, cvs, component->version_len);
>  	comp_tbl = kzalloc(length, GFP_KERNEL);
>  	if (!comp_tbl)
> @@ -623,6 +666,25 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
>  	return 0;
>  }
>  
> +/**
> + * ice_fwu_check_erot - reject an eRoT update that misses a component
> + * @priv: PLDM firmware update private data
> + *
> + * An eRoT authenticates the complete NVM image, so all four components
> + * must be updated together.
> + *
> + * Returns: zero when the update may proceed, -EINVAL otherwise.
> + */
> +static int ice_fwu_check_erot(struct ice_fwu_priv *priv)
> +{
> +	if (!priv->erot_present || priv->seen_components == ICE_FWU_COMP_ALL_EROT)
> +		return 0;
> +
> +	NL_SET_ERR_MSG_MOD(priv->extack,
> +			   "eRoT adapter requires fw.mgmt, fw.undi, fw.netlist and fw.pqc_manifest");
> +	return -EINVAL;
> +}
> +
>  /**
>   * ice_flash_component - Flash a component of the NVM
>   * @context: PLDM fw update structure
> @@ -667,6 +729,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  		reset_level = NULL;
>  		name = "fw.netlist";
>  		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
> +		/* the activation select mask has no bit for the manifest */
> +		flag = 0;
> +		reset_level = NULL;
> +		name = "fw.pqc_manifest";
> +		break;
>  	default:
>  		/* This should not trigger, since we check the id before
>  		 * sending the component table to firmware.
> @@ -676,6 +745,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  		return -EINVAL;
>  	}
>  
> +	/* every component table is sent before the first component is flashed,
> +	 * so all components of the image are already known here
> +	 */
> +	err = ice_fwu_check_erot(priv);
> +	if (err)
> +		return err;
> +
>  	/* Mark this component for activating at the end */
>  	priv->activate_flags |= flag;
>  
> @@ -706,6 +782,11 @@ static int ice_finalize_update(struct pldmfw *context)
>  	struct devlink *devlink;
>  	int err;
>  
> +	/* an image without any applicable component still reaches this point */
> +	err = ice_fwu_check_erot(priv);
> +	if (err)
> +		return err;
> +
>  	/* Finally, notify firmware to activate the written NVM banks */
>  	err = ice_switch_flash_banks(pf, priv->activate_flags,
>  				     &priv->emp_reset_available, extack);
> @@ -843,6 +924,39 @@ static const struct pldmfw_ops ice_fwu_ops_e822 = {
>  	.finalize_update = &ice_finalize_update,
>  };
>  
> +/**
> + * ice_pending_updates_from_caps - Report the pending updates of a caps read
> + * @pf: the PF driver structure
> + * @pending: on return, bitmap of updates pending
> + * @dev_caps: device capabilities holding the pending flags
> + *
> + * Build the bitmap of flash components with an update pending, from an
> + * already read set of device capabilities.
> + */
> +static void
> +ice_pending_updates_from_caps(struct ice_pf *pf, u8 *pending,
> +			      const struct ice_hw_dev_caps *dev_caps)
> +{
> +	struct device *dev = ice_pf_to_dev(pf);
> +
> +	*pending = 0;
> +
> +	if (dev_caps->common_cap.nvm_update_pending_nvm) {
> +		dev_info(dev, "The fw.mgmt flash component has a pending update\n");
> +		*pending |= ICE_AQC_NVM_ACTIV_SEL_NVM;
> +	}
> +
> +	if (dev_caps->common_cap.nvm_update_pending_orom) {
> +		dev_info(dev, "The fw.undi flash component has a pending update\n");
> +		*pending |= ICE_AQC_NVM_ACTIV_SEL_OROM;
> +	}
> +
> +	if (dev_caps->common_cap.nvm_update_pending_netlist) {
> +		dev_info(dev, "The fw.netlist flash component has a pending update\n");
> +		*pending |= ICE_AQC_NVM_ACTIV_SEL_NETLIST;
> +	}
> +}
> +
>  /**
>   * ice_get_pending_updates - Check if the component has a pending update
>   * @pf: the PF driver structure
> @@ -857,7 +971,6 @@ static const struct pldmfw_ops ice_fwu_ops_e822 = {
>  int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>  			    struct netlink_ext_ack *extack)
>  {
> -	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw_dev_caps *dev_caps;
>  	struct ice_hw *hw = &pf->hw;
>  	int err;
> @@ -878,22 +991,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>  		return err;
>  	}
>  
> -	*pending = 0;
> -
> -	if (dev_caps->common_cap.nvm_update_pending_nvm) {
> -		dev_info(dev, "The fw.mgmt flash component has a pending update\n");
> -		*pending |= ICE_AQC_NVM_ACTIV_SEL_NVM;
> -	}
> -
> -	if (dev_caps->common_cap.nvm_update_pending_orom) {
> -		dev_info(dev, "The fw.undi flash component has a pending update\n");
> -		*pending |= ICE_AQC_NVM_ACTIV_SEL_OROM;
> -	}
> -
> -	if (dev_caps->common_cap.nvm_update_pending_netlist) {
> -		dev_info(dev, "The fw.netlist flash component has a pending update\n");
> -		*pending |= ICE_AQC_NVM_ACTIV_SEL_NETLIST;
> -	}
> +	ice_pending_updates_from_caps(pf, pending, dev_caps);
>  
>  	kfree(dev_caps);
>  
> @@ -904,6 +1002,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>   * ice_cancel_pending_update - Cancel any pending update for a component
>   * @pf: the PF driver structure
>   * @component: if not NULL, the name of the component being updated
> + * @dev_caps: device capabilities to read the pending updates from
>   * @extack: Netlink extended ACK structure
>   *
>   * Cancel any pending update for the specified component. If component is
> @@ -913,6 +1012,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>   */
>  static int
>  ice_cancel_pending_update(struct ice_pf *pf, const char *component,
> +			  const struct ice_hw_dev_caps *dev_caps,
>  			  struct netlink_ext_ack *extack)
>  {
>  	struct devlink *devlink = priv_to_devlink(pf);
> @@ -921,9 +1021,7 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
>  	u8 pending;
>  	int err;
>  
> -	err = ice_get_pending_updates(pf, &pending, extack);
> -	if (err)
> -		return err;
> +	ice_pending_updates_from_caps(pf, &pending, dev_caps);
>  
>  	/* If the flash_update request is for a specific component, ignore all
>  	 * of the other components.
> @@ -981,9 +1079,10 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
>   * formatted image that matches this device.
>   *
>   * Extract the device record Package Data and Component Tables and send them
> - * to the firmware. Extract and write the flash data for each of the three
> - * main flash components, "fw.mgmt", "fw.undi", and "fw.netlist". Notify
> - * firmware once the data is written to the inactive banks.
> + * to the firmware. Extract and write the flash data for each of the main
> + * flash components, "fw.mgmt", "fw.undi", and "fw.netlist", plus
> + * "fw.pqc_manifest" on eRoT adapters. Notify firmware once the data is
> + * written to the inactive banks.
>   *
>   * Returns: zero on success or a negative error code on failure.
>   */
> @@ -994,6 +1093,7 @@ int ice_devlink_flash_update(struct devlink *devlink,
>  	struct ice_pf *pf = devlink_priv(devlink);
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
> +	struct ice_hw_dev_caps *dev_caps;
>  	struct ice_fwu_priv priv;
>  	u8 preservation;
>  	int err;
> @@ -1013,18 +1113,52 @@ int ice_devlink_flash_update(struct devlink *devlink,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
> +	dev_caps = kzalloc_obj(*dev_caps);
> +	if (!dev_caps)
> +		return -ENOMEM;
> +
> +	/* Read the most recent device capabilities from firmware. Do not use
> +	 * the cached values in hw->dev_caps: a driver loaded while firmware
> +	 * was already in recovery mode never reads them, and a reset may be
> +	 * rebuilding them while this request runs. The same read serves the
> +	 * pending update check below, so this costs one AQ command per flash
> +	 * attempt, as it did before.
> +	 */
> +	err = ice_discover_dev_caps(hw, dev_caps);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to read device capabilities");
> +		kfree(dev_caps);
> +		return err;
> +	}
> +
> +	if (dev_caps->common_cap.external_pqc_rot_invalid) {
> +		NL_SET_ERR_MSG_MOD(extack, "Invalid eRoT capability reported by firmware");
> +		err = -EIO;
> +		goto free_caps;
> +	}
> +
> +	if (!dev_caps->common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
> -		return -EOPNOTSUPP;
> +		err = -EOPNOTSUPP;
> +		goto free_caps;
>  	}
>  
>  	memset(&priv, 0, sizeof(priv));
> +	priv.erot_present = dev_caps->common_cap.external_pqc_rot_present;
> +
> +	if (params->component && priv.erot_present) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter does not support single component update");
> +		err = -EOPNOTSUPP;
> +		goto free_caps;
> +	}
>  
>  	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
>  		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
>  		priv.context.component_identifier = NVM_COMP_ID_NVM;
>  	} else if (params->component) {
> -		return -EOPNOTSUPP;
> +		err = -EOPNOTSUPP;
> +		goto free_caps;
>  	}
>  
>  	/* the E822 device needs a slightly different ops */
> @@ -1039,7 +1173,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
>  
>  	devlink_flash_update_status_notify(devlink, "Preparing to flash", NULL, 0, 0);
>  
> -	err = ice_cancel_pending_update(pf, NULL, extack);
> +	err = ice_cancel_pending_update(pf, NULL, dev_caps, extack);
> +	kfree(dev_caps);
>  	if (err)
>  		return err;
>  
> @@ -1066,4 +1201,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
>  	ice_release_nvm(hw);
>  
>  	return err;
> +
> +free_caps:
> +	kfree(dev_caps);
> +	return err;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 1ff69f7..0fed29d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -1152,6 +1152,7 @@ struct ice_aq_get_set_rss_lut_params {
>  #define ICE_SR_OROM_BANK_SIZE		0x45
>  #define ICE_SR_NETLIST_BANK_PTR		0x46
>  #define ICE_SR_NETLIST_BANK_SIZE	0x47
> +#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
>  #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
>  
>  /* CSS Header words */

Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

