Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB32C0032E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Oct 2023 16:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 845E940037;
	Wed, 25 Oct 2023 16:08:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 845E940037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698250113;
	bh=VFkxF7bOvY6zTsJYQ19oxghViLXgYqnBCYD0Yi4fr+0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HsDx2Q5IUYUKpginjHomHQd5u0WRduaTffzMyzI1S/FqYpYkTQMKkpnCYchbIaWyY
	 UqJScmruMbWXpXuDSkpypfG/E8CIM60o1oK0942Akx/3EgkVKSYF2tBFjkCtkBHiob
	 AxwWdv7WKSxV2d9OR2JKOmIEZzq5ow4eetZk9ZqWzZYg6+c7Qbzcx39jAM4m3Eg/JV
	 ZQHDY+e2ocC57imFBc23SPIuTGjdoDtQ0+0Zq4l8FDKYTkeRkI2ILVbPtbElrQYL30
	 SFFckWXi/EY8BO/SVuXB9A2/gotw/fXAgDljGswTzcVKrhGeKJbDisDya6snYVoAHG
	 bayc+9IUPInzQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3VjwWdEfoop; Wed, 25 Oct 2023 16:08:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9614B4004B;
	Wed, 25 Oct 2023 16:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9614B4004B
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 988401BF276
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 16:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AF0860592
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 16:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AF0860592
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id exOOH0_-2kLy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Oct 2023 16:08:30 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00DF56058D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 16:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00DF56058D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D39A9B81D8E;
 Wed, 25 Oct 2023 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0623C433C7;
 Wed, 25 Oct 2023 16:08:21 +0000 (UTC)
Date: Wed, 25 Oct 2023 17:08:18 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20231025160818.GJ57304@kernel.org>
References: <20231019135342.1209152-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019135342.1209152-1-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1698250106;
 bh=qujSkRF7+AONGoOyzL5iEs4HyhHB1A7/KwcVxpI/2zg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hhe4jh7N3pSu+gEqdcyo7MNZVayhegtdhvTp999RtA/HrfW08chTo4Jn4dOi2LsGE
 V6BeYiJ12107KrejTtMO4sqS+Ggb+/Mv3Cqs2bKxy4JUDJ7/RHXr1xFsMKHd+cuOKN
 JEbdfCMnY+ipAb6YmSB9DIA+5NTYXYE4ho6tXpX4wRm2LaoUqCdBrX8SuyMmWslUqV
 cM2NX5WohOLtXxOVHn4uOrbHOl/zIUasH2D1G4libVed1KbRiFdRv7Wkr5BlTfTjLg
 cpGWVBwkPc/NczjX/MQ+xHLReVfTXxZeib+Klzj1PqYBrnrIqs9ob7sKG2pzZaqOti
 2nva9RTu3q+qg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Hhe4jh7N
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Fix wrong check for
 I40E_TXR_FLAGS_WB_ON_ITR
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
Cc: Catherine Sullivan <catherine.sullivan@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Anjali Singhai Jain <anjali.singhai@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Oct 19, 2023 at 03:53:42PM +0200, Ivan Vecera wrote:
> The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.
> 
> Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks,

I agree that I40E_TXR_FLAGS_WB_ON_ITR is consistently used
as a i40e_ring flag, other than the case that is corrected by this patch.

I also agree that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
