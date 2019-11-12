From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:33:03 +0000
Subject: [Intel-wired-lan] [PATCH S33 06/15] ice: Only disable VF state
 when freeing each VF resources
In-Reply-To: <20191108142331.10221-6-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-6-anthony.l.nguyen@intel.com>
Message-ID: <2f03e8f67bd840bba2b926a44fb1dc7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 06/15] ice: Only disable VF state when
> freeing each VF resources
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> It is wrong to set PF disable state flag for all VFs when freeing VF resources -
> Instead, we should set VF disable state flag for each VF with its resources
> being returned to the device. Right now, all VF opcodes, mailbox
> communication to clear its resources as well fails - since we already indicate
> that PF is in disable state, with all VFs not active. In addition, we don't need
> to notify VF that PF is intending to reset it, if it is already in disabled state.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


