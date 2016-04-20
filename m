From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 15:15:16 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 9/9] i40e: Test memory
 before	ethtool alloc succeeds
In-Reply-To: <1461004429-34316-10-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-9-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-10-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2544@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 9/9] i40e: Test memory before
> ethtool alloc succeeds
> 
> When testing on systems with very limited amounts of RAM, a bug was
> found where, while changing the number of descriptors using ethtool, the
> driver didn't test the limits of system memory before permanently assuming
> it would be able to get receive buffer memory.
> 
> Work around this issue by pre-allocation of the receive buffer memory, in
> the "ghost" ring, which is then used during reinit using the new ring length.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-Id: I92d7a5fb59a6c884b2efdd1ec652845f101c3359
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 34
> +++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code compiles and passes traffic, bug fix already verified
