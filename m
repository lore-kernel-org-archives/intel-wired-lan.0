Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E74606A31B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Xvc5rA4y;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OqS8erVH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B374B4040F;
	Thu,  5 Nov 2026 12:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWHgdDgaymDL; Thu,  5 Nov 2026 12:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA2824064A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793883059;
	b=evp3CQoGE68VcKYRlTNLFu+wWqwnG+m634YoB3TLPcU0jd49Zc5ojKNGekKZLqdjLah6
	 glXS6pFi/szPm1nkaD3zqKnZZhAOKRRU1EoN5qUpgeNO2bL4GUp7Gkcav8lQxA7AXyUZ9
	 oa4Ax+EhCX1hAV67x8Q5NHtjpK/70sLCxQl6NitOEyIiNtHhsp19x4pUuQbMAZUeb03mu
	 zS1XZOy73m9G8PIA2CUr74QrCsV8LEX465/5+/WiLoA/xXbKnCgKu8Ri8+igPsNvH6H44
	 y/L53if2mX+ROfc2o42K0PZhde9BLYgqituo25b0Sb5RPS0yUSVXRwlYcEhMvVsQlHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793883059;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tTm0aw1KwdQjIz2crEpeXc6IEwMkxQFjxql+mZgR+GU=;
	b=OLqmQJW3XLJOeBGDS9WWwukPJKdbAuDR9op4gieBmswp84Vr++lEL+kvcKxwxHRSqjoB
	 w6yG99iX1DPO0IMVlQrW2vFzRVz3zKzGO/8/w4t+FFvxTE1KNYCAte/41HHHJy5CVift1
	 VqT/8xaOzXO6Xgp7xf+ZQoaaTQ1FKziJwCWVFi765tmhs2Qa/mvs/Vzl6S1xyjHOTfTUP
	 o4EnKRdXyCaI6Y9hKXhTyLMs0o0D9MgzbQegJUzYfA8yJmCkwpI2fHlCV1E1Tt5UYXtNq
	 sKcAbmDjwDvUY651SiGAT6gFGCsLrlCU8Jhfxvyj7RaJwj82wVbmze6Zxw2Y2xj95vQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OqS8erVH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793883059;
	bh=tTm0aw1KwdQjIz2crEpeXc6IEwMkxQFjxql+mZgR+GU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xvc5rA4y+zfy35okGP8eEKyTwn4Nr/u2nPn9DQHJBs5M4RgzPpHFd38kSRp0RLtnx
	 2S4Q4O17XOQAioPU/WoeOzyHsemAAWTxZxw9yPaj/UxvHBTHRLbdK1c+2209vd7750
	 UCrJKqW9G//pi4mbPFU8MB/INxnzzkrKTghu/qgjWWa5TakAFG65flV53q/js1ijlo
	 DUIpOoW+H5euQr2cWVUkGmjU8cDJyXu1UFnkchKnc/ntbOjcpcrffHiYOmh8+E0yVV
	 FXpn6jw4aZpmsCMgwZ/cztBwuSxuLN1VFfMCiw6S3gx1+LoiZsFHJHBHQRi67NPdAN
	 I4LqpMxcCtJnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA2824064A;
	Thu,  5 Nov 2026 12:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F98BD3A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9074B40842
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXZkMxW3wGPB for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 12:50:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C99A4040F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OqS8erVH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C99A4040F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793883056; x=1825419056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DVTEEKSZ6c8vusuvDYtwJ4nfHqai3fo7nPuajMtLxfA=;
 b=OqS8erVHnrpdBuqY6ra0PKEW0I3Xi7bKdfd6Bi7NWT0XYXltykBqsYfd
 ZDS/DryB763viMNZbLdB6dcyzORdmpjl47Va+lznxZ76xervK6aC74RNS
 WrQS6PzdDKg7Lb60i/Z7ykCSzqYyWUf58d907xU6IvJIt4gTIehhNJWkP
 ajTB34s/WUqrVlvn2d2mLOYOPgIcTlqozt88wPV365gpuSQXalRiJjYat
 pKId/E6WdUAMqF2k8pbuaZ+U96nStKQUCaBfO+0FIehcdhjxeiLxIv/IO
 cO4kgc4ZeVRwdBi8ljlOgIzfn6NbQ6mKJYcfo9z0eThnsVQSLgIqwqYHQ Q==;
