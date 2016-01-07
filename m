From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 19:03:41 +0000
Subject: [Intel-wired-lan] [next PATCH S26 07/12] i40e: APIs to
 Add/remove	port mirroring rules
In-Reply-To: <1451932392-15538-8-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-8-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E479@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 07/12] i40e: APIs to Add/remove
> port mirroring rules
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch implements necessary functions related to port mirroring features
> such as add/delete mirror rule, function to set promiscuous VLAN mode for
> VSI if mirror rule_type is "VLAN Mirroring".
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Iaf513fd5f188f99dcb977b48f99e73185dfddc40
> ---
> Testing-Hints:
> These APIs will be tested as part of testing 'Cisco CSX - Port Mirroring)'.
> Hooks to test this APIs will be exposed via. debugfs.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 162
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  12 ++
>  2 files changed, 174 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
