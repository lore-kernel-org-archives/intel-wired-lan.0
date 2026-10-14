Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBCCC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 10:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEBDA607C7;
	Wed, 14 Oct 2026 10:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XMU4QoX6QZs; Wed, 14 Oct 2026 10:29:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 124456076B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791973766;
	b=F6/KGd1ZUO0pcvjakgj7f48mfmAUrnP+7ljdNWpJGm3f9kTsBUR9wl4m5GIk3Hls1irF
	 5k1exsM5n7POW7//s4e4Ek94zP6iQMJ3Cz4DYyQmX1v1PeLw57ehk/2UYg5NDvWrFpfiX
	 9wv4msN2CGFNktqMKMt+2MToKkFEg4x8AhmQDHSb5L657ELvsX7Fwe6/5k1MW0DvK3zg5
	 df1BF4AOMHrWxNk95HGE+36xHNKd3wRc6vW8s+hHEcVua4031Bcr6qPC+z3krQJC6nXaA
	 hCeNecE6yCxPk4jF//BdYpKEcxt8oLm7h8DcsWtqnzn0sjqP+NRH1/KJ1GNpw/T4xOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791973766;
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
	bh=iGaNrAMtodzXp4aZ65FugWPOqpCXxX4iUiDry03Lm0o=;
	b=KbtFdQzLAbVY2mk7GQe9FMhxnbCreKlpeCpChLKmVZAPvaMGXNlxyPJ3+r+Rbi8C1ncj
	 ydOMVn9LMZx9DpssZIFit+t5Uvbwrk8CWotDeUSeCZQErONuVrjj1fP6JNAY4Xu7cya2X
	 G6qtw3wcmfzgebmSA0Q7uIxaann9vfIIM19ev2NKTmzZ37zcARkanygkBkYIaXoBIjMff
	 Wo8/+V2BwGTsVobjA0ny5KV1lI18ZOLogSsMt/+31/PoDY6azjWXXlYAFEsAGZ/8CcdO3
	 V++eRueYXNxYVCJ78+D41CKBjbzwb58MvZtif8k64YtKW8n2I4T5N9qYMpD6JH9mKtw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791973766;
	bh=iGaNrAMtodzXp4aZ65FugWPOqpCXxX4iUiDry03Lm0o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7dC+rcNb2ur1PTPQrYv5ab4+vukHL4MzLlWebOOyvE9GkM+DQ8gERDbOlCG8cWvup
	 ij3HPve+vc7oQZ2w1mPZMPVreyCzz3a5r9ekKSwa4vwlYWQv5bwT5CJdt11FZLum8N
	 JXq1jSBgV3/49xh9mL1sOl6/vX3LEEuZh91e7b9QgU7I1+psn1vII32IvEVARteuru
	 wN9ZB7AK7nnwbN4pmT4pe6Hs2nyRaOh76xWo/7uCHcer9sENuzdjzIB1MRhS3FY7Ws
	 M4oD1vQcaZaVPto/8MfaBijxfGDMaJzwIVj5dSmjbUAoQtthxpwK7tR2ssFrLdKpeK
	 XhP4il5U09N+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 124456076B;
	Wed, 14 Oct 2026 10:29:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01EF5255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC11480998
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBk2xnS9FWp8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 10:29:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6E2780987
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791973764;
 b=JAfEgwJV6LkvkdxtStqY040LOKVElnZzC6FJkP91VcEcjS+hXwknYHFcmwbdh++PQCkz
 QhGexw8yqytCuzrkrdd/7qxBKkPendfgxYA5pq81ODKEbjKdvYaonpGQ+lhxWKUd4SSC0
 aJ12QIZ5Dh+/XEOjU/zs6g3HF+Z8Nx5dtAH5hwoZxLhsC15ELIzfGDqdbBrzvMVmOSxlo
 7QNtH1GlxJkRosE8neLXVjcJ/nmtq2oLCMxv9LNMk+dBrRu4kG1MXkOsYqLX1uyNfChgn
 OzU7eIRjMvguwq4/lqcV0JIvP3ClwB57CzjbYMZuG5VGhNYdQ055d2S+AgJffX6FEKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791973764;
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
 bh=iGaNrAMtodzXp4aZ65FugWPOqpCXxX4iUiDry03Lm0o=;
 b=PBxriTgdn9NPBqPHFYxFFhLA/63OfYbovWq3MowCXxugE78SdV/mkheVmrcNUAQznU+A
 CH7fbpFdNNGrmtV8q0vROkLb/qWs5TGBljsGK5d3ZiNIUg3wqqIF4ikzhIojhgIVnm71d
 UufTA/azPgXrTk3djhG2I17zevzmUEKCRBrCZEAeJx3/yQOttcAwFP+jLOdCIswwHKgEv
 jlDR7KWhO7aIa3fgWfNwgj2ObTsuA9mqgI+F5gaHS7IhCpn5uU0yNkjL10Ls+1iksy7RP
 vyJ5movjC14EBHY00YactjRKgD3eFUXj+l7LNt4R5/YaU8GKFUy/E92x5Nmi8ugse4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RYjlrpCF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RYjlrpCF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6E2780987
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791973764; x=1823509764;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iGaNrAMtodzXp4aZ65FugWPOqpCXxX4iUiDry03Lm0o=;
 b=RYjlrpCFjRVKxwBT9L87G0i3Ni9rxxwCqADf/2LV0XAy/d8nSP2Hdi0C
 w8WdhURVj2j6EG9bxD4dbUWpj7Kz2z/XBiNXGbhC6EOVpx2MFM/Q3s4bA
 CM9VaznGZPLrcbIEu58zTg5vEmHoCC3IuwLDJtFvgwVmfNEltqD5UGd6r
 gNXYmW9UFBRwxhr2oH60qHB5JKSj3wsO+ILhz9sQw7VobnBc9z0yWhb5F
 EUo/ufTwk1rGr1Z+9rDFeucmpqGG5fqTuGefUl4fgNlYOUhMJbUK8ql1K
 L5GC6YBoI20HzPqxrE8BN5tI3XOWRawDGmNHS/X1W9+WhlGDanAnkIcJf w==;
