Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF4CD343F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 May 2026 18:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A2B441D5B;
	Fri, 15 May 2026 18:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtQEX0SqD3TM; Fri, 15 May 2026 18:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C167641D5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778868720;
	bh=phXTIkRdDW79+3IUaUBPZ4VZbcHHw1Hfs3mbvZODsVA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kuXndPhSEc8pwJPiEXMIPOnrlq1TyFmQ3j2QKBdbgLE4FPEFaEVqoSFWdgePd1iFT
	 IuUaJoEZZcWr7784JmMFGBksvvAR8wZYIpG4TCVJVhYtgF30zckg1C9JwgELeAFt3H
	 alE8V/IFZ5a6Pp132bUl1lm+sFY9koxTinN/1YIRvZ5Iam68doJaoK0eZiZ+9Grm9s
	 LUZnNaGCj9hOYot0Y3WpSj//SsuhUEbCnLH+Glxbl7JVYaPiRRodLsK7mUCG0Qona4
	 KqJpHJuyd3y5Un6VNUI+DEUlflXula/Z6kX9+O05PV9tu+A6tXvggrBPkZFnUaTaKX
	 zU5sPga5riZhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C167641D5C;
	Fri, 15 May 2026 18:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E99145B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 18:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 201B941D5C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 18:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZgakEx_KYor for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 May 2026 18:11:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 080F341D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 080F341D5B
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 080F341D5B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 18:11:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EDD4560098;
 Fri, 15 May 2026 18:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03530C2BCB0;
 Fri, 15 May 2026 18:11:54 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: przemyslaw.korba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com
Date: Fri, 15 May 2026 19:11:11 +0100
Message-ID: <20260515181111.272950-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
References: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778868716;
 bh=alyM4fL2zP9I3YpMAWZdGzHyvU+rcfKXgtXzmLlxz5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L/QN/TKFkDsP9Npdr4s7C/jmY7qzNZpRsZWIkLAQsQnzFeLtkykbKK/wKfm00YF3i
 uuZ8lT4rLbru7G111nyIAt6Zk4RZVkgsWF0CaoLMx/CyJqKDTsN/z3qDf9B+M4ILpU
 O7We8tKrTeNcQrSlUonWmx/V7EJswXiS2BtlW0uOTDL4lnqZ5n87OqLy2IuyMFWmhl
 1PV4eKNHKn2aH7//cTSfyZBDYBeRqkFd5hioCoWFSDNQzJp4j4m7qpNLgDSTwwczwj
 ZBfRJUhJc+rJq5DnqA2YRYK6qGzhywa8Wr96sLI5qJQ2paqelbCN76YYwFGlvlQH8u
 NEkFCzfC+jYlA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L/QN/TKF
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: suppress DPLL errors
 during reset recovery
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: suppress DPLL errors during reset recovery

This commit suppresses DPLL error logging and counter increments when the admin
queue returns EBUSY. The intent is to avoid unnecessary warnings and prevent
the DPLL periodic worker from being disabled during reset recovery.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 0704e92ab0430..78b8836b534b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>  				   ret,
>  				   libie_aq_str(pf->hw.adminq.sq_last_status),
>  				   pin_type_name[pin_type], pin->idx);
> -	else
> +	else if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)

Could this check of sq_last_status race with other admin queue commands?

The sq_last_status field seems to be global state that is modified by any
admin queue command. If this is checked outside of the admin queue lock,
could another thread (like an ethtool operation) issue an admin queue
command and overwrite sq_last_status before this check runs?

If it gets overwritten to LIBIE_AQ_RC_OK, this would falsely evaluate as not
EBUSY and log the error anyway, incrementing the error counter.

[ ... ]

> @@ -2955,7 +2957,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
>  	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
>  		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);

Does the reset recovery suppression also need to be applied inside
ice_dpll_pps_update_phase_offsets()?

If ice_aq_get_cgu_input_pin_measure() fails with EBUSY during reset recovery,
it looks like ice_dpll_pps_update_phase_offsets() only checks for
LIBIE_AQ_RC_EAGAIN before logging an error, which might still spam the log
with EBUSY errors.

>  	if (ret) {
> -		d->cgu_state_acq_err_num++;
> +		/* EBUSY is expected during reset recovery */
> +		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
> +			d->cgu_state_acq_err_num++;
>  		/* stop rescheduling this worker */
>  		if (d->cgu_state_acq_err_num >
>  		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {

By skipping the increment of the error counter on EBUSY, will this create an
unbounded polling loop?

Looking at the end of ice_dpll_periodic_work():

resched:
    kthread_queue_delayed_work(d->kworker, &d->work,
                               ret ? msecs_to_jiffies(10) :
                               msecs_to_jiffies(500));

If the firmware gets wedged and persistently returns EBUSY, the error
threshold will never be reached, and the worker will continue to hammer the
admin queue every 10ms forever. Is it expected to poll this frequently
without a backoff mechanism or an upper bound?
