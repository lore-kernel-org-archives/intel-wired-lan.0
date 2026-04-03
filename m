Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05004E7E37B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 11:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2F6D40EFC;
	Fri,  3 Apr 2026 11:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VQjsFertBNo; Fri,  3 Apr 2026 11:54:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E198140EE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775217245;
	bh=/P3PGVnIBtbptqa66WcAt07NfhQIaerWQ7Q/aTRRjCU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vC2cukJf8t4ys3XrpXB2ix8w9GJZ2wDB++50W/8KUgWCrT6xDuvK7ykBX1gPgl7U/
	 /r15IANcmhghwMlJxvWxL2SfKmoth15Qr1cPY7s8Uc3i/eUGjPvoD5bWyPNITyw+8I
	 0rPfP3a6KJX1P4w2vaqqXHsbh2D9kmniE107tHGxpxxABfbL13qyk/NTldaI4hqfUQ
	 gFG3Gc2upQ7Z44Gchk3qKZAX5loPtf7Fz2hjm7I8P+GFY4lXJY/jYJI56FY94pLcMu
	 zhCh0PriJH3iQMhdVcRgmwrOu+VaPQEtgMcNYnka7mT4HO2/fAWh5tpQMpma2WDuQK
	 /8I/LzqggEDKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E198140EE8;
	Fri,  3 Apr 2026 11:54:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15F781F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF8B840EE8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkw5iGFbP-hj for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 11:54:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B4AD940EDE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4AD940EDE
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4AD940EDE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:53:59 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d029f346eso1721766f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 03 Apr 2026 04:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775217238; x=1775822038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/P3PGVnIBtbptqa66WcAt07NfhQIaerWQ7Q/aTRRjCU=;
 b=eXhra/Z+mOX6HHdufngfG+5LwUVEJKnYIGF6HQxjD/XhxJthwGvaoqtXu8KgkmS7uN
 B9Pirxeo9C2NZp10YgHrgrr417gKzhkTHma5EN8M0IXp3VKZq7My3gFR6UpElXt7K0tP
 IQgEtqV4F8oK1waViJhNPjDaa7LLaChFP6l2o9rvw5Bo/Y34t9YXPRNdRVM0a6IMDuiQ
 rGEJMqZGEqpOLScEIcuwYgD37BZRnExWEaKd12OaCBCv5PFg3CScbXYMeolFJmqk2TIp
 4wJSWLNpqhc1NfSepDffdrghHS//3db3hID5K1u8OYogrrM+WeZYT/e1k6b7aQMRBHtD
 t4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9FuYf6qlJS9YCsGcTywv8yU5EPiIqtYfgj6GrSQRTee2li0SUsefoJFf8LpkVEUGNtHWr4MxlNRDAtfDXzsA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwwJUSLguTAWlC4qo2WHjAt5596/FwxMygJn0smQfVMnKCcl0bI
 DUpHrWWj7RwZANGLCAttdU8LPfZIoAGXll97BUIle0JRDTKffUZKt1w0nOpeA6mavt8=
X-Gm-Gg: AeBDiesnnyjmo5BHczzLQMUpqe+tglIPl9eTCQLkQu6bYMtzNVVag+0eQnawTdZIOZH
 lLokx9SfKzDCR95kvEGcvsdBUpeXC/yUtt5tu0lsF4YM/TTh3W/ehoeBJXCHyrUrABTY2Mt/6JO
 B3IB+Yxt6cASMv2qfe22B87UqrZ8EaxH52+cmpHuMY7OdPmnhXrZoGJsMnUKT8FaADLgy3EcyOS
 QOsn76SARMQuaM8kuhqhup3zrevkVq6HNMmqa9vcuMU/7s32PUIV660qQPVrEv49CTNRfdnymIZ
 phwWghNWBpWl/rrWxc+kKbKbZARFN81z6+u0ZIiPuorsA2JpaeNKkOU6SumNKC9HHciO4PNqWEv
 QqZbeZhEjdRlpqDwvphmnpPqjxNefBQMLxH5TmPL79fx5FWBhvVTjpkHBi28nZoAHlgCvj/nrOY
 RyDkLMLeWwLLLlsM/7cx18TYDlXA/NQn+QYObKzZLNXA==
X-Received: by 2002:a05:6000:2586:b0:43b:8f04:2ee1 with SMTP id
 ffacd0b85a97d-43d292daa45mr4482680f8f.27.1775217237109; 
 Fri, 03 Apr 2026 04:53:57 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:dc3:ce9a:4aaa:6bb8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f843dsm14846357f8f.37.2026.04.03.04.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 04:53:56 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:53:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <5wacj2o5m7knwtc7vxws4xct4ogpitrwnmrtvtsdn73blddsql@natpxrbsaske>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260402230626.3826719-4-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402230626.3826719-4-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775217238; x=1775822038;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/P3PGVnIBtbptqa66WcAt07NfhQIaerWQ7Q/aTRRjCU=;
 b=Ov+lgI4vzNInvUvRm/6d5mphQyAc1ngrZOuBHpz5MK821WMkpUDblYXEMzvrfNfFZ8
 4evLQ6xRV489sH00Snevf3k8n0a9ogx1sg1PbBjQEuCF8B7uxsLOfw12P/5lLNkj+R5/
 04xmyK1oZ9gmHDlCiC7gpd6d1TtNSnZm3NXdhLpPno8RA25TBRUe/QvlpbvVzbKodw+D
 i/gXLnHCwe2LL/Di1NBVIF1R2xeRErLoGiK2fuVYLqiyaUd1yKdDv/PUeG79K0rYT0vp
 RpqgP11PMrw7631CfdZjsCsOw11qilNtnbFLGX028NUNze4NKXp7lm7zgLCsXBhRS5Si
 kPkQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20251104.gappssmtp.com
 header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Ov+lgI4v
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 3/8] dpll: extend pin
 notifier and netlink events with notification source ID
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
Cc: ivecera@redhat.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 kuba@kernel.org, vadim.fedorenko@linux.dev, edumazet@google.com,
 netdev@vger.kernel.org, richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fri, Apr 03, 2026 at 01:06:21AM +0200, grzegorz.nitka@intel.com wrote:
>Extend the DPLL pin notification API to include a source identifier
>indicating where the notification originates. This allows notifier
>consumers and netlink listeners to distinguish between notifications
>coming from an associated DPLL instance, a parent pin, or the pin
>itself.
>
>A new field, src_id, is added to struct dpll_pin_notifier_info and is
>passed through all pin-related notification paths. Callers of
>dpll_pin_notify() are updated to provide a meaningful source identifier
>based on their context:
>  - pin registration/unregistration uses the DPLL's clock_id,
>  - pin-on-pin operations use the parent pin's clock_id,
>  - pin changes use the pin's own clock_id.
>
>As introduced in the commit ("dpll: allow registering FW-identified pin
>with a different DPLL"), it is possible to share the same physical pin
>via firmware description (fwnode) with DPLL objects from different
>kernel modules. This means that a given pin can be registered multiple
>times.
>
>Driver such as ICE (E825 devices) rely on this mechanism when listening
>for the event where a shared-fwnode pin appears, while avoiding reacting
>to events triggered by their own registration logic.
>
>This change only extends the notification metadata and does not alter
>existing semantics for drivers that do not use the new field.
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