X-CSE-ConnectionGUID: 3B4hpKthRvKcR6FWpv2KvA==
X-CSE-MsgGUID: bpA2gnLZQvy7X10RyTGLhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="723700"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="723700"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:29:21 -0700
X-CSE-ConnectionGUID: ir10z3kTQAS15iwizz1fDQ==
X-CSE-MsgGUID: fZnZGWqcTaWsoY5m0d9z1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1739118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 03:29:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:29:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:29:20 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzRiU2LnWe0HWGre/FlrcInXOanf04lrPve0ID4qMyQk5hgJLgicmF4rbdZd9BQxr5/gxSaSKs6y2ncD4GdY865LI6fSODZfaTkI5uti1GQbWA5PKWNHxJEywzzsx/4OOi1FYsEgfbOCywcXMWVkq/wnp1vInbZPTeII/lYiZIdSK/ojmgs0Tp/qUuQvZHL6erM4yqog+cp0/xrI+a/Ptc3W1MVxUYBj1ZFVSs2cSN/QoCusa2DU31YSrcFisA/0/zIS7XrYoINVpgut20T7rrl6xEJ+6d+645jf4nxVKicuXTocMXoBwMkKuRHsNa/gQ9UUDcT8LjglLwgPaAsNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGaNrAMtodzXp4aZ65FugWPOqpCXxX4iUiDry03Lm0o=;
 b=N6Q5GkheOCDMc9W6gmMvMpA+Jql9uICPEBV8udSu56Trp3j1R4YnI4PjcGV/ZmQZjnM9epVnwZG36ct7sAV+FcyeYcu+nABA5gSv4/vHsn+3Mcn8Apo+DJ2hfLv11C1zRWRwrNO3DCVyKmZStV79a0mK9b0CqH0LsNlV61gj7e73lbQTyszM2JwVPxifTo7z2tMcTsstaFlg+RjXtwnEe7RyAV0HpVzWHGLAzp/rBf1PTW+AdEJQ5qe3SOZg/F8B+0tvJ88mT2NT5kiMBrycsIHiXy61PDgM4/nXWxEfZpthNYUlZ6XioN4/tRxGFyyYuolTEf9M+qTNHoUhpB+vEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by DM3PPF17031675B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f09)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:29:12 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:29:12 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: Takeru Hayasaka <hayatake396@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "marcin.szycik@linux.intel.com"
 <marcin.szycik@linux.intel.com>, "Nowlin, Alexander"
 <alexander.nowlin@intel.com>
