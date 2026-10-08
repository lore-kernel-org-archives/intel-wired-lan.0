Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE9ECA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7361040B30;
	Thu,  8 Oct 2026 15:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fs0igWif29Er; Thu,  8 Oct 2026 15:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1C9E40B2D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791473590;
	b=h5DFBC4q+YLOk1O8/X5dLAOL7xvoEyHz9Kosy6Q8qWZsDkVFtlzBUJ6b5Mt6yf8kWrBL
	 JCQel1OgfA30EKt6EVqXsPmOACrv1XZAn4C2Zl1ndR3QLwNYOJV0dqJw8B1fSTmJKYqe8
	 vTn3gwxihEOSvg6E7RDE5B/gwbH9s1BZIhet2VGNZW2CyjAgGhERyRj4txmc6hXnXBGxq
	 YB48orVIGqPnNcOxu4Rqu+s1JHkNevZk/IvEKOzFB36ToepGQOeccICVx+6RCU9kxPKyE
	 CXhSbvQJOyV9PeHB/s3E3lPLMJ2Jdni36FvEOZjztwl7n/OJmN1IKxAj7A6rEZf7JDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473590;
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
	bh=ttU+ZNyOzY3hMYN1TpnBNq6GQ4902yzagtLsvIp40h4=;
	b=MQoJ09Q7ku3hg9RuDupqJgof2RUF0gPrtEk2y5L1/whZCNDOOZ5+B84hp7Zo/D5rlsvx
	 PWH5or7eaGiP4HDoWNC4pGXtQE+spCrDn8dJ2NbxftfVd2feNDw9mnkyLR/v8l7eltN0L
	 bNf1/h/VL4LB3GIxsfLTfDjxbDXM0SCT8roWTDI5xWiYIgEehqnidtk918GAnj6aYJ95A
	 GQoHbBXAuKNLmwjYMeOHGDBAYLZ1vU7Z08tzqQKdPeQfExslqZ7ggdrmJNQbYwt38B189
	 6xYm32ublYsS4MA9jqMVHg0R+FStzMxMBS06mERpEjKKougkjdLqpmvkBrayJm6o7KQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473589;
	bh=ttU+ZNyOzY3hMYN1TpnBNq6GQ4902yzagtLsvIp40h4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g5tks3Xvr8503c3YlXX/5c1RZ834U/kt0kmhznEskUkEULyPB2A7nS1oA/b7ej3Tg
	 4sfJDbhNSURK6Z0dkbxAIljMZ512ILcB8alHrinayK2+xLe6BD/mAN3c5E7DoIfQEo
	 V0S6Gtnv03EzkjQRgUo21xL16NG49AY1qZJm6S4Kt4rcJkuSutKnT1dbo57JRMWXkp
	 78mpxJpgbSjYV2q/AIpb2pDBKRkXI5lUs0H+CdZf0QLzHaw5O4qHU/Vnd/aS1cxZ2s
	 EIEH/vptkw7PGlsNbrl+lMGLPjkvD2fANmKojzM+U1F81rBS81MH8wv2AGI6pixtC+
	 PJ8W5lDTlH4bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1C9E40B2D;
	Thu,  8 Oct 2026 15:33:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 451F475
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4243F810DE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrRkCxEu-Q9k for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 15:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 24D37810DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473588;
 b=j9rCIXl8hmyCCMB+PsUuq2KoCpzDl5KZvB+/B20s6hEyb0BG2HLBRrSnIQi5nLCuT++g
 b7XsJnKamTqStOImUxYqYIu7n9Bq5chWLX7O2M/wPTqeQb7PaVLe9n42ILN9s0w9B0q3v
 DUnCZv1vaEqBkfCmLdbiSzqGr2MHrXMfK5uZAW3f55NvG0QV2xoBAIg/fYvuGxBzKz9Va
 5UKQv+9BwLbG6frjaJCilai+DVaSkTr9Uh6rXkiabfLVrERMl+FiO1bT663gtJdc0/wvX
 CK8ta8VNFZI+Fu/j4pWqC5ONV3Jj1nMXTogXAzB8z+xYda2dRfJrJDPPPStqqQd/8gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473588;
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
 bh=ttU+ZNyOzY3hMYN1TpnBNq6GQ4902yzagtLsvIp40h4=;
 b=jagaZSBK3a4ndNmcB7tf9mR9OI22Q1BxPiERh3ZTVQWHbjS0vqCdGIoWdiBMCZGC9yEQ
 UskDF9bp5PlOREIWgOek/BU+59usmQq4ZSE9RuV/jWdCwFE932Idt9w5oslqs4IH0k9dp
 c94wxMUmrd4rpputLjpAIzaA5JSx06nhWQcmvNe+yQEap0rrik0hTN84NkpF5FG2M+dFE
 ki0Ql4j+6WHdx5P249c8RfrbMGxturhKzj5BXFSCXzuPv/maBQgnPnEUTytS809eWqnid
 u4Tv5AibxOnMWDFg9JzOCcaqLFTtI2xj+JVPqbQQ+ELtYHQugoHVS+5oE3RyGZLQ35Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oBLdALih; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=bharath.r@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oBLdALih
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24D37810DD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791473589; x=1823009589;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8Hh8Zh9n+C12NJ+ZR/3sYaxs84U/nTUijkqS9KCYpG4=;
 b=oBLdALihLpDULEelf3ffVmYQmbYoecQDGkLBpb8glg8Sr9D27XC+XZh0
 OpIS+321TqOZJfNQVhZnEzrpGyO+GD19LYPPKSXg1/ojKB5ExAjCfrQIr
 +CUUq7EqUtTZSsBXv9tNZRfyieVdcrFfPl5+2C9yUr1UScfkeQmNG3ard
 9CM66dwsg66GlXez5Bf4CDwJRjYpVEulss78LNRYY6ArHtSZqHKIURRFC
 N1oBQKZitRAPwAT7K0b7ZLN85HmPhNwfelmJeVbmuuaykwLMs8IZ8wXTt
 jbommCypTcIRojKIEC/SeAL0PyPyWZBU1oP3MMvrciOjYSIzh9zUIS05W g==;