X-CSE-ConnectionGUID: iP1eiG22Ri+lrGVlJd6UlA==
X-CSE-MsgGUID: JKJpknKvSCSz+CQhTsWnxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2557786"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2557786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:50:54 -0800
X-CSE-ConnectionGUID: u88PAwlGQvuzY+xkiA39xg==
X-CSE-MsgGUID: sF1r355RR/2yisGZDf0RJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7015368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:50:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 04:50:54 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 04:50:54 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 04:50:53 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by CH4PR11MB222363.namprd11.prod.outlook.com
 (2603:10b6:610:508::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 12:50:46 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:50:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: David Hu <dhu@x6u.co>, Mustafa Ismail <mustafa.ismail@intel.com>, "Shiraz
 Saleem" <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
CC: Jacob Moroni <jmoroni@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "David, Hu" <xuehaohu@google.com>
Subject: RE: [PATCH rdma-next v4 1/6] RDMA/irdma: Plumb uverbs_attr_bundle for
 QP, SRQ
Thread-Topic: [PATCH rdma-next v4 1/6] RDMA/irdma: Plumb uverbs_attr_bundle
 for QP, SRQ
Thread-Index: AQHdaxojO7oKbe9RvUq/94D6I1H5g7cfckMw
Date: Thu, 5 Nov 2026 12:50:45 +0000
Message-ID: <CH3PR11MB56689519BD2B2A4CD964487E0DE5772@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261030181512.2056056-1-dhu@x6u.co>
 <20261030181512.2056056-2-dhu@x6u.co>
In-Reply-To: <20261030181512.2056056-2-dhu@x6u.co>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|CH4PR11MB222363:EE_
x-ms-office365-filtering-correlation-id: f1d14584-c464-4bd5-57a7-08df3b3b6903
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|261021121427099003|261022105027099003|11063799006|10067099003|4143699003|261022113327099003|261021135927099003|56012099006|261021123027099003|261009223027099003|261026121527099003|261028144727099003|261022075727099003|261022115727099003|261021130227099003|261102123227099003|261026130827099003|261026140227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: lB+O9XPdkNOTiKrtMIn8ddEpL6zksUIDekzehefFqYvEDfW+c/yU3BBzu3zFX5Pc4uptauXxYHZUw2o5NpjhBBwk8SHARsySLKwqhsBKp0d3S4jP70Z5Xd8nZixqaDBBurTjRfkngRWLoCDyIg5qA1AUaGOX0srie+D4eojGM0wUHM+GfdFNAlvRi+W4ExhGTMytLcsuTHyV9iwYEB2uipwQc564xAKhlFQT8llPqW2oYF5UgNF5Y6zsWUAiBgZWxve6MS+cHa4pdB3swjcE7CkNDcfVrV7CiGDfH8CBciqkP1vfYRztLe69EHyZJu7JhTosRjUXoZTWVnRgfSwBRshZY/uJewsuac515KhWRNG1ydedYofN8ALsIIGQW9DAUHjqAA0bMcp4U676EtvvO1ugtkzUucWI3gZKHVE3l62nI+dZ4PKP++pPJyTaruzFAPvUNMNHhWjyYQRqYvZFqy5g9ZSSm8rzlZYmA/uIeBmxAxi4ywB8PtUu39JWzF63cF6Vkp14dO/6tzjMoq6jef/iKbqMmcTz9cH3SS4qOkhPPvtFLK0IxTs+dY5NdHoivYwOYh5MX57iDvpEFaz1A/n43Olpg0iHVCtOU+tD7OR0kgW/hpyDX9lwutMqqYy71mvE8IcoZYHW5+IpX3MDdHJx0iCU35++8zv0mkY6bQ1lXKpSpj1hH1avTBwX03mNbhCgScJpGNEXs9/MnKD3wwVf0xHxxnvDOVVAPeavW9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(261021121427099003)(261022105027099003)(11063799006)(10067099003)(4143699003)(261022113327099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022115727099003)(261021130227099003)(261102123227099003)(261026130827099003)(261026140227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3OBURU3ehhdcyLzlPSgUWS/TjJcZyzty/ie4D6uYLOBQzz6sfHL5dvzpvSQg?=
 =?us-ascii?Q?XQGCNuGGq1nkwqZCHuywU2k4dvIGdNAeMk0jnwDB8EdRd7GlbBL93+qJL7so?=
 =?us-ascii?Q?MJAFXD8fER7gHTG763x+lLSiyp/P3MRKI1yTYYAaKTch0elq4FOFpbI09Ubl?=
 =?us-ascii?Q?gh0aqbtoFVukfZs90x3hPVB8BdsRzGPg9BS82EEPd5KaDH3Zn4UXsqxGqwP/?=
 =?us-ascii?Q?WCIzo+pZ6OB3m3jCjYdny5mjAeNPKXWdOv3JrlQIR1SNp9yHvUESp3AKFtmW?=
 =?us-ascii?Q?rZqVyRNeE/iC/2Oii9Mj0Df/iTD4QTyt7jB9Qsvx4qicvsz1YR7fcZtej5H9?=
 =?us-ascii?Q?xiXkJjCMg/H0grhc/+HSZP6Wo8BPFxuFqP4IsxUfRS6qnLOp+RSzzxvg/f3I?=
 =?us-ascii?Q?ytdMjMg+I3hFh7pY/5dUclAnIqbZNRdkwacPX0osMXNeGCIwzReKxob9iXV/?=
 =?us-ascii?Q?TnZHQeYrLE69WKbAcYLh2QtejubA5dx3FLEclm+NU2++HiNOJCObI4Ort8T0?=
 =?us-ascii?Q?3a2swxrd43/6w20ORQWG6DNx6duPRzEYNhunHRYlmNPF4H8TYT77jnv2JsQQ?=
 =?us-ascii?Q?+kV4lLVcoGaT++Kx3mbmsR+LTqgZKEfMgCjsZ6UH8rC+PHfKjQ6SyaSxeweA?=
 =?us-ascii?Q?6xucV/w9IC6lHt6n8gEq5oxkrQAFLlNy6UYNDZxrRT4C6B2MqhcVe/KZG5tP?=
 =?us-ascii?Q?qeZS84zFLSm7QXP6BcKURTxMgTusdlXQB4s8CurNSPSMGe8lURSgfbrI2qe+?=
 =?us-ascii?Q?ZTv0nGcPhFC8DyrTc4Fayew5XkfHzSUiiw05P+QleYFrIyaj2aLJK+rT1q/x?=
 =?us-ascii?Q?iPMahv0pxaPX64T+uuTK8vpGgi3zjU/RBW3Q6PsDMTQWhN4E6oT6zg947R9O?=
 =?us-ascii?Q?FauP4BDE6CQdAwzbF3IbSdtW1gri5y3etZ59ByeO6mE0jJljHUv4nlQ19fFk?=
 =?us-ascii?Q?FKxwS2gG9RA2z2KwEQPuhm1PiTQLJl7+KLDR0CJgSu+7v4RB0+O1z/TtiBes?=
 =?us-ascii?Q?SDnDq8ggRQ7jSe8NH7NtwlZNGm8GAbMnhsbem/nUfPqJ4c5W0Nw8nPTnWg36?=
 =?us-ascii?Q?x46P4BJAqlrknANeX4M/I+6pOpDNcVhJlJjNPHUoSjZheNNLJLGaX1NkKO1c?=
 =?us-ascii?Q?esCsV75dNA9VHU82zNLWd0IBP9l2FrxRWEHv7k+PzBlSaJCv8cs26+0cXABx?=
 =?us-ascii?Q?7O6zVnaA3kXXey0fPPeoWrt/Hw+QvmCwqLFGaAg/Fk2IHgEk6ssFrwOErvhv?=
 =?us-ascii?Q?6H9GZ2Bt0NDSg4IcFGZVw63dRsIXmsMOi7um9mRiEGu5bW3TvE1Haps+nOHQ?=
 =?us-ascii?Q?W+sV3lXVKChPlaxn97wWtXc9CJu9Llgc6zBVVTygf3zux9OV8HwU/58LJZeV?=
 =?us-ascii?Q?L9MZyIKh2vnk/c0vbbzEAfpzC6LVMKR1XKdl+jztxVwVtUZ1mzFseOxmYV83?=
 =?us-ascii?Q?s5grlfzSJ1Yq9U8qFXXmBFZVjkGUGhTrEdxq670duzg23Zh3wLGTHQQERgxI?=
 =?us-ascii?Q?XYo2CX9rtGf8AsjWy2IbxFkA8TNH2kwBCnMJOhJu7A5zk6L742UXbTkNwU86?=
 =?us-ascii?Q?1twmVTkVjYyNP2MvDLfL2OaHxpKCIXBpV+T5NlzrcoJ9f0B5o/cFjF7pHCCQ?=
 =?us-ascii?Q?0awqy+1pSwUym9PxJseSHkYmCKmm2aWMzNfRas8uc3BYOpctkngDrOHrqQMM?=
 =?us-ascii?Q?TLOUPYo4v3VN2EvHrEPYyyM5jyQd5J1ig0kJhOjVudTIhw1butg60+HLppnm?=
 =?us-ascii?Q?TfEhbr1udrt8AWwSufUyv6tZ3UY31UM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LwkuJVgHtlFIh5Yjw9SRLcfj/MZsqOV2cEtpYIEAqbidmpefBQzuC71VmxGLooVOtydtVnsrvgCLeW3Ia1U0n7oTFyHb4ZUJcqmhPOieEIjfcRHG9cIirfTyP5uMbTP+gN6OJ1A3TfSRzuZM0y+QluwXvmZXWnsFEGeDA1E23c/3FYAONjacydJvsNuv4V+t+VUfRMuuoobxnsVdHiTcRtjNF46vpJFk4F4d/dU/vj4V5N+C5QWetY0H+bSkgs/An0Wd4TZgr7uXLyXZztXkrmxNAeMOYVBRno4vGEPHplhyT1xXqM2BC+z/5sf5RkT/csqjBDSvjP3UALWBnPMxfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d14584-c464-4bd5-57a7-08df3b3b6903
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 12:50:45.9761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98/3Sl4Xd0Q5LVdxD5OtfgcUa7tjcjZG/+sY+j7sY4LmF4VcBoIbqGkwGJDgOPO72GNnZ1cJFNoWegEJpNs3oQjpGw9/FNbTSBm04PY2jZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB222363
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: David Hu <dhu@x6u.co>
> Sent: Friday, October 30, 2026 7:15 PM
> To: Mustafa Ismail <mustafa.ismail@intel.com>; Shiraz Saleem
> <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>; Jason
> Gunthorpe <jgg@ziepe.ca>
> Cc: Jacob Moroni <jmoroni@google.com>; intel-wired-lan@lists.osuosl.org;
> linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; David, Hu
> <xuehaohu@google.com>
> Subject: [PATCH rdma-next v4 1/6] RDMA/irdma: Plumb uverbs_attr_bundle
> for QP, SRQ
>=20
> From: David Hu <xuehaohu@google.com>
>=20
> In preparation to support modern UVERBS ioctl attributes (such as
> UVERBS_ATTR_UMEM for CoCo DMA bounce buffers), we pass down
> `uverbs_attr_bundle` for inner QP, SRQ routines. Since standard uAPIs
> provide `ib_udata`, we derive it via the helper macro,
> `rdma_udata_to_uverbs_attr_bundle`. `irdma_create_cq()` supports
> `uverbs_attr_bundle` already, therefore, this patch fills the gap for QP
> and SRQ.
>=20
> QP, SRQ uAPI will now have `ib_udata`, and CQ uAPI has
> `uverbs_attr_bundle` as a top level input. However, we think it is a
> future project to unify them.
>=20
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c
> b/drivers/infiniband/hw/irdma/verbs.c
> index c91c55917de9..811b1d532599 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -637,13 +637,15 @@ static void irdma_setup_virt_qp(struct
> irdma_device *iwdev,
>   * @iwqp: qp ptr (user or kernel)
>   * @info: initialize info to return
>   * @init_attr: Initial QP create attributes
> + * @attrs: uverbs attribute bundle
>   */
>  static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
>  				struct irdma_create_qp_req *req,
>  				struct irdma_device *iwdev,
>  				struct irdma_qp *iwqp,
>  				struct irdma_qp_init_info *info,
> -				struct ib_qp_init_attr *init_attr)
> +				struct ib_qp_init_attr *init_attr,
> +				struct uverbs_attr_bundle *attrs)
>  {
>  	struct irdma_qp_uk_init_info *ukinfo =3D &info->qp_uk_init_info;
>  	unsigned long flags;
> @@ -981,10 +983,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
>  	struct irdma_qp_init_info init_info =3D {};
>  	struct irdma_qp_host_ctx_info *ctx_info;
>  	struct irdma_create_qp_req ureq =3D {};
> +	struct uverbs_attr_bundle *attrs =3D NULL;
>  	struct irdma_srq *iwsrq;
>  	bool srq_valid =3D false;
>  	u32 srq_id =3D 0;
>=20
> +	if (udata)
> +		attrs =3D rdma_udata_to_uverbs_attr_bundle(udata);
> +
>  	if (init_attr->srq) {
>  		iwsrq =3D to_iwsrq(init_attr->srq);
>  		srq_valid =3D true;
> @@ -1071,7 +1077,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
>=20
>  		init_info.qp_uk_init_info.abi_ver =3D iwpd->sc_pd.abi_ver;
>  		err_code =3D irdma_setup_umode_qp(ucontext, &ureq, iwdev,
> iwqp,
> -						&init_info, init_attr);
> +						&init_info, init_attr,
> attrs);
>  	} else {
>  		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
>  		init_info.qp_uk_init_info.abi_ver =3D IRDMA_ABI_VER; @@ -
> 2337,7 +2343,8 @@ static int irdma_modify_srq(struct ib_srq *ibsrq,
> struct ib_srq_attr *attr,  static int irdma_setup_umode_srq(struct
> irdma_device *iwdev,
>  				 struct irdma_srq *iwsrq,
>  				 struct irdma_srq_init_info *info,
> -				 struct ib_udata *udata)
> +				 struct ib_udata *udata,
> +				 struct uverbs_attr_bundle *attrs)
>  {
>  	struct irdma_create_srq_req req =3D {};
>  	struct irdma_ucontext *ucontext;
> @@ -2420,6 +2427,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
>  	struct ib_srq_attr *attr =3D &initattrs->attr;
>  	struct irdma_pd *iwpd =3D to_iwpd(ibsrq->pd);
>  	struct irdma_srq *iwsrq =3D to_iwsrq(ibsrq);
> +	struct uverbs_attr_bundle *attrs =3D NULL;
>  	struct irdma_srq_uk_init_info *ukinfo;
>  	struct irdma_cqp_request *cqp_request;
>  	struct irdma_srq_init_info info =3D {};
> @@ -2430,6 +2438,9 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
>  	u32 depth;
>  	u8 shift;
>=20
> +	if (udata)
> +		attrs =3D rdma_udata_to_uverbs_attr_bundle(udata);
> +
>  	uk_attrs =3D &rf->sc_dev.hw_attrs.uk_attrs;
>  	ukinfo =3D &info.srq_uk_init_info;
>=20
> @@ -2470,7 +2481,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
>  	attr->max_wr =3D iwsrq->max_wr;
>=20
>  	if (udata)
> -		err_code =3D irdma_setup_umode_srq(iwdev, iwsrq, &info,
> udata);
> +		err_code =3D irdma_setup_umode_srq(iwdev, iwsrq, &info,
> udata, attrs);
>  	else
>  		err_code =3D irdma_setup_kmode_srq(iwdev, iwsrq, &info,
> depth,
>  						 shift);
> --
> 2.56.0.317.g454f8302e1-goog

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

