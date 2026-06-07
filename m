Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8BBCD8C8C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  7 Jun 2026 18:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF9661060;
	Sun,  7 Jun 2026 18:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QySVlMz9QwD; Sun,  7 Jun 2026 18:43:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7A3761B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780857829;
	bh=EjtkuncPzpU+zLvkBIiESV+ZeOqOheMDo2Qtqj6iFrQ=;
	h=From:To:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cYkGWI6BZOoCb6y1B5oLMAWk2psIYRxLCjyk4zXbLNbpp5GhHUcrzRmXL4VtUZWua
	 1jK+OOLd3JcX6v0bCx42/yHtpRZBbEgNRKDbwv/cBEa4HgRJbtnD6VY7w+3/5h7hrS
	 Tf4SOrVX8xinZSd7ZX1sRjQW47nSmjJCGaX4868q6Arl4hNhxhQcwFYhL8ZrJmcrI9
	 DEj6hwOwacBCin6lIswZlN1XX/Yu2AWnrBNhgB3J3zbXhJA2VMZPqHL5fxqvlE7JY1
	 sorJx0e8zYnOiR1qG7PK81XeLxHE/8H7LvqaMDQMbFNN22B9z29dLU64bm5dsnNdQy
	 yJEodxLQMQhCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7A3761B34;
	Sun,  7 Jun 2026 18:43:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9532A345
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8738B61B34
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cq-xbuMZ0g44 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  7 Jun 2026 18:43:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9160061060
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9160061060
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9160061060
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:43:47 +0000 (UTC)
X-CSE-ConnectionGUID: aSK0HGyHQMCtUeHykmbzjA==
X-CSE-MsgGUID: Hw/qBrzbS1GDPziZq68K5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81664495"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="81664495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 11:43:47 -0700
X-CSE-ConnectionGUID: hoq6MSf5R7Ojj8TuvAeeVA==
X-CSE-MsgGUID: MJxUALnpSDSvSg9IUrj5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="241153954"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 11:43:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 11:43:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 7 Jun 2026 11:43:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 11:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Q5WHBfuXDY6JSkSrqjXWOrWUTlBPJXp7mqfYxqASnoVIQlxjc2SwSB7YMzcW3PCVqrEqVwytjM579gvbjBwwjNdKEGvLM7noHACh4X9qTBK0I32nqoUSJhhhZJlmkbhC3Xr1fHZWi5qSy52Sm97oK2wsqXFYi1emVmNNkVF4/sWos/9vnnpoZ3ppzrmDnNBJjoijn7cmJu3jiZX3rjgJQqQoDece6iifZL/7/ffg6VUwDBpvdpaUDq++N6hfjAzkVC91kmJ8iXL0lX8GpKxi7lVcLsdRZHo9/oy7rwF5IyfTl0T9qakAaEK6QWXxWzFsU+mGSBDRr2KKlO2y5H4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjtkuncPzpU+zLvkBIiESV+ZeOqOheMDo2Qtqj6iFrQ=;
 b=nNJZy/6rDPtSFUykY2OuEEf1XipdVw3dMRZ2lwh//42BetLaZdTAskBh1xwXZc+2AlJJVuRoDcu25etpSaL3EshZw3VImjcI+J+GiEQRpKqiRKlcfobym6qoXlgH0TKvHw96MLXRGBxmyt9CGty7nQ0YgMSq5nwmeyEqFYxr5ZjxE7PTQJ9QhwXz0wAeYSxBKI/3q6Xi8Jkj+McvZfeqV5rMzkKAP+msG8KD2lpYuchB2b9lP4Kvmj4sj3vQc4+1vI+0iiFuKfGv7NFC80eiW6Z2Xaei5I917yn/Ex6SvxghvP/I+9tzjcy5w8x9N9bNTsWwnrF1D7x0O7mvy4GkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by CHXPR11MB9673.namprd11.prod.outlook.com (2603:10b6:610:2fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Sun, 7 Jun 2026
 18:43:40 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 18:43:40 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Thread-Topic: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Thread-Index: AQHc73fbuuwofGiUWEqM+0MeGgr+dbYtpIwAgAEzHgCAADOQAIABGPFggACCTYCAAtS1oA==
