From: Salil Mehta <salil.mehta@huawei.com>
Date: Wed, 21 Apr 2021 08:08:00 +0000
Subject: [Intel-wired-lan] [PATCH V2 net] ice: Re-organizes reqstd/avail
 {R, T}XQ check/code for efficiency+readability
In-Reply-To: <9335975a-ef19-863c-005a-d460eac83e03@molgen.mpg.de>
References: <20210413224446.16612-1-salil.mehta@huawei.com>
 <7974e665-73bd-401c-f023-9da568e1dffc@molgen.mpg.de>
 <418702bdb5244eb4811a2a1a536c55c0@huawei.com>
 <9335975a-ef19-863c-005a-d460eac83e03@molgen.mpg.de>
Message-ID: <fdd2432301e541baa82ec56427d40cca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Paul Menzel [mailto:pmenzel at molgen.mpg.de]
> Sent: Wednesday, April 21, 2021 8:54 AM
> 
> [CC: Remove Jeff, as email is rejected]

Yes, thanks for the reminder. I had noticed it earlier.

[...]

> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> index d13c7fc8fb0a..d77133d6baa7 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> @@ -161,12 +161,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi,
> u16 vf_id)
> >>>
> >>>    	switch (vsi->type) {
> >>>    	case ICE_VSI_PF:
> >>> -		vsi->alloc_txq = min3(pf->num_lan_msix,
> >>> -				      ice_get_avail_txq_count(pf),
> >>> -				      (u16)num_online_cpus());
> >>>    		if (vsi->req_txq) {
> >>>    			vsi->alloc_txq = vsi->req_txq;
> >>>    			vsi->num_txq = vsi->req_txq;
> >>> +		} else {
> >>> +			vsi->alloc_txq = min3(pf->num_lan_msix,
> >>> +					      ice_get_avail_txq_count(pf),
> >>> +					      (u16)num_online_cpus());
> >>>    		}
> >>
> >> I am curious, did you check the compiler actually creates different
> >> code, or did it notice the inefficiency by itself and optimized it already?
> >
> > I have not looked into that detail but irrespective of what compiler generates
> > I would like to keep the code in a shape which is more efficient and more readable.
> >
> > I do understand in certain cases we have to do tradeoff between efficiency
> > and readability but I do not see that here.
> 
> I agree, as *efficiency* is mentioned several times, I assume it was
> tested. Thank you for the clarification.


I mentioned inefficient because below code gets executed unnecessarily.


/**
 * ice_get_avail_q_count - Get count of queues in use
 * @pf_qmap: bitmap to get queue use count from
 * @lock: pointer to a mutex that protects access to pf_qmap
 * @size: size of the bitmap
 */
static u16
ice_get_avail_q_count(unsigned long *pf_qmap, struct mutex *lock, u16 size)
{
	unsigned long bit;
	u16 count = 0;

	mutex_lock(lock);
	for_each_clear_bit(bit, pf_qmap, size)
		count++;
	mutex_unlock(lock);

	return count;
}

/**
 * ice_get_avail_txq_count - Get count of Tx queues in use
 * @pf: pointer to an ice_pf instance
 */
u16 ice_get_avail_txq_count(struct ice_pf *pf)
{
	return ice_get_avail_q_count(pf->avail_txqs, &pf->avail_q_mutex,
				     pf->max_pf_txqs);
}



> >>>    		pf->num_lan_tx = vsi->alloc_txq;
> >>> @@ -175,12 +176,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi,
> u16 vf_id)
> >>>    		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
> >>>    			vsi->alloc_rxq = 1;
> >>>    		} else {
> >>> -			vsi->alloc_rxq = min3(pf->num_lan_msix,
> >>> -					      ice_get_avail_rxq_count(pf),
> >>> -					      (u16)num_online_cpus());
> >>>    			if (vsi->req_rxq) {
> >>>    				vsi->alloc_rxq = vsi->req_rxq;
> >>>    				vsi->num_rxq = vsi->req_rxq;
> >>> +			} else {
> >>> +				vsi->alloc_rxq = min3(pf->num_lan_msix,
> >>> +						      ice_get_avail_rxq_count(pf),
> >>> +						      (u16)num_online_cpus());
> >>>    			}
> >>>    		}
> >>>
> 
> 
> Kind regards,
> 
> Paul