Subject: RE: [PATCH iwl-net v2] ice: fix empty PTYPE set for GTP RSS profiles
Thread-Topic: [PATCH iwl-net v2] ice: fix empty PTYPE set for GTP RSS profiles
Thread-Index: AQHdSNC5yquAvwbqoEi+hTRhrSECb7b8/BGA
Date: Wed, 14 Oct 2026 10:29:11 +0000
Message-ID: <BY5PR11MB3976F54C29A6CD8B08DE17FAA59D2@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20260920072127.1278984-1-hayatake396@gmail.com>
In-Reply-To: <20260920072127.1278984-1-hayatake396@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|DM3PPF17031675B:EE_
x-ms-office365-filtering-correlation-id: 6687b9c8-d4a6-4edc-f0ce-08df29ddfd09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|38070700021|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: tbqSAUhcsa0CQ8mipeJl9p5eo9x1TzE2VQ+8q07sbNfGrsyXofXP84MGp/LFp9uVwPZS1rjojm9vvBOxTX+6kAKpm2XncOYlQp0iIxtZALkUsVJUvciPY1Xng8nV6PjGA+SnuGjKDdFipv0L1KUCULoY6+iMwGkD2vNLmL3IL0O2X+VmrJDYOofZLC/OZHnVgTgZxxbyG4r6txLSoE4G3ipSOiqAykqQnaIDNJNzOUvuJplldnay5rqylHcDFweolpu0Bvv8j5Q0jca1aDb8h1C0dYwj51AUNCzFGWYO84BZv1XirSzeCEUNok63gDZ9E3Qivg5VwpyvobUNVJlpxlUCvKTYDroEGArsXngNJlMkejsLUFImT9QYGb0MEF8rSQH1qOvpqoowOlbvJUw/bZSfoMDuos1jVRoaN0amusT9y2XAj8CWadNSd3ibmd3GfmCer9Qxcxnzr3gHKpchYAsCJ/6N6XgxnyntISpxcf3am//ZUOrKeFACOFtK8Iat44MARWFU7JuOkLlB5J97ZXT3gKROZSKsMAaZ5bYBlnBYypKQr2TghdAelpfBDi72Jb/HicC+XfXaTADEsEVmWLooGtyj7mMHUec9auVATea1NI6v92wAWdSNfpCYs6pRATPpx9RbyrX5GnstTuJDhNSuZ3hS/nP2mooT3lStRT1lSSmByyOoPULLuZgqXYfZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h0N6t6kDFIdImR/9x6cX4Uc+2FmYpPv9YxcicirNnCMwNNt7AQz2XIAqlW9J?=
 =?us-ascii?Q?h8xvggHpVRy+xYiXYsAUe/DqQl18wYX0a2B5IxUTKBrx8bmmvXg2iVk0qA3T?=
 =?us-ascii?Q?l0EowToNyHup+p/hnEECZ2OyXkskK/mZFuCBaisxXrWVGpKK4S2zSk94EkWS?=
 =?us-ascii?Q?mpr8dgcG3hf2kEIq1ZihUz5Mbuy7iKzP98e1H6/nb9P3cGzt/BfkS6N8Jpg7?=
 =?us-ascii?Q?ZZjh+l1wI+DMeDFB+bUwzQD4sxZ187DTGZFhaZA6FPPGERWz5teJZBMz3G0d?=
 =?us-ascii?Q?uR0KaJGKijSZ/EMCgTbcDZ0zRvvpYCisxjDH9e1Ag3WfCPy/Qsi9zmA3ZlbG?=
 =?us-ascii?Q?lFyk8Q23yFLHSsAVuWB3/eqP1ZZ+Uc/Eyf7Gxn3l+TJCkmMhC43cL7D1pct5?=
 =?us-ascii?Q?jXSeTbbjL5GQd90Jz1Fo1NTadsN1L+0bx003d6o/DtBgzOiWOb4KlWo4yzVc?=
 =?us-ascii?Q?2Lfs/8YID5kequMFTxx2XdbYCeQixBrOnEN7ZhKMkzjeNZzYK9W7iryeS7Eo?=
 =?us-ascii?Q?ibeCgVFA02dCwN5UhkubqAvioIkKGo8ZFiv938yHrSR42XHJsi0O8Qgvfrnd?=
 =?us-ascii?Q?4DrEWs/6i4Ucq8ejmL00/YGqsKJ6yNOtPgvmEEgskgi6W7nFYlFTjVuMnqLn?=
 =?us-ascii?Q?L1qxzyPYfcZo5GtT9jD5ruOpRKW3wPKgqqK6McxVHlekguwrGB2txyu/rab+?=
 =?us-ascii?Q?MJh4TN3TNYiH6rUjAORiYLfVkcLZ3v3q2XdPZTOzWrKEzbveyqfehMjkjwwz?=
 =?us-ascii?Q?dwxFxyC8jVHNj0v3LuUQVq4tBI3dHKILp/xhSPKP/MpLnLg0anMviN1QR2q6?=
 =?us-ascii?Q?ldZPCCFZ7CFaYCvYojFp6T0vxDtgXOL9M68N9bz+MvNHy54XNIJ13ZsJG5GX?=
 =?us-ascii?Q?IV4OaDeKcJDsuX1NGYFECpadXQxTZvDs02Qflm6fLUBKaiZe/TLYl5tPjTOb?=
 =?us-ascii?Q?qymDEGObmFh4d0eRy+VrPJ6iO4gzvonPG4wieLzC+NocwSnDbrZR3WHb9Ygi?=
 =?us-ascii?Q?fRZ1A/fvpXRcOWqsltRA2OWAnb5pX4EIWpbjTOvlAuKeSQfG6flcWvG6A7IB?=
 =?us-ascii?Q?pJNwfN+x1TzA2ic+S9UiLR9i4iaxKBE2r5hDpXJ111rZtDG06E1lWfv3QOIL?=
 =?us-ascii?Q?xGbt8kXNqDuKsZVHkpWzjtD/FwyCmjt4A3JCFiXWpbiWUGgm5dn7lIp3KKEh?=
 =?us-ascii?Q?imOOckJAjI+ankcv4WqV3GfB0EwZD/SfY9wrcUwT/KHxGI42sCc6CCnwL59T?=
 =?us-ascii?Q?o6ifecIyN0bcMna6cWRTCuFJ6EFAkBFGntNeEgCYD1QMhVM5LeKmZ2eRSV0j?=
 =?us-ascii?Q?AqtCPZSC3zQX6HGbcUrK/Qe/XZVdrxte4wRTNdBYcswqQF2jWq5PEsNhTf0A?=
 =?us-ascii?Q?HDW8DJkKbmDzIGzvPa60j/ZXHoQoaUG62AbCCtGzjgEwMl7/54PDuGPCoHjY?=
 =?us-ascii?Q?oBkBqoy4evrKGb5V3MkjqmYn+je16tc2qMWZGcohYaod6bABv9bP5XmhVSd5?=
 =?us-ascii?Q?cnth1tg98YplXIxlRGg4vqK+Qu2AVV77Ws2MJxggue7jBE1i5EOpqu1dQYl2?=
 =?us-ascii?Q?FdnO7yhN5I927DaGt2nlg+KtQIN5k2RtvRcKCLICZ3dFJ5wVszvHHdEcAYZg?=
 =?us-ascii?Q?BxA2+dSUQh9HinwVypl2XI4+lWlkH+8SBr6yVOORbbZNR5DMwd+8USbEzaDS?=
 =?us-ascii?Q?ITmehk/QYkSzlP1ujC+kvRaQ/avdIY3tlYe8q6yAcjOvPHbIbGXr0vRxoZf3?=
 =?us-ascii?Q?IS+Hy6Oe8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qh771c8zvW3FaEn+ppdiQldGwBLSlhemYGaR+DpGfH6xuQvs9TnRLHRxwBPiYXHxByRE30R0gqja0iY4DYYrYvvhQsUqktcWFbi6uawDZuCT0ha6Xnuv0Xz14qdOEBGxGy1e5283/QXAkErE7JqBHspIcztxgS/THeUQIr71Vm7TL85gcmMMP2AogDBYkE/0FTcyMglWmeltXiAOwyIgjxYF39o91F5mZI3lH3vVZKIOBpkRaOO91f5/4jVQ4nN1zBh4/LS/h9DMTkB8WX170SsBQz8xncLVocTeQs0hX9mRbjr+A+/UuFFd1iLGja0HOY2f7A49HgakJ+MkRynwAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687b9c8-d4a6-4edc-f0ce-08df29ddfd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:29:11.9104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKLktn9ftVhbgQQSg6XvTKEkUCn1RgyGBHs587BkoERuLX2CQVKgKDbnNF1b1sO7H+HWo1ycVWb8GE9R0Tr52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF17031675B
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
> From: Takeru Hayasaka <hayatake396@gmail.com>=20
> Sent: 20 September 2026 12:51
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; netdev@vger.kernel.org; marcin.szycik@linux.=
intel.com; Nowlin, Alexander <alexander.nowlin@intel.com>; Takeru > Hayasak=
a <hayatake396@gmail.com>
> Subject: [PATCH iwl-net v2] ice: fix empty PTYPE set for GTP RSS profiles
>
> Configuring RSS for GTP flows via ethtool, e.g.
>
> ethtool -N <if> rx-flow-hash gtpu4 sde
>
> is accepted but has no effect: the hash of GTP-U packets does not include=
 the TEID, so all traffic between a given SGW/PGW pair lands on a single Rx=
 queue. The GTP RSS configurations the driver installs by default at VSI in=
