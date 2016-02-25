From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 25 Feb 2016 23:44:20 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: use fm10k_stats structures
 for	per-queue statistics
In-Reply-To: <804857E1F29AAC47BF68C404FC60A18490D71028@ORSMSX104.amr.corp.intel.com>
References: <1454697789-22420-1-git-send-email-jacob.e.keller@intel.com>
 <1454697789-22420-2-git-send-email-jacob.e.keller@intel.com>
 <EF50CC0C76A53A44BAD798C58E0A157E2734A9C4@ORSMSX103.amr.corp.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D71028@ORSMSX104.amr.corp.intel.com>
Message-ID: <1456443860.12253.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-02-25 at 23:43 +0000, Allan, Bruce W wrote:
> This patch unwittingly adds an extraneous/unnecessary blank line
> after the local
> variable declarations in fm10k_get_sset_count() - checkpatch should
> have caught
> that.
> 

I can clean that up.

Regards,
Jake
