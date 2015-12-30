From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 30 Dec 2015 16:19:37 +0000
Subject: [Intel-wired-lan] [next PATCH S25 11/16] i40e: add a little
 more to	an NVM update debug message
In-Reply-To: <1450901156-30904-12-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-12-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97C9AB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 11/16] i40e: add a little more to an
> NVM update debug message
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add a little more detail to an NVM update debug message in order to see the
> full ethtool request data.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: Iab10437cb32d6fddc67ee347e7c0b42511e152cd
> ---
> Testing-Hints:
> Turn on NVM update debug and see the new data in the logfile ethtool -s
> eth0 msglvl 0xf000008f
> 
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool command shows message
