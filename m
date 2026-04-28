Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4C4FF885D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 10:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E433860FF9;
	Tue, 28 Apr 2026 10:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avSx0AL2tbHk; Tue, 28 Apr 2026 10:54:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47B2360FF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777373641;
	bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzg4O49MFo01zipoAhk8wHqZPrUI3ADgvtUlIRqHINViXJUf8Cb/3j2PD2IHwvqu2
	 tcpldymO7VtdcKCX2s50ALx4ksHLRYXr/PCosFiTDO8plwGBZ+cGDQe816IcKcEm4W
	 mQE8P+VS7AuEHXqwjB3+nGXS5Wqke8W2PFDFv3CX92kJnqZP82IEkuojhwQBX3vzpJ
	 rWEsQDchb4V+pWdZjh0j5d9GPbjBYH1PMvIIP3PvjzZes2AM5QNE1mH8/QxcjpxYaA
	 yhccsJcZfaBzLDLBUdTTxSSVbAYz4V39URB5P/UEeNibHNC+2DNk6X8YfoKZNL5K8f
	 d+oKQv7GciBmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47B2360FF1;
	Tue, 28 Apr 2026 10:54:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAA13231
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 10:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4B5B83670
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 10:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2AAv6PCznwy for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 10:53:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A38F783626
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A38F783626
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A38F783626
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 10:53:58 +0000 (UTC)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-QhKV0zdhOsGVyBvdJZmTOA-1; Tue, 28 Apr 2026 06:53:55 -0400
X-MC-Unique: QhKV0zdhOsGVyBvdJZmTOA-1
X-Mimecast-MFC-AGG-ID: QhKV0zdhOsGVyBvdJZmTOA_1777373635
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8ebc7ea2402so1772909485a.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 03:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777373635; x=1777978435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
 b=fc4Vl2XjFFIsELDje0zNTmfsZRiUC039Owa+Wmf48Nnt5DryAQ++BWG814TxQ8rROg
 rp9a7PV9w9JWbTF72wrsafkHAmg+oLd24dlVW85ZVyQCBKF2mgeRRIOtMyJLXRGfabbY
 2lF3ybWOBfQkQTYEocEb9wbAKRc2tJ5+X7826YzH13xvbKx3ITKyZkos/8M21TEHC3tN
 m2DjCv+bq1Q+Q+GTuTL/CBe7NH2V/IDjKApjVQ3udRLRBEmmDPD9Rw0OMHMXmad8b/yZ
 y12PEv4TH48D1rHGZoD5nLUE37FEEVu1jwaRwqI5dB+yDSAs6c6NjsBjqr+5t3H9oVnL
 QbBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oQw7qGsz8y8wBjiquVFrXd3XGVC9jCG8fX5FFhINYFpkJs5q3nz/QelfZkrWZSJMMgvXxDei2Z3xmTiTd7RA=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxqb2qbVrufoKNwhCktSe4sUoWTh9eBSyDwgrSaduPluOKyKqgO
 GTY48259+Kco7ncB4m2++Y/EvChKzlf/sCyWjI4RuBikZvmCApgtH+EajDQ5ODdAfP7QX1N78HJ
 nMs+wOMjfAAjqNNwJqucbwCu9/N5ORSQF0knYu75tvrFUT/BjTZw+e3Evn5jB4s/AOaBlVCM=
X-Gm-Gg: AeBDieuDqn/wWy2dZvnv9nF6zqzW/lPKdXkDx72j0h1EjzxJNUUyTJ7FV9gEwWLTMZl
 a1pKC0omkaCxcuKP1WAPk83qx1QADxcQjIU0TAzeNVwi2K9dl1KKFVXvTzFVFCd8q+U7koBB5FF
 J8qtTnJwa7AWbbS/bBIrwAKjeeJPnFUNg1ZfKYcuQAvPNYW4TGQdLIa7NQxVC6UyXZcn16UESO5
 znqWy9WxMzQXrYRTP0MCOiV+E1D1B+e4SqMWQX4rAELzVxGk0fQ/5S39EbtrKjI9UzSGZeDMiXl
 npdxeLPv9c6WS6iFopM5twnwPB/KlsJpQxQhSKl7YXijMwx8x05JEej0gGC6VSap8U+ZoD3EKtZ
 DpTKQ8eGqB2SsFOQiWoo=
X-Received: by 2002:a05:620a:bd3:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-8f7d920261emr295663185a.36.1777373635141; 
 Tue, 28 Apr 2026 03:53:55 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-8f7d920261emr295658485a.36.1777373634541; 
 Tue, 28 Apr 2026 03:53:54 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c7cd2becsm161540785a.29.2026.04.28.03.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 03:53:53 -0700 (PDT)
