From: Periyasamy Palanisamy <periyasamy.palanisamy@ericsson.com>
Date: Mon, 13 May 2019 07:36:41 +0000
Subject: [Intel-wired-lan] Not able to create VFs on PF passthrough of
 ethernet interface to VM
In-Reply-To: <AM0PR07MB531317D299B0EC8D11D67F568A0C0@AM0PR07MB5313.eurprd07.prod.outlook.com>
References: <AM0PR07MB531316C34EDCB413A855132A8A0C0@AM0PR07MB5313.eurprd07.prod.outlook.com>
 <AM0PR07MB531317D299B0EC8D11D67F568A0C0@AM0PR07MB5313.eurprd07.prod.outlook.com>
Message-ID: <AM0PR07MB531393AB5237B86A25991A7A8A0F0@AM0PR07MB5313.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I?m trying to achieve PF passthrough of 40/10G ethernet interface (i40e) into guest VM running on qemu/kvm hypervisor and then create VFs on the PF inside the VM.
This is to have a flexibility and better manageability of VFs inside the VM (for example, kubernetes worker node) itself and not on the host.


The ethernet PCI device is seen inside the VM and bound to i40e driver. But I don?t see an option to create VFs. i.e. sriov_numvfs file is not seen under /sys/devices/pci0000:00/0000:00:02.1/0000:02:00.0 directory.

Host versions:
OS: Ubuntu 16.04.5 LTS, Kernel: 4.15.0-48-generic, libvirt: 4.0.0, qemu: 2.11.1
i40e version: 2.1.14-k, firmware-version: 6.01 0x800034a3 1.1747.0

Guest versions:
OS: CentOS 7 (Core) Kernel: 3.10.0-862.14.4.el7.x86_64
i40e version: 2.1.14-k, firmware-version: 6.01 0x800034a3 1.1747.0

The VM libvirt xml configuration [1], PF configuration at host [2], PF configuration at VM [3] are attached.
The lspci output line nos. 63-75 related to SRIOV Capabilities in host [2] are missing in VM which looks bit weird.

Could you please look into it and let us know what?s going wrong ?

[1] https://pastebin.ubuntu.com/p/wrDB6T68r3/
[2] https://pastebin.ubuntu.com/p/PW7Z4SxQPt/
[3] https://pastebin.ubuntu.com/p/JcmpMY48D6/

Thanks,
Periyasamy
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190513/3ce61567/attachment-0001.html>
