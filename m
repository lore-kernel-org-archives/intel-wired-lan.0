From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:25:24 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 1/9] ice: Reliably reset VFs
In-Reply-To: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
Message-ID: <450a5a5f23a04f9a8563d468accc414e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 1/9] ice: Reliably reset VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When a PFR (or bigger reset) occurs, the device clears the VF_MBX_ARQLEN
> register for all VFs. But if a VFR is triggered by a VF, the device does NOT clear
> this register, and the VF driver will never see the reset.
> 
> When this happens, the VF driver will eventually timeout and attempt
> recovery, and usually it will be successful. But this makes resets take a long
> time and there are occasional failures.
> 
> We cannot just blithely clear this register on every reset; this has been
> shown to cause synchronization problems when a PFR is triggered with a
> large number of VFs.
> 
> Fix this by clearing VF_MBX_ARQLEN when the reset source is not PFR.
> GlobR will trigger PFR, so this test catches that occurrence as well.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


