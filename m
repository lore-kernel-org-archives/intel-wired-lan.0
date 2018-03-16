From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 16 Mar 2018 09:21:27 -0700
Subject: [Intel-wired-lan] [PATCH v2 07/15] ice: Add support for VSI
 allocation and deallocation
In-Reply-To: <20180315234802.31336-8-anirudh.venkataramanan@intel.com>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-8-anirudh.venkataramanan@intel.com>
Message-ID: <a2087633-f969-d399-e51e-6d392ac1a581@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/15/2018 4:47 PM, Anirudh Venkataramanan wrote:
> This patch introduces data structures and functions to alloc/free
> VSIs. The driver represents a VSI using the ice_vsi structure.
> 
> Some noteworthy points about VSI allocation:
> 
> 1) A VSI is allocated in the firmware using the "add VSI" admin queue
>     command (implemented as ice_aq_add_vsi). The firmware returns an
>     identifier for the allocated VSI. The VSI context is used to program
>     certain aspects (loopback, queue map, etc.) of the VSI's configuration.
> 
> 2) A VSI is deleted using the "free VSI" admin queue command (implemented
>     as ice_aq_free_vsi).
> 
> 3) The driver represents a VSI using struct ice_vsi. This is allocated
>     and initialized as part of the ice_vsi_alloc flow, and deallocated
>     as part of the ice_vsi_delete flow.
> 
> 4) Once the VSI is created, a netdev is allocated and associated with it.
>     The VSI's ring and vector related data structures are also allocated
>     and initialized.
> 
> 5) A VSI's queues can either be contiguous or scattered. To do this, the
>     driver maintains a bitmap (vsi->avail_txqs) which is kept in sync with
>     the firmware's VSI queue allocation imap. If the VSI can't get a
>     contiguous queue allocation, it will fallback to scatter. This is
>     implemented in ice_vsi_get_qs which is called as part of the VSI setup
>     flow. In the release flow, the VSI's queues are released and the bitmap
>     is updated to reflect this by ice_vsi_put_qs.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
> v2: Addressed Shannon Nelson's comments by
>     1) using a new define ICE_NO_VSI instead of the magic number 0xffff.
>     2) adding missing curly braces and break statements.
> 
> Also, ice_set_def_vsi_ctx was changed to ice_set_dflt_vsi_ctx for clarity.

Thanks,
sln
Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

