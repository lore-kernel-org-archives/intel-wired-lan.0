From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:04:22 +0000
Subject: [Intel-wired-lan] [PATCH net 2/8] iavf: free q_vectors before
 queues in iavf_disable_vf
In-Reply-To: <20210604164900.33156-2-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-2-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB42246E149C8CD9F53BF0AF78828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, June 4, 2021 9:49 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 2/8] iavf: free q_vectors before
> queues in iavf_disable_vf
> 
> From: Nicholas Nunley <nicholas.d.nunley@intel.com>
> 
> iavf_free_queues() clears adapter->num_active_queues, which
> iavf_free_q_vectors() relies on, so swap the order of these two function calls
> in iavf_disable_vf(). This resolves a panic encountered when the interface is
> disabled and then later brought up again after PF communication is restored.
> 
> Fixes: 65c7006f234c ("i40evf: assign num_active_queues inside
> i40evf_alloc_queues")
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


