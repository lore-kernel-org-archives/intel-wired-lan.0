From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 23 Feb 2022 09:02:29 +0200
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Print PHY register address
 when MDI read/write fails
In-Reply-To: <20220210132256.53589-1-yu.c.chen@intel.com>
References: <20220210132256.53589-1-yu.c.chen@intel.com>
Message-ID: <723d2a6c-8f5a-8e26-73d9-e96a289ff9af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/10/2022 15:22, Chen Yu wrote:
> There is occasional suspend error from e1000e which blocks the
> system from further suspending. And the issue was found on
> a WhiskeyLake-U platform with I219-V:
>
> [   20.078957] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x780 [e1000e] returns -2
> [   20.078970] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -2
> [   20.078974] e1000e 0000:00:1f.6: PM: pci_pm_suspend+0x0/0x170 returned -2 after 371012 usecs
> [   20.078978] e1000e 0000:00:1f.6: PM: failed to suspend async: error -2
>
> According to the code flow, this might be caused by broken MDI read/write
> to PHY registers. However currently the code does not tell us which
> register is broken. Thus enhance the debug information to print the
> offender PHY register. So the next the issue is reproduced, this
> information could be used for narrow down.
>
> Acked-by: Paul Menzel<pmenzel@molgen.mpg.de>
> Reported-by: Todd Brandt<todd.e.brandt@intel.com>
> Signed-off-by: Chen Yu<yu.c.chen@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220223/6bef2cfd/attachment-0001.html>
