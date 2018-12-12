From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 12 Dec 2018 03:24:59 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix an issue that PME is not
 enabled during runtime suspend
In-Reply-To: <20181203055438.363-1-kai.heng.feng@canonical.com>
References: <20181203055438.363-1-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965E5E94@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kai-Heng Feng
> Sent: Sunday, December 2, 2018 9:55 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; intel-wired-lan at lists.osuosl.org;
> davem at davemloft.net; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix an issue that PME is not enabled
> during runtime suspend
> 
> I210 ethernet card doesn't wakeup when a cable gets plugged. It's
> because its PME is not set.
> 
> Since commit 42eca2302146 ("PCI: Don't touch card regs after runtime
> suspend D3"), if the PCI state is saved, pci_pm_runtime_suspend() stops
> calling pci_finish_runtime_suspend(), which enables the PCI PME.
> 
> To fix the issue, let's not to save PCI states when it's runtime
> suspend, to let the PCI subsytem enables PME.
> 
> Fixes: 42eca2302146 ("PCI: Don't touch card regs after runtime suspend D3")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
