Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636BCCA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 17:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 169D76075F;
	Mon,  5 Oct 2026 17:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oN8Nk8GgcAUW; Mon,  5 Oct 2026 17:56:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B03D60761
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791222998;
	b=qdTWICcFKqD4xdrLxAoNYIiDtG9qNAMaE2N39j98p7y+yMtzHhLgnjHzDOD9swLVt0Ns
	 lYTKR8/IoUXT7FcQiT+juwAIwHx8TouYUBO++i5QhuMkRVp2+Hur9b9sLnNxtPL8k0Hns
	 Z2Xki/NbjX1MsuBPaHtvLpi6QCci2IZGy2LowIRgqBJmeQ7sp4jZQ8sI/m6VOIhfhn0Ln
	 7VKIhQ8WWCloZj9ts4Ynqkks+dVY4fEfx/cu6LahmuwWBUu9cSn35B/vYHtM561QzQ1DB
	 6YwqDLZPhPRPrfYM4G61ALHb7R7g7ZsFZ8UEIsn9FtK49ly9sUAZbLhYpehIBXpJO9g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791222998;
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
	bh=gN6aIUvHweO4QmMx0a6phIF2w28IjJxPaH8M3t00u6o=;
	b=OSyabk4nfY3F6D3cXQIkzV37rPBiGex7+WcW8EH6+yivz08O3juM6dW2/qhphWGJrUeA
	 KyVycsJ3/yecX6VYap1RlcjzHpI7WcrT35AYDjeKy8b0OdK+eJ7yLgIjf7gJBW5OX9Xqz
	 X1JIWQZxlrxqO4KjRQrUdH5dL4ok79cfXUYWE93lVf4DboojKqmINKhfFP2KJWBRa+ttx
	 VZ0BEd7HDexyDJqi73nzvpLHM9CZWsqVMDdy43dun7vpPUvC6giHuS2tninHxLb4gXrOJ
	 rcEEBXmxGqi4/rmbi4SKpViUQPteaN/B1PjtPenUE8rw397j/LY3PkZLpYDoj1JCEyw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791222998;
	bh=gN6aIUvHweO4QmMx0a6phIF2w28IjJxPaH8M3t00u6o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r84Z6P8bRhP7tJGC35pOwFooDRco6hMl9ypFFFR93iKp7Exs7Mhuc+t/1r2TsKwRP
	 UE086iktnr3xfTyQ8Je4q1MEF40UaVeaWKmzY618ncMdJPoW1UZHBz9QXOLT223Aqb
	 +AF29cq+z/oJBbDjQPttDN1bQ+6aFuLLKzQHDkXBoU/N8p3Vq6Uj9MtqC360UUCXL3
	 LNLHQDc7hsnX0vHs5NFBmeUXekih5aZrsVbh4zp9Ar7WJBK7IenszdQstpXXymWCOC
	 kV1B+HP4knE86wGhLuRIky4EHj7hgOvshktndb5jNUNt2Xqkgbd9aAJtxOyW05wYVI
	 xCFP2gvDn2Mow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B03D60761;
	Mon,  5 Oct 2026 17:56:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B23E21A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A339E80C53
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9XtScaOEi15 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 17:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5686580C41
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791222066;
 b=pb5eFC/i2s5ccovDBCuYYNODW8NcyRdpRrlYbTDEmbPs/0lT7+Eu8V5v96jsAPOtARw5
 YWC62dhnZlKmWF4zPV0xnFTZM/njGbhz7yY6gyejbHEnZwV0JRYH0J7JdSu2qaXHV6LcK
 Saev1yUAW0RuB0abgGUvyi/A97epyh3Yh1PPELltQ8i0ClB8ZKuz9TPVLRcwGAyoLt8ey
 /clO8pstmnM3gYFLDFGK743N/Z1cFQ2ieNgbYsd1CE+rRuRZ5BUbR/ZCTTsk4806kwwHk
 vCp7pcPSFQVgIk8mrilAtvL8tg+tWrL2y7a1JhofLPQVtov2x9Oyr0MUMaipdfkE1xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791222066;
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
 bh=gN6aIUvHweO4QmMx0a6phIF2w28IjJxPaH8M3t00u6o=;
 b=iLRnNVjWG1hNUjNeTLqrDZreDgb+1tWccjrJ8VU392tQDDNwogbpyeTNSebwzFFtKZ8v
 RJSWVVZsXvluDBC/KbJAUA+WGv3QMMlgIscQpN+XSoCSn5g/Wxm+iT7quK4OabAE/8omn
 W/QdXn+8hLWyztGWuBBQ0ZL8cBtiwatQTeVzcwfBNyYKXjJzfvjqmnzRxGvuPVdLli3+o
 iluneiq94ccc0vS7vNnJDCdVG0ziVmnfdmcnrnBpa8QVDsnmqYdD6nsjIyRjeSeQYPlpP
 H+bKjWa3tKrBejmLRyO2X9c+E4C1h0IBzlVgDMEX63Fw32ZLwpH6iwM8mlN7oBBSzYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WNLP9V5F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WNLP9V5F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5686580C41
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791222066; x=1822758066;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xIFslpommQyhS6XAcQcPs5kMdsn1+FzyAp9jMVIyFHo=;
 b=WNLP9V5FSXKUe/dJqeSbM1BGy3KfGZ9TPjDB4NkDVgxyJ3WZ2/abGF4w
 WTTYjtytDaWgLkwnM8JhAeSeNc+4pbzdIuE3nkbI0DYM0cTLA+EWJTZQK
 zXrBH1GFxjE9wUZrWHj6bc9r4QWL9Af+guja4FwaXiOFYLWybUZIcJTIz
 fwtjeAgi51Vt1yHZ46MeGLpSwRYX2yZE1aoK2H8ZGpB7W9o9TAR4veGY1
 QXlSqODcIZaTBuYS08ctUdHDTiACwNlULj5Yrf4KA6uSTMUilTq9Lizyl
 i5+0dUrCA3c+TzmG6LHEHaZoCIcdmQcbBngxPyc01NWpyCKhlNHhooX58 w==;
