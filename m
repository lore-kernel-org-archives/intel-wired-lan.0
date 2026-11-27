Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A18606A330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VUtyh3n8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WOV7E5nZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0096740893;
	Fri, 27 Nov 2026 13:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjVAnZYiBDFq; Fri, 27 Nov 2026 13:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB3E0408A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795786501;
	b=CVWTyZAgvJZfortDip3aFpb8rHqntvT5WbGyci3k5WneVcGDsV0R/hRWZLSBgKj6QDek
	 BE5dcw2F9GXid46bi1lETfVX6Wp0FhVRlNTtdbt4rgNwCaRvoOR+QkqYYPWYEIZeDApKu
	 QKPCry1l9PJMnmENbwrvj+ncHia7L/bR5qS7dTypEeFoR3TWftjsaEVHJyWTOmAbj60f+
	 6+kd2Iwpe0GeoS9oi9cosNsyv7lq8eX09eZVHyvrEVKOGQYPkBXYIZ/zRfmBMxVLFqd5w
	 QCPnZa+Q195ZzvuYDOFXN7NsxyhEROn2QIT+e5Bouqm628ZukR3acUEV8vsP6xD6n0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:From:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aiz7OskXSIxLqPwAnUazU/gTX3xJwNj2Edl+jQMGQGo=;
	b=ZJBO8i2CG/A98Dk+ul2HGs+elZxmH54x8Hl3mCOPRGMjN6DdL54GemgMy89JPj2ygVPC
	 jhuSGQXMq6gKc4kVWoSAdGnyeVROP6HkCIclKK/IM1taW2PZ4AFhmlkLlhdT2CT9jN5dl
	 yZpurQ+fmo1g2URvZo6FtoIobng8fKYA4gZcrUY7vUpUu5sxH3ydzf254gCRWJ9JyHwcn
	 /HVaD8BzEi57te0d8ApIcXhc3ZDxaFLYv+bTitObrSQOgbeU1S4QEql6PyRwuLKpF8e6r
	 xEa+sGOV5PyXIASAjwSPSd6qyrVlBTFwQrm4/eflKJoSrj1SD7dVVqcpv6RAoUF+quw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795786501;
	bh=aiz7OskXSIxLqPwAnUazU/gTX3xJwNj2Edl+jQMGQGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUtyh3n8+hpDFAqAYqwox0IYY+TGSrDqisXsrNP9yuQ7lQ08hRmJkGTuB+kDW9cxO
	 4p/tcukjbZpI3VSLWuWDhNnm2iLigjTmGTnFaC82+2QidgRguEeYP4iBK2M+x5bjKT
	 lMZxNWE8GInT04Iopjl8Lj+ApNkKOxBv+4snYOU1fDvQhitLb9TavFmzXTTMymmS5o
	 PQm0sUDHkQ7hsoVZ+RBG24RZ5sbF/lumZaKb3l7li7bCwA98eo0RKMdkiwUKn3fwAr
	 VTu3NUVbwIvfNLS1qCUPw84WJ1ZYSgYyZTtJCg+/WgTRLx2yuVKNwJ2jv+4rL7Ti47
	 TbFod4tkHCnYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB3E0408A2;
	Fri, 27 Nov 2026 13:35:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B70592BD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6952D60AA5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6w_FPNQndbi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:34:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AC8060A4E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WOV7E5nZ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AC8060A4E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795786498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aiz7OskXSIxLqPwAnUazU/gTX3xJwNj2Edl+jQMGQGo=;
 b=WOV7E5nZInwBVGGexjZxWclH7OmuxGD339enNb/KDfIogO/vYevS2Rhg91ZfmYFYuoSD3a
 Go3EG6Xk/PbehqvSgOX7U8Zns2nIXHRutFxXw34+kEqr5+hs4XvwFf/l2tB8HfAL8FfyBk
 VZGPpaLx4LSK8x2jgTOkt+111ofWfw8=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-EzbpiHW1PBGbmjnfkGDfTA-1; Fri,
 27 Nov 2026 13:34:53 +0000
X-MC-Unique: EzbpiHW1PBGbmjnfkGDfTA-1
X-Mimecast-MFC-AGG-ID: EzbpiHW1PBGbmjnfkGDfTA_1795786491
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75C4F1954223; Fri, 27 Nov 2026 13:34:50 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0461F18011D4; Fri, 27 Nov 2026 13:34:44 +0000 (UTC)
Message-ID: <768596a5-b2d6-4778-bb24-2b26244fc5e9@redhat.com>
Date: Fri, 27 Nov 2026 14:34:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/4] ice: do not leave switchdev mode while
 representors exist
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>, Patryk Holda
 <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261127085714.1207361-1-poros@redhat.com>
 <20261127085714.1207361-3-poros@redhat.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261127085714.1207361-3-poros@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jQ0MCfSiskv1D9Nq9e4U7yBKESfigfou7nsVs3Rqouo_1795786491
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 09:57, Petr Oros wrote:
> ice_eswitch_mode_set() refuses a mode change only while VFs exist, but a
> subfunction port has a representor and a switchdev session too. devlink
> core usually refuses the change first, because of the devlink rate nodes
> the representors export, but ice exports none while DCB is active. A
> switch to legacy then destroys the representor xarray under the running
> session, the representors leak, and the uplink stays in its switchdev
> configuration.
> 
> Refuse the mode change while the representor xarray is not empty.
> 
> Found by AI code review. Reproduced on an E810-C (FW 8.1.1, ICE COMMS
> package 1.3.55.0) with the firmware LLDP agent off, without kernel
> changes:
> 
>    dcb ets set dev $PF tc-tsa all:ets tc-bw 0:50 1:50 prio-tc 1:1
>    devlink dev eswitch set pci/$BDF mode switchdev
>    devlink port add pci/$BDF flavour pcisf pfnum 0 sfnum 88
>    devlink dev eswitch set pci/$BDF mode legacy
> 
> The last command succeeded, the representor netdev stayed registered
> and promisc off no longer took effect on the PF. With this patch the
> command fails with "Remove all subfunction ports before changing
> eswitch mode". No kernel selftests cover this.
> 
> Fixes: 977514fb0fa8 ("ice: create port representor for SF")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v5:
> - New patch. Without it a switch to legacy can orphan a switchdev
>    session, and patch 3 resyncs the uplink only when a session ends.
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 6e7bba4738989b..c96b201901f48c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -354,6 +354,13 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	/* subfunction ports have representors too */
> +	if (!xa_empty(&pf->eswitch.reprs)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Remove all subfunction ports before changing eswitch mode");
> +		return -EOPNOTSUPP;
> +	}
> +
>   	switch (mode) {
>   	case DEVLINK_ESWITCH_MODE_LEGACY:
>   		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy",

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

