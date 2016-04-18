From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 22:49:48 +0000
Subject: [Intel-wired-lan] [next PATCH S34 09/12] i40e: Use consistent
 type	for vf_id
In-Reply-To: <1460542112-20166-10-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-10-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2082@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S34 09/12] i40e: Use consistent type
> for vf_id
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was all over the place using signed or unsigned types for vf_id,
> when it should always be signed.
> 
> This fixes warnings of type unsafe comparisons from gcc with W=2.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-Id: I2cb681f83d0f68ca124d2e4131e4ac0d9f8a6b22
> ---
> Testing Hints : make sure virtchannel (VF) still works to configure MAC
> addresses and such from the VF.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF MAC address configuration, etc, works as expected
