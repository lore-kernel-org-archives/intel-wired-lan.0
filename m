Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B177DC4167D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Nov 2023 17:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 688F041BF2;
	Fri,  3 Nov 2023 17:14:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 688F041BF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699031645;
	bh=fzoq5nrVdMsQR44siXDu8LIOhYJ26dovfH1coEiDLsg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iXtuauzF/daDoq8eVDjvZWyrVigcmYJaWGp6guFlPaLOZn/EuD5QQjH877XOP9IBN
	 kNOcGYGkNpuyYiouR5e3wz5YTP8EzfeRc4QDjR8oBInpOChRjXpNyjX7yGjZGPgo+j
	 +FWhmu2u3ofrWEyj/J+yYiJ2ELGBST7v6wDTqKD8ZQbRTQMBU2HBTAj1/3CVsl5fAY
	 xz1wuvE/FqJkZdFKkLmXoYjZgvaUA+/m5IRVU1SSBsq95tky19ArNwG/yHposzS833
	 wohB75I/Ja0nrUgnBnQPmhdawwdd/XObwtMl0GL4DY0olCVpt/Jw7GhFd4eWaOvLDX
	 fAYC3Nx24MovQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jx7SpPz2hLA0; Fri,  3 Nov 2023 17:14:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7978A41BF8;
	Fri,  3 Nov 2023 17:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7978A41BF8
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 78D8C1BF21A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 17:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50AA560A97
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 17:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50AA560A97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rs5T62vbmvQD for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Nov 2023 17:14:02 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B391060A8C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 17:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B391060A8C
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B4671B81F78;
 Fri,  3 Nov 2023 17:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF03C433C8;
 Fri,  3 Nov 2023 17:13:57 +0000 (UTC)
Date: Fri, 3 Nov 2023 17:13:54 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20231103171354.GE714036@kernel.org>
References: <20231026083822.2622930-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231026083822.2622930-1-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699031640;
 bh=i1/OCP6nHwLYZipGp9hjEQ3J+qcqL4DAmtnlCVaSDqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s5to2z2eyOIQrYaKX3IjmVMzsSpkh2bZkXp3Sqv27KBCY6mmo/R2twyhRcxqpzpyj
 H5dGKPKcwqvbFQJ/mi8MtB/CwI7mhPLMOxKJoi+z/1xm20XxplGjR5FdYtzqk7OWaq
 y5ayxEyYL2pzmNy+JuvGsE4mTJXsQ1wklVC6G81wYR/TwD0mfOqx9QCVx87MsD8HHQ
 kvRA7K0lIi/+FJdbogUsko5plKqmEzYPTZP07RIsz2FUETDojmrh55pZxy2u6JwbG+
 NZvWx/NLyX9qjon10RPbalzWtg16ebUfqwHp4av1NLDDSNKiffldCjRVCGVOySt/wq
 wrZrczhJZcWRQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=s5to2z2e
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: Remove AQ register
 definitions for VF types
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Oct 26, 2023 at 10:38:22AM +0200, Ivan Vecera wrote:
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks, another nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
