From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 24 Mar 2017 00:43:12 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix timing for 82579 Gigabit
	Ethernet controller
In-Reply-To: <1487270527-4549-1-git-send-email-berndfaust@gmail.com>
References: <1487270527-4549-1-git-send-email-berndfaust@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5DC96A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Bernd Faust
> Sent: Thursday, February 16, 2017 10:42 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Lubetkin, YanirX
> <yanirx.lubetkin@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Bernd Faust <berndfaust@gmail.com>
> Subject: [PATCH] e1000e: fix timing for 82579 Gigabit Ethernet controller
> 
> After an upgrade to Linux kernel v4.x the hardware timestamps of the
> 82579 Gigabit Ethernet Controller are different than expected.
> The values that are being read are almost four times as big as before
> the kernel upgrade.
> 
> The difference is that after the upgrade the driver sets the clock
> frequency to 25MHz, where before the upgrade it was set to 96MHz. Intel
> confirmed that the correct frequency for this network adapter is 96MHz.
> 
> Signed-off-by: Bernd Faust <berndfaust@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
