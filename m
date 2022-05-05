From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 5 May 2022 09:38:28 -0700
Subject: [Intel-wired-lan] [PATCH net v4] ice: Fix interrupt moderation
 settings getting cleared
In-Reply-To: <b5307c42-8f1c-228a-a3c8-17d65f3b9def@intel.com>
References: <20220420075452.126-1-michal.wilczynski@intel.com>
 <b5307c42-8f1c-228a-a3c8-17d65f3b9def@intel.com>
Message-ID: <03bdb584-9c2b-3cd1-c688-eadb9553295a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 5/4/2022 11:32 PM, Wilczynski, Michal wrote:
> Adaptive-rx and Adaptive-tx are interrupt moderation settings
> that can be enabled/disabled using ethtool:
> ethtool -C ethX adaptive-rx on/off adaptive-tx on/off
>
> Unfortunately those settings are getting cleared after
> changing number of queues, or in ethtool world 'channels':
> ethtool -L ethX rx 1 tx 1
>
> Clearing was happening due to introduction of bit fields
> in ice_ring_container struct. This way only itr_setting
> bits were rebuilt during ice_vsi_rebuild_set_coalesce().
>
> Introduce an anonymous struct of bitfields and create a
> union to refer to them as a single variable.
> This way variable can be easily saved and restored.
>
> v4:
> -Moved Singed-off-by tag to the end of the commit
>
> v3:
> -Added proper Fixes tag
>
> v2:
> -Changed argument to ice_write_itr to rc->itr_setting,
> instead of settings in order not to pass unnecessary bits

If you're carrying forward change log from internal review, please make 
it clear these are not from review on this list. e.g. mark these as from 
internal review.? Also would prefer them underneath the '---' after your 
sign-off.

>
> Fixes: 61dc79ced7aa ("ice: Restore interrupt throttle settings after 
> VSI rebuild")

When I attempt to apply this, the fixes has a newline. Can you check 
that you don't have one, no newlines for Fixes. Keep it all on one line.

Also, the patch is not applying.

> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_lib.c | 16 ++++++++--------
> drivers/net/ethernet/intel/ice/ice_txrx.h | 11 ++++++++---
> 2 files changed, 16 insertions(+), 11 deletions(-)
>
<snip>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h 
> b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index cead3eb149bd..ffb3f6a589da 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -384,9 +384,14 @@ struct ice_ring_container {
> /* this matches the maximum number of ITR bits, but in usec
> * values, so it is shifted left one bit (bit zero is ignored)
> */
> - u16 itr_setting:13;
> - u16 itr_reserved:2;
> - u16 itr_mode:1;
> + union {
> + struct {
> + u16 itr_setting:13;
> + u16 itr_reserved:2;
> + u16 itr_mode:1;
> + };
> + u16 itr_settings;
> + };
These appears to be missing all the indentation.
> enum ice_container_type type;
> };
>
Please get rid of the footer.

i.e.

Intel Technology Poland sp. z o.o.

ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII 
Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 
957-07-52-316 | Kapital zakladowy 200.000 PLN.

...

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220505/9b100c03/attachment-0001.html>
