From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 19:00:40 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 4/6] i40e:
 Admin queue definitions for cloud filters
In-Reply-To: <150909695111.48377.10187091086275409372.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909695111.48377.10187091086275409372.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADBA1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, October 27, 2017 2:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: jiri at resnulli.us; netdev at vger.kernel.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 4/6] i40e: Admin
> queue definitions for cloud filters
> 
> Add new admin queue definitions and extended fields for cloud filter
> support. Define big buffer for extended general fields in Add/Remove Cloud
> filters command.
> 
> v5: Addressed Shannon's comment to move couple of description comments
> to the right.
> v3: Shortened some lengthy struct names.
> v2: Added I40E_CHECK_STRUCT_LEN check to AQ command structs and
> added AQ definitions to i40evf for consistency based on Shannon's feedback.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  107
> ++++++++++++++++++++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  107
> ++++++++++++++++++++
>  2 files changed, 210 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


