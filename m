Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF4DCDB470
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jun 2026 10:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C2C80D3D;
	Tue, 23 Jun 2026 10:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSA4a-Zldfym; Tue, 23 Jun 2026 10:29:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5EF280D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782210599;
	bh=7T1CU5SSShDw0aJ9KVYUgQhuWKn/RhlR48iRi5suHSQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v8mtQVgRFZ3w12hdk0adTQxvluoy3fm/oB/r4ywnqXPGCTLq/lsuTzS2ritNqLESw
	 1r8jfSRzeAmxdn2s931K0wC/zmwI71/0yaaF6HPGHWEFpfxdChsLSBXk3n4gSvq1sa
	 csLjA/oyTVatA8uizhyxCUwSZiSFiq3dYsMKyfh3ZXzAv0xsfWSmY/SpYZ7DNxWqEn
	 BIIVmrYbTOlyi8QpDjmCfQq1UUmZVYpfSc6znTiR9CSJ3jCW9Bp04eW/QoY2GgbPGu
	 H1sSCGNV/E4ljWGPKU+17B+u9OCw+UgVKfJO2+jp47tQ4OTjxWZoMSpwFJ37IOZq9t
	 gB7JgFCigDcdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5EF280D2D;
	Tue, 23 Jun 2026 10:29:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37F95256
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2156640266
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uowBAlW35GOd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jun 2026 10:29:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 48BEA40252
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48BEA40252
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48BEA40252
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:29:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB5A160052;
 Tue, 23 Jun 2026 10:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985471F000E9;
 Tue, 23 Jun 2026 10:29:53 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 michal.swiatkowski@linux.intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Tue, 23 Jun 2026 11:29:34 +0100
Message-ID: <20260623102934.1072800-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622081030.2312129-1-poros@redhat.com>
References: <20260622081030.2312129-1-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782210596;
 bh=7T1CU5SSShDw0aJ9KVYUgQhuWKn/RhlR48iRi5suHSQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hldRoK8vcpn7kEthG8alQzSf9gF2SaT6ZvQLwwP/WpSnZHbTrSJaeQzykQjKQv4OW
 bUk3ic3Ua2enzhh8wA9tt1SSv86e7xsKb9LBy6yLxffWTqULMaTzer1ETP6W4vGL1C
 hsO7N28i9oeDbDpZ5AC4HiBfVFcJUMJiFAIQyRINGAXSwAJ5NofUv/Ne2jMoVuCYS2
 130Rvc7zknfhC3MlmVDMZMlV/goMSXobtzsFcBvLmGpSpakIwJ+6fyWQeUW/hNBbVl
 laEx8Rix5+b0CxuyEqDSh+XwszZqPej60MvjCQnWvdsH6hPMxTX8UNWukO+lYefsnt
 5UcKC2eGY0H+g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hldRoK8v
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: clear the default forwarding VSI rule when releasing a VSI

This patch restores the cleanup of the default forwarding VSI rule
in ice_vsi_release(), clearing it when the VSI owns it. This prevents
a rule leak if a trusted VF enters promiscuous mode and is then destroyed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>  		return -ENODEV;
>  	pf = vsi->back;
>  
> +	if (ice_is_vsi_dflt_vsi(vsi))
> +		ice_clear_dflt_vsi(vsi);
> +

[Severity: High]
Is there a time-of-check to time-of-use race here?

ice_is_vsi_dflt_vsi() acquires and releases the filt_rule_lock to check if
the current VSI is the default. If true, ice_clear_dflt_vsi() is called,
which acquires the lock again during rule removal.

If the lock is dropped between these two calls, could another thread
establish a new default VSI rule before ice_clear_dflt_vsi() runs?

When ice_clear_dflt_vsi() executes, it appears the rule search only matches
by l_data and flag:

ice_switch.c:ice_find_rule_entry() {
	if (!memcmp(&f_info->l_data, &list_itr->fltr_info.l_data,
		    sizeof(f_info->l_data)) &&
	    f_info->flag == list_itr->fltr_info.flag) {
        ...
}

For the default VSI rule, l_data is empty, so it might match any newly
established default rule.

And since ice_remove_rule_internal() does not appear to validate the
vsi_handle for non-list rules:

ice_switch.c:ice_remove_rule_internal() {
	if (list_elem->fltr_info.fltr_act != ICE_FWD_TO_VSI_LIST) {
		remove_rule = true;
        ...
}

Could this blindly remove the default forwarding configuration for a
completely unrelated VSI?

>  	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>  		ice_rss_clean(vsi);
