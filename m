Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D90CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 856EF80E85;
	Mon, 28 Sep 2026 15:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mc3XXTlR9j2g; Mon, 28 Sep 2026 15:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BA3DA80ED0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608801;
	b=EFe6zmrKv+mj7ef1rij9GY7XzE98Jc5ADF+OyAIYCfG7CORwRGw1Ou/QEMS2VAha5nyE
	 1tFybCLBMwSR6zORZtEKAEmsFq9gpBaXc3Md0bnlLE/2xNwG6Q4LC02tccR76/DRK762p
	 /M3irRzvvEiYyvwMeDikgirzIxfLhk+NSMOeyoxHjCneGz+HNPFcm83MhYdqBeyma8nbu
	 Mu1f1M6OXRwCzgzKBygef/rJ2remPg+E4nbmFmjm5qg4bE2/680bASHleXCoghfoPeaSV
	 rhjxKZSWNhXVnRQSAiUVBOQu9TB1svie1F2OuSy9xA73Oz4KdY4jWJ+7lRxuSi0+zGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608801;
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
	bh=i2CgG5afMNtRuTWISeEE7zYZlmNMgQGRdDSyzHQhYC4=;
	b=Vd2SOTm0/zQzkCIEsidXaN026v4N750qBbpmPzgFHaohlLYtVdU14YPZNNztgp8+7kdH
	 bi7tvn34fifvSNaKB4FvH8VXcR2D4crk+/GuzNNo02TLlnG+iPifXT/0b/ShKBcX8AduG
	 ND+XIe/pk5+QdmxfuJd3/1FqDbIMLM3f/XRoo87A09kqrQZOk2hAjYx2w8b5BQypInoZ+
	 Y2rVI+rLy0ZYZg2r/El76fyRQIcBk+pYE28viyM7f7goe5RA5kyS2kcackBO4g2s9deo5
	 zq71RjAqd9a4sMy53hstUjSq5SdVLWEE/GU7x2fM0/D6Mbf6YcoNBw8avLhJXJR1TtQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608801;
	bh=i2CgG5afMNtRuTWISeEE7zYZlmNMgQGRdDSyzHQhYC4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IyP82v5jXY6dHyJSgHK0NAcXhJ5sT0rTQzR0m2tJPypgoUFtDWgTnGrBK1OteBynI
	 Xanj9ZJdNrA0YUhzs9NsY3Atz21yo4EXoCWwyUcV6WRRpXi1O4Kd0pMqh2Jex+ha3M
	 QJVx09Su4He6TdFU6re/21sn3295TZ67QGTK3Ga3RePFDssYokeqUi9QxYlHbiGZZQ
	 emJ8GwsrDbgqhCYNh4EnDy01cyITEUmBg3B1qh+Wt0aN92R4oPMrAcJcHIMS3V96Xr
	 qjSb4+uI6KYywC7fd0XpipEkU2NAlqYqISRd/xnp4/FF69dr/OwO3lxCA4HXkMCU4V
	 rFlyPMbPYUgpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA3DA80ED0;
	Mon, 28 Sep 2026 15:20:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5A72B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C956406DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXfxRhrzV46M for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 15:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2C2CB405DF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608799;
 b=n7xCmVJ888H0MAGyTeQgX2eBF4BXICeGPihhnOesbNf/ljJ6N0bAGE4e6qNjlnoKLUO5
 8V0PktAlsIgwoYssnxrnxRPnpd+Ev+4twa/yCcBPpO/sCi5jGslC44Q+XHiUrRKn5O2N6
 GUQ8sxHYEJcOQCBJhtstlADAawcjI5vws37xRJJvKyyVrV06uyWFYnhdB5/0p2l047UXg
 U0kl4xCEQoyeWGsWBERdDgpGQIdGvuKhDipJNi6VG9MEXe9GiVuqLJtSiaQOGlgFCYjuo
 wFmhb/+XWsb/9Hpzc66Rw8JOTPEuySKIMUGWEMaHHuS4UhnnZqaia8mdSfD+xO7YQ3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608799;
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
 bh=i2CgG5afMNtRuTWISeEE7zYZlmNMgQGRdDSyzHQhYC4=;
 b=RQHbPWgI3nIcLclv1KFCt/N2hbygRyo1KQsPHonaQjHelRs/B5S2HeluDWrjgLT7tDZg
 YOXzW4eSvr1mfJeQKC6rnvSJxNy2qGNP+HVAP42X9rnzdnCUYvr/8BGBlNPg2CvTyrrFh
 0aJwhftFEWholCxcYXJao/6Lk3bvIWfkHAE+5KbgNnhKJRUeEYvaNOmfzofVuvqabkh+N
 9KKn7OGU7ZLMvKi/wYsJY5XM+M5Gu9PJJnuxYAk9X8VfEuGA6mKU3rtUA1MYI8UhEjRS0
 O0TQ55cdoeyR4AttkEkbXq79hbdHx3XdZJ+iydGHI6CrQnc5JGah0i/xGa+zidoFRQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="V6lucr/Z"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V6lucr/Z
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C2CB405DF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790608800; x=1822144800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w5sjOaw0FFkjM14W+/3wZbiAhPLGNtdOotFsovGm4M4=;
 b=V6lucr/ZLZz7Jz/6H62Kiq+H+IEVNSEdZISPvoJ0S3fYwMaRelRLZBVb
 585e8MZCvg7tNLFtN5Q/TK6lBSXMC9GJ4kRm0DbNiXpao3QEGRaFrvplM
 zaMmkP9EqEH1N065XyA07EDAnoyRwAvYieR8WvMHhO84A4vlBpV/2ta92
 pJxbRS9vHA8xD65qUGAmpSUS6+qY39j2Zz3D9g+lMbGp5jWZ5rJeNlcnc
 gLvRs83s+GmzumEESrpPv99LyqmkLmGKuv3w74Prai30PLh2W40mOQv2x
 qfEuj1b4vZKJ3Vl4YZ2sDrbj7x26YPcztQ/s6vBCMq77nle7b1m1LTjQM Q==;
