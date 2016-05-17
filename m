From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:25:00 +0000
Subject: [Intel-wired-lan] [next PATCH S37 03/15] i40e: write HENA for
 VFs
In-Reply-To: <1463419605-30746-4-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D685D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 03/15] i40e: write HENA for VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Now that VF RSS is configured by the PF driver, it needs to set the RSS Hash
> Enable registers by default. Without this, no packets will be hashed and
> they'll all end up on queue 0.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I38e425f40ddb81e3b19a951cfbb939fa5b1123f1
> ---
> Testing Hints : Send packets to the VF and observe which receive queues are
> in use using ethtool -S.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Receive traffic properly spreads out among queues on VF
