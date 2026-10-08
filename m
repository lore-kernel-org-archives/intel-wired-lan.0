Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808CDCA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34E4A81135;
	Thu,  8 Oct 2026 21:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uwmb5XECtbJ7; Thu,  8 Oct 2026 21:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F96081192
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494649;
	b=X4ZDTP7JdZDvtm78CBR1T7IldSKwMyh3Di2F6bOYfQ2HAxrc4Rz95nDvxdFwElxSxANW
	 jRcDgh6P5q57/fhe88GFNhT62AESHxzT9+l+wxdIZZZcPaNfgCngk1qiSVy+2DbkopBF1
	 RGXkIQIvAgKElTXz2nFuPeqfqBqUNisPGEOfucqt+BXebrx1lbd8RYwY6GGxYmn6Jr04A
	 ajyO+eRdDzpsoc+l+BvkAJvQwZeMtH3ix0h6iVz3YsramKvJzr8B+xBJ4nLvecXOQfNXW
	 ORnOoL12+1B0wo1LeQyLFKCENf/br9oH7M/uZNj7uDyazNkJc0ahnqSRIkE0OEpNYaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
	b=SBBURwW1BXH+czPWZwMfvRhWDn+gPTvpPpxqgnT1lubWjVWFo47kQMfkwqSa+aQBrF9t
	 KwhQUsYGKYbDplMezi7bRM7Ms+d05FEW1BF4MxrtK2bLpN3xSDzAxnlZPKmTO4i5gJAYR
	 7JOXaEQ814tNKr3dgZ+11Ufa7ohdMVjSgS7jHAIV82kNiND7RPL4p0c/C3HiYLmF51PWP
	 a+Ge70xGqYIHhxp++gAOlr6FzAZJMKFcVsxqCFM/MBkOhaLmv0nK3lORQhVOKShW7Eoi5
	 1ALZvNDOpyQjz1coTj+16+3UofkGpwBXXoH37ocQUdC4V8C+/7JfbIJAzBvUbnMoOpQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dqhFRGSz;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494649;
	bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1DRd9Ubq89sT5xKL5HKFtEk/MygM4npI78PQPFARce6jyMicg7qPGzE3TgHhFHhG
	 SxXxGSUrw0RKvpIBBno/ztPS6dVZWS4v5Y76PIvaXGH2b1GxSsDtbwmuq3whUO9vS+
	 0ocRUK8xbW3h+pVoxhXj4iJ7nOl0ufKuI+OwUUDBcRjDZfy8VHcVYSsWFtxOx/+52x
	 N+UYhL+nmA/xjBi9DHo/2D9F0nWgCSVnZ4DimMIK+o7xUyqUMBRSfLpvXreyqkRhid
	 78ze+4TnzInbpJv7X3OW+2bh4hsFIaNzpSChYQrg4UAG5daLtnwHMkxSA+geRRMDiY
	 CIkmE0gFyS9DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F96081192;
	Thu,  8 Oct 2026 21:24:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 165F1156
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07D698137D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kREloM6XImmW for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08ABD81135
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494647;
 b=WpQq/zq/ds4EIDhIlISpZEIEr3gb/mi5b5oKnrLPqhgqXSJ3iYb8nXjfuf4uMRSOiOMn
 DQxFBRWs+5VIYqs6zqmfnO7qnYNhGJzSP1eGswbXmbedt6pQrO6l7ZGVY3w0AEckcf9AQ
 U4jhoB5QCRhJ2/CkrVPvz4Mn5m1fOMkiCAQhmCvy07SHJ9eefmidoqgGdPWWDE7Gp0NEp
 zdgvCwX7nRrELCO4ZjGQda1H9RORW450qtPbo4FcM6L/45e3SpltIaRZM8fu9+lctHfuo
 0O6OQqMGBnaS0GojFXgHv8DELtyhGu1taS7RgZ4CssMp2UgNmetY87Xl+Gg7PpN+ZCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494647;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
 b=X53dgfagsbjlsJQ9Fe+y1Ku00Dk0bhwICSAUhS0Dx+So7q6ghUE48LXWfR88Ryfuev6l
 XoItwSDuQTWhO3zV1fdLMwM//KcDsQlIjjUhxEaqKwxjSIsa/PqWARUrv4KCrDxSjJfeE
 uojQpCoE1x+00lI8+65+cT0BP9GKKeDXI/l9/rLDd6QVCanxFjNsR6R2ai5GxXrrA2MuQ
 WMVTvvIAom6AHIHpI62Bt9iORThXobh2nKCHs3OdGnGYz2ihtEjjCv7U7qpMiw74gHUx5
 QOniXJhoaVFZB/lG7BsJXJFjj3iDKqKU+gdXLfPTn23i34V441rvHZnVXswFhjuzjyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dqhFRGSz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dqhFRGSz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08ABD81135
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494648; x=1823030648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
 b=dqhFRGSzsoK4e7UCQnhhif0uE4pEhokDOmizDqlilotcTd0miQq6uWx7
 OTr+n7M+hBCNTJzfCtzC8lzPpQmTkm2wGcomJBJM+ZW1MSlg/3wTUUkXn
 MGDFuaCCXVjy8nBIHbloGBqlgB0XoTr3Uj5iHTLunQLzxiYZ6UP40g+7T
 fbdKDyTl88PAbZKyC5pz9CmQ3Hmp4NruyOgs28yxedzvaaJFc/QDJIiuh
 64IJjl9XChoK88RJ+HCAm6m2YnaH/Dc1FihRtfiv1orBkMfNVuu29BBpo
 KqWloimgW85QzixR4ViJC495eAzYnEvQk4JcF6onFhrxdk4ZFQBR7ZKuL A==;
