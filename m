From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 12 Jan 2021 19:41:07 -0800
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix for link-flapping
In-Reply-To: <20210112171431.457524-1-arkadiusz.kubalewski@intel.com>
References: <20210112171431.457524-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210112194107.00002d0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Arkadiusz Kubalewski wrote:

> VF queues were not brought up when PF was brought up after being downed
> if the VF driver disabled VFs queues during PF down. This could happen
> in some older or external VF driver implementations.
> The problem was that PF driver used vf->queues_enabled as a condition
> to decide what link-state it would send out which caused the issue.
> Remove the check for vf->queues_enabled in the VF link notify. Now VF
> will always be notified of the current link status. Also remove
> the queues_enabled member from i40e_vf structure as it is not used
> anymore. Also refactor repeated link state reporting code into a
> separate helper function i40e_set_vf_link_state().
> Otherwise VNF implementation was broken and caused a link flap.
> 
> v2: improve commit message
> v3: net tree target

For future patches, please put vX: messages after a ---
which will allow git am to strip the vX: comments.  You can optionally
put the vX: messages in the same section as the diffstat info.

> 
> Fixes: 2ad1274fa35a ("i40e: don't report link up for a VF who hasn't
> enabled")

You probably don't need to wrap the Fixes line, but it probably
doesn't hurt either.

> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The patch sender's signoff should be last (think chronological order
starting with oldest at the top)
