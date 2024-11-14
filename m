Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AEED6A22D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 Nov 2024 20:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA4A240558;
	Thu, 14 Nov 2024 20:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNWvvlwj_u2F; Thu, 14 Nov 2024 20:49:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA0BB40561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1731617371;
	bh=VzenMFjGmiLUkDNkOxhhX9ZG8CaN7dCVomk6HWyYk3E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEJ9DR0+rsP0fmrHt8QKsUO7RARAli6AwI0JXHlWbLUbwbQi+HUcoSYzYM4OEQNU8
	 35INmuZAWDxPxwZq4SR0tzUmXH8bOWkmlXobbbv1WY6gq/HUzFLtRYiI+/ySpXPIQY
	 lT7o0XNF9bUmY8SoF6kwG2o7mnyhlXH4hheZZf6QNkhQV5kDZnZpu4dvVYRbO8ITk/
	 mefreKjPnLryJ/W5szKUUfFxBXSOshhOthFKpqciW39jbe6cDXcdtg3dnuneYhoAhn
	 2o0qcpSguQVBUXO2hqtF2n+9RANlGeCymgaE9mggGAbABNjSJtRtzsn8a0znQGydrY
	 cfZtT/0JfE/AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA0BB40561;
	Thu, 14 Nov 2024 20:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 063EBBF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Nov 2024 20:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E78F140558
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Nov 2024 20:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZZ4QBGR-BRi for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 Nov 2024 20:49:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E1626404EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1626404EB
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1626404EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Nov 2024 20:49:29 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4609967ab7eso6926161cf.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Nov 2024 12:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617368; x=1732222168;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VzenMFjGmiLUkDNkOxhhX9ZG8CaN7dCVomk6HWyYk3E=;
 b=jV/J8TyFCchy0XYT3vTb/ZhewCPy2mkMDnEV48RweJvxKqYRl/OP0rBazr7tFLYnLI
 Y3e0QesQ0a378WVEYg+Rv8guNh6sejiuqT0ud8AcuS1l6j1OAXU/YnX4I7IFPb4aFBW1
 QpUhmJ3GpIrLwTmmd7pLW9XCKPFBZNdCDbJpiMKpUzmbgGJCzwMfZzDh/HGuofQUJvgX
 Px7OaZtocZpFLAp5X4c4rxKG1z1J8n7SKOTmCxEKIjlz4jc1aJwkRkf7g6Jsu6ln0+gT
 035hskulT98F9Wpo1WCduD+rkdrdETw0J4L0QjyxT3j0XC3rHQsJ7z7dG1yjXQra27Rt
 Dfwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzWyEYCwGyPdCZwBMHYLp9mnFZ3jIRK1lh1jYQVIT8GLZC2T2G2IckzgKZlGKSOr9UKt923F6+i+DjTm9fUrY=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxePW67vlpenvsD8hYh74yf/kyBDORSBprOFUAJg1p491+Xtqty
 WyAFQ9O9RuHfDjSCcEQUoh4QX0yldlvrhp3JxLnhC34LIIyXkGoI
X-Google-Smtp-Source: AGHT+IFjZrZFMHfmtwPufHCrAtncZ868BgfSdkzU4TmreVHdLrdN/XZXvaTBRQMH7iXh110geLUbxg==
X-Received: by 2002:a05:622a:355:b0:460:bb95:5934 with SMTP id
 d75a77b69052e-46363e3d376mr3177471cf.32.1731617368484; 
 Thu, 14 Nov 2024 12:49:28 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca30777sm88473085a.86.2024.11.14.12.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:49:27 -0800 (PST)
Date: Thu, 14 Nov 2024 15:49:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, Milena Olech <milena.olech@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <6736625792e20_3379ce2948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-8-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-8-milena.olech@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731617368; x=1732222168; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzenMFjGmiLUkDNkOxhhX9ZG8CaN7dCVomk6HWyYk3E=;
 b=MPyHwDjOilsp5dfAJdAbxeAt+ZR2Kkh0v8HEcq0eK/J/I3BiojP5Gc3EeDwJRpTMqw
 wwGQyEBcjKmu9nExvJNNFE8FXDmTvL3iKFef7oGJffr1Pf3Nw6WMg+NvVp4G5BJKPhrD
 JT5BBkXdiho777/AYQIQpEbk0+JsQWFtELnVTSMNzpywzirkiN64/1x91tCaWGghHqXG
 WS92y+LfH72YEnTfx4hmHN7PBjunbY+wYISJHknt6kcUV5eASWFwd9R9kGPPuDOyxG6H
 QVs6Ww0WS9CM+W5NXge070wNfSQ4rmSDbEhKL4dVELmazeeWE80cQzf9mlBXYATjRQIM
 dJgw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=MPyHwDjO
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 07/10] idpf: add Tx timestamp
 capabilities negotiation
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

Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

A few minor points. No big concerns from me.

>  struct idpf_vc_xn_manager;
>  
> +#define idpf_for_each_vport(adapter, iter) \
> +	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
> +	     *iter = *__##iter; \
> +	     __##iter < &(adapter)->vports[(adapter)->num_alloc_vports]; \
> +	     iter = *(++__##iter))
> +

Perhaps more readable to just use an int:

    for (int i = 0; iter = &(adapter)->vports[i], i < (adapter)->num_alloc_vports; i++)

>  /**
> @@ -517,6 +524,60 @@ static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
>  	return 0;
>  }
>  
> +/**
> + * idpf_ptp_release_vport_tstamp - Release the Tx timestamps trakcers for a

s/trakcers/trackers

> +/**
> + * struct idpf_ptp_tx_tstamp - Parametrs for Tx timestamping

s/Parametrs/Parameters

> + * @list_member: the list member strutcure

s/strutcure/Structure

Please use a spell checker, don't rely on reviewers.

Also, going forward, IMHO documentation can be limited to APIs and
non-obvious functions/structs/fields.
