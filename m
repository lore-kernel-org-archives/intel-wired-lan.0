From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 16 Oct 2015 23:41:24 +0000
Subject: [Intel-wired-lan] [next-queue v5 04/17] fm10k: always check
 init_hw	for errors
In-Reply-To: <1445018231-3196-4-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC552F6@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, October 16, 2015 10:57 AM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v5 04/17] fm10k: always check
> init_hw for errors
> 
> A recent change modified init_hw in some flows the function may fail on
> VF devices. For example, if a VF doesn't yet own its own queues.
> However, many callers of init_hw didn't bother to check the error code.
> Other callers checked but only displayed diagnostic messages without
> actually handling the consequences.
> 
> Fix this by (a) always returning and preventing the netdevice from going
> up, and (b) printing the diagnostic in every flow for consistency. This
> should resolve an issue where VF drivers would attempt to come up
> before the PF has finished assigning queues.
> 
> In addition, change the dmesg output to explicitly show the actual
> function that failed, instead of combining reset_hw and init_hw into a
> single check, to help for future debugging.
> 
> Fixes: 1d568b0f6424 ("fm10k: do not assume VF always has 1 queue")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 34
> ++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>

