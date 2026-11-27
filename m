Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54E606A324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1N/PY19N;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYP/VN+z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BC2860A4E;
	Fri, 27 Nov 2026 13:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yul1EVfiTaHD; Fri, 27 Nov 2026 13:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D428860AA5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795786470;
	b=qbQCiDUFIdHalspKxNT/EWAgD2cb4aXdd55Ku2rNJ211efLU4TiNPeC9mQ9wSuF4dzyi
	 cxXQcqP91jPeOcQuD44OeG+NH7Uie/sCon+XbP5r5MAz8Yg3QYO8AjHzm2zuUUocwMyAu
	 ar3lTxDZ7KrvKmiocr2BkOxYoj5+/aTrXLBuk85lrIShz3rFc6/yR+P1S9na/yn3DBakc
	 lYkMgz8nehuszZ5S2+0VKR8IQHw3+xxERTUjh25/jT/IZ484fZLFxPjTzVizePjlGdMl9
	 1xutPNzdGPPOVjH89gs+Shqy/GHE+rEqG5V1I7H/hhOlb77ypZorAN+FYoBtiXz69Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786470;
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
	bh=hQK1Qvervs1OAOhCCxOUr4dL6b3RgURGSMAbo5aH1Sk=;
	b=IKcfPVYvEjXxP584l7Fb/mbaFOxDauwUHTgn5pqGEhNCDCbXV6PuegBJrAQhYiFtUkQ9
	 ETzBuXFWfsytQ/UZqqhgWGGKOoI3/hFT0LqmCpYdFfjcUWUnHKUXvxTqfz75FE/gMg9E+
	 kN158egs5NdDhT6D0nTUNp59q2QHn12Y1miU8CCKtuqwCY9XTqZ1WFtwv3/bTnFn7cnSx
	 lvw32Rm3ieJgkq1ZQGIYZQapfBst8kF4wIgWSth8HuLwS8EQoilYpZvuFtSKmxRmPp4Ws
	 H8aJvizOxaTgzoVewPrJUu/UHIhDyc4/r9vMJb4Tv4oGMuw5mKdC7NvX08apN+8LEbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795786470;
	bh=hQK1Qvervs1OAOhCCxOUr4dL6b3RgURGSMAbo5aH1Sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1N/PY19NEpUTCjm3/0g3Ta9A5hhyTm0/3RuxfgrjC8xBTXg02pdA+iNm/LYaRsGPH
	 eKdaEW/6z0wP8iRy3IJmq1iOGHwcZO4PofD/c8e4f9eQ6AR+XlkfLowjTgx5iH2ym+
	 xF2L1uvz+dVksVxNrkZaxXRMGQb4jyRKn4n7A8lAEkNhAY13jJevvHtscK2REN1T80
	 c+uvCrKuqVm6d43DB6DfbUvPMFb3d7Nh4ShoqQ2YSPUslcxgx+x6rV09rabLiAfhmC
	 re/ONaaQADMh0o3/kHy2h8HJOsMiXxYuZP7udQefako5aGkTbD7C0mRLc+0pZ1qSPQ
	 V59kFZzzbRAew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D428860AA5;
	Fri, 27 Nov 2026 13:34:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C19CD1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58C7E810C7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJ3_Sm3k1jcZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2ABB810C3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YYP/VN+z
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2ABB810C3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795786465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQK1Qvervs1OAOhCCxOUr4dL6b3RgURGSMAbo5aH1Sk=;
 b=YYP/VN+zObawm5ilrTciSxHH7QcWqMojJKDzsOKkVQpruIKTFCeeZUuIW+bUnBqaakCpHq
 zD8gccWwRhwKwhO4nzcugxWBDRHCfH3J6ehRNVjyj6i554Vu4c2vF3FZKgdHS6Qbm301M4
 YJQjG8lGNR41ujKJ6ELVt86/DMGej0Y=
X-MC-Rep: binary re single
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-jPo4byX3N5SVBAflMNu0Zw-1; Fri,
 27 Nov 2026 13:34:19 +0000
X-MC-Unique: jPo4byX3N5SVBAflMNu0Zw-1
X-Mimecast-MFC-AGG-ID: jPo4byX3N5SVBAflMNu0Zw_1795786456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EDEF1955E97; Fri, 27 Nov 2026 13:34:15 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9C0218004F7; Fri, 27 Nov 2026 13:34:08 +0000 (UTC)
Message-ID: <c7708854-5a47-46a1-bca7-df3ba03ff85f@redhat.com>
Date: Fri, 27 Nov 2026 14:34:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] ice: stop the service task before the PF is
 unloaded
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
 <20261127085714.1207361-2-poros@redhat.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261127085714.1207361-2-poros@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: dmnSn-qDgdTgobir1BR0ucqi0kSDs3NHgjBFR4p5K5c_1795786456
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
> Commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit
> paths") moved the service task stop and the cancel of the AdminQ event
> waiters from after ice_free_vfs() to the end of ice_remove(). Since then
> a queued or running service task can still walk pf->vsi[] while
> ice_remove_arfs(), ice_unload() and ice_deinit() free the aRFS filters,
> the netdev, the LAG and the VSIs. A last run that takes longer than a
> timer period also arms the service timer again after the stop at the
> end has deleted it, and the timer then fires after the PF is freed.
> 
> Stop the service task and cancel the waiters after ice_free_vfs() again.
> The stop in ice_deinit_dev() stays and deletes a timer armed by the last
> run. As before that commit, a devlink flash that is still running when
> the driver is removed fails, at the latest when its next AdminQ wait
> times out.
> 
> Found by AI code review. Validated on an E810-C (FW 8.1.1, ICE COMMS
> package 1.3.55.0) with a test-only 12 s delay in ice_sync_fltr_subtask()
> after it took the VSI pointer, armed right before a promisc change and
> rmmod ice. Without this patch KASAN reports a slab-use-after-free in
> ice_vsi_fltr_changed() on the freed main VSI, and the kernel then faults
> in call_timer_fn() on the timer function of the unloaded module. With it
> rmmod waits for the run and nothing is reported. Also tested by removing
> the driver during switchdev sessions and with four VFs bound to iavf. No
> kernel selftests cover this.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v5:
> - New patch. The uplink resync in patch 3 queues a filter sync when a
>    switchdev session ends, and a session that still runs when the driver
>    is removed ends in ice_remove().
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 47c6798c97e8f1..6dede87b78944f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5387,6 +5387,9 @@ static void ice_remove(struct pci_dev *pdev)
>   		ice_free_vfs(pf);
>   	}
>   
> +	ice_service_task_stop(pf);
> +	ice_aq_cancel_waiting_tasks(pf);
> +
>   	if (!ice_is_safe_mode(pf))
>   		ice_remove_arfs(pf);
>   
> @@ -5407,7 +5410,6 @@ static void ice_remove(struct pci_dev *pdev)
>   	ice_deinit_hw(&pf->hw);
>   
>   	ice_deinit_dev(pf);
> -	ice_aq_cancel_waiting_tasks(pf);
>   	set_bit(ICE_DOWN, pf->state);
>   }
>   

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

