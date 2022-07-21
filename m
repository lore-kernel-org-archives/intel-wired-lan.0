Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E5AC43334
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Jul 2022 21:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32432818A2;
	Thu, 21 Jul 2022 21:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32432818A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658438138;
	bh=lilKQPRNE/cFOd/cr/2kmARuGsOO+kiJKv2XTkCu9+E=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7PKaE+CR4YgQv7r/czDXGy+oLw/eYlFnXZPnWoCIqHiQv/kBxA1eLSZNnsDlbqKYN
	 p1iLK3Z0E/zvF6LVkSJh91MG5O7iuabSj1PEi+nyHxyghRVL9IMr9zuJb4hVSIMOmq
	 tsBTWvbo3vbhmRPbO7Y55TZzrvdRY56SLAL5e4YrLr5fSM0KDEnowBdO3+BE1WTKr0
	 DefxKtHeym39rtGZ5NJIVBp20Zmvuy1RnsOBVIwXi8m2q4RXcqzgRed0DUlpoo/Btg
	 fEW6RsGcZvzXx17qkcRCMhMMWqgnpDOWlbRPwGCTodiGPoPCKj0f8KedsfBTGVoV9f
	 fU9q+BVwIg0jw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Bmf2H_jC-b0; Thu, 21 Jul 2022 21:15:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 342C7818C9;
	Thu, 21 Jul 2022 21:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 342C7818C9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 524531BF375
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5F6860B8C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5F6860B8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdHjQbEPgh_0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Jul 2022 21:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2919460BEC
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2919460BEC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Jul 2022 21:15:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348874491"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="348874491"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:14:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; d="scan'208";a="925816204"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 14:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org
Date: Thu, 21 Jul 2022 14:14:48 -0700
Message-Id: <20220721211451.2475600-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.456.ga9c7032d4631
In-Reply-To: <20220721211451.2475600-1-jacob.e.keller@intel.com>
References: <20220721211451.2475600-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658438121; x=1689974121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IgQ+/HMuFU5/Y784herXZ7Q8bHscE6snojWqY83h2XY=;
 b=AS9JkXkp79l/LOymVPpICYjmM0RmhNK/L2kdtTpeDGLzl6Lj2bjrD9UU
 gO4RHKyQH2NEbsqzj+3ntHvEK2skoZ6j0J+c6HZugNHPMMaZxxXtMNpx+
 408MMR99eGD1gB80KADRRQ4qq0g6w4Lgze7ZOCNHTGv8TRKbR4Ht3GdsK
 pbY0NrFDi2FEld9R2dr7ha3lLMv00oYa3AEQM2AIJ3DPfUHW/c5xxmxYt
 jfVEIu6SkzMTHH0gaagKG57vyjmu+XY6GDC7tI6uzeqXRQUsKcmyL3hLM
 bxsXC8OVfXFLojD/QB/pLTkJnzLYzVjzmz6ywuzEy4u+yLrxCYEcBcYe2
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AS9JkXkp
Subject: [Intel-wired-lan] [iproute2-next v2 0/3] devlink: support dry run
 attribute for flash update
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
Cc: Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org,
 David Ahern <dsahern@kernel.org>, linux-doc@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Allow users to request a dry run of a flash update by adding the
DEVLINK_ATTR_DRY_RUN.

Because many devlink commands do not validate and reject unknown attributes,
this could have unexpected side effects on older kernels which lack the
attribute. To handle this, check the socket and determine the maximum
attribute the kernel supports. Only allow passing the DEVLINK_ATTR_DRY_RUN
for kernels which have the attribute.

This allows a user to validate that a flash update will be accepted by the
driver and device without being forced to commit to updating.

Changes since v1
* Add Cc for maintainers
* Make dl_kernel_supports_dry_run more generic

Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-doc@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org

Jacob Keller (3):
  update <linux/devlink.h> UAPI header
  mnlg: add function to get CTRL_ATTR_MAXATTR value
  devlink: add dry run attribute support to devlink flash

 devlink/devlink.c            | 45 +++++++++++++++++++++++++++--
 devlink/mnlg.c               | 56 ++++++++++++++++++++++++++++++++++++
 devlink/mnlg.h               |  1 +
 include/uapi/linux/devlink.h |  8 ++++++
 4 files changed, 108 insertions(+), 2 deletions(-)


base-commit: 4cb0bec3744ac4f8d21de0e769f170e4059c6b9e
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
