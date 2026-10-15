Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0B8CC6B34
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 11:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A78C54086D;
	Thu, 15 Oct 2026 11:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gw5N5uy3kMkj; Thu, 15 Oct 2026 11:58:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9805B40866
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792065488;
	b=ZHE6CRfreUS5IiAtyAzEsy03WJTNQlQpHbde2KGdEklTnOfJHXTy5XED/HGpL5EeHHbF
	 sHcB5fX+kAh9edEA1lgyXPXFnuY38zg8ZawoRs0H+ynTvrZN09EwKcqjuse3oeUMcZyDJ
	 UZNJYcJClnvXVUWirCtrStfmvlsWDC6523sYSa4R76kuJeDtjnZ9y49evkNQTMhvRghkP
	 iK7/dqwqR66vUpmQIVtB0aJZ+367rYee0CzmfbHSAmSGmmca0XWQVb+rTbXe7MzCpkQQy
	 dbZfelWbLkFWTEt7v/uAK2RsAHmU5C/L3vUYWZ0m4Cii+yUt2AJhAQJhijmdwOKZZVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792065488;
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
	bh=toXsa4WlqNglCaWZSFgb97Ds5DeOwv0XyzTuoZ44RVc=;
	b=UhNKAiB+beEVr/2mvpRIebdda/GuirTxYbqSfvWUQ3tk20XQD2ZTcFEcpuK0OHoa7XkW
	 9ksYhG/SVi6G5bMJi7f+GV+L6e53RM/VY5+IgQZD/O9P21hRgiuqGlVROpD0yIuA1qogi
	 /WW4sYctBT+g7Lm1aV4L0h3bfaJ4Vu+CT/no27Q7EpNX3Ax97+qzamkS2LVvu0jDPjmXy
	 8yc1+hw8ucPfGqyLWuNvcyPuBGxEsn4B8xGWZJRkVNnWxoHE58elYh7avVQZ6YrphYGK7
	 I5oXXsC3ueuBVWQ2CJV79QYDvy85Qj7hWDj5zPhRsM+SpqvOp7CpsI8C/3gTvhR90+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792065488;
	bh=toXsa4WlqNglCaWZSFgb97Ds5DeOwv0XyzTuoZ44RVc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kOn40xQiqO0xAFSuM35ZgfBoSPV/cpVsq8WifUP1KrfMy7SE/tOVLbsmxs5EYw6NT
	 RJJsSEe1zci0w8Xx/UIZ1ZEViu2VDw/4peGJbOTWRvlgksWVtMMutLbuRfCngR1bjw
	 Aw+k9MwwqUTLNAidm5Ooy9FaKfs5k/oP8/TaU23R1fLhwEerBmUfowtr0qW1aTpgqo
	 7NalYequxA8gySdgunMfehjsXiH30QRqy/LZoP9q68POhg1M4sKqVPVxeUeB5zwj9L
	 /SmKTemkCO5iwjtawMG068Nl1xoDK7BCS8SzeBDUbJx/g/e7kBAZkPCbFFL6QNQB9H
	 uNlk4dwK3NkLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9805B40866;
	Thu, 15 Oct 2026 11:58:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 035E475
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8DA781124
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTqYePtMA6H8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 11:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA0FB81118
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792065486;
 b=Gv2kKCZYPk1i6itxHLldHf8TtFbMKAqgCsnFXP1As3g6W1SrkPq1KHsQwjAPT7kxONYL
 qf4nzu8iXLyWE2QZjdxAwLpxDDKIqxZuMy6L80zCneIOOpUkNRIFdOJiFqjFyjNEZcjYE
 ECIJ7KXXZCTtkvPcKHl+9mlZjPnazFYsRzFxTfi/5z9uxon2ApekUbfeS6Bi2pjqktEX2
 6TraUQWpVo+gi4SN6J83sVNFyly4opFvKbfH1G3bHGZirqbD4Ll1RlbMYbiB3xO79A9U2
 51FENY6shxcvZTbBLhJCxafTkVNdE8JqXudKpX9t9Q7Y77mt1OPhk0g80OIPOEWoJyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792065486;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=toXsa4WlqNglCaWZSFgb97Ds5DeOwv0XyzTuoZ44RVc=;
 b=pamZs7Fg09S9ZGSDXpcYCxwZjLwn6yRILeFoBQLBdmfD3C7nrv/JWRPIxABNTjmTlGFv
 F/pCX4DsKAFJdvo2LqNH6Odt8d4WFqyR4uW3adx52mOQqVeY+4AC2KGQQgEmL3VoYHk7B
 KzSGmr1dtvG3NhXyvEiWLxDogEHffHZ1j2pJYUuDiNoDf9F72SRlO+w8HVak83zmTJ9Zj
 8mVz8N1SiB3beUjlfUER2Mwu0CSUMw/UZAZs4or5UGDKX1uDFzaCrIzUk5U6VSY5vbRBF
 YKreAyqZg8mcLzFf9dJ+upLaSdndoxtuT+oveLxseIp0agbYiI8gCvv6jEcFIdMlcNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linux.intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S6HT2Rd3; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S6HT2Rd3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA0FB81118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792065486; x=1823601486;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=jQ6mB1w2+Xh0GmqRYdKU3Zdj9ZSHb53A8RoSPhjQ2UI=;
 b=S6HT2Rd3OAyvWCv0+KLz/SNqFCmFf99mqLbjF0mDViRyP5ieApnZ91yj
 dDs5tliD/dLuGMWkkPGM4gxfGdmGouD7S35Bh8OQqwkfICiKbUILLVrRx
 sc/l9/sNnQwWzgWjgKMxsIICCv89K98uYVAeAIUJnrlXiaKbrlJmQHaIR
 RuxgDDRX1a8Q/JZUk8c9/2El9rPkMMHuoseVzItf5BniuN0Ixo1nWWFKc
 7wNngwoKaKKECYlfWQMbjTC6wcBOkAdDyDNc8MFtK4a+/IQ3rkOf1PgDn
 kE3lG8AvjTjaMgO5l9MChQ8h53SsTGTZ7cFvOIFoyiQgYbG9ddWspuPgv w==;
