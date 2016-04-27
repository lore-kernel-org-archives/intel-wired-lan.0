From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Apr 2016 22:19:19 +0000
Subject: [Intel-wired-lan] [next PATCH S34 06/12] i40evf: RSS Hash
 Option	parameters
In-Reply-To: <1460542112-20166-7-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-7-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5187@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 06/12] i40evf: RSS Hash Option
> parameters
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch syncs the VF code for the changes made to the PF for the RSS hash
> tuple settings.
> Since the VF still cannot change the RSS hash settings, change the code to
> make this clear to the user.
> Previously, the default settings were returned in this function. However, the
> default can be chnaged by the PF so this does not make sense anymore.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-Id: I085eaf005fc7978b440d2a1bf2b2dd7cadaff39b
> ---
> Testing Hints : Make sure any attempts to change rx-flow-hash via ethtool
> returns Not Supported and a message in the dmesg log that informs user to
> use pf for these settings instead.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 201 +--------------------
>  1 file changed, 2 insertions(+), 199 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Changes work as expected
