Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F41073C85
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 09:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A8A680BE8;
	Wed,  8 Apr 2026 09:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrFmFgOj4gCT; Wed,  8 Apr 2026 09:45:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1374280B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775641508;
	bh=fVByUgcVRV9cDGwBxu0qdLtCN/YmZ0vWbRv6xHT9zUI=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DMadxhf0Go9SY3BMRIHdPDXRDsJdCd98u5qOoAfG2nqwcvy9xvdZRoVCpCpzSgTUh
	 17IgY/HAAcc+NeVPjvfdjKCu8Hahyul256h82+Dd30kfBsY+YBLZwYaEio53k+EW1u
	 uLRpXO31wcejWg6zNyg9Jbxx+ZMHnHMQThnqAh/H8uBsmDd/TYnd+/aqQsGt9S481l
	 R6gt428syEOTGGiH5ifC5657IP/DjtPHH6nR1HWw9AbXj8oQBUmXJTw/jahxaJNkdz
	 XkznGexVkQKrQP+5lwUHzxZ/iRMOGs4T97MCO15ligJuRJYNsNMEPfiuXJVjPzGdrH
	 uw6sKvbaqq7Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1374280B1E;
	Wed,  8 Apr 2026 09:45:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB72C1F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 09:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAEC080B1E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 09:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIt50QrJd4wx for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 09:45:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B1CBA80B00
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1CBA80B00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1CBA80B00
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 09:45:04 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-QqfLZcIANHqLSnK_0ttR4A-1; Wed,
 08 Apr 2026 05:44:59 -0400
X-MC-Unique: QqfLZcIANHqLSnK_0ttR4A-1
X-Mimecast-MFC-AGG-ID: QqfLZcIANHqLSnK_0ttR4A_1775641496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD409195608D; Wed,  8 Apr 2026 09:44:55 +0000 (UTC)
Received: from [10.44.48.188] (unknown [10.44.48.188])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A85A3300019F; Wed,  8 Apr 2026 09:44:49 +0000 (UTC)
Message-ID: <dce8bcba-5806-4d8a-a678-c816b292fb87@redhat.com>
Date: Wed, 8 Apr 2026 11:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Grzegorz Nitka <grzegorz.nitka@intel.com>, netdev@vger.kernel.org
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260402230626.3826719-5-grzegorz.nitka@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260402230626.3826719-5-grzegorz.nitka@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: qy48aukMVew2cl4ikAb7gUNsbg3Yr8fSLDsxq8N93RY_1775641496
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1775641503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVByUgcVRV9cDGwBxu0qdLtCN/YmZ0vWbRv6xHT9zUI=;
 b=NB5wq1qaRbRqY8HA4Y+CJtQwDrA5CClK7RaKavM3IbaBN3RcBRuwA2NE5H9UI+cnKqQE3j
 B/MHblWSO+VGaULR5X4WxqBqEfypCnVCCFM07Y7CXuYw4MH0Qhxr37sFqa2mD+a0YC/ExC
 L3H1ODKU+oO8He9ZiHs3nW/J8vNdMcg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NB5wq1qa
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 4/8] dpll: zl3073x: allow
 SyncE_Ref pin state change
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
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, jiri@resnulli.us,
 edumazet@google.com, przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 donald.hunter@gmail.com, linux-kernel@vger.kernel.org,
 arkadiusz.kubalewski@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Prathosh.Satish@microchip.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 4/3/26 1:06 AM, Grzegorz Nitka wrote:
> The SyncE_Ref pin may operate as either an active or inactive reference
> depending on board design and system configuration. Some platforms need
> to disable the SyncE reference dynamically (e.g., when selecting a
> different recovered clock input). The hardware supports toggling this
> pin, therefore advertise the STATE_CAN_CHANGE capability.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>   drivers/dpll/zl3073x/prop.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978..acd7061a741a 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>   
>   		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
>   
> +	       /*
> +		* The SyncE_Ref pin supports enabling/disabling dynamically.
> +		* Some platforms may choose to expose this through firmware
> +		* configuration later. For now, advertise this capability
> +		* universally since the hardware allows state toggling.
> +		*/
> +		props->dpll_props.capabilities |=
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +
>   		/* The output pin phase adjustment granularity equals half of
>   		 * the synth frequency count.
>   		 */
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

