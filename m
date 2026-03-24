Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5897E9A779
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Mar 2026 12:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B1B88220C;
	Tue, 24 Mar 2026 12:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atyAyvfuqTsP; Tue, 24 Mar 2026 12:31:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1193581EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774355484;
	bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nFcuiWxuX/jCmc3XJrl5dQ9amxJ0BR8Nt7ZgrXCG2J2VpOUf1fBsbOFAcOcX6BSz3
	 OcGIaqysypiiPjPJJ7AL5sF0Ty9In18RsubHzMd5NZlK5Zu3X1H/DC2tgwR7f11Fj+
	 xciSOPo67rMyaVWqTmbrENpL7C4g3wqzexmHZ9ZHy2J/RLk5vIhNr+PtlsYyrGxGNM
	 tL1NHg+SOMZu3rCYoqJyoPXdL/Ww6EyrG9w46mOMduxJqlKoOJpvo/r2X7BOmnoQoc
	 aNT5Mn0WhZwXJjkLmDhNqo+bZ/syfnhixexSxdb6U8FDG5IAJ6lRoTh9i5Pl8996u2
	 YEYHnI+0MRzdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1193581EAC;
	Tue, 24 Mar 2026 12:31:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E8C1353
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 12:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 247C3401EA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 12:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wh63WD52CMxw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Mar 2026 12:31:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 02A5740188
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02A5740188
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02A5740188
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 12:31:21 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so52103755e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 05:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774355480; x=1774960280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
 b=NVIPn6pUy6PiXTanZcN2DsILldhub0XjxUVfgPbiTJLiAuzTtCQVVC66sHDQf5umET
 X4/7Ra/3IoQVSy0NZ2DXCC0E6lFHAty2+vpAUhbNiffoWI5IxO8pr8FpKz+3jbJBYhNo
 8nkFZyXlZyDjH1zxdTKJ3I+CHLK0NF0EZcd5IIitpUf9nJQvom1Wgdt5W3DC7K4SELgl
 6wGiCvNZTEKpxjJnE2bnbcBJG21jNYQXiy7g0S7Gv3T6xmhdlpe8dSj0PCHXPlOuav0s
 dPVoeOx7Fm+bZvPvNoBITW/x2GU9OFMP3YqaOxCocctsLD1oujr1Mql18GYYpiDs9XOW
 FH1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRXsapjlWBxzyjW4MAoAAu5hpR9DUPnBnv5haawq41fnkvvFZlSJay/+cBrT7YCIFF4I7FniCDlyMCGurpSZA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxN7R/U6zMrAZ3UtF7hG3tKxur4S9jNR7XjApHtHnMcswF3N+AG
 dEdnxC9CNwZKKUUtOvQESMLOvn5IxQwqnOGv7xC5FL2a+5uzKmkAUXHIR2xwCmxlFGo=
X-Gm-Gg: ATEYQzw8LJ+/ZV2MoD5H26btTFzAPeuAAKy9jiVdLjRDzdK4z8mcCTZwqr5boh4NQ7K
 TvpyyJE84LVROeMa0TBn5rSXGpPLQnXJjWV8pDaoiIiud2D2uK8V7cextkLFXuMR3s68zZPlsG/
 JceCpZcwN6fyCQIo96H49QDETyykgUuSvkJEITGKQKegbRNp6pv3xdF9L/IKzKHS8+oSoKw5l+T
 FYN9milhgk3opCGVDLDTMb0SruI13ExcwJOZhkNFhHFHVGxtIVA/HYxTulbJiOHqsEMVk88GJ+z
 NHKVPDJGdqohsclbA4v1x/qSgpNZboAAJrZf6wmhwRzbn2OIqSWHDMcsKf5gWk93b1t9MfJQ0J5
 9cz7XwQjwDE7svqa9pY8fEMxpzpJd2Nh4Dd5sNlrfsGatxucXv04+CLA4HUqAlT2Ys4fGjKWDok
 A2zSRUP/l5xlwA4bXNC/bOzLK0AOgS5g89WX1yAszGSgK/DQ==
X-Received: by 2002:a05:600c:8710:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-486fee051camr217093495e9.21.1774355479578; 
 Tue, 24 Mar 2026 05:31:19 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117077cbsm45730395e9.6.2026.03.24.05.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 05:31:19 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:31:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <4h6vp6vzu54okdnckxd52tg6oz3lhf3wy52xfkbluytc3gs6bn@dyu32dx4pnii>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-3-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321222627.1193603-3-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774355480; x=1774960280;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
 b=Glde7VdpGnD5sWrKxiwexyaM7ynByFFObcOQWIEQ1z/8TWOMU475F5Z4Yu5I2J/8ST
 G6BeSNAjMoen9h2zkpB+dndOLKX3gV4sJbK6AAthO5uzlY+4Bx2EQeWZeo1GEC1Mutyj
 MP0NFmSeMWQ8+yiFRNfW8IbkJrbRQ5bxddGpOzcPVfHZutikGfvBsyn7MEnhdbcggGQV
 ZJ8u8j1TCqzny75OSVlBpZoKfo9QAWq832JCuittf7Yhal0XHjncYSzUWa428OUL8eK2
 TCnvHGTRATxRdGL2R+rcWsbQdvEu9od7pn8hsRf4Zj4VlICaA9rcTI5LoIXsWjlR1rIk
 SikA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=Glde7Vdp
Subject: Re: [Intel-wired-lan] [PATCH v2 net-next 2/8] dpll: allow
 registering FW-identified pin with a different DPLL
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

Sat, Mar 21, 2026 at 11:26:21PM +0100, grzegorz.nitka@intel.com wrote:
>Relax the (module, clock_id) equality requirement when registering a
>pin identified by firmware (pin->fwnode). Some platforms associate a
>FW-described pin with a DPLL instance that differs from the pin's
>(module, clock_id) tuple. For such pins, permit registration without
>requiring the strict match. Non-FW pins still require equality.
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