X-CSE-ConnectionGUID: 5XRIRzZoR0WNC2BEDVnBhA==
X-CSE-MsgGUID: rlc1oz8NTFSPaHy4WlOtiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102063602"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="102063602"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:41:05 -0700
X-CSE-ConnectionGUID: OrIjJLEGR+22OsgWXMkFTA==
X-CSE-MsgGUID: 0NeS57AdTtKEm5datuIOgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="936101"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 10:41:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:41:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 10:41:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 10:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeK9hZ+hSck3h1fyJE7nB0uvYBRw5X196TsVXw1/TQ0dxoMUqM7Vm/tBYP8Te6jMwfuhTdu2jodqVnvyCsjWLCfqKg0b0sdR02msuBeYgdS4prUGj6uxAYkjKV8QBddBMsSTRixMNZP89ZiemQa0AuhOTK6mDOnKDlok6DA/Kq2mTScy/4WMJIwGYpBFJmdblxAiOQBmKAXE1x6aDOyD0WWyTWbr3eK5ihC2v22A+2gKmgK7m0J9Avr57ArKXvBQgDi18VgkjFc0rSD0rQabTCryFZ0j4DH1Qx9fY0rnfmCXb/P3+koaR6Z0934y6PHLr2KfiIuzVsk0FG10dYlf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN6aIUvHweO4QmMx0a6phIF2w28IjJxPaH8M3t00u6o=;
 b=XnlSPLoMlBrMuhMYJc5WnFYOKg0l8pIO60VnucseMTn5ibMwe04POIt2WVVxcTLZ/1qJ4A4rFgGQYM9HX1sNOM5NkicjKiUrl9t8yIF3td1Yj9YVAIJglGmVgMtbPwh2RYdCxl+0xzjx6ULIaOq5Vv2CX2gbJBcBuHRpSZ5dP7xTay3KwpajHOJR1nVKqjrrQwSVcb1/2RppTiGrcLtO1f6JvXdkZOY1RVS8lbM5e4O+LEc8pMLP2nrSg64JCuv7Tucqzy2TxELbh4BOBc2Ct+SobHnXoW2cAMBV2MPGlXRGAUqEStcDXsCmEiZiBeOdVtd1R6CeV9VdoLx+VoEusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Mon, 5 Oct 2026 17:41:01 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:41:01 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
 <paul.greenwalt@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/3] idpf: add devlink info
 support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/3] idpf: add devlink info
 support
Thread-Index: AQHdLFUevSLDDYXIrk+1WNroZEpybbbviIHg
Date: Mon, 5 Oct 2026 17:41:00 +0000
Message-ID: <DS0PR11MB6422611948B667EAE9C6B8DB9B962@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
 <20260814174919.4177289-3-paul.greenwalt@intel.com>
