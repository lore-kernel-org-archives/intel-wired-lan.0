Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62809F30925
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Mar 2026 09:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F9F581DE5;
	Thu,  5 Mar 2026 09:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flRYHJIt2T8S; Thu,  5 Mar 2026 09:30:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DADA81DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772703059;
	bh=johCU6idJup7WxIBVk2NTKubfm7Hnx/VtL8EYfM5cKs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qKfnNrfmTDebzukSJO69de86wTbGglj2Q4DsI0AJTo9r9xWu/5RT9+j41zMJ2DG3g
	 s5HWWmXDTW7wcfAUI6gOGv0l6I7OiJib5ckQNd5RJd1w0+4/USiWSlqjP2P3OxnCJh
	 x+M5ulHUBa6G+e9mNgZm3lvdC/4H+W6rytr0qLRO99FEYtfnSowmrponfw4kNGbw9G
	 PDsfAb9d/2Z60bhrQgCELUiNYAalSMOQCc6jw29mTHhPYIWGdNvBvOpzOO64j/bmle
	 DnflZQUvNYIIQKz/b2/DlAYO73pZPkB/jm5ktCj2oZ1dT1OObN9XNjWLG1Qu6DgLum
	 IR0XqS+I31/TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DADA81DE6;
	Thu,  5 Mar 2026 09:30:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76BDD25B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 09:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6846481DE6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 09:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59usXwl2zBjl for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Mar 2026 09:30:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA19E81DE5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA19E81DE5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA19E81DE5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Mar 2026 09:30:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E009643D90;
 Thu,  5 Mar 2026 09:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F0C116C6;
 Thu,  5 Mar 2026 09:30:54 +0000 (UTC)
Date: Thu, 5 Mar 2026 09:30:51 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260305093051.GB90938@kernel.org>
References: <20260303012831.662492-1-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303012831.662492-1-joshua.a.hay@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772703055;
 bh=2b1eWPC49WnzEkK2zp9nESZ7FeyXoj/88zwhNB7MJhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cqvccO2V4yW8Qla55RUDyFGDyZ4LlRg1amcoSpYDapttyd8FJxEJRoe9pyT/IXm2C
 bEGzA/cfV9lI3JdP9jIn8H1RihSY9YtyWCZUdxINykMUk7peDOxtuvDo8IRHJtZMVL
 bwwbgKLw10BL9JsqKjxeC400LG4ZScDj2zz0fm0xWNwDFk2VUK7HQsHWjFdLSBokNx
 BzB/3oJ96sNFv4jpI/3DjJHnfi6ETBPfPzWxZ3u7kG8gYcwU966sVL+1WjojKAQyVY
 TgFTXaRq4/1+rqpdqOo4IRZfdvT81XYItsU2nCJIEHuyUT4VNbW7O/1zOHWYxjFKR7
 dfS9Ras3aHQYQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cqvccO2V
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: clear stale cdev_info
 ptr
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Mar 02, 2026 at 05:28:31PM -0800, Joshua Hay wrote:
> Deinit calls idpf_idc_deinit_core_aux_device to free the cdev_info
> memory, but leaves the adapter->cdev_info field with a stale pointer
> value. This will bypass subsequent "if (!cdev_info)" checks if cdev_info
> is not reallocated. For example, if idc_init fails after a reset,
> cdev_info will already have been freed during the reset handling, but it
> will not have been reallocated. The next reset or rmmod will result in a
> crash.
> 
> [  +0.000008] BUG: kernel NULL pointer dereference, address: 00000000000000d0
> [  +0.000033] #PF: supervisor read access in kernel mode
> [  +0.000020] #PF: error_code(0x0000) - not-present page
> [  +0.000017] PGD 2097dfa067 P4D 0
> [  +0.000017] Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> [  +0.000018] RIP: 0010:device_del+0x3e/0x3d0
> [  +0.000010] Call Trace:
> [  +0.000010]  <TASK>
> [  +0.000012]  idpf_idc_deinit_core_aux_device+0x36/0x70 [idpf]
> [  +0.000034]  idpf_vc_core_deinit+0x3e/0x180 [idpf]
> [  +0.000035]  idpf_remove+0x40/0x1d0 [idpf]
> [  +0.000035]  pci_device_remove+0x42/0xb0
> [  +0.000020]  device_release_driver_internal+0x19c/0x200
> [  +0.000024]  driver_detach+0x48/0x90
> [  +0.000018]  bus_remove_driver+0x6d/0x100
> [  +0.000023]  pci_unregister_driver+0x2e/0xb0
> [  +0.000022]  __do_sys_delete_module.isra.0+0x18c/0x2b0
> [  +0.000025]  ? kmem_cache_free+0x2c2/0x390
> [  +0.000023]  do_syscall_64+0x107/0x7d0
> [  +0.000023]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Pass the adapter struct into idpf_idc_deinit_core_aux_device instead and
> clear the cdev_info ptr.
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

