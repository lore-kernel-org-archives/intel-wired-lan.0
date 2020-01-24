From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:08 +0000
Subject: [Intel-wired-lan] [PATCH S37 06/15] ice: Remove CONFIG_PCI_IOV
 wrap in ice_set_pf_caps
In-Reply-To: <20200122152041.41498-6-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-6-anthony.l.nguyen@intel.com>
Message-ID: <4520740f160f4d67b4e9f6fd8e0a6af6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 06/15] ice: Remove CONFIG_PCI_IOV
> wrap in ice_set_pf_caps
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