Date: Sun, 7 Jun 2026 18:43:39 +0000
Message-ID: <IA1PR11MB6219FC5035A394BEFC7537B9921F2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
 <20260603183036.7c4762d2@kernel.org>
 <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260604155422.167314ff@kernel.org>
 <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260605162615.0987ff2a@kernel.org>
In-Reply-To: <20260605162615.0987ff2a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|CHXPR11MB9673:EE_
x-ms-office365-filtering-correlation-id: b76eb4c3-762e-4b4e-aa1c-08dec4c4b188
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099006|11063799006|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: 2ZoerhrQH0jgbgWH7oZs6pv8sIy2VpxDBJyPXvrH/Rb0WuPfkMv6hQacOEO+V+PVBB3wre6fvHhKTD/wnxByYUMqNYQHjYQKKfE/Cj4vJ5DKGLtzQXv5RbY1e3KHf+9b24PJHqjUt2wfd5iJT48fVAqvgeKOlWbQPUPDJEU62yN6727hde85i4n1IGMPA1by2lWnagtLoJlhk+hO7h+lNEoBZm5iHTZ2+PBFGcrtfdsIPn5L/pUTfgDKqBQnBdvNf0sjih2tAzy3nO1ZT+tvXpzOJbdVH39RT7jrnyi1wrjAB8QqWxzq+rsuVeiccNKXKKRV00YFWLvMvCi5hBKMdjv1ZkW5DsqxcC6mGQvmjq61i9/agJEuF5SQ9Yoi1VzhjKCHAZiiKvH4dHzh5XkS2qKiVwAMw0BYt4dprjHeHYOd0FSdj9qvEV/XTKHgkXkQR86YbSF4rBBOAIvyieAHist3kx1JCOk5eZ7DE+JyYcBmeOr/PBJFx6xleNmnMKIeme335NeTwL9MY+4E9DEtTyQ7JiKnEPXklubX8ngjGeQp3x2K5cMxWgQO89W2LZnCjMt9qKI9YQwKQWQ5Ft3zkAJE1ingDgxBlDatgUHSSQg7uINCci0qIoFMCg5TjRPgA9XU598ddTsvH8cjScqWWCb8DCyDbp+4EI3MhHVdgUck6L1+KEfn8aipe6/m39eR/nnBivplRsoujU2rV02J52pDq7BxtbhTJgdh/HqBjrGV39gM+fF406kPk3r0cgeq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49Y+UIeI3N+wizTpsES2W7NpHtBdfu6jM9PVxg3I6l4xrIvReadgVQAQcc+J?=
 =?us-ascii?Q?30QswieJM89ktIeu2Bajnoz2259Gm47v4b2sU2P8f+X7y5ZaBdLb+lsG/J2V?=
 =?us-ascii?Q?vJaTnwOE8oht2N/Z4zan2sbp/s4zGXsnSLJ6tfWVRvwMAFqxaT2Z3KMrWVvD?=
 =?us-ascii?Q?4gNhR8uWQTc4M3HHayF82pWci1gQ+XSSSlQFVfflXHDAP6waA2EqtqRBTmDL?=
 =?us-ascii?Q?riGtyGBOir9oXIPSoWeISrb+49CJdUjEKs9ZzLfm9WVUl1mCiMAsZrj8zZCe?=
 =?us-ascii?Q?EJKO0B2HI1z7SqWw9vcJ/YnNFqKEjZV0xYOLunIr21DB/tR/MucxqKz47d31?=
 =?us-ascii?Q?U1cgjjtnGc6lSiCAtGkGlHlOAQJcnuoaImACK6mmAx16+35C/Y35lXBLlvJz?=
 =?us-ascii?Q?nPfrveP8Q6ho8Lq0j48b8WoEOLZt3bqf6WBRqQ3Sq+t+0Kl+EQNTtmPKLHV+?=
 =?us-ascii?Q?xaJy54uZixjYCFtqRJQAeJQjLOP8fntXHeXOEp//grmNYuB2Rb6iu2EXifw/?=
 =?us-ascii?Q?UjxZxIZGNXpSbSfkJN9wE7L8xZCam/qfLYaNnrAMrT5FfpAi0we9NBe3pau8?=
 =?us-ascii?Q?Flh2LsBnx+NHI5T8FcNgcdxY+2Qj7bg2dgUZenhT5HlqEPllUWpPHxeAI6zm?=
 =?us-ascii?Q?7jPZqKWMHbG9T5mulpgVbg6Z+0ifCa5/e3cNX6DwN+TKYl3jZY6qUTK6R24F?=
 =?us-ascii?Q?/teJDZFT/I4SPSJMGiyxOajSpcLU+K8f5Px7IHxutd0q6D41gYzVRYuZYF8/?=
 =?us-ascii?Q?DUq8TxmcsUyMbRqvjbOlDLH9Zo7GI3VwTw4hRhlEU5uzFvGuhT3wMb7JaiJK?=
 =?us-ascii?Q?SOTbxOro0kb9mWgZdFXSLJNKUe54ac/t2IcfyzHvEbN5+rW6jkOgEpa66PbR?=
 =?us-ascii?Q?G7v9ViESYlkylUJtCMgwvXjzB848wCJlAGPVlDndRnU1nL7Kiq8Fyu+BCtVY?=
 =?us-ascii?Q?gdNdECujOwd+Z4vpDMmNFSXVOiczZTRiriGw/fh/FknBR5Or6mJi6AG1pRNb?=
 =?us-ascii?Q?KhcpcWLvbdt6QcP0YwWmpR9VAnB0FyWIN4c7yffn37lphLwD6Q0DuN/0mVgt?=
 =?us-ascii?Q?Amz2hvPdGSNDRZPS0tOJIwUpGF1kb28sua1XKLpAYCnIAdXwE8o6Hlpezdw+?=
 =?us-ascii?Q?D8XKw4Xaa0czma+dNNaCZbWarqdQXj5TSlPn7Cc7A/o/EJwMw8YMmKFhVV1b?=
 =?us-ascii?Q?hVG/MzYzV9T1Eyg+sjw6+HX1doXwGQK8gQyNpzxbNIbml0YTK7VkSQW79XTJ?=
 =?us-ascii?Q?F9dxuIkeVfOAts1A8N/1DYxo6eNTJPut3vIAQKJSoP0OH9fyNzv8/mS5hNvV?=
 =?us-ascii?Q?TUB9TQlR0YUIlx2B+RHuukFO4eWJTRii28YBTzGwmxcVAhhuOqVgNWJAXLKy?=
 =?us-ascii?Q?ium+V1ffS3pLOGlJxJV9aNZakDNPrLcF6ZsbprqkhumFNmCZYqn0NKISauBx?=
 =?us-ascii?Q?Dk4Y6+Ri2Gn16lw69Fnyf59PAhIxHVpMQgOJH5aHpQ3IKx+HcmrL8WirkK8K?=
 =?us-ascii?Q?+h/1mHLLdEvD4VrzEewGwN8+7PS52iAt6fJZd559f2hhgy37ywzGr9gEC8fw?=
 =?us-ascii?Q?HMVV//k5gbk5AcpUteSH35G+tK8fklbi9P/xfk3+qz5Nxg8mhEbCNst7NH3o?=
 =?us-ascii?Q?OEMOdk1Fi7/aT1XBHoBO8dhzVOlCFBJnMarwTGd4atvsAaFy+7Emq4T9by3N?=
 =?us-ascii?Q?nJ8esoZ/12hFTSGBRW7vEB72aOa57lojJO0Ib5ibByLX649arSnrvP6Wth3I?=
 =?us-ascii?Q?8gLHSULNzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QAaM7+U0GpAh5cB+cCLX/6r78KTe2ttS59tyepMWrZc2b8rHPpepumD8Rjtyv1PGtb1xsGgvDQ76Ldt3VLWul6YimI4NEBbvbZ7ykRmz5+lB/rP8O1/EndbT0o6pLfRUrsViyvRH1ntU+OH3/5cJEJyGlgjCj5CsFl4LVkkNRKCCyCCPqDl5TkoIq31B3KMblZVN9yoXokZRGUnzuz70yMo8l3cFGvB55+pz0dilvkN2gegUWFP4MwQosb9wopP2byjI63rbXSFOdKaLoh6ceFtbkEkHDv4L8O9Sf347m+XxOIX1+Dx1dQ/RhRgMRNnRmF/mTFGwcM5xaeWBEQiXDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76eb4c3-762e-4b4e-aa1c-08dec4c4b188
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 18:43:40.0256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8pHVaD3uRxSgwWtrln/H7Y+5sSUT2SEGWXXoRMfDpQXsL4jQt5XotRXg6F7+27VC96vVoOOAXmVh4nCFvcN2L04p0yq6r3+SaMVbVF2mi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9673
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780857828; x=1812393828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mXVBOGBDXOHHZmQ9dVxgvwPBvTbzq8rfAPBeUtEg8Sc=;
 b=PPFlajxP4z1eWbFYj0y4q46IeEJiSdMZ6VSOwFSG9TejVOIkSszUN5zc
 voo153DsFaqS5zJQMAo1pjU46ufEFLbboHCTJ1vn3aSi0LEDnENSWuxID
 uHJ2AH1NY0bYAOWZKUrOT4A45280gOV5CufhBBeDrwJrCPkK6YgCcNRt0
 gizCb72JoQ7WhlNpXWuHRj8ZT7kgNmUczAsQmUFf/sXN1bet9wOcHB+O/
 tBMmvfjz2bOKZ/DxYxYqPPb5mFWsUXtcvH9Z8jTW8Fynp+2xpBVbYATRY
 S2B96uZKM+mRCW9ypjH1HbZGtWx4t58+yT2tlQWYolA/jGOcPtT9bPvaH
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PPFlajxP
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 0/8] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, June 6, 2026 1:26 AM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; edumazet@google.com
> Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and=
 full
