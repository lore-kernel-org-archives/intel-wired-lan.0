From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 05 Mar 2017 16:27:31 -0800
Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: allow
 i40e_update_filter_state to skip broadcast filters
In-Reply-To: <20170215200517.30216-1-jacob.e.keller@intel.com>
References: <20170215200517.30216-1-jacob.e.keller@intel.com>
Message-ID: <1488760051.3477.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-02-15 at 12:05 -0800, Jacob Keller wrote:
> Fix a bug where we modified the mac_filter_hash while outside a lock,
> when handling addition of broadcast filters.
> 
> Normally, we add filters to firmware by batching the additions into
> lists and issuing 1 update for every few filters. Broadcast filters
> are
> handled differently, by instead setting the broadcast promiscuous
> mode
> flags. In order to make sure the 1<->1 mapping of filters in our
> addition array lined up with filters in the hlist tmp_add_list, we
> had
> to remove the filter and move it back to the main hash. However, we
> didn't do this under lock, which could cause consistency problems for
> the list.
> 
> Fix this by updating i40e_update_filter_state logic so that it knows
> to
> avoid broadcast filters. This ensures that we don't have to remove
> the
> filter separately, and can put it back using the normal flow.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Id288fade80b3e3a9a54b68cc249188cb95147518
> ---
> * v3
> - Use hlist_for_each_entry_continue instead
> 
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 30
> +++++++++++++++++++++--------
> ?1 file changed, 22 insertions(+), 8 deletions(-)

This patch does not apply cleanly, not even close...

I tried to match up this patch with something that was in my queue, and
I was not able to find a single patch that this would easily replace.

Please resubmit this series, based on my current dev-queue branch.  I
am dropping this 2 patch series and will await a re-submission.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170305/02d0ae21/attachment.asc>