X-CSE-ConnectionGUID: unmYjhHPR3iUHGc1B1YCsw==
X-CSE-MsgGUID: /iEf6d8CTayMbWwQPi9O2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="287103"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="287103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 08:32:42 -0700
X-CSE-ConnectionGUID: X8f9yfJySqiTakhQMEygWQ==
X-CSE-MsgGUID: YJT6P5yISz+t+tK37uBuuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="413585"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 08:32:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:32:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 08:32:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbmdzR7ARNHwT4vwTrMQ+wnC4Hu92QAHJfnkO7mB3gRi5Nd10+7bYQuegrQ8yOC8agusD17mTYM0IxLCrCtkX8ghszItwVBXRJzd5KwBDX76sFsKugDUaryPUXiqkV7nS9WCnx3PRuouN1e9LnCQLwAP1mpdpRie6c382IbcglpXoWwKWY5mtEyGwmisrNR34RkVHCr6fcTQaHhdSEBMhW2wbbGumW0qrzHXKhag6Pha0U38ftszlUEVYAxZfQIq++WQuG84RD4Da9o8RJxmphZCRu+x45DiLVlfxk7sN+S5dOkCCPkV8JZ0F83f2DPyHV3u9MeSSUHIpVIsL3xu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttU+ZNyOzY3hMYN1TpnBNq6GQ4902yzagtLsvIp40h4=;
 b=nz0Vq646xxLYOxpo/NQ0jBmBuhd7wZHf3qti9B3RBlHAXc1bdX8QnztM0joSCmjXy9l83mub2oazMVL/dtyi6a0jm1DtNduMKtB5lGQiUTmBK0mcxlOLZMDCoLKOhf2A5Gw6oygLoOzdtTl0YNwQQpT7jzD1+aVN90msEAXVeZpPMpxImspXGulmn/UlA6oukFpnZyR4TaXk3syWqgOW1GAg/jDrDqI/yPxmqyvW+n5MK/J5QHi/1UMZWD3jQxd1wb45oquq60NbvG6xZ2qko8UyZzIFakcbupfwNQDOt7XZZxYlAul8ZfF88a1jHwjeG5yOHHvomD3ZoDCsQ6d6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 15:32:36 +0000
Received: from PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf]) by PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 15:32:35 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
 regions
Thread-Topic: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
 regions
