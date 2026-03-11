Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469A3112584D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 15:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65D4E8467F;
	Wed, 11 Mar 2026 15:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40QnipcXN9Q8; Wed, 11 Mar 2026 15:33:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4032A84673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773243238;
	bh=CodiYBsmL0ndtqHN7u6tywq9/pii3+ZsztJ5W7pc52A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cc5KCrZMLgahWJhngmgrfeVsKNhh0lNqBd9ZrjaUAjiR8RkB2jgG955r2T5ZgNAwe
	 jegTx6De92n8K6DpdQSgXqd22i82nroEm2gRlDd/7MhYhnqQZVsMVD/zowMJsZMVL/
	 0edJqA12ekMclWrF2YbygBJbgaXvuIb0CypD5PAg6XxBF9F64gqkHZTo+hRAC7FtXn
	 CJnSXhbhQnZGw0w7aj272fO05x6y5BXlNCCOL+ruydQLsqZ1OBz8SJjhg0JEG8ReIz
	 SsxEknLD9K+0KNgTIv/nRGtZVuDbboq3Ds/TgWb6jdTMXRfm/YBMnfjQHGgs//zkw5
	 AzyywWBH35ZpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4032A84673;
	Wed, 11 Mar 2026 15:33:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CA4E33A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 05:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 187B841E05
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 05:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUAshuCCzDh9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 05:13:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mhiramat@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7F86741B99
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F86741B99
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F86741B99
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 05:13:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E663440BC;
 Wed, 11 Mar 2026 05:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B290C4CEF7;
 Wed, 11 Mar 2026 05:13:33 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:13:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Message-Id: <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
In-Reply-To: <20260310100750.303af303@gandalf.local.home>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
 <20260310100750.303af303@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:33:54 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773206020;
 bh=28by/08L5sQfVInnpnws13wBN8rSRzXkYuFZbXIDejE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fBD8jk+Az9XLzjQybetTno+W1ryvU+pJL+N7BKChPP4rEV9IYqgPEFF2K1MPy7V+I
 icuIUfL/Dg5/kgC+Hmy6YXnokVmu1zBps2v+geMH037tafu9KbfbPBt55PGuheVQJI
 z4qBbYgbztbgPszs8uOt3DWOo4BLsomiZb502AAVr8RGodlkXenJkrZoPQ7T4PM4Oz
 vrK0XegnvMjvVzXWSmVe1LK/JeGbm1OZeYQWd07yKlzuY4gn+/WuMImks+j3fST4ms
 212iplG27c78T1c+7zhxUp3BWeQ6jYmUF3g5aNFDkxAetR3pCSSickOn/0/x8U56nb
 McVwjAbkgnZAA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fBD8jk+A
Subject: Re: [Intel-wired-lan] [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL
 over manual NULL check
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

On Tue, 10 Mar 2026 10:07:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Mar 2026 12:48:41 +0100
> Philipp Hahn <phahn-oss@avm.de> wrote:
> 
> > Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> > check.
> 
> Why?
> 
> > 
> > Change generated with coccinelle.
> > 
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-trace-kernel@vger.kernel.org
> > Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> > ---
> >  kernel/trace/fprobe.c                | 2 +-
> >  kernel/trace/kprobe_event_gen_test.c | 2 +-
> >  kernel/trace/trace_events_hist.c     | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	do {
> >  		rhashtable_walk_start(&iter);
> >  
> > -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> > +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))
> 
> Ug, No!
> 
> That looks so much worse than the original.

Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
But if you want to use IS_ERR_OR_NULL() here, it will be better something like

node = rhashtable_walk_next(&iter);
while (!IS_ERR_OR_NULL(node)) {
	fprobe_remove_node_in_module(mod, node, &alist);
	node = rhashtable_walk_next(&iter);
}

Thanks,

> 
> -- Steve
> 
> >  			fprobe_remove_node_in_module(mod, node, &alist);
> >  
> >  		rhashtable_walk_stop(&iter);
> > diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> > index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> > --- a/kernel/trace/kprobe_event_gen_test.c
> > +++ b/kernel/trace/kprobe_event_gen_test.c
> > @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
> >  
> >  static bool trace_event_file_is_valid(struct trace_event_file *input)
> >  {
> > -	return input && !IS_ERR(input);
> > +	return !IS_ERR_OR_NULL(input);
> >  }
> >  
> >  /*
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
> >  	 */
> >  	field_var = create_target_field_var(hist_data, system, event, var);
> >  
> > -	if (field_var && !IS_ERR(field_var)) {
> > +	if (!IS_ERR_OR_NULL(field_var)) {
> >  		save_field_var(hist_data, field_var);
> >  		hist_field = field_var->var;
> >  	} else {
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
