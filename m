From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 18 Feb 2022 21:03:28 -0800
Subject: [Intel-wired-lan] [PATCH net-next v6 6/7] ice: Fix FV offset
 searching
In-Reply-To: <20220218145339.7322-1-marcin.szycik@linux.intel.com>
References: <20220218145048.6718-1-marcin.szycik@linux.intel.com>
 <20220218145339.7322-1-marcin.szycik@linux.intel.com>
Message-ID: <20220218210328.4420a768@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 18 Feb 2022 15:53:39 +0100 Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Checking only protocol ids while searching for correct FVs can lead to a
> situation, when incorrect FV will be added to the list. Incorrect means
> that FV has correct protocol id but incorrect offset.
> 
> Call ice_get_sw_fv_list with ice_prot_lkup_ext struct which contains all
> protocol ids with offsets.
> 
> With this modification allocating and collecting protocol ids list is
> not longer needed.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index 38fe0a7e6975..9746db6e19b5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -1884,7 +1884,7 @@ ice_get_sw_fv_bitmap(struct ice_hw *hw, enum ice_prof_type req_profs,
>   * allocated for every list entry.
>   */
>  int
> -ice_get_sw_fv_list(struct ice_hw *hw, u8 *prot_ids, u16 ids_cnt,
> +ice_get_sw_fv_list(struct ice_hw *hw, struct ice_prot_lkup_ext *lkups,
>  		   unsigned long *bm, struct list_head *fv_list)
>  {
>  	struct ice_sw_fv_list_entry *fvl;

drivers/net/ethernet/intel/ice/ice_flex_pipe.c:1889: warning: Function parameter or member 'lkups' not described in 'ice_get_sw_fv_list'
drivers/net/ethernet/intel/ice/ice_flex_pipe.c:1889: warning: Excess function parameter 'prot_ids' description in 'ice_get_sw_fv_list'
drivers/net/ethernet/intel/ice/ice_flex_pipe.c:1889: warning: Excess function parameter 'ids_cnt' description in 'ice_get_sw_fv_list'

There's another one in the next patch.
