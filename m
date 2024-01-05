Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48A8C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jan 2024 21:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 721AF414C3;
	Fri,  5 Jan 2024 21:13:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 721AF414C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704489227;
	bh=FzYEo+MfhMZ6+kJfJb3ezaqYmqrqPvUpOZE0NUHz7Jg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=crhyIj+vJvOeXnSXg0tmbzjkxgrEoEwQzf/kMGVirxDk7ComKLEE0rESDD9aouIBF
	 ir7qsmUvWwWNMab2Z2jb+/cDVI16EZ/RDha9XTiH8yWSpun9EU36XE3EykyCD3++AG
	 hdbA7iF2Oa+teEHEpBvqDHfnRs7Y/gMK3TTgCFcJBYST7aTpYS9OIsw4Vkn7rL8bg5
	 RhdG5pWGOao0CJjXJ5N9C7pFfyJcpRXJA3sndElx81oxN7NjfntidRP1J4SfrNKzKY
	 rMg23id689JULZ6JUw1a5f1wLjT4RcdolOMp61Lf7y8lrx7c5se8zXlDWoRlHODlxq
	 L54FA9130kYVQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YMFNXAWVKpfN; Fri,  5 Jan 2024 21:13:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 794E5415E6;
	Fri,  5 Jan 2024 21:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 794E5415E6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7901D1BF326
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jan 2024 21:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54C95615B1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jan 2024 21:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54C95615B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bc461nZfWM6D for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jan 2024 21:13:44 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6825F6143C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jan 2024 21:13:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6825F6143C
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4C5A4CE202D;
 Fri,  5 Jan 2024 21:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB625C433C7;
 Fri,  5 Jan 2024 21:13:37 +0000 (UTC)
Date: Fri, 5 Jan 2024 21:13:34 +0000
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Message-ID: <20240105211334.GA114301@kernel.org>
References: <20240105013232.44996-1-pavan.kumar.linga@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105013232.44996-1-pavan.kumar.linga@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1704489219;
 bh=l5Ymg66TVOpAN1XPpEJlRktNwCvTjgI4pO0t7LY8zZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WvPNzW6Txqyb5nciGlGjQreOLOKXUW78CXZ4hFfh1ZLLkyM+2YTj/c7Wym/Nqu+PU
 fKToOBz8kestyJs0d54HjxuOUijefLQWKoHVMBYqlIt5xwJyPChYDSyQBMF4loSIja
 0/hCR9PxpEM7M+/oO+iwQdyIqFiteM1ag6xH9tSc8QhfeWijC/QPuqletrdJKPRD5Z
 eKezNlTCHWmVnIu5RBScAKWjcaZYxV03KtxxBsF5/1jTrSelTq3GN5Cac/gUgaZLA/
 RPMVFGEQcRvNjpwjFO7UvVn+cQWFFEjKBQnp9NbjsHkRD1ONnq4FG6yuyByIosFHyv
 8s8CLBkMko0Tg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=WvPNzW6T
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: avoid compiler
 padding in virtchnl2_ptype struct
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
Cc: pmenzel@molgen.mpg.de, emil.s.tantilov@intel.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 04, 2024 at 05:32:32PM -0800, Pavan Kumar Linga wrote:
> In the arm random config file, kconfig option 'CONFIG_AEABI' is
> disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
> This causes the compiler to add padding in virtchnl2_ptype
> structure to align it to 8 bytes, resulting in the following
> size check failure:
> 
> include/linux/build_bug.h:78:41: error: static assertion failed: "(6) == sizeof(struct virtchnl2_ptype)"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>          |                                         ^~~~~~~~~~~~~~
> include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/idpf/virtchnl2.h:26:9: note: in expansion of macro 'static_assert'
>       26 |         static_assert((n) == sizeof(struct X))
>          |         ^~~~~~~~~~~~~
> drivers/net/ethernet/intel/idpf/virtchnl2.h:982:1: note: in expansion of macro 'VIRTCHNL2_CHECK_STRUCT_LEN'
>      982 | VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Avoid the compiler padding by using "__packed" structure
> attribute for the virtchnl2_ptype struct.
> 
> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

