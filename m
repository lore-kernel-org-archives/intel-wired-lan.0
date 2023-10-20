Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E646C001E0
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Oct 2023 00:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF89A8472B;
	Fri, 20 Oct 2023 00:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF89A8472B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697762950;
	bh=s0Igel9sQE6aRWh/I4yVvoyE+hyGz/i22CENP4+fuQc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=94doaorKeRLKj82TyXfo5vfwq1BaF5HH5+Xxbo1VxLE08w0AQ09z5NQGw9+y9aaki
	 a2RzlwrD4UMGF/8e0PkXT4P+5M/5q7o+8OY9eUs0Kl2KPRKotdINHzQYSsb71dK0xF
	 T6Mlb6UtbxHGaWvNGD3a2U6nP5sYr3TELv2N7dm4+0sXRi9N/dfHNP6O8gw9ihzik4
	 UPMo0wUkhLokqEwuBeqKuXsOSIStMZWmB6Sok2I5xB01nex4D2tfvPjmXZl6QE5/fv
	 z/svp6/pAMrfOmX3diPeVtAQGMyaDixCY8ft7uUlDgLtcKBx44oerYjqpPQWsxj7Mm
	 bbbP3LBnlJocg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8vUmBGWE75m; Fri, 20 Oct 2023 00:49:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3CC98472C;
	Fri, 20 Oct 2023 00:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3CC98472C
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 219721BF368
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 00:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF9948472C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 00:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF9948472C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bz3LjiooCSR4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Oct 2023 00:49:07 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 047878472B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 00:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 047878472B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E5668CE32E5;
 Fri, 20 Oct 2023 00:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA34C433C8;
 Fri, 20 Oct 2023 00:49:01 +0000 (UTC)
Date: Thu, 19 Oct 2023 17:49:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <20231019174900.29d93b3d@kernel.org>
In-Reply-To: <20231018231643.2356-1-paul.greenwalt@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697762942;
 bh=rnIfb+GILZTA3JjJg2XMTMZwzlS5SD40Q5GFiOgP0Xs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=shrjz2sm8lLpVjNejlun0cxC1rHqHaC0uGar4sDgHDRTSvQ98EZj2fujtTc1nQvdx
 aT5n7VC3/dthkSekKnpf/J29kDlb4fF+O8U7Kl/4yQoT/sImJQhLQHAztB1anyCQb5
 h+iDsFoDScABwem01RGzHiXutOIVV3eeiwJIH2y9eUXDKU6Vp7OHgQMV3LmKZnpy0/
 RVe8sLPpYQwf7WYBaKuiUyzjTh4fenvRRZPAsIvIW5yfxIoSN67FXXzJp9T6tXwvY2
 PlQ9qYIj5SemyZXAxOXW+l6QM20NSIxlCc5lPl8NYkButCPXGZRDTIJ3yLaQ7wsl/C
 M0a6Suymegh1g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=shrjz2sm
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 0/6] ice: Add basic E830
 support
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
Cc: andrew@lunn.ch, netdev@vger.kernel.org,
 Pawel Chmielewski <pawel.chmielewski@intel.com>, anthony.l.nguyen@intel.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 18 Oct 2023 19:16:37 -0400 Paul Greenwalt wrote:
> This is an initial patchset adding the basic support for E830. E830 is
> the 200G ethernet controller family that is a follow on to the E810 100G
> family. The series adds new devices IDs, a new MAC type, several registers
> and a support for new link speeds. As the new devices use another version
> of ice_aqc_get_link_status_data admin command, the driver should use
> different buffer length for this AQ command when loaded on E830.

Please make sure to mark purely Intel driver patch sets as iwl-next
rather than net-next.
-- 
pw-bot: awaiting-upstream
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
