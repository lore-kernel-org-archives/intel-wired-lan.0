From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:18:49 +0000
Subject: [Intel-wired-lan] [PATCH S46 4/9] ice: Allow VF to request
 reset as soon as it's initialized
In-Reply-To: <20200516005506.5113-4-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659A46C548B2BE3ABF65E728C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 4/9] ice: Allow VF to request reset as
> soon as it's initialized
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> A VF driver has the ability to request reset via VIRTCHNL_OP_RESET_VF.
> This is a required step in VF driver load. Currently, the PF is only allowing a VF
> to request reset using this method after the VF has already communicated
> resources via VIRTCHNL_OP_GET_VF_RESOURCES.
> However, this is incorrect because the VF can request reset before
> requesting resources. Fix this by allowing the VF to request a reset once it
> has been initialized.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