X-CSE-ConnectionGUID: xv4cGWJdQy+dsfmTYtlTzQ==
X-CSE-MsgGUID: +L1JM9PGRT2Eiud/RnIWdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="286570"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="286570"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:24:06 -0700
X-CSE-ConnectionGUID: M4kOd/nORcSdKJb+jOGA6w==
X-CSE-MsgGUID: P/wGSFH5SHyRC7G4qie3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="511935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:24:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:24:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs7hxAuYA87Jh8yRirME0NBKmjrgl822DV1Li9CNjZtckb2CamrQQTxGk2BsoSKfpi0ZVPewhz4viRWW8ZsgdLeRXMl3vflBFiLbnKUWcCYv6WKi6HlqXQYB2Ux4xqA2/C+qgebdYQrFqaoeunYfvUBPy3e+RHqlQt27BlIxpqiTS/zvZZcVsB789TG/nDJicMEFTMzdJZIaCYMsxP+Y9J5mcsNTxG0F2imUbzFPYlLVypngp8AaHWhG+faqIoCSTxEXqTgsYogg4cRtj8w4FpwESY/nZNR4IFXEkLOjP6WoteBlT5nUDDwmJIHnpcLCXtIgQnSB0cK5mGv+HSLldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
 b=tOBeOS0O9/8B0azBQxTpb6J2hQBIf+TWVwYLPcf9IzqxHiAk8vtxbgybAjvuvFCIAshF8Xyhjy99ZUwpLlYnQVokOObx4OM4YSzK03pKa7bEqa6kiylORl+WoX8+6iu0BPw0YpwL2dWfGoSUlqsX1taAET41FAX92GxApHjy/AaM0rhQxEXEyC5aseEiFsa3LAfemjOq9TcgNX5njbiHByxHYZnnZDuml1Tc1ikgI+wf3M8b6IMAyVVKl+XywkaWvGM5728g4ay4CB6yQ+Ru8QYMt8vsQiAVQGTiOjLnqIlqwZXm/nqAkIQs8vwmVcUV6w9+0qMKwEiGI6iO3V6ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Thu, 8 Oct 2026 21:23:58 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:23:57 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