> TX reference clock control for E825
>=20
> On Fri, 5 Jun 2026 16:10:19 +0000 Nitka, Grzegorz wrote:
> > Hi Kuba. Just submitted v13.
> >
> > It includes the following fixes for pre-existing issues:
> >   - dpll core fixes. Each AI review concern (3) is addressed in separat=
e
> >     commit. If you think it's better to squash them, let me know (howev=
er
> >     it addresses issues from two different 'old' commits).
> >     Also, the hint form AI  to use different dpll xa_array (parent not =
pin) to
> >     address one of the issues, it simply does not work (WARNING flood
> observed,
> >     more details in patch 3/11)
> >   - ice driver fix for potential hung on flush_workqueue in error path =
for FW
> node pins
> >
> > As you noted, two other pre-existing issues are covered by ICE_FLAG_DPL=
L.
> > I left the code as it is for those concerns.
> > There is one more pre-existing one, related to ice_ptp_link_change. As =
the fix
> seems to be
> > rather simple one, I believe I need more time for more comprehensive
> testing.
> > So my preference is to go with standard fix-path on 'net'.
>=20
> SG, thanks!
>=20
> BTW either you or Arkadiusz should chime in on the NCO thread, please:
> https://lore.kernel.org/all/20260531194423.383366-2-
> ivecera@redhat.com/
> Shouldn't take much time to express an opinion, I hope.

Sure, we will do on Monday (we had a long weekend this week, so limited
capacity).

Regarding this series. There are another pre-existing dpll-core findings
reported in v13. As I still had to address valid critical/high issues in 'i=
ce',
I added 2 simple dpll-core fixes in v14 (just submitted, along with ice=20
improvements).

Regards

Grzegorz