X-CSE-ConnectionGUID: A92O7CSDT2m3niLbqTs3ow==
X-CSE-MsgGUID: nHgxbaC+RyGOr2wa5VtSwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94024829"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="94024829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:19:58 -0700
X-CSE-ConnectionGUID: nxBaUcyXTRO5Yy2HMDCieA==
X-CSE-MsgGUID: 1tOTG4MuSSKSdPPPZtGnNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="313002251"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:19:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:19:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:19:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NALHWjD4SZrg4NiQfknirPcdiQNXkfrjkyrr5aIf1c4ZOKYZCm5u4ciechfpnsWKiDqAr9HIG1JSGywVmVSbOHtUcor4W3jbmHPdtDhMMRb8toETXMUq2mF3sOqe7MyGm8RJyuaetdtCO2JgNO/uam+w6foY6eRBCE8A/BmlpA57CP1tlnBF2e0fnVn+9OVj6I5EhDDAvyplnpH/smW/1ZjtXMEBP4KpPOTa5YFyWKG9zRaAY8fcQU7eO5d+95XBIojMC5AREpcZmbsnuB/STX/ksKTpBnyziBoJONRXrmQVYwA7HQv5kOq2AJrcyZpBXMgkejRt6Cc3TLJK7JAL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2CgG5afMNtRuTWISeEE7zYZlmNMgQGRdDSyzHQhYC4=;
 b=phxvB9UkHkXf/RS+wVD6pqbKtKUy8nPV3Di7WWPRX2xEMsYxCZieEG+jln0CSqeVtUetP/r+idLg+PEUKSmvcXf6JwnR521fm7lsEfNC5+BgYJTr+GS1F0NlbOqz4jc9UP2BWEP/Fdvh1ud6f26lsObBrUcPwETKUCiSCXTw71e805iEfvPWDa7u905HIPFkm0dZtST/xeaxgjeOtXIalYzkuBHZNf/+OljWg+BQKyG+PUt1puO26JpwsRsaarI1MlD04uUdwZg+eXDmpqqD4kMV9O+0+nMVxbPSfhOPUMGYkjUaCzzVJkP46qXbrStYWQuyj8AEG0jKrrN5nC+oiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:19:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:19:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "Nitka,
 Grzegorz" <grzegorz.nitka@intel.com>, "Temerkhanov, Sergey"
 <sergey.temerkhanov@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Thread-Topic: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Thread-Index: AQHdTT4H6kjxK8OKVEe8RKShxlXiy7bkHwig