In-Reply-To: <20260814174919.4177289-3-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|CYXPR11MB8712:EE_
x-ms-office365-filtering-correlation-id: 06635272-c448-4cab-3309-08df2307d255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Zno74JiGRyWC+UwpygonDipPLTZ4hRh+NBYv+czxDeyFdK3hARYXuQSWRELnfu5JRg5SHwi5ijT29audXUGkYadTZltVJvGAtujY7qqzQwtHMKjfRQ37upr+EDAL9jwIdEh86a2CW/wpg9UGzmNoZqZgbtPn+vlTVeFYUF/PDfco0dJgs+9Wr9HUNFjvsYlM5QxN2aPVMILmqtNvqkrv5Ve3S9knrqNzW1ciHYNfDXEq+AaIBm22Wgjnm3ZrmSbk4RM+Y2tSuLa54WlUuWALw+MipE8oVgjj0NN+EbKw30ne+s24KB84McTJNdKV9nnPm1Zh5oqsyKsf2EGcqCdITf617SMAMFP3O5wmfxpm5t8IprcUjIDLc6vRJ5+/jbR/Oqp/oX2m56VT5dAeDS51aGhsgLUKjAybbe9hervRCtIyR2QWovfnT7rIL62HFUm87C6g35/wnAhWFSG5JfKXW30sVUnk98hAGH8Pl+TRQejL2jAXjHM4v7JVwGM26JdOa5RtFnJEfSy4dgsWrgW4Vg5FbqgedmBdkNK3KzVb4f4m5tBnGtbXyQvR8e/ijlkFTpkBBHe6ZtZVFnL0g7hNwsiculgNClCjLfyK654HBac+hhE/AO+jLX/NvdWeWxADBPDHXkALlJUJ/kxeJ+UVvkH9X/JRy0DR7ojhExraJFz/g0Z+JcfoIb1yo8frHcQvN37D67z759izNyhlQbn6fc0lZp2TYzIJa8fHTmxI7GY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rC9asqQW3fX3ZFYYdqJfAB23ysZGFU1ykicwJKxS5Twq5KLJFX8htXbARHVZ?=
 =?us-ascii?Q?pwYqoSNhT8RJkHMC28GrfT9D7V4eERTk/aMsR/lXyl5N1g5owQkGqjZS60RM?=
 =?us-ascii?Q?NfkEucqmxM+IZKmzsR1nbH75aA4G5xLp5fqRLuw1/6ggZXgJNzJoIZBoAv8x?=
 =?us-ascii?Q?63CuoJrdERzQEHjodk1JgFq14NTpbWuIMUuSs26xe8Q4C7Sb+Obx9HEm+KH6?=
 =?us-ascii?Q?48LFDhIi38n5sMpIS720Tg8wr03vAZdO0ftvDvO7G/0zM/Ow/TBgWUPIJPGi?=
 =?us-ascii?Q?U+fVOMbO7BxyMNsEmTkBczu//CNrXnztFneILypSJR4cmuSTOcviGPphEcWI?=
 =?us-ascii?Q?eBuvtrKOjXVQ3F4ek64iByTlycwkQK54ph0UyMGjdWobuKdr8M3V49kBYSPf?=
 =?us-ascii?Q?nvbtjDS0lUgRh5FjENF0FdOi1bVuycLcI9AVDtVU7nOe8fGJCQVFD2lcgFRD?=
 =?us-ascii?Q?Yk7s5LGItAM9ms9mD8VxsP5yNE8cYrOqr016S7ZTow3EGQOXapsW9ESbvoc8?=
 =?us-ascii?Q?YR6DExYEcbvnoOLIljiM6PpUsN2GAWv2OO7hB1C25dFHzdrwNkmtPhC0NQYB?=
 =?us-ascii?Q?HfHNp6+jCInJUBeXGl3/ePW2JDFH1DZw2mLdToSEV8v0p4lVy7SdMZkJm0IF?=
 =?us-ascii?Q?NmG4ePJdHR9lTcFutWfrfpCmAF7gRGi2MTwsk0cL0uc1VVIOMsK7x11aNdgw?=
 =?us-ascii?Q?uZBTBnfThUqp6MQQS0oWVC8hgdwLwgkwOiKrbhG2dQmLlTKbNxI+6teu9GRk?=
 =?us-ascii?Q?ub6osQKt5AfUGZ6vjMYVxSmfCWxZsRQWQ5q62Hk0CmYDWtC5mEhbQ1tZqEVz?=
 =?us-ascii?Q?wtbhOgYw9/UN5chOGO4oko8CP/xpfyQiNPDl7ypTlrzIWI1a9aT4RfChN2vy?=
 =?us-ascii?Q?1dHdGrxeyf8cTewiQfub01hMCpxNNtIzn2tqPJqIfr8Btcd4juFS+d3FKXro?=
 =?us-ascii?Q?1cbf5UGKPonU3HmSERVYK7faJk4bKEjTMUGEa3RiH6rKDPSAmVANDsbXqqzc?=
 =?us-ascii?Q?O1T4flcUE2xQWcbFs2EETlHeUk7Jbe7qaYag6e+XHPI64Ef4gCqtlkK6pWT/?=
 =?us-ascii?Q?mU0TQ71Sl/+I9QfGGN/e+fjZX1timD+JEBSmhFpUa1C/zXeyTOEJmivYSHnF?=
 =?us-ascii?Q?Jd0eZmgbjaJbwdxTgLu3iy/80rzlL+sZldcEvu4tf8zxIwAb2jTWSIU0O3ea?=
 =?us-ascii?Q?MCbVwkcfyDv3lp8jMxY1WcWCklMPi4CdeX7cXXcvKPLhoJeHZ5Ffwkbjd7Bx?=
 =?us-ascii?Q?zpC6SS7X8P0Y2RGzCNKQnuKBdD+IOlPyJcF+JiLUAgJXPZAD5xXTGZ332IrO?=
 =?us-ascii?Q?EiE9vIcNFSwTkm0To59D4fzshazM0FshIyuJp/xagZAhEXz/M3ZpDGo2ohZs?=
 =?us-ascii?Q?schDFtQmH5hYkAAEe3uJ4pZoPwob0OJJv64kRI3mbAOnBhJsQBoiTguBF6cz?=
 =?us-ascii?Q?pGnu8wNQkldg5clyrdfO2pe2V8U0ye1gjvx2X/0rU2b8aCr/9Z9pxC/iUvbD?=
 =?us-ascii?Q?qaakf6MnncFJewpaOMOP/xOUa9iHd/ndM3XtEZA8wsg2DFFToZWSNgTuXjqU?=
 =?us-ascii?Q?zhIWuHSweJpGoxy+ON4p3DnxU32fWnXEfLUZtdvc7abb1w+e/RyZL3wNYjHs?=
 =?us-ascii?Q?21Vp9xJqFu6dRpTNRPEVxQspxdX6sLBjw9b0FKbsOd8hykA4f95sDQcPq8Lf?=
 =?us-ascii?Q?+4PxMI8rip5XCkHLVxHq7SVa8w34Yrih6sfHN45KAjSD/its?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0xdmFI3RYuHhfyQrWNwHOIZEAzvlFWTl1L62ErVtrMmQEWVRObumnFupCoEApXcLQh87HtiCZ9/xc37VvRdTEHpsa83XQfq9NISJI5dnZHH5hsH+eBs9XkMyMqoxszRH9JffNmzd5lPegj+sba2tid9rN6jPw68pGgzBx1BebQTCvEm8P71IVYLdOS3SUwI5zLkHOKJKhbl2tzrUUXJWaU6D4P/kfp7uY3593kRr5NQcpya+9VY94usbT76+U4x0fWDN6w1Ds+6lrjMXyxKUZmvXQoAJqHWJPN1KJ+jtng7LPRJ7ao0bL5EflQfQc8UX1jqXNLLgG+6Ff8DcGV1NSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06635272-c448-4cab-3309-08df2307d255
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:41:00.9911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAuiquBx8FXMuIv8Nv3Gp3Dk5KsrQyhV1BNsBtcj+wofA70qAjb7cj3WRYrRwrrrV0Cfn62X5egpleTf8REAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Paul Greenwalt
> Sent: Friday, August 14, 2026 10:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/3] idpf: add devlink info su=
pport
>=20
> Add devlink info support for idpf, reporting:
>   - serial_number: device serial number (DSN) for device identification
>   - fw.mgmt.api: running version reporting driver-device communication
>     version
>=20
> This enables NIPA CI and other tools to uniquely identify devices under t=
est
> and track device capabilities. This phased implementation initially focus=
es on
> stable, readily available information (serial number and virtchnl version=
 from
> negotiation). Firmware version information will be added in future patche=
s as
> support is exposed through virtchnl and the driver architecture allows re=
liable
> retrieval.
>=20
> $ devlink dev show
> pci/0000:85:00.0
>=20
> $ devlink dev info pci/0000:85:00.0
> pci/0000:85:00.0:
>   driver idpf
>   serial_number 00-a0-c9-ff-ff-23-45-67
>   versions:
>       running:
>         fw.mgmt.api 2.0
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-
> information
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>