Message-ID: <c90116ad-4b32-4a55-970c-fd8518fccf62@redhat.com>
Date: Tue, 28 Apr 2026 12:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Aaron Brown <aaron.f.brown@intel.com>,
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <cover.1776426683.git.poros@redhat.com>
 <20260421090254.GW280379@horms.kernel.org>
 <b2d56951-4776-4d99-bb4a-69ef7da0a502@intel.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <b2d56951-4776-4d99-bb4a-69ef7da0a502@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BBxc-ybHIoVUhOeyjHa5j5XyAcKtrx1lHjrIuMkabKA_1777373635
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777373637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
 b=XrVGM2Q8ORygkCIzwGrz9JubYUIAVm82w7TnA6N72zI0bnXsFEe6kC8b+Em48jGT/tAL+V
 pu5gSziWf+qJfkbcufClc0rRrShIPCHCyQuWf0rGxz9kQefnsTMMityrtlgF47YIYi8WHi
 rJjtqPTY18tOYOg9AQTuYtFME7+CesM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XrVGM2Q8
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 0/4] iavf: fix VLAN filter
 state machine races
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


On 4/23/26 22:48, Jacob Keller wrote:
> On 4/21/2026 2:02 AM, Simon Horman wrote:
>> On Fri, Apr 17, 2026 at 04:29:41PM +0200, Petr Oros wrote:
>>> The iavf VLAN filter state machine has several design issues that lead
>>> to race conditions between userspace add/del calls and the watchdog
>>> task's virtchnl processing.  Filters can get lost or leak HW resources,
>>> especially during interface down/up cycles and namespace moves.
>> ...
>>
>> Hi Petr,
>>
>> Sashiko has a bit to say about this patch.
>> I'd appreciate it if you could look over that.
>>
>> In particular, the feedback on patches 2 and 3 may warrant
>> some updates to this patchset, while I think 4 is more
>> in the realm of possible future work.
> @Petr,
>
> Could you please review the Sashiko reports and clarify whether a new
> version will be needed?
>
> The original series posted as a net-next was Tested-by, and it would be
> good to get this moving, but I don't want to queue it up for sending
> until certain it won't simply get rejected due to these unresolved comments.
>
> Thanks,
> Jake
>
Hi Jake,

The Sashiko review identified seven concerns across the four patches.

Five of them describe sub millisecond race windows. Rapid del and re add
of a VLAN in IAVF_VLAN_ADDING state. Pending IAVF_VLAN_ADD lost across
down and up before the watchdog ships the request. REMOVING combined with
user re add and user re del state confusion. The reset path resurrecting
filters that are in REMOVE or REMOVING state. Phantom ACTIVE after the PF
rejects an ADD whose user side del raced through.

The remaining two are deterministic pre existing V1 bugs unrelated to
this series. The V1 ADD_VLAN error path has never called 
iavf_vlan_add_reject().
The V2 path got it in 968996c070ef ("iavf: Fix VLAN_V2 addition/rejection")
and V1 was missed. These manifest whenever the PF rejects an ADD on i40e
for example a port VLAN conflict or an untrusted cap reached, and they
belong in a separate fix.

The five race window findings require tight syscall sequencing via ip batch
or sysfs FLR concurrent with del to reach. These patterns do not match how
NetworkManager, systemd-networkd, libvirt or cloud-init configure VLANs.
Those tools add VLANs once on VF setup and do not issue rapid del and
re add or trigger FLR mid operation. The current version keeps the state
machine minimal. Closing these windows requires per filter flag tracking
that adds complexity disproportionate to the user visible benefit on real
workloads.

Two larger problems are worth addressing in follow up work.
The first is num_vlan_filters accounting on V2 under high churn.
Post series, filters in REMOVING state count against
iavf_get_max_vlans_allowed until the PF confirms the deletion.
This can cause a transient EIO on rapid del then add when at the cap.
Pre series this was avoided by immediate kfree. The trade off here is
correctness (no HW resource leak on PF reject) at the cost of a transient
userspace error.

The second is the i40e silent ADD reject. The i40e PF rejects over cap or
untrusted VF VLAN ADDs by returning VIRTCHNL_STATUS_SUCCESS, so iavf cannot
surface the failure to userspace. ip link add ... type vlan reports success
while no filter exists in HW. V2 on ice avoids this via the client side cap.
Closing this gap requires PF and driver ABI coordination.

The series has been tested across documented user workflows on both
ice and i40e PFs in trusted and untrusted modes. The tested scenarios
include interface up and down cycles, namespace migration, VF reset,
VLAN add and remove sequences, parallel VLAN operations across two VFs,
traffic verification via ping under spoofcheck, port VLAN, and multi
VLAN configurations. The workflow scenarios pass on the patched kernel.

The small number of test failures observed were test framework artifacts
(missing IP configuration on probe interfaces, settle time too short for
PF round trip drainage, V1 PF reject classification) and not kernel 
regressions.

Regards,

Petr

