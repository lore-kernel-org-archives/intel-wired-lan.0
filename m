Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60647CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 13:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17D29605AF;
	Mon, 28 Sep 2026 13:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAc1Dat5-Rk8; Mon, 28 Sep 2026 13:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2173D605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790600896;
	b=AMs7XPxnvBMLpZHdmnPuhJ3yF4PTtyg78SzTEgDceqhCIKEEzs56TCO9lZrnx8Zwm8/S
	 fXJRcJnn5zZ5Ic6qK7tDmMh5MMiE3lYGZvyv09l4IAJsZ+kYkJofEBxpcjIR1LVzsp+IL
	 3BUS0Pn6CHI6CSeLt0tJanuBkpMdU5nPy7G1G1UiQQxKGpKDyMIRDIpXQ1f697d/x3kRu
	 WuFafm1awpnfARXyVp9+EAhXhTrusDOM8Zdj5bBsPCzzEY+ZBElK6X765pxWv9/dEUhAS
	 Q7T0tfKbymsIZ8SLi/CttFLJLBxDgPh5JDAlVLvQ98EiCppz4pKH/S+uOPIWx+iYXsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790600896;
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
	bh=TwlcODT0gNeCzzleAkfyVS8kMyoWmwaJYPLJqLqTHbQ=;
	b=CRhP8nBUlKt0nLWFb1rLkIGnvRbMQZF7/YJd63Css+hAqW9gCbbR7dafTsqmecRvv4eV
	 xDnMURAeYmybNa42ePJPIoVGgth5lVnznaZXdmiDq3QOXyUfCAceWUwbi0nA8I20lavQH
	 mpwRQy0/En3PP30FKJhEeusgeCYEh4vMAkfEnig41gtXUvoqKlIDHT6wQNQMnFOBM7OR8
	 yTLJjvSRkK2OJ7QVczQdhDbjmNuxdmshZTzOu6A+kZMyIHkWUuRy8BNV0zsPZjZ1SbLv0
	 Wz3y+Q3H4w200LNoER+p1c38+Ac/Yk7qLyTurmIjDOBZw0XjBV1QrZGvJuI3ji//i7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SkMtrz+U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790600896;
	bh=TwlcODT0gNeCzzleAkfyVS8kMyoWmwaJYPLJqLqTHbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JvSuYcU1GGVA3aJOM+26+RtMFOWUTWOcQESXm9hsOXBk3s3Kdpv4tcrGXQ7ncH62Y
	 WMc/AvGtcoIPYgxTUJiMsvTgreONDOk79VphTeK7ODzK/4k5Lsm9vDFDx79KUv0vmv
	 e88foCZgaI+dgq5M/o33+3n3CJ2/Kz4AIvi65Kpo0N8L7XUF3Bfp/dzxcdYV/MYNyN
	 7gR1mNTfe6KyciPL92keeZ1BjTV29vrpqpJEbmwaGDSvD0n30KKlZv5xJeHC3bnobb
	 VONHLDstAH7SZPHYcRMB6PSqIOSbdpJxpy59TenRAsQhADnKilfSAOd+8/iXQVRdyw
	 araE7MBQiJVwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2173D605FC;
	Mon, 28 Sep 2026 13:08:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0439F72
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE205605FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQKF355Uf-4E for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 13:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9E60E605AF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790600894;
 b=kXV0vY+I0QZN5vvgybEBx8KJVZzYqtD+9lCnlDTcCZSJvn9L94MmF9Te0HMijtJtFef0
 DyHoXHM1jleepEOqSKIIC1vixUwv2ES9Rds4ec/VZeks4Sqqbd3L/1/I0EjwMC6yk7Ywn
 jus8eOJqyWPtZx1LZ37ldcMSnR9B29bQnxvBdDcrbL+gldfI/dqX22+seZsEwD8h/VPGa
 An/h4OxUZU8WI5GZF8RPUOu7IAHT1O1Z9mS5hBHjwL2AJLzgONfTIouNCWsfHAH8e34ZR
 EjBlCCkYXXUJ52wJ5r0f9/44mlwevysYnpv3il3xMkMNW2VJi/SuUDGhccdAz5hTgPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790600894;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=TwlcODT0gNeCzzleAkfyVS8kMyoWmwaJYPLJqLqTHbQ=;
 b=XNxmgw13DIWwzzBPn6M12W2MexUrDRhlsCqTJL1asZjriqd4GCX8eAY/4FmPVaecd4cv
 inboDOCKna3wWG3IqKLHuFFVV1JdWmz7Yv/HqYWDEur5GW7eg7JHJYQkva5doQkyTPGep
 MJtudIFdBg4nV9zE50bZVpZrAn0Bw1+abLapQc68LpLYVM5zUwwOzCPtjr8UV4vZaFgpw
 k14zUR2/SLLs/Vekil/8M+ym3Efyal9uG0fGrmUJ1Ud+waUI/Iswfw0lvl9lTTuGcAYnf
 iTIQMoFc7ACajQqnHp2Nx3MD8UiAcBgzgzh30R4dm2P3FaR65nODzkcgPyBh1UU0uag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SkMtrz+U; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SkMtrz+U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E60E605AF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790600894; x=1822136894;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5Hj9ni/TpoYtr93aWbk+8aZHf1HPKdtjqnX/zK20FhE=;
 b=SkMtrz+UtaMVu/lXHzJdPegIdS2fbhGAtcIKYEPV7SBR/t+mBF2zPJIh
 /LOjUUsOw7B7vv8G7mk08ZwQQV3ycxdxbqoXABS+ndoZAJp5roTjMAQcZ
 Ad4ZtmROyeei/MPY/V8OcOBFUv9kGLj2gNHHVNSBvSoNd91zoAqR4jbV3
 nxna8ypE8FENJc9MBwephOmHz/rbViCtulsCTnGfkCposrrZ/iY3eogNU
 9FtT8oSNpsC7BAxiRcrNW3eI2U7/6XMrgRBS7DedfiEKmCKaLSF4NeIgy
 IgD1Z+joEN1lsST2fltRK5dDN3WKBEYWc1jV0LaDFsBjkyehW1XdV0S/I g==;
