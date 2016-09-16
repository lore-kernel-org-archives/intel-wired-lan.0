From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 16 Sep 2016 01:59:42 +0000
Subject: [Intel-wired-lan] [PATCH] PCI: disable FLR for 82579 device
In-Reply-To: <1473316048-7598-1-git-send-email-sasha.neftin@intel.com>
References: <1473316048-7598-1-git-send-email-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F90996@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Wednesday, September 7, 2016 11:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] PCI: disable FLR for 82579 device
> 
> 82579 has a problem reattaching itself after the device is detached.
> The bug was reported by Redhat. The suggested fix is to disable
> FLR capability in PCIe configuration space.
> 
> Reproduction:
> Attach the device to a VM, then detach and try to attach again.
> 
> Fix:
> Disable FLR capability to prevent the 82579 from hanging.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