Thread-Topic: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
Thread-Index: AQHdQfHZSqocsuXbt0KzravpLk5fh7b0UoIA
Date: Thu, 8 Oct 2026 21:23:57 +0000
Message-ID: <DS0PR11MB64228770313658AAB57D3B749B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|PH0PR11MB4982:EE_
x-ms-office365-filtering-correlation-id: 249fa496-bd3e-45ac-a62a-08df25827694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|38070700021|4143699003|6133799003|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: EZazb5smhd40Pzsa8cffU1WrmVDFcR22gY0n4ZGlKjN9XBw2G7csF+JMVTwCj6GMgOQQDU7ppoxEcUaQPNbXl2hMz0x5A9glR3CkXQKQDZc4Ng9qyFvlGJzvDQ1W52vidXuoBTzTgyR6PhepNGmBd6JbXtB3TCy8ZZk5alJlkHLeaxqWK85UdeSHRUsqF2R7IAOEP+7MXLvOQZGOZFbuV7vlnjYGZhvNk+XQwPhsY0+siZrNvu5I9vP7VCXykrh6LV3P2lgvjI5z4tQsbQa90xKbQRBiWEsyXb+gBBk6rDo9D9Iuwjia1dg8o/ra0OBhBywHpkkPn6AEG/9elrotATA+evtmTyizZxV0BYKOHt2hd3x8CW8iWzWoevqh6GEygfJ63A+PQy2a1hG1scm0RvKsHxnMaeGokNisUIhJH23Ch1Nvb9yYkr9v7NA2qtv1FM9qyZEHrVKKYeqwi2szEvxpYgW7HcPt8QEk8t9ugibs6zhtB+N5sEhwlLrkvFOS+b/xYJZdRJO6I3CyRNCawwDpuT3PrNFfUruCfrf3hYjt96sCqs5SSrc8CkfYlNG0A6HZPTZRuOn0+TMF/KJDzK1E2rtQPH9a/1jWV+MbwCJZB+PJtf6Qdo0yAVFLeDeyqRV0twyy/5IjAY17o6McpOmC8sapf8iKX8NIBIGhMiEgS4HGxUjw7OueswFhvSyXS4q36wGxsz3WIXGVl+Wv9q8iAhvuRHx+9Ts07vCwtaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a94Ce+CUR1ff+3VsyV8K24Vo/oyBdE5Dun0uzxFsLc9T2Uqza6GU4Fr5ac4J?=
 =?us-ascii?Q?PJ+nQsqPYsfjB3JTwmgww3civwk0IjDTEipMtViDQlwS28YdPZHGAfudp3v4?=
 =?us-ascii?Q?/ST4gGcbMQ0YMhRJoEaDf3W6czn/CiJ77DQ5garhyC/NUp2ECq7JauC531mb?=
 =?us-ascii?Q?5FKe0DE0RDxjjxiwAV1GShyJzbRS2A4Ecq9ixBsXFksltmj2pPa7bH/uD2dE?=
 =?us-ascii?Q?Zemcj6bjcrt9l+g/+qqz3dx85VptRTMFPMlw+q42LxjOdWP2CSrQbbaOvumt?=
 =?us-ascii?Q?iSkn8KKUeXgAsDRI743loQ9tWh8s2+HPgjypfPz2e5XIj03b9VnkoZi2OmwR?=
 =?us-ascii?Q?whu7X2cwUlptSKk7kFhm7UTJr0o5XkiXRVSXIiBlAfa8Fo7INU/rLYPymkCo?=
 =?us-ascii?Q?JAFWryx4z/Mz40cNF0PujKr5MZtI8PadZ8yVtl1Of4aBAeCxaNC1yjxK3y88?=
 =?us-ascii?Q?gB5Ur2tIXd8zEfWpVYDqZ9SU22xGkem0lKZ0d/+IA+Zl0jV1VV/XevF4szIF?=
 =?us-ascii?Q?4YPsLur41/6gLMdZurl23htkiiY7qqeEKAR697C4Jzm+CJL3YV3f6BXES7SQ?=
 =?us-ascii?Q?5JwwMNeals7PVnq6ZgI9wO5s6hP/8lB/xPPLaL6NDWZzPRmKQZ9BqpeidgqY?=
 =?us-ascii?Q?mse05wASSA3QvLI/I2mxFj37GxG8u2k56u27oaiUtfxefrcW4WZoRd5xE9jc?=
 =?us-ascii?Q?0ztZa8Y+91suJNB3HQgzP3Ae4ipBzseD3lzuW3rrwwnghTPnqIyd6hGKmj3s?=
 =?us-ascii?Q?K2KmuU/b9qlDPTJj8nM1qNjKWwyYq1ikxdyTG/qN/jPY464LBTr3fCv5dPA2?=
 =?us-ascii?Q?53nn3cHpPiFTUPzawwvdeX5lQ5dnghThpl1ZhOWsqXIcmvW2iTKZffrt7jsP?=
 =?us-ascii?Q?ylxzeqScXVgdEjmBSgBrK2/yagFjRm2LcGH0DOuVKzXmtVSDu5hkoMMUXEhS?=
 =?us-ascii?Q?zF7aaqHK/qTyMzI1sTwuE+DYA5VblfvjImwisjKP8T5J06YjTJJ1xkqZie8i?=
 =?us-ascii?Q?uqkcrBR9fWrsoZJup9MonQQeQ11CCrKFk0ayV4MqLeim++8evw5K3E8OLpe/?=
 =?us-ascii?Q?zKHCCqY8vwcO/YS2IQ3CLJogdEzhn27tXWvNKOg7JNpPgaM7hffAyTaj7InF?=
 =?us-ascii?Q?qxn/uKgSb0yjDKs2UYnBaCbBuGZZ0NgrBr8SbQDM1nlTB2RzkoKCftXVY1wn?=
 =?us-ascii?Q?OhU+bNcYg90kstqT1lzRGR7t1CzOGzhWPcM4j08Wf2rGRCNEhHaLuDLUah0c?=
 =?us-ascii?Q?Ke0kJaHNO5KXYJGKkSy8zgOhF/12gIHVTfP5U3ct9eSHHGmAC+YKbJvwWXcs?=
 =?us-ascii?Q?/HgJ0xK2lmkJPQT4mj3rS4H4m82Qg5DZu86CMXe4Hsi4qnElSH2fPPKs8fvn?=
 =?us-ascii?Q?ZYFMytyUQGfYEloVVUqeY5rwjPko0lCBQX4o3Pwp+q/+30Iebz3bxEC6Jq/M?=
 =?us-ascii?Q?CRTiS9lk6H/zLyzWcYiMp1XSEn+1zDlfnIDcuxbmJ/NFNBxfYWnHAFeaSkmH?=
 =?us-ascii?Q?GPgBSlGz+guEiY+xCJYXtAi7gueCIr/fP7BOtNLUDdxC69WQyS/IRHtXjdiO?=
 =?us-ascii?Q?tg+S3w290NjuW/aH4n5g28nc5YtxKyPVdapjIvvM+g8QZLKUO3ymMG3A6xri?=
 =?us-ascii?Q?OgZMYEGMvp7hLuqB2Co/ieYQaX3LkiDGrdDVBFKbP42AmbOdjj9k2LBf5z69?=
 =?us-ascii?Q?rDcsnuJR6K7GxKctA4S3+xgW1MTTITxGveRSWBTEbvteZBvFtKzV0nK8HPTA?=
 =?us-ascii?Q?RJDxbJu7mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sEaGQsCdtVBMFDq6oEC8270sxg2eMkoIz5krI/xnajmpMW71a/sHNoOx4EyOKvX+/Bep3ZvlP5vC4csWWbQDpkVKfCLY2sAs3hbqF6xdWZmYZbR5RyL1P49VonuEE+/Q1++iS2+OVgryJc5BMFuxarPnnnWCRhk8NANu2iJTk+sCkyHCr9eUg0PKNrePXNsWgTKYKekT0OSlHFvSzNJI0fGv2Z5Xdb8gT2llDlduLTaB9i66RuE9NOWdcSYD3uB99ta1fzYUjIUn6MsSjELETIySb8sUfTQCMDDGMFoydb0OK3MFKgMPZpWEqUt67Gs9zmSsuMoWEVJIc9IJZpJUFg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fa496-bd3e-45ac-a62a-08df25827694
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:23:57.4827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENLKK40PkGdCMHjRAvu6rbOzMouJJyBHyfDUUcoBnDQ/EDW7FNs2fB+aLm8FyPJ+HCk4a0VEPx02Afi5h4oD3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com
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

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
>=20
> Currently hardware vectors information (registers address and HW indexes)=
 is
> stored in virtchnl command. When this information is needed they are pars=
ed
> and returned. There is a need for alloc/free array for this information e=
ach time
> it is called.
>=20
> Information about indexes and registers are parsed in two similar functio=
ns.
> Create one parse function for both and store it in irq_info structure to =
use
> whenever it is needed.
>=20
> Stored virtchnl command still has to exist, because it is used when sendi=
ng
> dealloc message.
>=20
> Make intr_reg_init() functions (for VF and PF) return void to simplify co=
de.
> With stored irq information there is no need to alloc an array for it, so=
 these
> functions can't fail.
>=20
> Previously mailbox vector wasn't filled in idpf_intr_reg_init() function.=
 Store
> the mailbox information in irq_info.vectors to have everything in one pla=
ce.
> Because of that tweak index in few places by adding IDPF_MBX_Q_VEC (when
> allocatig or iterrating) or not substracting IDPF_MBX_Q_VEC from
> q_vector_idxs, because it is no needed now.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>
