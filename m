Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79906606A33F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=E+Joj16A;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF43811F6;
	Tue, 10 Nov 2026 12:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YW-DzbuPrOw; Tue, 10 Nov 2026 12:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D5E48121E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313553;
	b=p8yY+M2aMaGIppJQufpbbhDybEHfOvJ/rtsdN8KXu17T/vr2dS6gbqV8Q3TqWJuEnBb6
	 C/zNXD5rL8ziFRpd23/kcSg53dPp3AgSiRmWceN05w1o9OHfW8tlSoLuss4MGKtOGAnId
	 cLbrucrVRBFdq13aZj+0wxan7m2aVgwK7R2y4YtfmmQCdKTTXxsX+GlzwX9ltle8E8LVy
	 8riVH+/SlJeotbWCtl3tD+nFHl2HZIKw62R7bX6Dvitf++V5HM2SryCg4l47ydIxk2cIj
	 JOpYKwD4pGyy5hT0eGWMBs34/CO39v8XsheG6xqPNRZCwAO1CG/I6NXylsXgf+eLMwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
	b=GgcGdEkZhZGqXkjdpaWx7GWSCTjVO/DWFerL4h+CHno4SpgVMY+a9ANjB3hzSwx6D9J+
	 yqQuDUQ4m6UKDRapfw2Y08gqElvr3fRdsCpkYcvfmK8VLWJjF0XNtCQz8z5IqmEFh4SeA
	 YOg85kcfcu5jboiJO0VniQaterhS7mgaeE7c9xn9mFe4sCxq2L2CF0rZJVoaUsVZcADbb
	 Uac9Plg3c5nuOddYdNPmXDULtBZKHruvdURPRtqRRVRB8oZ+9wtLaL17h0O0jTlo42sNK
	 URyTMQUxv0NGrt+paV9ZykmeU8PvycQsH4EwdGCpVdxRaEWvTjLt/r6DU91lP/nimsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313553;
	bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+Joj16AD4dOZDOfHLS4avx1BgGmzTsc1DzZzqQfyRB9YpRe/1NU3LJX6Um6UI/CE
	 gLGmEqZTe5wa6ei7sQyGvlZxmdqPyLTNaqCWjpvOamqIJYqTplcySK0IPpeFFEZn4c
	 Sd26YUuFuXxtZ/6thHa+ouO0f5yEKGpBNZo4coRmrZEs41Q3x2hZ/UEIJWcHCD5eGA
	 te+sAWWbYb/p6kojAZRpjLLRct7KudammXaGraBcfuwdlTNDjwKbi8S9Fh/TcwCS+u
	 V+SXWjbjIQKVnyn/C1NUl0cwNhOCeUMWGQDdU+Hq3iGiudOKOuB7MtguSJCd9VLXcm
	 0zp3f/osnnz7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D5E48121E;
	Tue, 10 Nov 2026 12:25:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D98D71A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB1D1408E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDbbEdhrRHaT for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00D86408E1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MzqLOvb8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00D86408E1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
 b=MzqLOvb8lzMKMW1vshqfCQkByLNtXRCJKaEia8Q2crJQW2Knbqtj9+1/E9pe2Mz+znk4zC
 32j41XjhFzt/Lyv2NgD5ClyPjjVbw+dLc9AePPcVKKa2KtatBlONOfyRQ4hbPad1oxum71
 qCKg48sCWXsaeDgEycE4xKpIH7xSzrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
 b=MzqLOvb8lzMKMW1vshqfCQkByLNtXRCJKaEia8Q2crJQW2Knbqtj9+1/E9pe2Mz+znk4zC
 32j41XjhFzt/Lyv2NgD5ClyPjjVbw+dLc9AePPcVKKa2KtatBlONOfyRQ4hbPad1oxum71
 qCKg48sCWXsaeDgEycE4xKpIH7xSzrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
 b=MzqLOvb8lzMKMW1vshqfCQkByLNtXRCJKaEia8Q2crJQW2Knbqtj9+1/E9pe2Mz+znk4zC
 32j41XjhFzt/Lyv2NgD5ClyPjjVbw+dLc9AePPcVKKa2KtatBlONOfyRQ4hbPad1oxum71
 qCKg48sCWXsaeDgEycE4xKpIH7xSzrw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-cHkqg-HPNrS4OOU73cz8_A-1; Tue, 10 Nov 2026 07:25:46 -0500
X-MC-Unique: cHkqg-HPNrS4OOU73cz8_A-1
X-Mimecast-MFC-AGG-ID: cHkqg-HPNrS4OOU73cz8_A_1794313546
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-490a0e72578so1273506f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313545; x=1794918345;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
 b=wg43Wdl3xSd4o0Pl1d4z0R7C+dqdfLTc+Xz/4ctjF3ba/vVTNz1TryYv/IIRLaK+R5
 Z/gYjJJvmm2kEwUwDuxTMDSG+JVtreZ1rh1iS4Uk+dQ515MSIP6JewS+sbnkizW8GGwk
 +1X7xoRDpUnPMcDJd8tLqgIh4266wvI7sAcPBv4L9Juy8PBrsUXTTQ1CjhGCtNKYB5D2
 JjqmQcx4AqBZI2LhpUzO3DbDtUG/+RvbmDLTYyUed91pUfhNclerGawPJSRwmFvpBGiM
 6oV9uKxHuA+HsFfNHTomoLlxGlZpF3xWUdyic58eTalwvGkZdOLOpxGQIPu8wB5wFqwb
 kMBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFuPLbRvlMIFxo/wws2+ueOEICxx7NCRdLA+wr2QEORoIONa8IDOzqlUXoRgLcjGDmbEXcUEBR36BYf0Myl31k=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/JeBQ/NbX1uauTs1UILoD0t3P6EHi8b16gh9f0nYl8SsooHGJo
 8tXgumXOVjorOA3VPgKbSjxLA+ePF/B3odVXNN55ccZCq11g5LsaQCMwdjSk64a+m8C8484B07f
 LZ/7tgqGEvZMMufm1jcdqbicTQDD6Pvs1rj84qR174+nSHtlQSwB2Zccpe2ueeskGGaqKbFk=
