From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 24 Jun 2019 15:03:16 +0800
Subject: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
In-Reply-To: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
Message-ID: <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeffrey,

at 19:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hi Jeffrey,
>
> There are several platforms that uses e1000e can?t enter Opportunistic  
> S0ix (PC10) when the ethernet has a link partner.
>
> This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but seems  
> like 3.4.2.3 fixes the issue.
>
> A quick diff between the two versions shows that this code section may be  
> our solution:
>
>         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
>          * may occur during global reset and cause system hang.
>          * Configuration space access creates the needed delay.
>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
>          * insures configuration space read is done before global reset.
>          */
>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>                              &pci_cfg);
>         ew32(STRAP, pci_cfg);
>         e_dbg("Issuing a global reset to ich8lan\n");
>         ew32(CTRL, (ctrl | E1000_CTRL_RST));
>         /* cannot issue a flush here because it hangs the hardware */
>         msleep(20);
>
>         /* Configuration space access improve HW level time sync mechanism.
>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
>          * value to insure configuration space read is done
>          * before any access to mac register.
>          */
>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>                              &pci_cfg);
>         ew32(STRAP, pci_cfg);

Turns out the "extra sauce? is not this part, it?s called ?Dynamic LTR  
support?.

>
> Is there any plan to support this in the upstream kernel?

Is there any plan to support Dynamic LTR in upstream e1000e?

Kai-Heng

>
> Kai-Heng