Date: Mon, 28 Sep 2026 15:19:51 +0000
Message-ID: <IA3PR11MB8986BE4B5CC840BBA908F4E8E58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-3-grzegorz.nitka@intel.com>
In-Reply-To: <20260925222824.270640-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 29f2bf93-5c6e-4f2c-52ea-08df1d73f13a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: rquEuw62zleAiZISuDjgE/b6ALEdk8+dqFR6fpudMfFwZ9B0M30M1g2mD/lHTcYyFCgfalqJ8Vz3E74qedAx3yjLHWDP+BwNMR6cnNkl+mcYmCI38wN6rDGRilnzdrYR0UJXRbgCq1xodc9lEErtA98cEnhMoikjHRURTu0xrMj3nLybzV76hPqbo/t63Xoq/cto3FRkms9/Acge5CjMAk+alKo9kUZ+i6ZzvVkuQuAhxYqwuftmsqBhwM9S6uD/OWXbRyS3tr8FKNRKTeCb/rTTqdd7PknlfUjRrekdv48niBa8OooIjtZo2/9hjyHPIFt6ScCL4zonJKy+ngO0C1CXyt/pgKq9Kpu53wPzV8KQi9MOF75NTOmoYPbt5BkMsWiV+iJUAerLB4/DvFY2BFpl4IsfKFOVgfVkCGIZl/ZciOHrCDd7WwlpUPhUtR7jndhjrcCRxpqStZgK3PHDuVWyqRzPKoWczctwwHSc2fLd+aq0nK8VuHRA85QL266zk3rdkgJYSgg9AVahHZ++t7/jZofpgINJRdNvnbAZc06v1oVxOBrxHZOIxzNjU6sjlrIA6CxwDyUQswhCqausqcsU/xgrbqzjEh2a/IOjUvyTkTEFKaBksJquWhsExBlwmbCIAyxwRJKhFkuabHE+6IubWhrQ7QcR0XN/bMu14i8f5oWDDLyJTVZeHy7NjUW903agqqt78YQ8Db9jTSv2bnFX24gOX1SL1zn8JPKYCzc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wIQkKFAtkfGqJMoeGgDduBGClw8RCX6bJqBd3mhGgNJAjhSfbJ1BrCbByhVZ?=
 =?us-ascii?Q?3sVKZYo+BXN4rP6IjrZKuNSPN2mbKKIL93wKI9eMiFOW8cz8KMJ4EJBTFDCO?=
 =?us-ascii?Q?FQYREoRra9bCSms7WKv7e6Rm2QYv/7MdomOGB5EL6hUbcezkSqm6sbMzaDIW?=
 =?us-ascii?Q?SPeb6oxrwpj67nhE5mpmWyMX9UForqiSa0lHZ9h3EA97sFV9z7hhVvxoN58H?=
 =?us-ascii?Q?UuCdbsmHnhZn1GhqgyL3ankBc3LPlMILi3HIPfnzw2fyscxdVec6Mkk9qzIr?=
 =?us-ascii?Q?F5+He1d2lQGAHepzVxa9GeUagtQ6SOort0gFU1ZIEww3f3mq6K8zrVEMMfbd?=
 =?us-ascii?Q?i2psm0T2Jv1aHNFWqqk2ZOx2bZ8wfAzJrtlgJYjUD5DAeUmLQkwKiaz0Itav?=
 =?us-ascii?Q?ZCl08q5HMmLj2WTxCm2htjCUZVI6XfhD5DKPZfvuGivGq3pnBT7rmlr/Mf+3?=
 =?us-ascii?Q?PeX9XWO2aZHTmbN4/w+cTlm27KpqAn6HH7CAOjtVU3l4wKq++iNT8F3Iy8+7?=
 =?us-ascii?Q?rzcCOcquuWYsQ3oItVKnSyx4IfoiahHYa5sjWvhqVDoqqhEf0mYSNn2QsP8a?=
 =?us-ascii?Q?uz8Euvx1KK+cMuDq9OPn38rWl///TysNxYmlktKfS0ie/82UppBX6VjQ/NRj?=
 =?us-ascii?Q?g80AXdlyC8Fv5VCvhpQhcBE8HaxUkrf7mZfKADG6e5/eF6Ek7xHV73js9BWp?=
 =?us-ascii?Q?AHpLgU1yOjHF+neCAGfuxAEDdzR7F/Kzy13p/WaBaE/MtHZGZOtxN2/xpSSq?=
 =?us-ascii?Q?YTm3wsxvChtapP9NIKn0sdcDh955pkroLx/diCSNqBgvgKIVXHchIMgbdn1W?=
 =?us-ascii?Q?N4kBugyIbUGnLJ3Is+OtR5eSUUAeWjWU+q/Q3VgzSkVq/690IT71Utaa42vu?=
 =?us-ascii?Q?yVFYYSeJohUysrZohTNHSahq0z9FOYogYO9Q8vyRL4QFjIsnj/NOcQdqpY+p?=
 =?us-ascii?Q?T+pLXyDF7KTr8xI8UvIqcCWF4D52ALH28MlCIMwgjRDllJgLJXWRvn8qY1lQ?=
 =?us-ascii?Q?tsU0XH9JrEX40geQ9TJ9+qLek/t9iJtiBUIR4sDIhtw3jDW//vGsy+YujGjw?=
 =?us-ascii?Q?NRA+ifNK6RJ6FBvznZTMgZszjsq3QWHc8Mj5WSmbsA1Sny+M66c1qhy09GNr?=
 =?us-ascii?Q?ZmOrfXSnqUjs4M+c5D5MmQdQiTgOI1F/iOEjOVZ+duUrXO2K5vc4gkSFlUov?=
 =?us-ascii?Q?VQ4HW3WP+BlYMzq11YhXJUuX8yhzV2GD141rC2cY5DdDJ7AmZr2jU2KdJxtb?=
 =?us-ascii?Q?oKihpy1fwIulqC9SIeny0QbkWLPfCEZpIKGZNu4UDxvANQ0ePUUEpjApkCpy?=
 =?us-ascii?Q?LWFfAB+dPy/8ym1w/NikaASA2X8CjlD56JjckNHyQzOJCYvQFBfBksh1mk4I?=
 =?us-ascii?Q?8lnHHLU/xx1X81YUhlnnY+07L9tPcZgGk0EysJmgBuuhJ2YnFxuX/K0VVl85?=
 =?us-ascii?Q?zW6NEW7i3RHjY4tHnMCzK1jyMOlNip8jMoEd9Lqsa3uml2wPeq6qaMdgim2g?=
 =?us-ascii?Q?MhnOFGI2Wg8F1fPBoaPn49q/AJ/ju7eFLsFNgiUt5Qauldxqo2XYqm2FW/k5?=
 =?us-ascii?Q?FMHJOhC36wYOzeYRfDOCOz1ONv8zJuEWXUoLGQtpDV9GFHmbuof6vFW+hVqk?=
 =?us-ascii?Q?XKqqU/8WYJoBBXVDm+cLuxIda7x3OEnFtSUEge/g3K31NZT2PMB3UCi4Z+T8?=
 =?us-ascii?Q?Vlb8bwFZ5nj/Kpe2HqrDRKqCIVPE5mDemrMARR4XPkkWEwnqpja956iEIrOT?=
 =?us-ascii?Q?W6cwcx0XlXkDCzzQ1Xa1tF3mjxRzVxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MiVZNopJ0Zmu2m6mNt0pXyixs4Eu7R2CYA88ZuFAFQ4kihrE0kOa5RuP6JPP5PGX8UWQZwqYYhdzJg0uk5r5C+jZjCg6LM/p0VtSFy+CKJLqQDVYM7ErrUnzEEazcp8n7q6LwpVbR/YkI4T0F9Yfid8NNGp1nbkQVsHuM4yTjr9JiDxetLyDZnaYF92z6wCOyoPVONjXWZb18/5N9p+d+3XwoeOM0gc0DCmct2+JKo3YH62fyetxSs+YJgd4IxVV0VvCHS7mDoTE/643gH7sauiORNiqqLUFedByUz4ULzYRRbOFyKubiEvbNpROh83OyXYg9xt92bMfathcsUXETg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f2bf93-5c6e-4f2c-52ea-08df1d73f13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:19:51.4633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZSIVdeX49CMlWvtdMcPTFeUf98SJoenYbcKPzVtoVvFPFg8Q80O6FhzhRGbjSj4WGWAJ59DVAKXihn+ZD73J+OCoQewkDO0AzWWE9bO614=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
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
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Sent: Saturday, September 26, 2026 12:28 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; davem@davemloft.net;
> edumazet@google.com; Nitka, Grzegorz <grzegorz.nitka@intel.com>;
> Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; Olech, Milena
> <milena.olech@intel.com>
> Subject: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
> command
>=20
> The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME
> before starting the ART/device capture and clears it with NOP
> afterwards.
>=20
> It was assumed that this change was needed for E823 devices, which
> turned out to be not true. The hardware supported by this driver does
> not require it.
>=20
> Since GLTSYN_CMD is shared with other PTP operations, touching it here
> only adds a potential race source.
> Remove the redundant source command programming instead of adding
> another guard around it.
>=20
> Testing hints:
> Verify crosstimestamp path, for example with phc2sys tool, on
> E822/E823/E825/E830 devices. Please note that the phc2sys tool
> performs cross-timestamping by default when supported by the hardware.
> This can be observed when the reported delay is 0, indicating that the
> system time and PHC time were latched simultaneously.
>=20
> Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823
> devices")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index fd97190a89a9..23c0a45050d7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2229,9 +2229,6 @@ static int ice_capture_crosststamp(ktime_t
> *device,
>  	/* Snapshot system time for historic interpolation */
>  	ktime_get_snapshot_id(ctx->snapshot_clock_id, &ctx->snapshot);
>=20
> -	/* Program cmd to master timer */
> -	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
> -
>  	/* Start the ART and device clock sync sequence */
>  	ctl =3D rd32(hw, cfg->ctl_reg);
>  	ctl |=3D cfg->ctl_active;
> @@ -2258,9 +2255,6 @@ static int ice_capture_crosststamp(ktime_t
> *device,
>  	*device =3D ns_to_ktime(ts);
>=20
>  err_timeout:
> -	/* Clear the master timer */
> -	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
> -
>  	/* Release HW lock */
>  	lock =3D rd32(hw, cfg->lock_reg);
>  	lock &=3D ~cfg->lock_busy;
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
