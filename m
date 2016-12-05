From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Dec 2016 18:34:37 +0000
Subject: [Intel-wired-lan] [next PATCH S56 5/8] i40e:
	allow	i40e_update_filter_state to skip broadcast filters
In-Reply-To: <1480710782-9195-6-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA393AA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S56 5/8] i40e: allow
> i40e_update_filter_state to skip broadcast filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix a bug where we modified the mac_filter_hash while outside a lock, when
> handling addition of broadcast filters.
> 
> Normally, we add filters to firmware by batching the additions into lists and
> issuing 1 update for every few filters. Broadcast filters are handled
> differently, by instead setting the broadcast promiscuous mode flags. In
> order to make sure the 1<->1 mapping of filters in our addition array lined up
> with filters in the hlist tmp_add_list, we had to remove the filter and move it
> back to the main hash. However, we didn't do this under lock, which could
> cause consistency problems for the list.
> 
> Fix this by updating i40e_update_filter_state logic so that it knows to avoid
> broadcast filters. This ensures that we don't have to remove the filter
> separately, and can put it back using the normal flow.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Id288fade80b3e3a9a54b68cc249188cb95147518
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 37
> ++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
