From: Henning Svane <hsv@energy.dk>
Date: Wed, 17 Oct 2018 18:09:48 +0000
Subject: [Intel-wired-lan] X550 VF do not support PTP
In-Reply-To: <37EA2F27FEDED94487ADB266632B54EF73069C4B@IRSMSX107.ger.corp.intel.com>
References: <5ABC601D16A6044981773D154D5C9F7101CC6B0C99@XMail-DAG1.energy.local>
 <3A7E81AC661B4646A4CE6F2E09B7B74E05C8F738@HASMSX106.ger.corp.intel.com>
 <37EA2F27FEDED94487ADB266632B54EF73069C4B@IRSMSX107.ger.corp.intel.com>
Message-ID: <5ABC601D16A6044981773D154D5C9F7101CC6F4CE5@XMail-DAG2.energy.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tim

Thanks for the answer, but that also means that hardware PTP in a virtual machine cannot be made.
There are some finance regulation (high speed trading) here in Europe which need hardware PTP to be precise enough.

So this need to be made in a physical server. Pass-through is not the way to go as you cannot vMotion the VM, so no benefit

Regards
Henning

Fra: Kielan, Tymoteusz <tymoteusz.kielan@intel.com>
Sendt: 17. oktober 2018 20:01
Til: Basierski, SebastianX <sebastianx.basierski@intel.com>; Henning Svane <hsv@energy.dk>; intel-wired-lan at lists.osuosl.org
Emne: RE: X550 VF do not support PTP

Hi,

I can confirm that PTP is NOT supported on X550 VF device.
It works when one port is in pass-through mode as this is a PF device being mapped into the VM and not VF.

You can see in the ixgbevf driver that SIOCSHWTSTAMP ioctl is not handled.
There is no plan for PTP support for ixgbevf as for now.

Thanks, Tim

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Basierski, SebastianX
Sent: Monday, September 17, 2018 10:28 AM
To: Henning Svane <hsv at energy.dk<mailto:hsv@energy.dk>>; intel-wired-lan at lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] X550 VF do not support PTP

Hello,

As far as I know, PTP is not (and probably will not be) supported by VF driver.

Thanks
Sebastian Basierski
SII Engineer
Delivering outsourced services to Intel
e-mail: sebastianx.basierski at intel.com<mailto:sebastianx.basierski@intel.com>

[sii-logo]

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Henning Svane
Sent: Sunday, September 16, 2018 12:54 AM
To: intel-wired-lan@lists.osuosl.org<mailto:intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] X550 VF do not support PTP

Hi

I cannot get PTP hardware to work on a Virtual Function Ethernet Controller.
Here below you can see what I have tried with no luck.

How can I enable PTP hardware on Virtual function NIC, as from what I can read in the documentation this should work, but how?

As hypervisor I use VMware ESXi 6.7 (9484548)

Regards
Henning

On Ubuntu 18.04.1 (4.15.0-34-generic)
I am trying to get PTP to work on a X550 dual port, which has been setup so one port is SR-IOV (24 VF) and the other as Passthrough.

04:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)
0b:00.0 Ethernet controller: Intel Corporation X550 Virtual Function
13:00.0 Ethernet controller: Intel Corporation X550 Virtual Function

To be sure that the drive support PTP I downloaded the newest driver
ixgbevf-4.3.5.tar.gz
sudo make CFLAGS_EXTRA="-DIXGBE_PTP" install (The documentation says this options has to be set)
https://downloadmirror.intel.com/26950/eng/readme.txt

:~/ixgbevf-4.3.5/src$ modinfo ixgbevf
filename:       /lib/modules/4.15.0-34-generic/updates/drivers/net/ethernet/intel/ixgbevf/ixgbevf.ko
version:        4.3.5
license:        GPL
description:    Intel(R) 10 Gigabit Virtual Function Network Driver
author:         Intel Corporation, <linux.nics at intel.com<mailto:linux.nics@intel.com>>
srcversion:     DE0A8FE27F168DAF11C29F6
alias:          pci:v00008086d000015B4sv*sd*bc*sc*i*
alias:          pci:v00008086d000015C5sv*sd*bc*sc*i*
alias:          pci:v00008086d000015A9sv*sd*bc*sc*i*
alias:          pci:v00008086d000015A8sv*sd*bc*sc*i*
alias:          pci:v00008086d00001564sv*sd*bc*sc*i*
alias:          pci:v00008086d00001565sv*sd*bc*sc*i*
alias:          pci:v00008086d00001530sv*sd*bc*sc*i*
alias:          pci:v00008086d00001515sv*sd*bc*sc*i*
alias:          pci:v00008086d0000152Esv*sd*bc*sc*i*
alias:          pci:v00008086d000010EDsv*sd*bc*sc*i*
depends:
retpoline:      Y
name:           ixgbevf
vermagic:       4.15.0-34-generic SMP mod_unload

:~/ixgbevf-4.3.5/src$ ethtool -T ens224
Time stamping parameters for ens224:
Capabilities:
        software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
        software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none
hsv at ptpc2ntps01:~/ixgbevf-4.3.5/src$<mailto:hsv@ptpc2ntps01:~/ixgbevf-4.3.5/src$> ethtool -T ens256
Time stamping parameters for ens256:
Capabilities:
        software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
        software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none

Ens161 is the Passthrough NIC and here PTP works.
:~/ixgbevf-4.3.5/src$ ethtool -T ens161
Time stamping parameters for ens161:
Capabilities:
        hardware-transmit     (SOF_TIMESTAMPING_TX_HARDWARE)
        software-transmit     (SOF_TIMESTAMPING_TX_SOFTWARE)
        hardware-receive      (SOF_TIMESTAMPING_RX_HARDWARE)
        software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
        software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
        hardware-raw-clock    (SOF_TIMESTAMPING_RAW_HARDWARE)
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes:
        off                   (HWTSTAMP_TX_OFF)
        on                    (HWTSTAMP_TX_ON)
Hardware Receive Filter Modes:
        none                  (HWTSTAMP_FILTER_NONE)
        all                   (HWTSTAMP_FILTER_ALL)
        ptpv1-l4-sync         (HWTSTAMP_FILTER_PTP_V1_L4_SYNC)
        ptpv1-l4-delay-req    (HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ)
        ptpv2-event           (HWTSTAMP_FILTER_PTP_V2_EVENT)

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. S?owackiego 173 | 80-298 Gda?sk | S?d Rejonowy Gda?sk P??noc | VII Wydzia? Gospodarczy Krajowego Rejestru S?dowego - KRS 101882 | NIP 957-07-52-316 | Kapita? zak?adowy 200.000 PLN.

Ta wiadomo?? wraz z za??cznikami jest przeznaczona dla okre?lonego adresata i mo?e zawiera? informacje poufne. W razie przypadkowego otrzymania tej wiadomo?ci, prosimy o powiadomienie nadawcy oraz trwa?e jej usuni?cie; jakiekolwiek przegl?danie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181017/e7159e5c/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 5461 bytes
Desc: image001.png
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181017/e7159e5c/attachment-0001.png>