X-CSE-ConnectionGUID: SR3Hcd+BSPyc6NKw+XBXLw==
X-CSE-MsgGUID: jTv9mwbjTLedPGS3TAHMMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="730779"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="730779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:58:04 -0700
X-CSE-ConnectionGUID: wGjC1md7Tkqu3pG9Wu2vSg==
X-CSE-MsgGUID: ADzObizeQs2uXs6IQEPyRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1555931"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:58:03 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 7DB1120B5708;
 Thu, 15 Oct 2026 04:58:02 -0700 (PDT)
Message-ID: <1063bc5a-740f-4580-a091-448fdb62e807@linux.intel.com>
Date: Thu, 15 Oct 2026 13:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/2] ice: reject partial NVM update on eRoT
 adapters
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
 <20261008141418.958066-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20261008141418.958066-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
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



On 8.10.2026 16:14, Aleksandr Loktionov wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> index 3631461..9da7df6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
> @@ -220,12 +232,27 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
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
> +			dev_err(dev, "Manifest component is not supported on adapters without eRoT\n");
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Manifest component is not supported on adapters without eRoT");
> +			return -EOPNOTSUPP;
> +		}
> +		comp_bit = ICE_FWU_COMP_MANIFEST;
>  		break;
>  	default:
>  		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
> @@ -234,6 +261,14 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (priv->erot_present && (priv->seen_components & comp_bit)) {
> +		dev_err(dev, "Duplicate component in PLDM image: component ID 0x%02x\n",

Nit: same dual dev_err()/extack reporting pattern already flagged for the Manifest-without-eRoT case above - please fix both occurrences together.

> +			component->identifier);
> +		NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
> +		return -EOPNOTSUPP;
> +	}
> +	priv->seen_components |= comp_bit;
> +
>  	length = struct_size(comp_tbl, cvs, component->version_len);
>  	comp_tbl = kzalloc(length, GFP_KERNEL);
>  	if (!comp_tbl)
> @@ -648,6 +683,12 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  	u8 flag;
>  	int err;
>  
> +	if (priv->erot_present && priv->seen_components != ICE_FWU_COMP_ALL_EROT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
> +		return -EINVAL;

Nit: duplicate-component rejection uses -EOPNOTSUPP while this (equally malformed-image) case uses -EINVAL. Consider using one consistently.

> +	}
> +
>  	switch (component->identifier) {
>  	case NVM_COMP_ID_OROM:
>  		module = ICE_SR_1ST_OROM_BANK_PTR;
> @@ -667,6 +708,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  		reset_level = NULL;
>  		name = "fw.netlist";
>  		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
> +		/* The AQ activation-select mask has no Manifest bit. */
> +		flag = 0;
> +		reset_level = NULL;
> +		name = "fw.pqc_manifest";

ICE_AQC_NVM_ACTIV_SEL_MASK only covers bits 3-5 (NVM/OROM/NetList), so there's no activation bit for Manifest. ice_get_pending_updates()/ice_cancel_pending_update() also have no notion of a pending Manifest update, so canceling a pending 4-component eRoT update reverts NVM/OROM/NetList but leaves Manifest state undefined. Please confirm the firmware activation contract for Manifest before merging - the cover letter itself says this is unconfirmed and not hardware-validated.

> +		break;
>  	default:
>  		/* This should not trigger, since we check the id before
>  		 * sending the component table to firmware.
> @@ -706,6 +754,12 @@ static int ice_finalize_update(struct pldmfw *context)
>  	struct devlink *devlink;
>  	int err;
>  
> +	if (priv->erot_present && priv->seen_components != ICE_FWU_COMP_ALL_EROT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
> +		return -EINVAL;
> +	}
> +
>  	/* Finally, notify firmware to activate the written NVM banks */
>  	err = ice_switch_flash_banks(pf, priv->activate_flags,
>  				     &priv->emp_reset_available, extack);
> @@ -981,9 +1035,9 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
>   * formatted image that matches this device.
>   *
>   * Extract the device record Package Data and Component Tables and send them
> - * to the firmware. Extract and write the flash data for each of the three
> - * main flash components, "fw.mgmt", "fw.undi", and "fw.netlist". Notify
> - * firmware once the data is written to the inactive banks.
> + * to the firmware. Extract and write the flash data for the selected firmware
> + * components: "fw.mgmt", "fw.undi", "fw.netlist", and, when firmware reports
> + * eRoT presence, "fw.pqc_manifest". Notify firmware once the data is written.
>   *
>   * Returns: zero on success or a negative error code on failure.
>   */
> @@ -1013,12 +1067,37 @@ int ice_devlink_flash_update(struct devlink *devlink,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
> +	struct ice_hw_dev_caps *dev_caps __free(kfree) =
> +		kzalloc_obj(*dev_caps);
> +	if (!dev_caps)
> +		return -ENOMEM;
> +
> +	err = ice_discover_dev_caps(hw, dev_caps);

This duplicates the ice_discover_dev_caps() call already done inside ice_get_pending_updates(), reached right after via ice_cancel_pending_update() — two AQ list-caps round-trips per flash attempt. Also note ice_switch_flash_banks()/ice_write_one_nvm_block() still read the cached hw->dev_caps.common_cap.* instead of this fresh snapshot, so the "per-update snapshot" isn't actually used consistently within the same update.

> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot determine eRoT state: unable to read firmware device capabilities");
> +		return err;
> +	}
> +
> +	if (dev_caps->common_cap.external_pqc_rot_invalid) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid eRoT capability reported by firmware");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!dev_caps->common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
>  		return -EOPNOTSUPP;
>  	}
>  
>  	memset(&priv, 0, sizeof(priv));
> +	priv.erot_present = dev_caps->common_cap.external_pqc_rot_present;
> +
> +	if (params->component && priv.erot_present) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter does not support single component update");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
>  		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
		priv.context.component_identifier = NVM_COMP_ID_NVM;
	} else if (params->component) {
		return -EOPNOTSUPP;
	}

	/* the E822 device needs a slightly different ops */
	if (hw->mac_type == ICE_MAC_GENERIC)
		priv.context.ops = &ice_fwu_ops_e822;
	else
		priv.context.ops = &ice_fwu_ops_e810;
	priv.context.dev = dev;
	priv.extack = extack;
	priv.pf = pf;
	priv.activate_flags = preservation;

	devlink_flash_update_status_notify(devlink, "Preparing to flash", NULL, 0, 0);

	err = ice_cancel_pending_update(pf, NULL, extack);

This unconditionally reverts any previously staged pending update before the new completeness/duplicate checks run (they only fire later, inside the pldmfw callbacks). So a malformed eRoT image is rejected "before any bank is erased" as documented, but only after a valid prior pending update has already been reverted. Worth calling out explicitly in the docs, or checking completeness before canceling.

	if (err)
		return err;


> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 1fede0f..43f3208 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -1151,6 +1151,7 @@ struct ice_aq_get_set_rss_lut_params {
>  #define ICE_SR_OROM_BANK_SIZE		0x45
>  #define ICE_SR_NETLIST_BANK_PTR		0x46
>  #define ICE_SR_NETLIST_BANK_SIZE	0x47
> +#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
>  #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
>  
>  /* CSS Header words */

Thanks,
Tomasz
