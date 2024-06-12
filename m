Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722C3C27C53
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jun 2024 15:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0683080F66;
	Wed, 12 Jun 2024 15:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwjEwBN1Bv5T; Wed, 12 Jun 2024 15:54:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57F9B80ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718207653;
	bh=HWITcPld692gjBNY4dq4HSNit6UcpgCJOc4MJm877h0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AiYz6PvwTZDxIElh5jlLCZtP/F2K38INKvkJ5TP6wVB+zsdi14HJ6o+xeHtniUwwb
	 V7jW4iGCQBS+0TdskAoRQicb9lrYeXfwZTtmOEys8SMorWFbJB9qy41iIrd/V8Y7JV
	 ogOErNEAdS3rfc0RkPaTZW0c/JN52vo3cP26tSvDOp0IAsYN6gclAOGZq0byBj4/7p
	 F2MQqS3Awx9PL2It9EPQ5055mhX/YHuY18WLgeYanq/2PX2jA6xihZ1GzzWkYAQTKR
	 p4JfY9boi+4QIsz6gYpoRQaZuUxmzhJtbwheWtJ6JoE+9ix2siYfeDhGF6ZUwLv0Yp
	 ttbCZXEWqBgDA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F9B80ED7;
	Wed, 12 Jun 2024 15:54:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3BB551BF36D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 15:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 302DD40208
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 15:54:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LPbxDigYcfK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jun 2024 15:54:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3FB4940204
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FB4940204
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FB4940204
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 15:54:11 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ylgDqTpaMkWuAu5eIWyGlg-1; Wed,
 12 Jun 2024 11:54:05 -0400
X-MC-Unique: ylgDqTpaMkWuAu5eIWyGlg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1C91956095; Wed, 12 Jun 2024 15:54:03 +0000 (UTC)
Received: from [10.43.2.69] (cera.brq.redhat.com [10.43.2.69])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECEB919560AB; Wed, 12 Jun 2024 15:53:58 +0000 (UTC)
Message-ID: <04c8da79-6d94-406c-b168-73c23a9c0e43@redhat.com>
Date: Wed, 12 Jun 2024 17:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
References: <20240612154607.131914-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20240612154607.131914-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1718207649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWITcPld692gjBNY4dq4HSNit6UcpgCJOc4MJm877h0=;
 b=Ctt9r0kLg7Mc4/qOAi6A1ejTlxW6GZWYTpDOMoUTb5sLsT6WSHGW0rNCJa7VuQBE5RMtjr
 dHvCgC15O+JnQu4wLPXkuc58YM4as1N+pZ4Bh03i7QeFtLjifvC5LqIKREzx7DhlwD666W
 taXybkf7SFeRyjJshxkOPaIciHpST1g=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Ctt9r0kL
Subject: Re: [Intel-wired-lan] [PATCH] ice: use proper macro for testing bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Konrad Knitter <konrad.knitter@intel.com>, Eric Joyner <eric.joyner@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Marcin Domagala <marcinx.domagala@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 12. 06. 24 17:46, Petr Oros wrote:
> Do not use _test_bit() macro for testing bit. The proper macro for this
> is one without underline.
> 
> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> index e4c2c1bff6c086..b7aa6812510a4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_hwmon.c
> +++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> @@ -96,7 +96,7 @@ static bool ice_is_internal_reading_supported(struct ice_pf *pf)
>   
>   	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
>   
> -	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
> +	return test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
>   };
>   
>   void ice_hwmon_init(struct ice_pf *pf)

Acked-by: Ivan Vecera <ivecera@redhat.com>

