Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87C8CD5BC8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 May 2026 13:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD2940FED;
	Tue, 26 May 2026 13:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qoj7rUffhMGO; Tue, 26 May 2026 13:28:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F4C440FE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779802080;
	bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yk4crW2HwduDCt8PeDpp19o1aZt4/3RMkGlqyuKJApIncT92oCE8dfhCEEsIyAFwy
	 NVF+5ZCaxB1Hy7BJZedjB+6+tr4ROW8d/l87UemFzBZPCMMg9CoK1KhSuW0SULcz2N
	 5gOzQklAIE5/rARXhN9pp4l/QlI/7JUgsbbh3qF6MXtNpED/uX7jarRsVlARQyRBP+
	 4FybVHRd4VrTa1C5MQD5Domzi8Z429EJj2H7PBqTCP2+/NAV8KM0pbltMlqOMlxeP6
	 I8mOFYODytG9cnIaL46GbpmSxDyYOT+OB44q2k/DvCxQOOvTWWBx1/4ZiPhyfiVl26
	 Q9PkmSckGwFZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F4C440FE3;
	Tue, 26 May 2026 13:28:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3271297
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 13:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B857C40885
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 13:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtUyfJM3ieDK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 May 2026 13:27:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 187B64087B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 187B64087B
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 187B64087B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 13:27:55 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49041e84237so34237485e9.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 06:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779802074; x=1780406874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
 b=QRjTUoo1PVPXr5bpBqEYd3U3g+ZlJHuDY4lKje498/5ar7eLX0wfOfFz9Gp57P3cK0
 JBVyDQkSpuD2GTt9IXLbH18XteU+MaUSUkECeot+C8msFALMmxFdr0hYADvWsdNubQ5r
 CuMoXaF5FLZ2NEhELqozB0trlet3vW/52+BjYas0btBoUaFxzFlIbF/0zsDQULgknFse
 6hmhpZAqlhc/kKpfTCtwAZDwXDc0NXhGreLGxbvUt8nVa7bY/aRM9x0tiqoJvq+j/ZU/
 wj6XbayPdRFQjIuuf6949YGCLSQDZ3aPWqF4f345DoO1O9vGqCaQqBmNLHI4pDBjp7R/
 EIkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Md/jBigDsqCyjzx7drcbY60Kf9NfN5Y7pI1tCA6SNlpZ+m3RheRL6qGWkzuSrHoKa2sW/+/yYr7OAT/0MBDk=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxrUgwSoIkAeX6hvj/NCOIjFjfXBLkS3/aQVd7z4AW6C8LoMKz/
 bWhP+50lhPzFhOKs41b0/4GeBwhnnPUbrNXkj/8SOqG2pmmp4KMV6l68h9YIxci8CPk=
X-Gm-Gg: Acq92OF1LTKiplGebTX4N+vJSucCMUC10SLAd2Caigbuzkad35x90s6+rID3ktT7YSa
 +oldDigrdaZiUuD2A9UYPTdmHqMvVk7eUP5Yi26E/6xiO1XIde8fkEE6+kfntmT+pHhkRJeWXZd
 Oqr0qvvoxG6ok8j5/bDKR9UcHZAoRAKzg+9bY7YUhaBERNLMOCZCknePSTZT95aiorlvdkdzlli
 UWr5hut6jHsAwGeJOxkpenOb33L/vKlOiLq8gkUMTmsIp23PRhN3JbqZBRp/nr4+KClie3QvVna
 pR8hKaR1SvQrZg5Fj3Qs/MCJjeVdn/jYosTFDX6OpAntdNIKN12gc/DZIHnspY+KKqXD5KhYiAa
 Ad8hQRfVElsGfTptYiDH4LFARIg38UtkfPMyi45dtWr5C2QZsUGLG8sbTN3efgrlOIcrvZQG/w1
 MFJvLrrYj+ud1nNv6h9EC9x4dhI3IxvHJbQyA9ITysRLU=
X-Received: by 2002:a05:600d:4448:20b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-490422687c3mr189986545e9.4.1779802073553; 
 Tue, 26 May 2026 06:27:53 -0700 (PDT)
Received: from localhost ([140.209.217.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm330056955e9.0.2026.05.26.06.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:27:53 -0700 (PDT)
Date: Tue, 26 May 2026 15:27:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <ahWf0HAr3sRfXw0Q@FV6GYCPJ69>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-5-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526093419.639220-5-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779802074; x=1780406874;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AF9tJ1amhlOtaGqlNAAzlZV5h8kKDyKt4veK2cMLXSI=;
 b=bk8eIfmpzpxHcvRaBiZBagZlgKFHX20sIxNrAu6bAoLwDYBbmNGFmm9FXKKzyteX0w
 OVZoWlxGx3aimxTLdCVeT6SIoQgkdxalliWaspE8SjDTnNgGnAniPYzpejOaZrYNp88m
 zV+pFHJkJv94WPiudUE/yh21WWHmMzOR3/AKelR68r8CG8oN5Yf4suoLTyselR+N7F2C
 hNbshC6PLUQnQUNbidbpbIsQ9Vz3rAl/940kkxy7kTprfJTJCzNDuJshMUFfg6wDFZFv
 6e2UTkCYqtbwrJxXqYaD5I3EO2AAlzvPcj4aUKyVUGq6Gh8kGMOoaOIOwb1YecLXvka+
 lMDw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20251104.gappssmtp.com
 header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=bk8eIfmp
Subject: Re: [Intel-wired-lan] [PATCH v11 net-next 4/8] dpll: allow fwnode
 pins to attempt state change without capability bit
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

Tue, May 26, 2026 at 11:34:15AM +0200, grzegorz.nitka@intel.com wrote:
>Pins registered with an fwnode may have .state_on_dpll_set implemented
>without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
>Requiring the bit for fwnode pins ties firmware description to driver
>implementation details unnecessarily.
>
>Relax the capability check in dpll_pin_state_set() and
>dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
>the capability gate and let the ops layer decide, returning -EOPNOTSUPP
>if .state_on_dpll_set is absent. Non-fwnode pins retain the original
>strict behavior.
>
>This is used later in the series by the SyncE_Ref output pin, which
>relies on the fwnode path for state control.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
