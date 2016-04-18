From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 19:06:24 +0000
Subject: [Intel-wired-lan] [next PATCH S34 03/12] i40e: Prevent falling
 to	promiscuous if the VF is not trusted
In-Reply-To: <1460542112-20166-4-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-4-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0F0B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S34 03/12] i40e: Prevent falling to
> promiscuous if the VF is not trusted
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> With this change a non trusted VF can never fall to promiscuous mode when
> there is no room for a mac/vlan filter.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I8a155aa25c0bcdc6093414920c9ade4ee0bd20e8
> ---
> Testing Hints :
> Try adding mac/vlan filters to multiple VFs and make sure they can no longer
> go into promiscuous mode if the VFs are not trusted.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
untrusted VFs won't trigger promiscuous mode
