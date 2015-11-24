From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Nov 2015 23:46:10 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 07/12] i40e: Opcode
	and	structures required by OEM Post Update AQ command and add
	new	NVM arq message
In-Reply-To: <1447961665-12344-8-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-8-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F8929F2@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [V3: next PATCH S22 07/12] i40e: Opcode and
> structures required by OEM Post Update AQ command and add new NVM
> arq message
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> This is a part of implementation which contains data structures and opcode
> for new AQ command. There's a new ARQ message that gets sent near the
> end of the NVM update process that the driver should recognize and ignore,
> rather than printing an Unknown Event error.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I04830a5bcae14823e16b9424cc4165e169336c1f
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ic73b0a4e10e0b6895d1f2435125f1e789f3756dd
> ---
> Testing Hints :
> 	Do an nvmupdate with the current version of nvmupdate tool before
> and
> 	after this patch is applied and watch the kernel log for the message
> 		"ARQ Error: Unknown event 0x0720 received"
> 	Using "nvmupdate -f" will allow you to "update" your NVM with the
> same
> 	version NVM, over and over; useful for this kind of testing.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 21
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c         |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 21
> +++++++++++++++++++++
>  3 files changed, 43 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no error in log after nvmupdate
