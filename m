Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB22606A8A2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XLdB4zry;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD16E40885;
	Wed, 11 Nov 2026 11:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjR4Unnbs23L; Wed, 11 Nov 2026 11:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 237D940A87
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794395272;
	b=O9bAAFC+bb46eFMKRn2Uf/EkM6YZU4dMqY8GZbAgKFFujVTBydhwJ/9JUzjCIGo4XHQR
	 q/GsXoXIrbo7lEFYRYTz68nVY2ikRE4AqYmxLpqdJHITXscYnwmnKHYQ/U760xrS9NKZc
	 C/POAJibhdM37bpNRqbXFvoUHDwxWaPrVPFBqn/psr/0UY9gOeekoURQbffrDoOZvFG0l
	 /rQM1nfzJxsVJNN7Ej/d2QsPs/omivz+4heV3k2C6zec/S4keNmpDM3wXmEoDnNg/izm7
	 A21zO+jNsPbVCc63z7GybC6/ux1C4EF1D6Pq03c056+Bx1F8IdBRU5xYmbvAVgDYytg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794395272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
	b=N/IxCR5v4QsfHlDm8nVU9TMs0BwE55lzLigivXpPbfyw/vY041ofvxirB4bJCixDDsC5
	 3QdJJovnGrVMjquEUsqW5r0oVNGEYvbHM66MHJbseluXJHY4xem8qBGvzL9lkYXKtYN4v
	 ftH4/VNWC6Bx2jyqLiYrrqKfhTZhjMm3hmYgePthVedqgLCVsglmgF1Bq8wabb4pHeQ+r
	 x/f/ol0+CV5zUDA41xGbxxr779tSuFMvqtQD61aVHbh8keoaygUr2yKs60oSwonp27rNK
	 PBuVLxk6BGkHebNVZcg1PqrMAzdZK9s+/KAkz+epxsdGqo/wI62LyIJhytDWqiqu5Tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794395272;
	bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLdB4zryhUb00fjWQMwSyLqn9lpItm+rlOzl7YvlXwaHiu7fU/XKNwbvtYwa+5wdd
	 93C2LwqWeXf+pPq7+GKxPW7xPUc/Nu0Eu4dvc6tJGN6FsQ2w3WT1DiZrI9f3viJMZW
	 GxRG2BlGrcKlll3+hXrFkb2+nd4OChhQuMFlNnbs1DwJ0va8k2RzxIseit9DRD7pdb
	 bZ8F4hCz2Khko0fn/inNxzEUtszxChJ7QnV5dz5IBZPrzQdEQusEKUUGXmiVjG8MK/
	 nK9FTL/ztHwJwU/VzEx951pCw+g32B9URLAdv1cDPq2i0XTb+2xVSfwTlY7j3xcF/R
	 cWItZK3dC87kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 237D940A87;
	Wed, 11 Nov 2026 11:07:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AAFD731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3CFE60796
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85W5HVGQzD_W for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 11:07:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DBE560793
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZYP7LgF; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DZYP7LgF; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DZYP7LgF; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DZYP7LgF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DBE560793
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
 b=DZYP7LgFMTFyL57ped10tlWkvcbRfzYGUIWkcT04LXBDcHH3iS+pTG+U0yyxemBZSwocQM
 Z6+NERh6qP8VfK0QseKESSk+EONYHNKgbXpvJqYVtWYYUJ1sJgYRDZ0C5RsEXEEL4s+zlz
 u1B8N42lIuG0gMppY9v4mPXcHuYVUrM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-J2onJeQLMJ27aPHD_IZPJw-1; Wed,
 11 Nov 2026 06:07:42 -0500
X-MC-Unique: J2onJeQLMJ27aPHD_IZPJw-1
X-Mimecast-MFC-AGG-ID: J2onJeQLMJ27aPHD_IZPJw_1794395259
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E581218005BA; Wed, 11 Nov 2026 11:07:38 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98DE31956087; Wed, 11 Nov 2026 11:07:32 +0000 (UTC)
Message-ID: <10769f32-0570-484b-a518-144fd3bdd4b7@redhat.com>
Date: Wed, 11 Nov 2026 12:07:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] dpll: document locking rules
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
References: <20261106121005.1327603-11-ivecera@redhat.com>
 <179433321053.994134.15233379643090486121@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433321053.994134.15233379643090486121@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: q8iPOUq7kJi_qszs-MCW27inQRcIM0ZZQjS8tGM-Soo_1794395259
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
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
> - [Low] The new Locking section in Documentation/driver-api/dpll.rst
>    covers three cases where a pin callback reaches private data owned by…
> - [Low] The new driver rule in Documentation/driver-api/dpll.rst (lines
>    716-718) says notifications for objects outside the callback's domain…
> 
> --
> 
> dpll: document locking rules
> 
> This commit adds a Locking section to the dpll driver API documentation.
> The section describes the dpll_lock and per-domain lock levels, the domain
> each driver callback runs under, and the rules drivers have to follow. It
> also adds matching notes to the kernel-doc of dpll_pin_register() and
> dpll_pin_on_pin_register().
> 
>> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>> index 7c117ae37cc1b..40d5037ff3bb0 100644
>> --- a/Documentation/driver-api/dpll.rst
>> +++ b/Documentation/driver-api/dpll.rst
>> @@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
> 
> [ ... ]
> 
>> +Callbacks of a dpll device run under the domain of the device. Callbacks of a
>> +pin run under the domain of the pin, whichever driver registered them:
>> +
>> +- A driver registering a pin of another driver with its dpll device has these
>> +  callbacks serialized with the driver that created the pin, not with the other
>> +  callbacks of its device, so it has to protect the state they share by itself.
>> +  A callback stuck in such a registration stops the domain of the pin.
>> +- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
>> +  dpll devices can belong to another driver, so the callback must not
>> +  dereference their private data.
>> +- The frequency monitor belongs to the dpll device, so only callbacks of a pin
>> +  of the same domain registered with dpll_pin_register() can include
>> +  ``.measured_freq_get``.
> 
> [Severity: Low]
> Should reference-sync pairs be in this list too?

[...]
> Could the documentation say whether a ref-sync pair may cross domains, and
> whether ref_sync_pin_priv may be dereferenced? The parent pin case in the
> dpll_pin_on_pin_register() bullet already has an explicit rule like this.

Yes. zl3073x and ice pair only their own input pins, so no in-tree pair
crosses domains. v2 will add a rule that both pins of a reference sync pair
have to belong to one domain, as the ref-sync callbacks of a pin get the
private data of the other one.

[...]

> [Severity: Low]
> Can a driver follow the work item suggestion safely without two more rules?

[...]

> Here the writer waits for the callback's read hold. The work's down_read()
> blocks behind the queued writer, and the callback waits for the work.

Right, and if the work notifies an object of the same domain, it also
waits for the domain lock. v2 will extend the rules to waiting for a work
item that makes these calls.

[...]
> The second rule is about lifetime. The text does not say that the work has
> to be cancelled or flushed before the target pin or device is unregistered
> and released with dpll_pin_put() or dpll_device_put(). __dpll_device_put()
> ends in kfree(dpll). A work item that keeps a struct dpll_device or struct
> dpll_pin pointer and runs after the final put would touch freed memory.

This holds for any work item that keeps a pointer to a refcounted object
and is not about locking, so I would leave it out of this section.

Thanks,
Ivan

