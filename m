From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:45:20 +0000
Subject: [Intel-wired-lan] [next-queue v2 6/6] i40e: fix
	unconditional	execution of cpu_to_le16()
In-Reply-To: <1444719992-301-6-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-6-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D11BE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Tuesday, October 13, 2015 12:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M
> Subject: [Intel-wired-lan] [next-queue v2 6/6] i40e: fix unconditional
> execution of cpu_to_le16()
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> The commit 3092e5e4cc79 ("i40e: add little endian conversion for
> checksum") fixed the checksum bug on big-endian architecture.
> 
> But we should not execute cpu_to_le16() unconditionally. Thus, put
> cpu_to_le16() under certain condition.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
> v2: Update patch serial number and add CC to Paul M Stillwell Jr.
> 
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