X-CSE-ConnectionGUID: WSPHXJ+lTr+EpGRU6cAnAQ==
X-CSE-MsgGUID: i77DePamTqOlvVPT7Ulwnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90251927"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90251927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:08:13 -0700
X-CSE-ConnectionGUID: vNPCrckvR2G4WnuKzPkR4w==
X-CSE-MsgGUID: utS07yfGSJGK+ziMUtQmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="273195135"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:08:13 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 9ECA020B5708;
 Mon, 28 Sep 2026 06:08:09 -0700 (PDT)
Message-ID: <1dc822f8-e2f8-4e22-aeba-dc91476c27ad@linux.intel.com>
Date: Mon, 28 Sep 2026 15:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
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



On 28.09.2026 08:53, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller, ice_ena_vfs(),
> goes straight to ice_free_vf_entries(), which drops its reference to
> every VF.
> 
> The port representors created for those VFs therefore outlive the
> failed VF creation:
> 
>   - the representor netdev stays registered and its devlink port stays
>     registered too. That port is embedded in struct ice_vf, so it ends
>     up pointing into the memory that ice_sriov_free_vf() releases;
> 
>   - repr->vf keeps pointing at the freed struct ice_vf, and repr->src_vsi
>     at the VF VSI that ice_vf_vsi_release() tore down. The leftover
>     netdev is still visible to the user, so even a plain
>     "ip -s link show" of it reaches ice_repr_get_stats64(), which calls
>     repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
>     reads repr->src_vsi through ice_update_eth_stats();
> 
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
> 
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach() never
>     calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running stays
>     true, with the bridge offloads and the devlink rate topology still
>     up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
>     left in the switchdev configuration that ice_eswitch_setup_env()
>     gave it.
> 
> Detach the representor in the teardown loop the way ice_free_vfs() does,
> ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a VF
> without a representor, so no extra condition is needed.
> 
> Hold vf->cfg_lock across the teardown of each VF as well, like
> ice_free_vfs() does. The VFs unwound here are the ones that already
> reached set_bit(ICE_VF_STATE_INIT), which is exactly what
> ice_check_vf_ready_for_cfg() checks, so a host administrator can still
> run "ip link set dev <pf> vf N ..." and a VF can still send a mailbox
> message while the loop walks them. Both paths take cfg_lock and then run
> ice_reset_vf(), which gets to ice_eswitch_update_repr() and writes
> through the representor that is being freed, or reach
> ice_vc_process_vf_msg() reading vf->virtchnl_ops while
> ice_virtchnl_set_dflt_ops() hands them back.
> 
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:
> - Link: https://lore.kernel.org/netdev/20260921031616.3390259-1-xiaolinkui@126.com/
> 
> Changes in v2:
> - Hold vf->cfg_lock across the teardown of each VF, the way ice_free_vfs()
>   does, so that a concurrent VF reconfiguration cannot walk through the
>   representor and the virtchnl ops that are being torn down.
>   (Sashiko AI review)
> - Patch 2/2 is new and returns the VF MSI-X window that the same failure path
>   reserves. That is a separate, pre-existing bug, so it is not folded in here.
>   (Sashiko AI review)
> - Not carrying over the Reviewed-by from Aleksandr Loktionov, as the code
>   changed after his review.
> 
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..95abc6704820 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,8 +508,13 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt == 0)
>  			break;
>  
> +		mutex_lock(&vf->cfg_lock);
> +
> +		ice_eswitch_detach_vf(pf, vf);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>  


Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

