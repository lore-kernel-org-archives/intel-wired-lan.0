From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Dec 2016 18:45:09 +0000
Subject: [Intel-wired-lan] [next PATCH S56 8/8] Acquire NVM lock
	before	reads on all devices
In-Reply-To: <1480710782-9195-9-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA393DB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Salter, Aaron K <aaron.k.salter@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S56 8/8] Acquire NVM lock before
> reads on all devices
> 
> From: Aaron Salter <aaron.k.salter@intel.com>
> 
> Acquire NVM lock before reads on all devices.  Previously, locks were only
> used for X722 and later.  Fixes an issue where simultaneous X710 NVM
> accesses were interfering with each other.
> 
> Signed-off-by: Aaron Salter <aaron.k.salter@intel.com>
> Change-ID: If570bb7acf958cef58725ec2a2011cead6f80638
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


