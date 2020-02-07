From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:33:11 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 06/15] ice: Remove
 CONFIG_PCI_IOV wrap in ice_set_pf_caps
In-Reply-To: <20200206092013.23388-6-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-6-anthony.l.nguyen@intel.com>
Message-ID: <00165864e7ae4fe4aad94620d3498707@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 06/15] ice: Remove
> CONFIG_PCI_IOV wrap in ice_set_pf_caps
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Remove unnecessary CONFIG_PCI_IOV wrapping in ice_set_pf_caps. None
> of the data structures accessed within the block are wrapped with this flag.
> When CONFIG_PCI_IOV is undefined, pf->num_vfs_supported will be 0
> anyway.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