Thread-Index: AQHdQfHX0ljn80Ncyky/8O38RCreI7bz6ymw
Date: Thu, 8 Oct 2026 15:32:35 +0000
Message-ID: <PH7PR11MB8012DC7C8029CC93C16B97FCF7932@PH7PR11MB8012.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8012:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 363cb283-e95c-4f5d-4040-08df255160c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|38070700021|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: J1CzDYwLS6WKB75Ofm5dm+nP5Qk5vpbKBKWZ53E5jqn8LTXKiUQykW6DMARvtJcld6XvT1pXANWX9N1FgrsGOtWurcVpEvBmE5/6gjLh1j/baAGzHDP92opueqEe3UrRRoN3AIj6R+OmIh7U+608M4zSRYwtlYHkw1EPuLWgRltcC2alvvvW4IYkb05M1wIwQWMmz0HlCBt8WLsYeDFiT2CUiJfF6vlzqAPxwdUQEAmcEM6nxyKvJSalq0KjrM2O6OGHqmnySf+GjhgBroNK2d+l9+E1e86VHM3udjDwm895omdEcNrEnGJpFiSzf0wpFFsz5bVcl1A4vNhR6VOBUFprtb884ubV0tFondxDcvLZKYOXkmiku48odbvQc0weWfuZ+r5AXSZSxlxHcOzBJ8EOJYlimi2zxkkjwL8bpsoY0TnMQEUc/4cUHpVgjrH0Pk2YUekZvnO1NrqmIGVAgJ7RsuT2C1EDpXO8sVuNypCNw0cxqtjyKQKD4z8FH0ybK8GOFCglzRKrtYy4L3tZwzKbwQcXJrbsLRLIJnf2Qr4KE3roCh1YZpquPtI0XK8dvCIO3bYpxysh9cABbalFFCaRKZAhWqCCtQAT4gXuO3TC/9KltsMWJhU9Yecu4G4iKMH+5xMTXuiHTyYB4OTXgNMt2JibMwFKL4SwSu/a/WmzEa3XoC+LTXSvkBrQJ5KEFWpERvJ0GKhjrAv+9Kr5og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB8012.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(38070700021)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OpoBH1xVdX/Vpzj4blRdyVNCHToRNYxSAbcib0zhGR4kmZfFkVBy9X6ryyKy?=
 =?us-ascii?Q?BSUYpd932ldlDrZIXs2DVFWMtksps0eHqxeitLzfAgPJd4cBUKBo6+j4PO5+?=
 =?us-ascii?Q?cU7HUMK2gGGnHSxHQpejlLMvVAtL0aA7kmsaCTbDvgMhUpMGoOHIGkelsY6d?=
 =?us-ascii?Q?THowA5CxNWYLi5KJ9zFbW2Rrarsxs9dxCBiG2bIhlrwNg8wgyvgaBx1w/L6H?=
 =?us-ascii?Q?QLu37+qilHXNILUxtSnu3l4Z0fPM77QypRvrZIaIN+9C2bsOlEnZZrowU6S1?=
 =?us-ascii?Q?YSLqJLM014/lkgFZwSZBmTbdBwIfol5UExlPONgt1e3nwNBr4MDxQg5SKumG?=
 =?us-ascii?Q?sBeOAlFMdbr5+sRNoL4nAgREF1IJpWOxH/klun8wkEVOowcg/O7SBb4Brvgw?=
 =?us-ascii?Q?pdqiRYlZQrHWEDAXfABFZvTq5wpKJDNnCbXAkc4B2n11ryp2yA5fNanjGJ8Z?=
 =?us-ascii?Q?xCYDTXzxiJv5JwyP0hTW0X9ygYWGZLUFYxMXGXgBcc0Tm2v561tfVAMTqG8K?=
 =?us-ascii?Q?Uf8J5fMqPVSTr82XjBf0IxDaDG3HX8QBmYAbd6yBGsONu4f9Dm2UpfiC61kU?=
 =?us-ascii?Q?WpPzv/h16rLTdAH55z/4AOr6MNGT5BYS9EeCSyx2v2c5K2qpGiwS67pZ0MQr?=
 =?us-ascii?Q?7aAkXAiVig8+IgHmD0j0qk+Nk/cEgJwRUWapLThthCB4OGgUZ3R1G6XgaKRh?=
 =?us-ascii?Q?2uM9BMfAq4VIi9KGutEfZMTfu1d0VnI6jRxypHd4zzLiO2hmvkJT1AqW/RmQ?=
 =?us-ascii?Q?rRIzqZobViDfhhmxN+p+6gmJZf45IA74kl4A+8TU5InESYx3lMz8U4Cmwvsw?=
 =?us-ascii?Q?2TWHW6Skr3L8foKNxgjVF4NG8kcaEkzzUSjDYRfu7A0Sun8LHMG6GwqwfbIy?=
 =?us-ascii?Q?NInokV4I4UhOoGBaCkVPfw0gIGNE2/WRURybP04JJ1mBPvRgJiQ4zAbCzLDg?=
 =?us-ascii?Q?DZ7g1RGMkMi8e6tytHebRbSd3BwnxUtkthB/N3d66ZlGw5oDcoqvPFIEzyqQ?=
 =?us-ascii?Q?i2KjXKlXx/IYpD0StEh6kyESRJSItoz/QSkU7JwSl+q8FcRM7qCuTNVjV7BL?=
 =?us-ascii?Q?vLx5BNXxcmt+TawVPQgp3Bmy7qMAAmXvMkklNKT9mz5ZCTVXSG72MLaM72l2?=
 =?us-ascii?Q?Pp2gdeXoExE49ygT2mcACIOR07KsoES/hF9ERwiIP/0EFyk9JCJ0AWCtco1d?=
 =?us-ascii?Q?vE5L0jvo1sGdXerAg5ziOUn1ycMufC4m8sO7+sw61EkKBOPIaTwDrDIYpxzw?=
 =?us-ascii?Q?mWyxSFs7kLRxnT3SJi7BW97sQ9ixc17ktTue5qSaQT7PiROY11bU+VNVJvsH?=
 =?us-ascii?Q?aDNBy/jLA3WLY4TbSSeNyE7cUP+wfSCeTuaMFtqrsQXVFG3SN73f4LaJqpNj?=
 =?us-ascii?Q?R//klK26DXrgYcrKmyyabpPHcjgkQRVhmr6lHRBXuO10SXY8+KagM4dy0G0T?=
 =?us-ascii?Q?7rEFJ84W+LZoRTJ8fQYXx8otZlECa+PqPn5V4rJOaDaBhLxliFV66BjaM992?=
 =?us-ascii?Q?EJtouAcdT3DPlrUur7jC+KQdWOMxVjx7+GTvAbbelW+TwNRuvOOXjOHQyJRT?=
 =?us-ascii?Q?kHib6UQHA5DbVWCxaQXhZ5Z08ocl11w9csnlKdwU9d//drhAnWL66S7ZoYf4?=
 =?us-ascii?Q?5s4FeaOnaFnu63wYaMqR0OVRUSa+XaTZjFr9JCX+MSOKhGXvyiNCtgkPn5rv?=
 =?us-ascii?Q?o9U0XxXIIZf9KRf4S7jCKmA053deCwso2SVcZIu7OsAnaTSz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U4eO8By14iGkCtI0grdD3XJt6aC8BAfOJAufTjtEulFTdYFQvnA0zpPZ1UobW853XcEe8wsjkPERxU7qLKHXFRu6c01wCdVEkTnczztZDm6Trj8nZmULY6HjcbO8+kJqkFWgpj/nJoVKaXF7tbjCIdFQdY/1YycYJmj8nKeM6zjvf5U3TerVjrZq8AW27tso2B/GhpY+g6BN5OTr0dCg0xJ+c2wZX4jhEf4bGAYY91cbzQVA/4pFKu8CCZdUipvT5aiD0dsQ4iEiMxHlwAVXDJJj75vhL6qnyIRPl8+TZrZhIdeGFCVqYZ84pidcZvqkTV2EDFmpmnUrDWNFhL2fzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363cb283-e95c-4f5d-4040-08df255160c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 15:32:35.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACs7WfH/YOGgTanYxb1KCm/aH4RQ97zxpAaC2m/VcDjf98QDczyu6E9mI7axYeFBiF64TLMtU+MHpzU8FcwIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
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
> Sent: 11 September 2026 18:19
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
> regions
>=20
> Send and parse get lan memory regions command. Map the regions from the
> command response.
>=20
> It is needed to set number of regions to not zero value even when just se=
nding
> the command. Set it to 1 and add comment about that.
>=20
> It is possible that get lan memory regions isn't supported. Driver should=
 cover
> this situation by mapping regions needed for running.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/ixd.h          |   3 +
>  drivers/net/ethernet/intel/ixd/ixd_main.c     | 131 +++++++++++++++---
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++++++++++-
>  3 files changed, 201 insertions(+), 23 deletions(-)
>=20
Tested-by: Bharath R <bharath.r@intel.com>
