Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A61C25B4E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Jan 2023 13:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5045C81E33;
	Fri, 20 Jan 2023 13:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5045C81E33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674220467;
	bh=5yg6kifz0OSuWQlk0N2eYl/1OCq7iZUI5l7bZHwAXpc=;
	h=Date:From:To:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Cc:From;
	b=UqS5rjIqsdrWEQ2RHevdFQ6GSfX6aP0hrB7MHc0ZUzgw/XXQQmohtUcNSmQAAQ++A
	 +nz9Ot06gesBJAmzMIgjKwKyoB1a4ByaWBB3ICiPbS51GHwpd0yGGETKHuCwApdzoK
	 rKaYH1JmSagEuU6yRXuWWSOI5aFPCXAIalZxD+Hw0XHWXm2rVy+y5xb6OFA3fs4DMH
	 l/VocXV/se/DzxmZQ5WRURoqq0E99LpQ9Y5i3jGaRiTS7ci0NxojRthi/EhC2ydzca
	 oMve8IuVZKhCR8yI3pTEHkz5Lh1nDpnKGIbxOh0h8O9sVJ/5+S17fRBE9IHt+NTbhb
	 xZ1ycUgCXJfHA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E62uxLBYStxO; Fri, 20 Jan 2023 13:14:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6174A81E76;
	Fri, 20 Jan 2023 13:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6174A81E76
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 917E11BF2C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 13:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68A2B405D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 13:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68A2B405D1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kd4S86vB5mXy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Jan 2023 13:14:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32DD14011B
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32DD14011B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Jan 2023 13:14:23 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4C761F67;
 Fri, 20 Jan 2023 13:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D73C433EF;
 Fri, 20 Jan 2023 13:14:21 +0000 (UTC)
Date: Fri, 20 Jan 2023 07:14:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230120131419.GA622602@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119191735.4bc11fd2@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674220461;
 bh=y2nkbcWRr5qEayC6d21noEl5u93nkRPbcNffzPJrZBk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=jjERjDD1RN3nq7qoHcU1vnBiVA/xlhinOqGkNB7IoWM/sMqZ6s85DrxZdNuIlvXaE
 N46d2uGkWvk9OldOpX2tbdZfv3Ujc0dkA1YLZ3BAWy/EzM3Z1RfU4FEPwYYmF2sDey
 Z24irxIinp8683wMjX0y9GNkQn9perV1SikxAdrTvO/FLZu7WdTADNlDf2GjWpJtUM
 sqsYXKy9mVOlss0WOwVvpWtV0+OG7VUkGHoMEq38rUl6wOVi0uGCEkPAO2/u0eatve
 ARLZrIoIur/x5zrFvCzJFbUNqblfBzQlG4pzs8G5jTHuQ9Aq5IGEs1nXSgGZ76k6nR
 6cRzghdjaIkRg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jjERjDD1
Subject: Re: [Intel-wired-lan] [PATCH 2/9] e1000e: Remove redundant
 pci_enable_pcie_error_reporting()
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 19, 2023 at 07:17:35PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Jan 2023 17:46:05 -0600 Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > pci_enable_pcie_error_reporting() enables the device to send ERR_*
> > Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> > native"), the PCI core does this for all devices during enumeration.
> > 
> > Remove the redundant pci_enable_pcie_error_reporting() call from the
> > driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> > from the driver .remove() path.
> > 
> > Note that this doesn't control interrupt generation by the Root Port; that
> > is controlled by the AER Root Error Command register, which is managed by
> > the AER service driver.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> How would you like to route these? Looks like there's no dependency 
> so we can pick them up?

Right, no dependencies, so you can pick them up.  Sounds like you and
Tony have it worked out.  Thanks!

Bjorn
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
