From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Aug 2016 22:26:13 +0000
Subject: [Intel-wired-lan] [next PATCH S44 1/6] i40e: fix setting
	user	defined RSS hash key
In-Reply-To: <1472063631-9033-2-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAAA1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 24, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S44 1/6] i40e: fix setting user defined
> RSS hash key
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Previously, when using ethtool to change the RSS hash key, ethtool would
> report back saying the old key was still being used and no error was reported.
> It was unclear whether it was being reported incorrectly or being set
> incorrectly.  Debugging revealed 'i40e_set_rxfh()' returned zero immediately
> instead of setting the key because a user defined indirection table is not
> supplied when changing the hash key.
> 
> This fix instead changes it such that if an indirection table is not supplied,
> then a default one is created and the hash key is now correctly set.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Iddb621897ecf208650272b7ee46702cad7b69a71
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++----
>  3 files changed, 11 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


