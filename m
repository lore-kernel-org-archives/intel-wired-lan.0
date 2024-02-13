Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C823DC48260
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Feb 2024 08:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7532860B1E;
	Tue, 13 Feb 2024 08:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02NkKR4_r92C; Tue, 13 Feb 2024 08:57:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D633060B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707814641;
	bh=bW1dt+T6JQTnPokjKPW3rVlYQaH4mXXFpQ+tNRxiqS4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=A0nMMS+AoNR+ZWUqB1IbY8gTOchVtaZWg/pVgQWKUPmKEPHHzEFDA3Ww294Owgm/f
	 dbv5a0pCc5FqEp6qQhg12ZaOtNbLTjqV+IL4U6Dvt4Bwq5e3PqbEMApeUCbdOtbivd
	 iPOdspXvC6qWWN9dzIPzQvr4+un/7osHHgOU7zHzf2eAIp8C/p+EoiH9/Gn+EJFiDN
	 Z1JUQAkqD1BXUf2wOIb+iMDJ+vEATb3mD8Z1t6fxjOIJHTAL8NeVm5nW+1fmYTCQfZ
	 R2kEprx1feoTrOwRRT9LjaQUugts/3mv9Qjd/wsAE5VpSGzZ1+JMs+NCnlVSTw+XmF
	 qTX6Hdx7bz2+A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D633060B14;
	Tue, 13 Feb 2024 08:57:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0FEA51BF2C1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Feb 2024 08:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA6C040175
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Feb 2024 08:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgPN8PhohKxE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Feb 2024 08:57:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C714640156
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C714640156
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C714640156
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Feb 2024 08:57:17 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d073b54359so61177531fa.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Feb 2024 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707814636; x=1708419436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW1dt+T6JQTnPokjKPW3rVlYQaH4mXXFpQ+tNRxiqS4=;
 b=NzbH56fIL5iZMnv1h2622DmKn/q8ld8i0FCMeveQj9h6vtHVdgV898vtCe+zA7Mljj
 rMWTPhpD0nKc16qtYL3yLlRh14w12GmES3iYM11SuEKSQB8MTNvmdUz4X86VxyEcCHM4
 70E9S2/pHucmzyjq7/E1imzq7Tt8f+QGqithe5nDVCxQ/JCyURx/Emq1BqcNatIEFdhG
 AcIT/BAbs/ayCJrxbPCKuAcECz7CwSi3Em+4h55O05EPSSRMm8i2pLuEqULuvfXnCg7J
 jwLxblQrQTuC8KvVBCay4/YJmiL2IVhabiFgkVswVL2J7iRsnA02K5wIZNSqqFUJkBYE
 tCDg==
X-Gm-Message-State: AOJu0YwgdHyKm6EZEMGPscxh4tgPWHtbutAqikgxd/GHDq0R0+j3pA8G
 nfPdEq/Uhrifd2CX62br3dhNMYF6+8IdRUBTmBxiFXB+B9Lk2OcbDahS80XGjHk=
X-Google-Smtp-Source: AGHT+IEiGj5S2ovVWIbdLdZuK3lyNH3PdMHYtryg6hdTo07KzO9v2DzkYE+0RaXrmJiAvjHf3lRfYw==
X-Received: by 2002:a2e:9b46:0:b0:2d0:aa06:f496 with SMTP id
 o6-20020a2e9b46000000b002d0aa06f496mr6030909ljj.40.1707814635693; 
 Tue, 13 Feb 2024 00:57:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXPq31U22cxZyWkhgE2kah6HnXzwxy7CfyHR0BoDuaCix8pMg+8vGbDFVTIdMqawyD6eOUCM9aykP2rjJEaJwp9VIEAaw7XsKvNyEiMchk/ttuZmPxvAxPo1UVwcivDV71SrwYDsrsr6VcvdF0ZElSRlROoz2dVsetkdUzwzqO1p4JXjuPynHkNBXj43SZhwm0mY7KRFDDZmRtCR6JQ9VTdG88EQxQFLs+FwqkVPqXdMP4GhFpTAvhq/CN+jObYm+Ti5AGP3PLrA3ZRXcTwX1Doj/Hny7Dsg14OZ2YeyGLX5WhnWj4gRz9O1qTXHQx0l3+SyPHmkycTEiMDX/+MwBFEKZ4eYVDXNPJnZmEmHT4GGkmxtFbOE6O3KU06ftD7m8yttJG/QaZgQ+mxffKUnqZGjiCX
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c310800b00410cfc34260sm5732576wmo.2.2024.02.13.00.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:57:15 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <Zcsu6MCX-XkS8bki@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707814636; x=1708419436;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bW1dt+T6JQTnPokjKPW3rVlYQaH4mXXFpQ+tNRxiqS4=;
 b=CUazqWUZj72JvXQ44ecPixF0iKJ0RHi60FyNG5kiD4DdyfAgkntlsDIuHh+L1mU2CF
 CDkjMXmkLD8eQj/7XEt1Sg5f1ipN/+j2Y94b+x5PCzs0AGEosL+ijCk3Zq7fJ8RgV7YV
 RG+F6UMZWvR523VfCD+plCz3aXi70Sz6J6UaFbV+rGnVSSFCMysHNUFkB30Jr9ccFlvk
 LopfnoLk7KSu5FOe7MujcLcnQi5o+t/radP2SIVH8SR0NHaiLV92lqNwSb9ntHMQqNjK
 qzXMU+w904MCO3SyL1MgDFK2Z1nkunxecGjOAXUv4DGYqHbzf87Ynze2CzCEkublSFR4
 cHiQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=CUazqWUZ
Subject: Re: [Intel-wired-lan] [iwl-next v1 06/15] ice: add subfunction aux
 driver support
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
Cc: maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
 michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, Piotr Raczynski <piotr.raczynski@intel.com>,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Tue, Feb 13, 2024 at 08:27:15AM CET, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Instead of only registering devlink port by the ice driver itself,
>let PF driver only register port representor for a given subfunction.
>Then, aux driver is supposed to register its own devlink instance and
>register virtual devlink port.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
> .../intel/ice/devlink/ice_devlink_port.h      |   6 +
> drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
> drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
> 7 files changed, 302 insertions(+), 31 deletions(-)

Could you please split this. I see that you can push out 1-3 patches as
preparation.
