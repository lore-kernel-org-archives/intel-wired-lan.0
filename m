From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:13:44 +0000
Subject: [Intel-wired-lan] [next PATCH 07/11] igb: Clean-up
 configuration of	VF port VLANs
In-Reply-To: <20160107071111.13648.16311.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071111.13648.16311.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F186@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 07/11] igb: Clean-up configuration of    VF port VLANs
> 
> This patch is meant to clean-up the configuration of the VF port based VLAN
> configuration.  The original logic was a bit muddled and had some
> undesirable side effects such as VLANs being either completely stripped
> from the port or VLANs being left when they shouldn't be.  The idea behind
> this code is to avoid any events such as spurious spoof notifications when
> we are removing one VLAN tag and replacing it with another.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |  181 ++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 71 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
