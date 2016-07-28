From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 28 Jul 2016 21:30:03 +0800
Subject: [Intel-wired-lan] [e1000_netpoll] BUG: sleeping function called
 from invalid context at kernel/irq/manage.c:110
In-Reply-To: <20160728101958.GA26846@bistromath.localdomain>
References: <20160726035003.GA15095@wfg-t540p.sh.intel.com>
 <1469524492.17736.3.camel@edumazet-glaptop3.roam.corp.google.com>
 <1469655487.2232.49.camel@intel.com>
 <1469684635.9389.4.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160728101958.GA26846@bistromath.localdomain>
Message-ID: <20160728133003.GA30283@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sabrina,

>The idea when this first came up was to skip the sleeping part of
>disable_irq():
>
>http://marc.info/?l=linux-netdev&m=142314159626052
>
>This fell off my todolist and I didn't send the conversion patches,
>which would basically look like this:

Yes it works in the several machines that had the BUG!

[   23.806847] netpoll: netconsole: local port 6665
[   23.807145] netpoll: netconsole: local IPv4 address 0.0.0.0
[   23.807494] netpoll: netconsole: interface 'eth0'
[   23.807799] netpoll: netconsole: remote port 6646
[   23.808096] netpoll: netconsole: remote IPv4 address 192.168.1.1
[   23.808474] netpoll: netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
[   23.808910] netpoll: netconsole: local IP 192.168.1.161
[   23.811680] 28 Jul 19:42:10 ntpdate[376]: step time server 192.168.1.1 offset 1696.257557 sec
[   23.811886] console [netcon0] enabled
[   23.812131] netconsole: network logging started

Thanks,
Fengguang

>
>diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>index 41f32c0b341e..b022691e680b 100644
>--- a/drivers/net/ethernet/intel/e1000e/netdev.c
>+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>@@ -6713,20 +6713,20 @@ static irqreturn_t e1000_intr_msix(int __always_unused irq, void *data)
>
> 		vector = 0;
> 		msix_irq = adapter->msix_entries[vector].vector;
>-		disable_irq(msix_irq);
>-		e1000_intr_msix_rx(msix_irq, netdev);
>+		if (disable_hardirq(msix_irq))
>+			e1000_intr_msix_rx(msix_irq, netdev);
> 		enable_irq(msix_irq);
>
> 		vector++;
> 		msix_irq = adapter->msix_entries[vector].vector;
>-		disable_irq(msix_irq);
>-		e1000_intr_msix_tx(msix_irq, netdev);
>+		if (disable_hardirq(msix_irq))
>+			e1000_intr_msix_tx(msix_irq, netdev);
> 		enable_irq(msix_irq);
>
> 		vector++;
> 		msix_irq = adapter->msix_entries[vector].vector;
>-		disable_irq(msix_irq);
>-		e1000_msix_other(msix_irq, netdev);
>+		if (disable_hardirq(msix_irq))
>+			e1000_msix_other(msix_irq, netdev);
> 		enable_irq(msix_irq);
> 	}
>
>@@ -6750,13 +6750,13 @@ static void e1000_netpoll(struct net_device *netdev)
> 		e1000_intr_msix(adapter->pdev->irq, netdev);
> 		break;
> 	case E1000E_INT_MODE_MSI:
>-		disable_irq(adapter->pdev->irq);
>-		e1000_intr_msi(adapter->pdev->irq, netdev);
>+		if (disable_hardirq(adapter->pdev->irq))
>+			e1000_intr_msi(adapter->pdev->irq, netdev);
> 		enable_irq(adapter->pdev->irq);
> 		break;
> 	default:		/* E1000E_INT_MODE_LEGACY */
>-		disable_irq(adapter->pdev->irq);
>-		e1000_intr(adapter->pdev->irq, netdev);
>+		if (disable_hardirq(adapter->pdev->irq))
>+			e1000_intr(adapter->pdev->irq, netdev);
> 		enable_irq(adapter->pdev->irq);
> 		br
>ak;
> 	}
