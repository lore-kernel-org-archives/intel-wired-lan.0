Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD8606A31E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8DsWWlNR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vea5nhuI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E16D64085A;
	Wed, 25 Nov 2026 16:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5paZEjR_I2h; Wed, 25 Nov 2026 16:41:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F5414085D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795624907;
	b=h8dMg1N4bK0laWNgALxpnw1iT4NXYPhH5/Y4dnWgXsV8naDGSl7gUJ0H8lKrTrs4rYSq
	 Ztw+WUUxe6/0IwA3RbQ/cHAZyDWiAKsAWCKYoFO9n4LpevuFYFoS7KIuPswni/0ZIi4co
	 dAT7ytXCRWkjgZTd31J3Z5Evjpy56YTi2VESvFOEaFWD4IUY9WwRqnsC3KupMaMiu80Og
	 ArM+v06W14CG6TLA0OZtu5EVW4jqEKHSfsbMfvw/8cFqioz186CLMCa5IVokmPZZ0ZSA1
	 yYtBY0v+IhjTsEn5GFmEp34AN6as+mAm6aR61A3BgP+a+ImW+CaYEsIu6uXTt9T0Cgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795624907;
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
	bh=IdjfLdJimPGqv/1f4+QLlSY9sA6ngGvkbX0Nb5aeWp0=;
	b=DKW8VPf+S353QvzDRp559+nxQC46pZPDTjzw3HToTilqKGPCLVP7wlXzxJaUrqjr4hXd
	 e/M/1MLFuK1J5YMzPkzRXAJimVRHQiFwvDHIMx2QA3RRgEloRHwkncOZCUCrPxKsoLjpp
	 +jb3+/gDeS+5cCuyk6OG5mfFVxcLwbO8ColSqb18bF3nQgtW/O5OypIDIfxz60MN/HHpn
	 IQwJYcGddgj8QUytczHPU0Vq75ttqq3mx+viYIxmY9Mio6vm7TXKKVWR3Vt3LOwbie4tU
	 GtsSLxD8pZ6I7eEBdSROeY7PWhpzoenMY6oApKXFmSy9FoS2dXeNibv7gUwfqyTR8ag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vea5nhuI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795624907;
	bh=IdjfLdJimPGqv/1f4+QLlSY9sA6ngGvkbX0Nb5aeWp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8DsWWlNROQckADdm6IackjVIz1MI3mRxTs4lyDxZu090JXfHMVhq74zlXfD3JKp4/
	 MNZiN/T3l6fGlFa8qo3eEGOo4nAntGjWFpOgO6HEpuka/XSzPY0swnX//OC75cSApt
	 j1Jtl23StwP7ke+bhY6d9+UmZpHxHsoIunqhw3DqZKNR8gBQ6vu5RLgHkA3eQ5Q+BQ
	 7SCO6pjDWrwpQcb1w2wmo6Ogk14XZ0SpyzjVeVDjJ555YnEZDUG9HzGA4bfsli2QUr
	 kzuShynCyLGdm1PCH92iRSu4s5W54CNgA4nA2jOb3KiuvlAr6MrSvzGcxLVnSkIy0D
	 twFtB3GJHaApw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F5414085D;
	Wed, 25 Nov 2026 16:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A1AE32D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AC994085A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEw-BNHYvweJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 16:41:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 090F240843
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Vea5nhuI
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 090F240843
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795624902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdjfLdJimPGqv/1f4+QLlSY9sA6ngGvkbX0Nb5aeWp0=;
 b=Vea5nhuII0z8VomJ73g78NgXxkPG48hmPWI1/GiIyaxltRquVr/CEFKY+s7dwQ87RKyIon
 qJrU2F5BFGBm1vpMdukPVoJC0Y3aZuz/QXnpjaqH3Ms4Dp8xTAOZaWgJkDlAMXXtPma3Cd
 O4V88sg/wbqE/BfRgkcos9eyfaUXypU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-hNXcFcPmN7qy9bm9EoFn4g-1; Wed,
 25 Nov 2026 16:41:36 +0000
X-MC-Unique: hNXcFcPmN7qy9bm9EoFn4g-1
X-Mimecast-MFC-AGG-ID: hNXcFcPmN7qy9bm9EoFn4g_1795624893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 221811955E96; Wed, 25 Nov 2026 16:41:33 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3CA63001DB3; Wed, 25 Nov 2026 16:41:26 +0000 (UTC)
Message-ID: <cbb7e8b0-1418-4120-abf3-f2b2f35cf585@redhat.com>
Date: Wed, 25 Nov 2026 17:41:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "Oros, Petr" <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
 <20261119133851.3f25074c@kernel.org>
 <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
 <ff8b63b7-b943-444a-bd37-b6fb493b5d9f@linux.dev>
 <awMP9Gj3Xhia0ZeI@FV6GYCPJ69>
 <8dc4f480-a875-4118-b5ee-2c4716ee53bc@redhat.com>
 <MW4PR11MB69845212A048D72C99D3AE079B432@MW4PR11MB6984.namprd11.prod.outlook.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <MW4PR11MB69845212A048D72C99D3AE079B432@MW4PR11MB6984.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YhY39EUrZPXjn-A55cE0VIeHM9DPKuVjeTd5iMOvvGs_1795624893
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 16:56, Kubalewski, Arkadiusz wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>> Sent: Wednesday, November 25, 2026 3:32 PM
>>
>> [...]
>>
>> I fully agree with you guys... I also don't like the way how the ice
>> implemented pin sharing
> 
> Could you elaborate on that?
> 
> Thank you!
> Arkadiusz

Sure. ice uses the API as it was designed, so this is more about the
model than about the driver. To support E825, two series extended the
core so that ice can plug into the objects of another driver:

- "dpll: Core improvements and ice E825-C SyncE support", which I
   posted myself together with your ice patch, added fwnode
   associations, the notifier chain and the MUX pin type in zl3073x,
   so that ice can register its RCLK pins under a zl3073x input pin.
- "dpll/ice: Add generic DPLL type and full TX reference clock control
   for E825" allowed registering a pin found by fwnode with a DPLL of
   another driver, added the notification source ID and let fwnode
   pins attempt a state change without the capability bit, so that ice
   can register zl3073x output pins with its TXC and TSPLL DPLLs. The
   same series also carried five fixes for the on-pin and notification
   paths.

On GNR-D this leads to:

- A pin-get of a zl3073x output pin runs zl3073x callbacks for the pin
   attributes and ice callbacks for the TXC or TSPLL registration, and
   a notification that ice sends for the SyncE pin runs zl3073x
   callbacks from ice context.
- The zl3073x input has to be of type MUX, although the mux is the CGU
   in the E825. The RCLK pins are registered with the zl3073x DPLLs as
   well, and the ice callbacks get the private data of the zl3073x
   parent pin.
- The same pin reports direction output on the zl3073x DPLLs and input
   on the ice DPLLs, and the properties ice fills for it are never
   used, because the zl3073x pin is.
- ice follows the lifetime of the zl3073x pins with references, the
   notifier and a work item that waits for the ice init and drops the
   ice notifications by the source ID.

The RFC keeps every pin with the driver that created it and describes
the board wiring as a static link between two pins, found through the
same fwnode references. ice gets its own pins for the TXC and TSPLL
inputs, and the CGU RCLK muxes become ice DPLL devices with the port
RCLK pins as inputs, whose outputs are linked to the zl3073x inputs.
No callback then sees an object of another driver, and the special
cases above go away.

Thanks,
Ivan

