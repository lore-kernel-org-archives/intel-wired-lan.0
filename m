From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 17:43:30 +0000
Subject: [Intel-wired-lan] [next PATCH S14 05/15] i40e/i40evf: Add info
 to	nvm info struct for OEM version data
In-Reply-To: <1441065295-234333-6-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A61C2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 05/15] i40e/i40evf: Add info to
> nvm info struct for OEM version data
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch adds a member to the nvm_info struct for oem_ver info to be
> output either by OID or ethtool.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I1e5d513ae67622e2af17042924fdb4b5d6d85366
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 9 ++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, ethtool shows OEM version info
