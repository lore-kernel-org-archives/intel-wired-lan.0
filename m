Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E6606A32D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=E16wTv6I;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dogS02vY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50F4E40572;
	Wed, 11 Nov 2026 10:57:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AaaotbfiqGhR; Wed, 11 Nov 2026 10:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91A5A40598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394635;
	b=l0wcJ7OYca3Bq1TbRFilCOacS17HbdR0oOmmAad1YYliVWmb5FZuMlqwZxIedyUjw/OF
	 q4hAnkCqac2ihMLMODDlITOqNfOuNu5ZyUVOEhLJWMbp6EmEomaZdjpJEHWUN7KTqz2TD
	 xdKKLFfQUHxi8xYgGWsS3eYDTJC9o9hmNlT25V6XJzM8/G3jLKYZ1M0HQswzxQwgkLO1z
	 PyZ0G1rpQx7O3i0DhTRZpLtwRbaSJ8FPvrOVgK2ZajEujUWKyWjpmqtY9/bQoVwb36jjm
	 xJtKNmvVYPf35njalkueLmPeX1zqcrSIG2i3tOCmDqI8S5A7tVOOaCMuNt98VO/u9+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y71I2g5CiY6ZLFtOOjFefsyXa2Y2V1HXYev8hBP6Jd4=;
	b=gy4PotgSdMS1Q5FF9kWMZGtQ5EtDvdkhrMpKdiK0aK71ktt+jSdZiJpzUZQXdxJt7oKa
	 v7LAqtbCRIOLD5BmxrhadSCWq+SstLNDwnYpDozeXC9S64n51BZecsNdkyuDQp165GmL5
	 U9uoplOBHe/Z9vkrBmRMzVy7GZzsSfzlA8stUX8RPYHrJACp+i/DRdLTXYxb3A5Xa0U0g
	 S2/R6qjoZpqsBM9848WcrbnZlAHrDi6FLUTWzrzsRc+Z0OWVK6IMX7dLpfdm2zA2L81ay
	 4JQ/hHvvrglmwWF5kZmIdr4HtjUhBiyaX8rQBZeA4o8uMGPPk3+lTz5ThlS+F6FsbTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dogS02vY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794394635;
	bh=y71I2g5CiY6ZLFtOOjFefsyXa2Y2V1HXYev8hBP6Jd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E16wTv6I1bpdLkczt1yLfA/Ver8HUNbSW1REl7AYTnTWVNoaX/CdglJN5JZUxC3eZ
	 1sJ6sRmwJYk7asodNxnslaUf8cSQgh8t5E1Kb7124RIA0v7o7JKxC1XQ6VTwI8kok2
	 eF3GeOFasg63r5JqxxwykLIxoZjNAoBKC3Sum9kn9Ht/mFBu8yfxyl1CVGpU/kZGmd
	 YlF+utT0FW86qSXuRGT7MOzYS27kvOYPJvReJv2vb7dJjEwnDWgsxxW7s42MluVGDb
	 4olCHwmHJpXpdBrUvBGsoWPCx9Qn+u9ojryMAoioHo3kzRZT6BBY9kf+vyN300J2Wq
	 z9LHbsoGVGWAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91A5A40598;
	Wed, 11 Nov 2026 10:57:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9793617CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 940DE40598
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:57:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FaPvoZ2EOx0S for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 10:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88D8940572
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dogS02vY
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88D8940572
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y71I2g5CiY6ZLFtOOjFefsyXa2Y2V1HXYev8hBP6Jd4=;
 b=dogS02vYUiLBKw4Dz3ut9QQ07lAdYTVeVZk+91xwuNC/hmj6r4hKL+8gLD5TgWaAaQM4MJ
 tG1Hfs5c5psnpeu2vSYc0sikO6AKziWlSGauBngaKpOabDms9BL5+rq3SRszfQI7kQyvJR
 m1q94qewMbI5Y2Td1taIL3bUE3QIy+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-VSeC4wBmMpOyp6eJ7S0wcA-1; Wed,
 11 Nov 2026 05:57:09 -0500
X-MC-Unique: VSeC4wBmMpOyp6eJ7S0wcA-1
X-Mimecast-MFC-AGG-ID: VSeC4wBmMpOyp6eJ7S0wcA_1794394625
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C3941955F18; Wed, 11 Nov 2026 10:57:05 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DD8C19634EF; Wed, 11 Nov 2026 10:56:58 +0000 (UTC)
Message-ID: <47221876-07a8-46c1-86f7-552402a8d5a9@redhat.com>
Date: Wed, 11 Nov 2026 11:56:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE
 CGU registers
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-3-ivecera@redhat.com>
 <179433320107.994134.16333323653199953270@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320107.994134.16333323653199953270@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: StzoN7Wk0ghzHxhnAsvZv943kXUBHzVhV2kExFTnhqU_1794394625
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit fixes a race that already exists in the tree, but it
>    has no Fixes: tag and no stable Cc.
> 
> --
> 
> ice: dpll: serialize changes of the SyncE CGU registers
> 
> This patch adds a cgu_synce_lock mutex to struct ice_adapter, which all
> E825C PFs share. It holds that lock around the CGU R10/R11
> read-modify-write sequences in ice_dpll_synce_update_e825c(), and around
> the ice_tspll_cfg_synce_ethdiv_e825c() call in ice_ptp_link_change().
> 
>> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
>> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
>> the DPLL core is going to serialize callbacks per (module, clock_id), and
>> each complex has its own DSN and so its own clock_id. With that change, a
>> test toggling RCLK pins of both complexes lost an update.
> 
> [ ... ]
> 
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [Severity: Low]
> Should this patch have a Fixes: tag?

[...]

> Another option is to split this patch out of the series and send it to
> net.
Done, the patch went to net with this tag:

https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

v2 of this series drops it.

Thanks,
Ivan