X-Gm-Gg: AYBFou1n0YtpIcE+JCR12lgZs4Lv379SagAfd2e2wn0QbcmwNeXUA3ePg2Uzp61G/aT
 qrAqbRfAFM/SugtXbdUKN5rrQ3u/PRhpEoLv+9Ge89Kiy2hAW/nym/nxtDNnpAr7ToPY+/taxut
 a+p/qxHnTS52O0Ss8/FkmT/RipcLOxzbLCvxHQjOwHYMySanvsR00z7886dMyqkeSq4vJJzL8RG
 rVG8PkeE2JRJOOSXoLjRK1VX1jQqSC1MvoS5PT2btxWTVPXe5ouLtX8JeGdhGQ+z/tWGZ0+AieT
 Jc+Wi9eJ0wPsfks+4BZswQ3dtvT3k2RlejpuHUyWAt52fxJ/0oU4XPpN3Tpt88qlGMXKOSWUKro
 FWgFSDNYn5/plHwgBtS5EOFFotVQT5r06Uts=
X-Received: by 2002:a05:6000:29d2:b0:498:88f:14c8 with SMTP id
 ffacd0b85a97d-4982fb52546mr2653563f8f.9.1794313545505; 
 Tue, 10 Nov 2026 04:25:45 -0800 (PST)
X-Received: by 2002:a05:6000:29d2:b0:498:88f:14c8 with SMTP id
 ffacd0b85a97d-4982fb52546mr2653511f8f.9.1794313545005; 
 Tue, 10 Nov 2026 04:25:45 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4989a2a505asm3264342f8f.13.2026.11.10.04.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:25:43 -0800 (PST)
Message-ID: <f73146cb-fcbb-4263-90d9-b5378faf30f7@redhat.com>
Date: Tue, 10 Nov 2026 13:25:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] dpll: document locking rules
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-11-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-11-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XDO6ZYtklkZnsQ6NkIOFLIyc12rUKxfNjVUw8lYqxZU_1794313546
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Describe the lock levels of the subsystem, which domain a callback runs
> under and the rules device drivers have to follow.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/driver-api/dpll.rst | 44 +++++++++++++++++++++++++++++++
>   drivers/dpll/dpll_core.c          |  9 +++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index 7c117ae37cc1bc..40d5037ff3bb0f 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
>   
>   More complex example can be found in Intel's ICE driver or nVidia's mlx5 driver.
>   
> +Locking
> +=======
> +
> +The subsystem uses two levels of locks, always taken in this order:
> +
> +- ``dpll_lock`` protects the topology of dpll devices and pins and their
> +  lifetime. Functions changing the topology, for example dpll_pin_register(),
> +  take it for write and send the create and delete notifications under it.
> +  Netlink requests, each part of a dump and change notifications take it for
> +  read for their whole duration.
> +- A domain lock serializes driver callbacks. All dpll devices and pins created
> +  with the same module and ``clock_id`` belong to one domain, in practice to
> +  one chip or card.
> +
> +A netlink request addressing a device or a pin by its ID holds the domain lock
> +of that object from start to end. A notification holds it while its message is
> +built and sent, so messages of one object are sent in the order they were
> +built. Only one domain lock is held at a time, so domains have no lock order,
> +and callbacks of different domains can run concurrently.
> +
> +Callbacks of a dpll device run under the domain of the device. Callbacks of a
> +pin run under the domain of the pin, whichever driver registered them:
> +
> +- A driver registering a pin of another driver with its dpll device has these
> +  callbacks serialized with the driver that created the pin, not with the other
> +  callbacks of its device, so it has to protect the state they share by itself.
> +  A callback stuck in such a registration stops the domain of the pin.
> +- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
> +  dpll devices can belong to another driver, so the callback must not
> +  dereference their private data.
> +- The frequency monitor belongs to the dpll device, so only callbacks of a pin
> +  of the same domain registered with dpll_pin_register() can include
> +  ``.measured_freq_get``.
> +
> +Device drivers have to follow these rules:
> +
> +- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
> +  any function changing the topology.
> +- A callback notifies about objects of the domain it runs under with
> +  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
> +  be notified from a context that holds no domain lock, for example a work item.
> +- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
> +  function changing the topology while holding a lock that its callbacks take.
> +
>   SyncE enablement
>   ================
>   For SyncE enablement it is required to allow control over dpll device
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 84377f8ba16036..6ad40fb9eee855 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -932,6 +932,10 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>    * @ops: ops for a dpll pin ops
>    * @priv: pointer to private information of owner
>    *
> + * The callbacks run under the domain of @pin. If @pin belongs to another domain
> + * than @dpll, they are not serialized with the callbacks of @dpll and @ops must
> + * not include .measured_freq_get.
> + *
>    * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
> @@ -1049,6 +1053,11 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>    * Register a pin with a parent pin, create references between them and
>    * between newly registered pin and dplls connected with a parent pin.
>    *
> + * The callbacks run under the domain of @pin. The parent pin and its dplls can
> + * belong to another driver, so @ops must not dereference their private data.
> + * The frequency monitor belongs to a dpll, so @ops must not include
> + * .measured_freq_get.
> + *
>    * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
Reviewed-by: Petr Oros <poros@redhat.com>

