From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 4 Aug 2015 22:15:43 +0000
Subject: [Intel-wired-lan] [PATCH] igb: do not re-init SR-IOV during
	probe
In-Reply-To: <1436533272-18070-1-git-send-email-sassmann@kpanic.de>
References: <1436533272-18070-1-git-send-email-sassmann@kpanic.de>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81ADF460@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Stefan Assmann
> Sent: Friday, July 10, 2015 6:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Kirsher, Jeffrey T; sassmann at kpanic.de
> Subject: [PATCH] igb: do not re-init SR-IOV during probe
> 
> During driver probing the following code path is triggered.
> igb_probe
> ->igb_sw_init
>   ->igb_probe_vfs
>     ->igb_pci_enable_sriov
>       ->igb_sriov_reinit
> 
> Doing the SR-IOV re-init is not necessary during probing since we're
> starting from scratch. Here we can call igb_enable_sriov() right away.
> 
> Running igb_sriov_reinit() during igb_probe() also seems to cause
> occasional packet loss on some onboard 82576 NICs. Reproduced on
> Dell and HP servers with onboard 82576 NICs.
> Example:
> Intel Corporation 82576 Gigabit Network Connection [8086:10c9] (rev 01)
> Subsystem: Dell Device [1028:0481]
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