it are affected the same way.
>
> ice_flow_set_rss_seg_info() does not set IPV_OTHER on GTP segments, and s=
uch a segment carries no L4 header bit either. ice_flow_proc_seg_hdrs() the=
refore takes the "no L4" branch and ANDs the PTYPE set with ice_ptypes_ipv4=
_ofos_no_l4, or ice_ptypes_ipv4_il_no_l4 for the inner segment. Neither hol=
ds a GTP PTYPE, so ANDing with ice_ptypes_gtpu leaves the set empty: the pr=
ofile matches no packet at all and the configured TEID field never enters t=
he hash.
>
> Set IPV_OTHER on GTP segments so that the tunnel-inclusive PTYPE sets are=
 selected instead, which do contain the GTP PTYPEs. Skip segments that carr=
y an L4 header bit, because the VF path strips IPV_OTHER from those on purp=
ose.
>
> Verified on E810 (kernel 7.2-rc2, COMMS DDP 1.3.63.0) by reading the RSS =
hash from the Rx descriptor: GTP-U traffic varying only the TEID goes from =
one constant hash on a single Rx queue to 4096 distinct hashes across all R=
x queues. The same holds for inner IPv6 (gtpu6) and for a PDU session conta=
iner extension header (gtpu4e); plain UDP flows are unaffected.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> v2:
> - Ignore IPV_OTHER in ice_get_rss_cfg() so "ethtool -n" reports the
> GTP fields again (reported by Intel validation)
> - Do not set IPV_OTHER on GTP segments that carry an L4 header bit
> v1: https://lore.kernel.org/intel-wired-lan/20260714192302.631428-1-hayat=
ake396@gmail.com/
>
> drivers/net/ethernet/intel/ice/ice_flow.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)

